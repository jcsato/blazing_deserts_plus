priest_background <- inherit("scripts/skills/backgrounds/character_background", {
	m = { }

	function create() {
		character_background.create();

		m.ID				= "background.priest";
		m.Name				= "Priest";
		m.Icon				= "ui/backgrounds/background_bd_plus_03.png";

		m.BackgroundDescription	= "Priests are resolute in their faith, but unused to the rigors of combat.";
		m.GoodEnding			= "%name% the priest eventually left the company and returned to the south. His escapades as a Crownling caused no small amount of controversy, but ultimately the man proved his faith none the lesser for his time sellswording and he is now looked to as an authority in matters of spiritual balance.";
		m.BadEnding				= "%name% the priest eventually succumbed to the vices of the secular world and turned his back on the Gilder's path. Last you heard, he fell in with a bizarre death cult seeking to spread its faith to the south.";

		m.HiringCost		= 65;
		m.DailyCost			= 5;

		m.Excluded			= [ "trait.weasel", "trait.hate_beasts", "trait.swift", "trait.impatient", "trait.clubfooted", "trait.brute", "trait.gluttonous", "trait.disloyal", "trait.cocky", "trait.quick", "trait.dumb", "trait.superstitious", "trait.iron_lungs", "trait.craven", "trait.greedy", "trait.bloodthirsty" ];

		m.Titles			= [ "the Faithful", "the Priest", "the Scholar", "the Astronomer", "the Wise", "the Quiet", "the Dervish" ];

		m.Bodies			= Const.Bodies.SouthernSkinny;
		m.Faces				= Const.Faces.SouthernMale;
		m.Hairs				= Const.Hair.SouthernMale;
		m.HairColors		= Const.HairColors.Southern;
		m.Beards			= Const.Beards.Southern;
		m.Ethnicity			= 1;

		m.Names				= Const.Strings.SouthernNames;
		m.LastNames			= Const.Strings.SouthernNamesLast;

	}

	function getTooltip() {
		return [
			{ id = 1, type = "title", text = getName() }
			{ id = 2, type = "description", text = getDescription() }
		];
	}

	function onBuildDescription() {
		return "{As a boy, %name% gazed with wonderment at the stars of the night sky. Perhaps it is little wonder, then, that he devoted himself to the Gilder's glory as a man. | Born into the family of a high ranking priest, there was never any question that %name% would join the clergy as well. | Originally a nomad, a spiritual experience out in the desert convinced %name% to join the priesthood and devote himself to religious study. | A priest in one of the many temples of the Southern city-states, %name% has devoted his life to the study and recitation of religious dogma. | %name% is a priest, one of the many students of the Gilder's teachings.} {But one day, his research into the stars mired him in scandal, and he was forced to flee the temple before he found himself indebted. | But the hedonism of the grand temples wore on his soul, and eventually he turned away from their excess in disgust and pursed a life of asceticism instead. | He refuses to elaborate, but apparently one day he committed some heresy and now seeks redemption in self-imposed exile. | But when his own son was branded indebted for a petty crime, he had a crisis of faith and left the temple to pursue the Gilder's gleam on his own. | One day he met an anatomist from the north, and was so struck with wonder at the man's research that he resolved to further his own studies out in the world instead of cloistered in his temple.} {Though not a warrior in the traditional sense, %name% faces the world with a dauntless calm that rivals that of the boldest knight. | If battles could be won through sheer force of will, %name% would be peerless in combat. He bleeds as well as the next man regardless. | %name% stops and kneels on the ground for his fifth prayer of the day. As long as he stays on his feet during battle, you suppose... | %name%'s face is gaunt and his body looks as worn as his clothing, but there's a fire in his eyes that would make the hardiest warrior back away. Wait, is he praying or did he just faint? | %name% claims he must “make pilgrimage to a humbler, worldlier station” if he is to truly earn the Gilder's favor. You suppose an early grave is worldly in a literal sense, but keep that to yourself and nod along. | %name% has abandoned most of his possessions and stands before you ready to serve in the Gilder's name, naked of avarice and ambition. You stop him when he tries to give a nearby beggar his shirt. | Murmuring a prayer under his breath, %name% would probably flatten a mountain if the Gilder willed it. You'll settle for the next infidel the company is contracted to kill instead.}"
	}

	function onChangeAttributes() {
		local c = {
			Hitpoints		= [ 0	,	0	]
			Bravery			= [ 9	,	9	]
			Stamina			= [ -8	,	-1	]
			MeleeSkill		= [ -2	,	-3	]
			RangedSkill		= [ 0	,	0	]
			MeleeDefense	= [ 0	,	0	]
			RangedDefense	= [ 0	,	2	]
			Initiative		= [ 0	,	0	]
		};

		return c;
	}

	function onAddEquipment() {
		local items = getContainer().getActor().getItems();
		local r = Math.rand(1, 2);

		if (r == 1)
			items.equip(new("scripts/items/armor/oriental/cloth_sash"));
		else if (r == 2)
			items.equip(new("scripts/items/armor/oriental/padded_vest"));
	}
});
