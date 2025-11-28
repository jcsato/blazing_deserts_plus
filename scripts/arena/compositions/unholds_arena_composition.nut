unholds_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.unholds";
		m.DisplayName			= "Unholds";
		m.DisplayText			= "\"You're up against what the northern scum refer to as an 'unhold.' The Vizier pays a proper pile of coin to get them here, and the masses love the giant bastards. They do a good job smashing fighters and, on occasion, heaving a warrior clear into the crowds. It's quite wonderful. I think some of the unholds even learn to enjoy it the longer they stay here, like they learn what spurs the mob to cheers and jeer. The brutality is something else. Anyway, may the Gilder watch over you.\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.Unhold ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Unhold ];
		m.Pay					= 310;
		m.AllowedEntrants		= 4;
		m.BaseStrength			= 50;
		m.PotentialTwists		= [];
		m.MinDay				= 10;
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Unholds;
		local titles = clone ::BDP.Arena.CompositionTitles.Unholds;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Plain);
		titles.extend(clone ::BDP.Arena.CompositionTitles.Hill);

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}

	function onAfterBuild() {
		local treasures = [ "scripts/items/loot/deformed_valuables_item" ];

		if (Math.rand(1, 100) < m.Entities.len() * m.Difficulty)
			addLoot(new(treasures[Math.rand(0, treasures.len() - 1)]));
	}
});
