indebted_northern_arena_composition <- inherit("scripts/arena/compositions/indebted_arena_composition", {
	m = { }

	function create() {
		indebted_arena_composition.create();

		m.Type					= "arena_composition.northern_indebted";
		m.DisplayName			= "Northern Indebted";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.NorthernIndebted ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Indebted, ::BDP.Arena.EntityTypes.NorthernIndebted, ::BDP.Arena.EntityTypes.NorthernIndebted ];
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Indebted;
		local titles = clone ::BDP.Arena.CompositionTitles.Indebted;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Plain);
		titles.extend(clone ::BDP.Arena.CompositionTitles.Steppe);

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
});
