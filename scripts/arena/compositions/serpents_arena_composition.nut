serpents_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.serpents";
		m.DisplayName			= "Serpents";
		m.DisplayText			= "\"What do you mean you don't understand? Huh, it's just a squiggly line? No. Look, this is its tail, and that's the head. It's a snake. You're fighting snakes. 'Serpents' the alchemists like to call them, but if I wanted to draw a serpent I'd just draw an alchemist haghaghagh!\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.Serpent ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Serpent ];
		m.Pay					= 200;
		m.AllowedEntrants		= 3;
		m.PotentialTwists		= [];
		m.MinDay				= 7;
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Serpents;
		local titles = clone ::BDP.Arena.CompositionTitles.Serpents;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Desert);

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}

	function onAfterBuild() {
		local treasures = [ "scripts/items/loot/rainbow_scale_item" ];

		if (Math.rand(1, 100) < m.Entities.len() * m.Difficulty)
			addLoot(new(treasures[Math.rand(0, treasures.len() - 1)]));
	}
});
