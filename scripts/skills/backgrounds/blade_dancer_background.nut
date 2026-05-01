blade_dancer_background <- inherit("scripts/skills/backgrounds/character_background", {
	m = { }

	function create() {
		character_background.create();

		m.ID				= "background.blade_dancer";
		m.Name				= "Blade Dancer";
		m.Icon				= "ui/backgrounds/background_bd_plus_01.png";

		m.BackgroundDescription	= "A blade dancer is a lithe, deadly expert in melee combat, though he's more used to duels than battlefields.";
		m.GoodEnding			= "%name% the blade dancer departed the %companyname% not long after you retired, seeking greater challenges elsewhere. Last you heard, he was making a name for himself up north fighting barbarians. Peasants in the clanlands have dubbed him 'the sword saint', and apparently the savages have a number of less-flattering names for him.";
		m.BadEnding				= "%name% the blade dancer departed the %companyname% not long after you retired, seeking greater challenges elsewhere. Unfortunately, his journey met with an abrupt end when a patrol of conscripts, mistaking him for a criminal, rushed him. He only killed one before a spear pierced him through the heart.";

		m.HiringCost		= 450;
		m.DailyCost			= 33;

		m.Excluded			= [ "trait.superstitious", "trait.hate_greenskins", "trait.fearless", "trait.huge", "trait.paranoid", "trait.teamplayer", "trait.night_blind", "trait.clubfooted", "trait.brute", "trait.dumb", "trait.loyal", "trait.clumsy", "trait.fat", "trait.strong", "trait.hesitant", "trait.bright", "trait.insecure", "trait.short_sighted", "trait.bloodthirsty", "trait.craven", "trait.asthmatic" ];
		m.ExcludedTalents	= [ Const.Attributes.Bravery, Const.Attributes.RangedSkill ];

		m.Titles			= [ "the Blade Dancer", "the Desert Devil", "the Lithe", "the Sandstorm", "the Dervish" ];

		m.Bodies			= Const.Bodies.SouthernSkinny;
		m.Faces				= Const.Faces.SouthernMale;
		m.Hairs				= Const.Hair.SouthernMale;
		m.HairColors		= Const.HairColors.SouthernYoung;
		m.Beards			= Const.Beards.Southern;
		m.Ethnicity			= 1;

		m.Level				= Math.rand(2, 4);

		m.Names				= Const.Strings.SouthernNames;
		m.LastNames			= Const.Strings.SouthernNamesLast;

		m.IsCombatBackground = true;
	}

	function getTooltip() {
		return [
			{ id = 1, type = "title", text = getName() }
			{ id = 2, type = "description", text = getDescription() }
		];
	}

	function onBuildDescription() {
		return "{%name% cuts through men like a fish cuts through water. | %name% moves with an ethereal grace, gliding effortlessly through city squares and battlefields alike. | %name% carries himself with a relaxed confidence seen only in fighters with no experience, and in those with a lifetime of it. His age suggests he's the former, but his eyes tell a different story. | Though reticent and refined, %name% has an unnerving air about him, as though simply standing near him will shorten your lifespan. | %name% has a piercing gaze that seems to miss nothing, effortlessly finding flaws in an opponent's stance and pathways through impenetrable crowds.} {For years he lived contentedly with a group of nomads out in the sands. Something terrible happened, however, and one day the blade dancer slaughtered the tribe to the last, traveling to the nearest city-state with a group of terrified merchants who happened upon the carnage. He refuses to elaborate on the incident no matter how hard he is pressed. | The blade dancer once led a decadent life in %randomcitystate%, until he was found having 'improper relations' with {a vizier's concubine | a court official | a high priest}. Normally such transgressions would see him clapped in irons and sold into servitude, but it seems there's a shortage of guards willing to apprehend the sword wielding criminal. | When the blade dancer slew his mentor in a disagreement over a woman, the chieftain of the nomads he lived with banished him from the tribe. He has wandered from place to place ever since, leaving bodies and stories of peerless swordsmanship in his wake. | The blade dancer is a wanted man in %randomcitystate% for his association with nomad raiders, but no guard dares approach him after he slew the first dozen men that attempted an arrest. | He's something of a local legend in %randomcitystate%, having single-handedly defeated an ifrit with only his sword and quick wits. Rumors abound that the sand demon was the spirit of his dead mentor, come to take revenge on a traitorous pupil, but none dare make the such an accusation within earshot.} {Unable to find worthy opponents, the man has become rather bored, and wishes to join a mercenary company for glory. | He now seeks the company of sellswords, driven to fulfill some quest of which only he knows the details. | Having grown bored of street fights and run-ins with hapless conscripts, he now seeks to ply his skills farther afield. | The man casually slices the hand off a pickpocket reaching for your purse and, ignoring the screams, asks if you're mercenaries and have room for another hire.}"
	}

	function onChangeAttributes() {
		local c = {
			Hitpoints		= [ 0	,	-3	]
			Bravery			= [ -5	,	-5	]
			Stamina			= [ -8	,	-3	]
			MeleeSkill		= [ 20	,	15	]
			RangedSkill		= [ 3	,	2	]
			MeleeDefense	= [ 8	,	12	]
			RangedDefense	= [ 3	,	5	]
			Initiative		= [ 12	,	10	]
		};

		return c;
	}

	function onAddEquipment() {
		local items = getContainer().getActor().getItems();
		local r;

		r = Math.rand(0, 3);

		if (r == 0)
			items.equip(new("scripts/items/weapons/oriental/swordlance"));
		else if( r == 1)
			items.equip(new("scripts/items/weapons/scimitar"));
		else
			items.equip(new("scripts/items/weapons/shamshir"));

		r = Math.rand(1, 3);

		if (r == 1)
			items.equip(new("scripts/items/armor/oriental/thick_nomad_robe"));
		else if (r == 2)
			items.equip(new("scripts/items/armor/oriental/nomad_robe"));
		else if (r == 3)
			items.equip(new("scripts/items/armor/oriental/leather_nomad_robe"));

		items.equip(new("scripts/items/helmets/oriental/blade_dancer_head_wrap"));
	}
})
