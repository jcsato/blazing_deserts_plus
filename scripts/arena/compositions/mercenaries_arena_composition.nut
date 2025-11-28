mercenaries_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.mercenaries";
		m.DisplayName			= "Crownlings";
		m.DisplayText			= "\"Crownlings like you have ventured down from the north. Up there, they call them 'sellswords.' Hagh! What sort of attempt at poetry is that? Don't they know not every man even uses a sword? They ain't the brightest up there. That's why I like it in the south. The sun is bright, and thus so are we.\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.Mercenary ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Mercenary, ::BDP.Arena.EntityTypes.MercenaryLow, ::BDP.Arena.EntityTypes.MercenaryRanged ];
		m.Pay					= 325;
		m.AllowedEntrants		= 3;
		m.BaseStrength			= 40;
		m.PotentialTwists		= [];
		m.MinDay				= 5;
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Mercenaries;

		m.DisplayName = names[Math.rand(0, names.len() - 1)];
	}
});
