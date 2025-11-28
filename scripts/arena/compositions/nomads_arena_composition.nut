nomads_arena_composition <- inherit("scripts/arena/compositions/nomads_low_arena_composition", {
	m = { }

	function create() {
		nomads_low_arena_composition.create();

		m.Type					= "arena_composition.nomads";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.NomadOutlaw ]
		m.PotentialEntities		= [
			::BDP.Arena.EntityTypes.NomadCutthroat,
			::BDP.Arena.EntityTypes.NomadOutlaw,
			::BDP.Arena.EntityTypes.NomadOutlaw,
			::BDP.Arena.EntityTypes.NomadSlinger,
			::BDP.Arena.EntityTypes.NomadArcher,
			::BDP.Arena.EntityTypes.NomadLeader
		];
		m.PotentialChampions	= [
			::BDP.Arena.EntityTypes.ChampionNomadLeader,
			::BDP.Arena.EntityTypes.ChampionNomadExecutioner,
			::BDP.Arena.EntityTypes.ChampionDesertStalker,
			::BDP.Arena.EntityTypes.ChampionBladeDancer
		];
		m.Pay					= 275
		m.AllowedEntrants		= 3;
		m.PotentialTwists		= [];
		m.MinDay				= 3;
	}
});
