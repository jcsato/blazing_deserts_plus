indebted_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.indebted";
		m.DisplayName			= "Indebted";
		m.DisplayText			= "\"It appears the Viziers wishes to winnow his laborers. You've got a number of Indebted on the docket. They shouldn't give you much trouble - they do not let them off the shackles if they're any good, understand?\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.Indebted ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Indebted, ::BDP.Arena.EntityTypes.NorthernIndebted ];
		m.Pay					= 100;
		m.AllowedEntrants		= 2;
		m.PotentialTwists		= [];
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Indebted;
		local titles = clone ::BDP.Arena.CompositionTitles.Indebted;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Desert);

		local cityState = getArena().getCityState().getOwner();
		local viziers = cityState.getRoster().getAll();

		foreach (vizier in viziers)
			titles.push(vizier.getNameOnly())

		local villages = World.EntityManager.getSettlements();

		for (local i = 0; i < villages.len(); ++i) {
			if (isKindOf(villages[i], "city_state"))
				titles.push(villages[i].getNameOnly());
		}

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}

	function setDifficulty(_difficulty) {
		m.Difficulty = Math.min(_difficulty, 2);
	}
});
