treasure_hunter_background <- inherit("scripts/skills/backgrounds/character_background", {
	m = { }

	function create() {
		character_background.create();

		m.ID			= "background.treasure_hunter";
		m.Name			= "Treasure Hunter";
		m.Icon			= "ui/backgrounds/background_bd_plus_05.png";

		m.BackgroundDescription	= "Treasure Hunters are bold and adventurous.";
		m.GoodEnding			= "You weren't sure how a man like %name% would fare as a mercenary, with his head more full of fantasies about lost riches than aptitude for combat. The treasure hunter surprised you, though, seeming to have found a different sort of wealth in claiming glory alongside the %companyname%. From what you hear he's decided to forge a name for himself such that his own equipment will be regarded the sort of legendary treasure he once sought.";
		m.BadEnding				= "For all the romanticism of delving into the ruins of old and coming out with ancient riches, the fact of the matter is that most expeditions for lost wealth turn up nothing at all, and most treasure hunters are one bad haul away from becoming brigands. Unfortunately, %name% was no exception. With the %companyname% falling on hard times and the treasure hunter having failed to secure riches now in two professions, the man left the company and turned to raiding merchants on the road. Last you heard, he's on the run after a caravan guard cut off his hand.";

		m.HiringCost	= 60;
		m.DailyCost		= 6;

		m.Excluded		= [ "trait.weasel", "trait.fear_undead", "trait.fear_beasts", "trait.cocky", "trait.craven", "trait.fainthearted", "trait.insecure", /* "trait.optimist", */ "trait.superstitious", "trait.deathwish" ];

		m.Titles		= [  ];

		m.Bodies		= Const.Bodies.SouthernSkinny;
		m.Faces			= Const.Faces.SouthernMale;
		m.Hairs			= Const.Hair.SouthernMale;
		m.HairColors	= Const.HairColors.Southern;
		m.Beards		= Const.Beards.Southern;
		m.Ethnicity		= 1;

		m.Names			= Const.Strings.SouthernNames;
		m.LastNames		= Const.Strings.SouthernNamesLast;

		m.IsLowborn		= true;
	}

	function getTooltip() {
		return [
			{ id = 1, type = "title", text = getName() }
			{ id = 2, type = "description", text = getDescription() }
		];
	}

	function onBuildDescription() {
		return "{In his youth, %name% distracted himself from ever-present hunger with wonderous tales the nomads weaved of great treasures lost in the desert sands. As an adult, he distracts himself by chasing those treasures. | A treasure hunter, %name% has never stayed in one place for too long, always chasing after the next rumor or folktale in search of riches. | Legends speak of a great many artifacts and relics lost to the wilderness. To some these are mere fanciful myths, but to treasure hunters like %name% they're a clue to the next payday. | As a boy, %name% was warned of the many dangers within lost vaults and ancient crypts. As a man, he's far more afraid of starvation, and so he ventures off in search of unclaimed treasures. | %name% is a treasure hunter, one of the many adventurous spirits that raom the sands in search of treasure and lost riches.} {He was always a self-assured loner, taking both danger and reward solely upon his own shoulders. His most recent tomb expedition changed his mind, though he won't elaborate on what he saw down there. | He was not alone in these pursuits, however, and developed a particularly bitter rivalry with a nomad tribe. After barely escaping an ambush they set for him, he's started to consider other careers. | One day he discovered a tomb and full of untold riches. The next day, he discovered it was that of the vizier's ancestor. The day after that, he discovered wealth means little if you can't carry it with you on the road. | His bronze skin, silver tongue, and golden jewelry made him popular with the ladies. A little too popular, perhaps, as attention from a concubine in the vizier's harem now has him on the run. | One day he discovered what seemed to be a whole city-state lost in the sands. Exploring the place, he learned a terrible truth and decided it was time to leave the South. He refuses to share more.} {While unaccustomed to wielding a blade, %name% has faced plenty of danger before and can hold his ground in a shieldline. Probably. | Seeking protection in the company of hardened warriors, %name% now hopes to join a mercenary company. | Deciding that the ruins of yore hold too many dangers for one man alone to face, %name% now seeks his fortune as a crownling. | Though adorned in golden baubles and jeweled accessories, %name%'s dusty boots and tattered cloak show his true nature. Perhaps the life of a sellsword would suit him? | Wondering if he shouldn't seek the gold of the living rather than the dead, %name% now finds himself considering life as a crownling.}";
	}

	function onChangeAttributes() {
		local c = {
			Hitpoints		= [ 0	,	0	]
			Bravery			= [ 8	,	5	]
			Stamina			= [ 5	,	5	]
			MeleeSkill		= [ 3	,	0	]
			RangedSkill		= [ 0	,	0	]
			MeleeDefense	= [ 0	,	1	]
			RangedDefense	= [ 0	,	1	]
			Initiative		= [ 0	,	4	]
		};

		return c;
	}

	function onAddEquipment() {
		local items = getContainer().getActor().getItems();
		local r;

		r = Math.rand(1, 3);

		if (r == 1)
			items.equip(new("scripts/items/armor/oriental/cloth_sash"));
		else if (r == 2)
			items.equip(new("scripts/items/armor/oriental/padded_vest"));
		else if (r == 3)
			items.equip(new("scripts/items/armor/oriental/linothorax"));

		r = Math.rand(1, 4);

		if (r == 2)
			items.equip(new("scripts/items/helmets/oriental/southern_head_wrap"));
		else if (r == 3)
			items.equip(new("scripts/items/helmets/oriental/nomad_head_wrap"));
		else if (r == 4)
			items.equip(new("scripts/items/helmets/oriental/leather_head_wrap"));

		r = Math.rand(1, 3);

		if (r == 1)
			items.equip(new("scripts/items/weapons/dagger"));
		else if (r == 2)
			items.equip(new("scripts/items/weapons/oriental/nomad_mace"));
	}
});
