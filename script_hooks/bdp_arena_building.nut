::mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(ab) {
	local origIsClosed = ::mods_getMember(ab, "isClosed");
	local onClicked = ::mods_getMember(ab, "onClicked");

	::mods_override(ab, "isClosed", function() {
		if (World.Statistics.getFlags().getAsInt("BDPVersion") > 0) {
			local arena = World.Arena.getArenaByCityStateID(getSettlement().getID());

			return arena.getMatchesFought() >= arena.getFightsPerDay();
		} else {
			return origIsClosed();
		}
	});

	::mods_override(ab, "onClicked", function(_townScreen) {
		if (World.Statistics.getFlags().getAsInt("BDPVersion") > 0) {
			if (!World.getTime().IsDaytime)
				return;

			if (isClosed())
				return;

			_townScreen.getArenaDialogModule().setArenaBuilding(this);
			_townScreen.showArenaDialog();

			pushUIMenuStack();
		} else {
			return onClicked(_townScreen);
		}
	});
});

::mods_hookClass("ui/screens/tooltip/tooltip_events", function(te) {
	local general_queryUIElementTooltipData = te.general_queryUIElementTooltipData;

	te.general_queryUIElementTooltipData = function(_entityId, _elementId, _elementOwner) {
		// UI elements can be a little wonky with what's loaded when
		if ("Statistics" in World && "getFlags" in World.Statistics && World.Statistics.getFlags().getAsInt("BDPVersion") > 0) {
			switch(_elementId) {
				case "world-town-screen.main-dialog-module.Arena": {
					local ret = [
						{ id = 1, type = "title", text = "Arena" },
						{ id = 2, type = "description", text = "The arena offers an opportunity to earn gold and fame in fights that are to the death, and in front of crowds that cheer for the most gruesome manner in which lives are dispatched." }
					];

					if (World.State.getCurrentTown() != null && World.State.getCurrentTown().getBuilding("building.arena").isClosed())
						ret.push({ id = 3, type = "hint", icon = "ui/tooltips/warning.png", text = "No more matches take place here today. Come back tomorrow!" });

					// Remove tooltips about needing inventory space or being unable to take fights while contracted

					return ret;
				}
			}
		}

		return general_queryUIElementTooltipData(_entityId, _elementId, _elementOwner);
	}
});
