hyenas_frenzied_arena_composition <- inherit("scripts/arena/compositions/hyenas_arena_composition", {
	m = { }

	function create() {
		hyenas_arena_composition.create();

		m.Type					= "arena_composition.frenzied_hyenas";
		m.DisplayName			= "Frenzied Hyenas";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.FrenziedHyena ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Hyena, ::BDP.Arena.EntityTypes.FrenziedHyena, ::BDP.Arena.EntityTypes.FrenziedHyena ];
		m.Pay					= 175;
		m.MinDay				= 5;
	}

	function onAfterBuild() {
		local treasures = [ "scripts/items/loot/sabertooth_item" ];

		if (Math.rand(1, 100) < m.Entities.len() * m.Difficulty)
			addLoot(new(treasures[Math.rand(0, treasures.len() - 1)]));
	}
});
