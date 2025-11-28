hyenas_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.hyenas";
		m.DisplayName			= "Hyenas";
		m.DisplayText			= "\"Hyenas. Heeheehee. Hyenas. Several of the giggling mutts, in fact. Good luck, and may the Gilder watch over you.\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.Hyena ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Hyena, ::BDP.Arena.EntityTypes.Hyena, ::BDP.Arena.EntityTypes.FrenziedHyena ];
		m.Pay					= 150;
		m.AllowedEntrants		= 3;
		m.PotentialTwists		= [ "beast_slayer_twist" ];
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Hyenas;
		local titles = clone ::BDP.Arena.CompositionTitles.Hyenas;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Desert);

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}
});
