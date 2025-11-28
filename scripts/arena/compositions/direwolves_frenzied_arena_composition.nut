direwolves_frenzied_arena_composition <- inherit("scripts/arena/compositions/direwolves_arena_composition", {
	m = { }

	function create() {
		direwolves_arena_composition.create();

		m.Type					= "arena_composition.frenzied_direwolves";
		m.DisplayName			= "Frenzied Direwolves";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.FrenziedDirewolf ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Direwolf, ::BDP.Arena.EntityTypes.FrenziedDirewolf, ::BDP.Arena.EntityTypes.FrenziedDirewolf ];
		m.Pay					= 175;
		m.MinDay				= 5;
	}

	function onAfterBuild() {
		local treasures = [ "scripts/items/loot/sabertooth_item" ];

		if (Math.rand(1, 100) < m.Entities.len() * m.Difficulty)
			addLoot(new(treasures[Math.rand(0, treasures.len() - 1)]));
	}
});
