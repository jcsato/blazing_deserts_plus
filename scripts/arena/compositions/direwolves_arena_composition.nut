direwolves_arena_composition <- inherit("scripts/arena/compositions/arena_composition", {
	m = { }

	function create() {
		arena_composition.create();

		m.Type					= "arena_composition.direwolves";
		m.DisplayName			= "Direwolves";
		m.DisplayText			= "\"You'll be facing hounds from up north. Now, they look like any other mongrels to me, but apparently the northerners call them 'direwolves' and tell stories of them walking on two legs like men. Pah! Down here we call them that because they 'die' swiftly when they wander into the deserts, haghaghagh!\"";
		m.SignatureEntities		= [ ::BDP.Arena.EntityTypes.Direwolf ];
		m.PotentialEntities		= [ ::BDP.Arena.EntityTypes.Direwolf, ::BDP.Arena.EntityTypes.Direwolf, ::BDP.Arena.EntityTypes.FrenziedDirewolf ];
		m.Pay					= 150;
		m.AllowedEntrants		= 3;
		m.PotentialTwists		= [ "beast_slayer_twist", "wardogs_twist" ];
	}

	function generateDisplayName() {
		local names = clone ::BDP.Arena.CompositionNames.Direwolves;
		local titles = clone ::BDP.Arena.CompositionTitles.Direwolves;
		titles.extend(clone ::BDP.Arena.CompositionTitles.Forest);

		m.DisplayName = names[Math.rand(0, names.len() - 1)] + " of " + titles[Math.rand(0, titles.len() - 1)];
	}
});
