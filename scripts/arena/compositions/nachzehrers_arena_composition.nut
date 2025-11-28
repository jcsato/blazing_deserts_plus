nachzehrers_arena_composition <- inherit("scripts/arena/compositions/nachzehrers_low_arena_composition", {
	m = { }

	function create() {
		nachzehrers_low_arena_composition.create();

		m.Type					= "arena_composition.nachzehrers";
		m.DisplayName			= "Nachzehrers";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.NachzehrerMedium ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.NachzehrerMedium, ::BDP.Arena.EntityTypes.NachzehrerLow, ::BDP.Arena.EntityTypes.NachzehrerLow ];
		m.Pay					= 175;
		m.MinDay				= 5;
	}

	function onAfterBuild() {
		local treasures = [ "scripts/items/loot/growth_pearls_item" ];

		if (Math.rand(1, 100) < m.Entities.len() * m.Difficulty)
			addLoot(new(treasures[Math.rand(0, treasures.len() - 1)]));
	}
});
