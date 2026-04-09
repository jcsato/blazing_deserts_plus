gladiators_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.gladiator";
		m.DisplayName			= "Gladiators";
		m.DisplayText			= "\"Well, heh, the Gilder must have a sense of humor. You'll be facing trained gladiators. May your path be ever Gilded, but to be honest, I said that to the gladiators. And I've been saying it to them every day. Understand? You should prepare to the best of your abilities.\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.Gladiator ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Gladiator ];
		m.PotentialChampions	= [ ::BDP.Arena.EntityTypes.ChampionGladiator ];
		m.Pay					= 350;
		m.AllowedEntrants		= 3;
		m.PotentialTwists		= [ "coward_afraid_of_gladiators_twist"];
		m.MinDay				= 15;
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Gladiators;
		local titles = [" of the Arena", " of the Ring", " of the Coliseum", " of Bloodsport"];
		titles.push(" of " + getArena().getCityState().getName());

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + titles[Math.rand(0, titles.len() - 1)];
	}

	function setDifficulty(_difficulty) {
		m.Difficulty = Math.max(_difficulty, 2);
	}
});
