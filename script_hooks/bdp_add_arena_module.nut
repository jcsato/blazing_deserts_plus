::mods_hookExactClass("states/world_state", function(ws) {
	ws.m.Arena <- null;

	local onInitUI				= ::mods_getMember(ws, "onInitUI");
	local startNewCampaign		= ::mods_getMember(ws, "startNewCampaign");
	local onUpdate				= ::mods_getMember(ws, "onUpdate");
	local onBeforeSerialize		= ::mods_getMember(ws, "onBeforeSerialize");
	local onBeforeDeserialize	= ::mods_getMember(ws, "onBeforeDeserialize");
	local onSerialize			= ::mods_getMember(ws, "onSerialize");
	local onDeserialize			= ::mods_getMember(ws, "onDeserialize");

	::mods_override(ws, "onInitUI", function() {
		m.Arena = new("scripts/states/world/arena_manager");
		World.Arena <- WeakTableRef(m.Arena);

		onInitUI();
	});

	::mods_override(ws, "onUpdate", function() {
		onUpdate();

		m.Arena.update();
	});

	::mods_override(ws, "startNewCampaign", function() {
		startNewCampaign();

		World.Statistics.getFlags().set("BDPVersion", ::BDP.SerializationVersion);

		local settlements = World.EntityManager.getSettlements();
		foreach (settlement in settlements) {
			if (settlement.isSouthern() && settlement.hasBuilding("building.arena"))
				m.Arena.buildArena(settlement);
		}
	});

	::mods_override(ws, "onBeforeSerialize", function(_out) {
		onBeforeSerialize(_out);

		local meta = _out.getMetaData();
		local bdpVersion = ::BDP.SerializationVersion;

		// Checking for the existence of Statistics here isn't normally necessary, but MSU exercises onBeforeSerialize
		//  before World.Statistics is set.
		if ("Statistics" in World && World.Statistics.getFlags().has("BDPVersion"))
			bdpVersion = World.Statistics.getFlags().getAsInt("BDPVersion");

		logDebug("Saving with Blazing Deserts+ version: " + bdpVersion);
		meta.setInt("BDPVersion", bdpVersion);
	});

	::mods_override(ws, "onBeforeDeserialize", function(_in) {
		onBeforeDeserialize(_in);

		World.Arena.clear();
	});

	::mods_override(ws, "onSerialize", function(_out) {
		onSerialize(_out);

		if (_out.getMetaData().getInt("BDPVersion") >= 1)
			World.Arena.onSerialize(_out);
	});

	::mods_override(ws, "onDeserialize", function(_in) {
		onDeserialize(_in);

		if (_in.getMetaData().getInt("BDPVersion") >= 1)
			World.Arena.onDeserialize(_in);

		logDebug("Blazing Deserts+ version: " + World.Statistics.getFlags().getAsInt("BDPVersion"));
		World.Statistics.getFlags().set("BDPVersion", _in.getMetaData().getInt("BDPVersion"));
	});
});

::mods_hookClass("ui/screens/world/world_town_screen", function(wts) {
	::mods_addField(wts, "world_town_screen", "ArenaDialogModule", null);

	::mods_addMember(wts, "world_town_screen", "getArenaDialogModule", function() {
		return m.ArenaDialogModule;
	});

	wts.m.ArenaDialogModule <- new("scripts/ui/screens/world/world_town_screen/town_arena_dialog_module");
	wts.m.ArenaDialogModule.setParent(wts);
	wts.m.ArenaDialogModule.connectUI(wts.m.JSHandle);

	local destroy = ::mods_getMember(wts, "destroy");
	wts.destroy = function() {
		// maybe unnecessary, since it's also called in `destroy()`?
		clearEventListener();

		m.ArenaDialogModule.destroy();
		m.ArenaDialogModule = null;

		// m.JSHandle is called at the end of `destroy()`, so arena module is destroyed first to match vanilla behavior
		destroy();
	}

	local clear = ::mods_getMember(wts, "clear");
	wts.clear = function() {
		clear();

		m.ArenaDialogModule.clear();
	}

	local showLastActiveDialog = ::mods_getMember(wts, "showLastActiveDialog");
	wts.showLastActiveDialog = function() {
		if (m.LastActiveModule == m.ArenaDialogModule)
			showArenaDialog();
		else
			showLastActiveDialog();
	}

	::mods_addMember(wts, "world_town_screen", "showArenaDialog", function() {
		if (m.JSHandle != null && isVisible()) {
			m.LastActiveModule = m.ArenaDialogModule;
			Tooltip.hide();
			m.JSHandle.asyncCall("showArenaDialog", m.ArenaDialogModule.queryArenaInformation());
		}
	});
});
