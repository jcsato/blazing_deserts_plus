lindwurms_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.lindwurms";
		m.DisplayName			= "Lindwurm";
		m.DisplayText			= "\"Your opponent is a... a... what is this? A worm? It's green. Never seen a worm that col- oh! A wyrm! No wait, 'wurm.' Wurm? A lindwurm! I gots'ta be honest with ya, I don't know what the hell this is, but I imagine our dear matchmakers won't be having you fightin' a worm of the regular sort. Or maybe they is. Maybe they'll just have ye eat it for our entertainment. Maybe they ain't matchmakers, but tastemakers! Herghgheeagghheeehoogh. Ha.\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.Lindwurm ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Lindwurm ];
		m.Pay					= 550;
		m.AllowedEntrants		= 5;
		m.BaseStrength			= 110;
		m.PotentialTwists		= [];
		m.MinDay				= 30;
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Lindwurms;
		local titles = clone ::BDP.Arena.CompositionTitles.Lindwurms;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Plain);
		titles.extend(clone ::BDP.Arena.CompositionTitles.Steppe);
		titles.extend(clone ::BDP.Arena.CompositionTitles.Hill);

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}

	function setDifficulty(_difficulty) {
		m.Difficulty = Math.max(_difficulty, 2);
	}

	function onAfterBuild() {
		local treasures = [ "scripts/items/loot/lindwurm_hoard_item" ];

		if (m.Difficulty == 3 || Math.rand(1, 100) < 33)
			addLoot(new(treasures[Math.rand(0, treasures.len() - 1)]));
	}
});
