nachzehrers_high_arena_composition <- inherit("scripts/arena/compositions/nachzehrers_low_arena_composition", {
	m = { }

	function create() {
		nachzehrers_low_arena_composition.create();

		m.Type					= "arena_composition.nachzehrers_high";
		m.DisplayName			= "Nachzehrers";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.NachzehrerHigh ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.NachzehrerHigh, ::BDP.Arena.EntityTypes.NachzehrerMedium, ::BDP.Arena.EntityTypes.NachzehrerMedium, ::BDP.Arena.EntityTypes.NachzehrerLow, ::BDP.Arena.EntityTypes.NachzehrerLow ];
		m.Pay					= 360;
		m.MinDay				= 15;
	}

	function setDifficulty(_difficulty) {
		m.Difficulty = Math.max(_difficulty, 2);
	}

	function onAfterBuild() {
		local treasures = [ "scripts/items/loot/growth_pearls_item" ];

		if (Math.rand(1, 100) < m.Entities.len() * m.Difficulty)
			addLoot(new(treasures[Math.rand(0, treasures.len() - 1)]));
	}
});
