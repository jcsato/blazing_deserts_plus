blade_dancer_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.blade_dancer";
		m.DisplayName			= "Blade Dancer";
		m.DisplayText			= "\"A blade dancer of the nomad tribes is on the docket. Now, he might look a bit foppish, but to get the title of 'blade dancer' you must be as articulate with the blade as a bird is with the wind. Dancing expertise is optional, but they're all pretty good at that, too.\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.BladeDancer ];
		m.PotentialEntities		= [
			::BDP.Arena.EntityTypes.BladeDancer,
			::BDP.Arena.EntityTypes.BladeDancer,
			::BDP.Arena.EntityTypes.BladeDancer,
			::BDP.Arena.EntityTypes.NomadOutlaw,
			::BDP.Arena.EntityTypes.NomadOutlaw,
			::BDP.Arena.EntityTypes.NomadArcher,
			::BDP.Arena.EntityTypes.DesertStalker,
			::BDP.Arena.EntityTypes.NomadExecutioner,
			::BDP.Arena.EntityTypes.NomadLeader
		];
		m.PotentialChampions	= [ ::BDP.Arena.EntityTypes.ChampionBladeDancer ];
		m.Pay					= 400;
		m.AllowedEntrants		= 3;
		m.PotentialTwists		= [];
		m.MinDay				= 20;
	}

	function setDifficulty(_difficulty) {
		m.Difficulty = Math.max(_difficulty, 2);
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.BladeDancer;
		local titles = clone ::BDP.Arena.CompositionTitles.Nomads;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Desert);

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}
});
