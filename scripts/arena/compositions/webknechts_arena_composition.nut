webknechts_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.webknechts";
		m.DisplayName			= "Webknechts";
		m.DisplayText			= "\"That is not a fig tree, it's a spider. The alchemists, bless their learned hearts, call them webknechts which is a silly northern name, in truth they're spiders. Unfortunately for you, there are several of them and a boot will not be sufficient this time around.\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.Webknecht ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Webknecht ];
		m.Pay					= 160;
		m.AllowedEntrants		= 4;
		m.BaseStrength			= 52;
		m.PotentialTwists		= [];
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Webknechts;
		local titles = clone ::BDP.Arena.CompositionTitles.Webknechts;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Forest);
		titles.extend(clone ::BDP.Arena.CompositionTitles.Swamp);

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}

	function onAfterBuild() {
		local treasures = [ "scripts/items/loot/webbed_valuables_item" ];

		if (Math.rand(1, 100) < m.Entities.len() * m.Difficulty)
			addLoot(new(treasures[Math.rand(0, treasures.len() - 1)]));
	}
});
