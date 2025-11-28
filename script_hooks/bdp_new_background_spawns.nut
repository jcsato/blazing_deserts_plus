// --------------- City states ---------------
::mods_hookExactClass("entity/world/settlements/city_state", function(cs) {
	local create = ::mods_getMember(cs, "create");

	::mods_override(cs, "create", function() {
		create();

		m.DraftList.push("blade_dancer_background");
		m.DraftList.push("crownling_background");
		m.DraftList.push("crownling_background");
		m.DraftList.push("priest_background");
		m.DraftList.push("priest_background");
		m.DraftList.push("indemnifier_background");
		m.DraftList.push("treasure_hunter_background");
		m.DraftList.push("treasure_hunter_background");
	});
});
