::mods_registerMod("blazing_deserts_plus", 0.12, "Blazing Deserts+");

::mods_queue("blazing_deserts_plus", null, function() {
	::mods_registerCSS("screens/world/modules/world_town_screen/arena_bro_selection_ui_helper.css");
	::mods_registerJS("screens/world/modules/world_town_screen/arena_bro_selection_ui_helper.js");
	::mods_registerCSS("screens/world/modules/world_town_screen/arena_fight_selection_ui_helper.css");
	::mods_registerJS("screens/world/modules/world_town_screen/arena_fight_selection_ui_helper.js");
	::mods_registerCSS("screens/world/modules/world_town_screen/world_town_screen_arena_dialogue_module.css");
	::mods_registerJS("screens/world/modules/world_town_screen/world_town_screen_arena_dialogue_module.js");

	::mods_registerJS("bdp_shim.js");

	::include("script_hooks/!bdp_constants");
	::include("script_hooks/!bdp_helpers");
	::include("script_hooks/bdp_add_arena_module");
	::include("script_hooks/bdp_arena_building");
	::include("script_hooks/bdp_arena_combat");
	::include("script_hooks/bdp_arena_traits");
	::include("script_hooks/bdp_existing_backgrounds");
	::include("script_hooks/bdp_new_background_spawns");
	::include("script_hooks/bdp_new_entities");
	::include("script_hooks/bdp_crownling_spawns");
});

// Hack to load the BD+ brush before trying to use it later when spawning crownlings. Obviates a preload/on_running.txt
::mods_hookExactClass("states/world_state", function(ws) {
	local startNewCampaign	= ::mods_getMember(ws, "startNewCampaign");

	// Unfortunately, the party needs to be kept around for the brush to not unload. Tragedy.
	::mods_override(ws, "startNewCampaign", function() {
		startNewCampaign();

		local party = World.spawnEntity("scripts/entity/world/party", createVec(0,0));

		party.getSprite("body").setBrush("figure_blank_01");
	});
});
