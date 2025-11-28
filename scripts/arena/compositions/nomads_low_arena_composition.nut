nomads_low_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.nomads_low";
		m.DisplayText			= "\"Your opponents will be a number of recently retired desert bandits. And by retired, I mean taken by manhunters, of course. No bandit willingly steps foot in here, haghaghagh!\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.NomadCutthroat ];
		m.PotentialEntities		= [
			::BDP.Arena.EntityTypes.NomadCutthroat,
			::BDP.Arena.EntityTypes.NomadCutthroat,
			::BDP.Arena.EntityTypes.NomadCutthroat,
			::BDP.Arena.EntityTypes.NomadOutlaw,
			::BDP.Arena.EntityTypes.NomadOutlaw,
			::BDP.Arena.EntityTypes.NomadSlinger,
			::BDP.Arena.EntityTypes.NomadSlinger,
			::BDP.Arena.EntityTypes.NomadArcher
		];
		m.Pay					= 250;
		m.AllowedEntrants		= 3;
		m.PotentialTwists		= [];
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Nomads;
		local titles = clone ::BDP.Arena.CompositionTitles.Nomads;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Desert);

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}
});
