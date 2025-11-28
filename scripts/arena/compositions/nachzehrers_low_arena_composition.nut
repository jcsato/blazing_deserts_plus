nachzehrers_low_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.nachzehrers_low";
		m.DisplayName			= "Nachzehrers";
		m.DisplayText			= "\"The alchemists call them, well, I can't even pronounce it. My tongue simply cannot shape itself to the word for it requires specialized northern lexicography and I've no time to narrow northern verbiage in a fruitless matter of mundane minutiae. Do I look like a phonetician to you? Let's just call them 'gnashslashers.' They're ghoulish cretins, it's several of them, and I've seen them eat men alive, so you'd best hope the Gilder is watching - I don't think He'll have any light for you in the belly of one of those beasts!\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.NachzehrerLow ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.NachzehrerLow ];
		m.Pay					= 100;
		m.AllowedEntrants		= 3;
		m.PotentialTwists		= [];
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Nachzehrers;
		local titles = clone ::BDP.Arena.CompositionTitles.Nachzehrers;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Plain);
		titles.extend(clone ::BDP.Arena.CompositionTitles.Hill);

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}

	function setDifficulty(_difficulty) {
		m.Difficulty = Math.min(_difficulty, 2);
	}
});
