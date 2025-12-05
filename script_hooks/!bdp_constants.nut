::BDP <- {
	SerializationVersion			= 3
	Arena = {
		TwistChance					= 10
		PartialForceModifier		= 0.4
		CasualtyModifier			= 0.3
		PayoutStrengthMultiplier	= 0.4
		PayoutDifficultyBase		= 115
		MinCompositions				= 3
		BaselineCompositions		= 5
		MaxCompositions				= 7
		Flags = {
			Deaths				= "BDP_ArenaDeaths"
			EntrantsUnderMax	= "BDP_ArenaEntrantsUnderMax"
			HighestDifficulty	= "BDP_ArenaMatchHighestDifficulty"
			MatchesFought		= "BDP_ArenaMatchesFought"
		}
		RewardModifiers = {
			BreadAndGames = 100
		}
		RankRequirements = {
			PitFighter = {
				Matches = 1
				Difficulty = 1
			}
			Fighter = {
				Matches = 5
				Difficulty = 2
			}
			Veteran = {
				Matches = 12
				Difficulty = 3
			}
		}
		EntityTypes = {
			NomadCutthroat				= { ID = Const.EntityType.NomadCutthroat,	Type = "NomadCutthroat",			Strength = 12,	MaxInComp = 7,	Variant = 0,	DisplayIcon="ui/arena/nomad_cutthroat.png",		Script = "scripts/entity/tactical/humans/nomad_cutthroat" }
			NomadOutlaw					= { ID = Const.EntityType.NomadOutlaw,		Type = "NomadOutlaw",				Strength = 25,	MaxInComp = 6,	Variant = 0,	DisplayIcon="ui/arena/nomad_outlaw.png",		Script = "scripts/entity/tactical/humans/nomad_outlaw" }
			NomadLeader					= { ID = Const.EntityType.NomadLeader,		Type = "NomadLeader",				Strength = 30,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/nomad_leader.png",		Script = "scripts/entity/tactical/humans/nomad_leader" }
			NomadSlinger				= { ID = Const.EntityType.NomadSlinger,		Type = "NomadSlinger",				Strength = 12,	MaxInComp = 5,	Variant = 0,	DisplayIcon="ui/arena/nomad_slinger.png",		Script = "scripts/entity/tactical/humans/nomad_slinger" }
			NomadArcher					= { ID = Const.EntityType.NomadArcher,		Type = "NomadArcher",				Strength = 15,	MaxInComp = 4,	Variant = 0,	DisplayIcon="ui/arena/nomad_archer.png",		Script = "scripts/entity/tactical/humans/nomad_archer" }
			DesertStalker				= { ID = Const.EntityType.DesertStalker,	Type = "DesertStalker",				Strength = 40,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/desert_stalker.png",		Script = "scripts/entity/tactical/humans/desert_stalker" }
			BladeDancer					= { ID = Const.EntityType.DesertDevil,		Type = "BladeDancer",				Strength = 40,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/blade_dancer.png",		Script = "scripts/entity/tactical/humans/desert_devil" }
			NomadExecutioner			= { ID = Const.EntityType.Executioner,		Type = "NomadExecutioner",			Strength = 40,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/executioner.png",			Script = "scripts/entity/tactical/humans/executioner" }
			ChampionNomadLeader			= { ID = Const.EntityType.NomadLeader,		Type = "ChampionNomadLeader",		Strength = 55,	MaxInComp = 1,	Variant = 1,	DisplayIcon="ui/arena/nomad_leader_ch.png",		Script = "scripts/entity/tactical/humans/nomad_leader",		NameList = Const.Strings.SouthernNames,				TitleList = Const.Strings.NomadChampionTitles }
			ChampionDesertStalker		= { ID = Const.EntityType.DesertStalker,	Type = "ChampionDesertStalker",		Strength = 65,	MaxInComp = 1,	Variant = 1,	DisplayIcon="ui/arena/desert_stalker_ch.png",	Script = "scripts/entity/tactical/humans/desert_stalker",	NameList = Const.Strings.DesertDevilChampionTitles,	TitleList = null }
			ChampionBladeDancer			= { ID = Const.EntityType.DesertDevil,		Type = "ChampionBladeDancer",		Strength = 65,	MaxInComp = 1,	Variant = 1,	DisplayIcon="ui/arena/blade_dancer_ch.png",		Script = "scripts/entity/tactical/humans/desert_devil",		NameList = Const.Strings.ExecutionerChampionTitles,	TitleList = null }
			ChampionNomadExecutioner	= { ID = Const.EntityType.Executioner,		Type = "ChampionNomadExecutioner",	Strength = 65,	MaxInComp = 1,	Variant = 1,	DisplayIcon="ui/arena/executioner_ch.png",		Script = "scripts/entity/tactical/humans/executioner",		NameList = Const.Strings.SouthernNames,				TitleList = Const.Strings.DesertStalkerChampionTitles }

			Indebted					= { ID = Const.EntityType.Slave,			Type = "Indebted",					Strength = 10,	MaxInComp = 8,	Variant = 0,	DisplayIcon="ui/arena/indebted.png",			Script = "scripts/entity/tactical/humans/slave" }
			NorthernIndebted			= { ID = Const.EntityType.Slave,			Type = "NorthernIndebted",			Strength = 10,	MaxInComp = 8,	Variant = 0,	DisplayIcon="ui/arena/northern_indebted.png",	Script = "scripts/entity/tactical/humans/slave_northern" }
			Gladiator					= { ID = Const.EntityType.Gladiator,		Type = "Gladiator",					Strength = 40,	MaxInComp = 3,	Variant = 0,	DisplayIcon="ui/arena/gladiator.png",			Script = "scripts/entity/tactical/humans/gladiator" }
			ChampionGladiator			= { ID = Const.EntityType.Gladiator,		Type = "ChampionGladiator",			Strength = 65,	MaxInComp = 1,	Variant = 1,	DisplayIcon="ui/arena/gladiator_ch.png",		Script = "scripts/entity/tactical/humans/gladiator",		NameList = Const.Strings.SouthernNames,				TitleList = Const.Strings.GladiatorTitles }

			Mercenary					= { ID = Const.EntityType.Mercenary,		Type = "Mercenary",					Strength = 30,	MaxInComp = 4,	Variant = 0,	DisplayIcon="ui/arena/mercenary.png",			Script = "scripts/entity/tactical/humans/mercenary" }
			MercenaryLow				= { ID = Const.EntityType.Mercenary,		Type = "MercenaryLow",				Strength = 20,	MaxInComp = 4,	Variant = 0,	DisplayIcon="ui/arena/mercenary_low.png",		Script = "scripts/entity/tactical/humans/mercenary_low" }
			MercenaryRanged				= { ID = Const.EntityType.Mercenary,		Type = "MercenaryRanged",			Strength = 25,	MaxInComp = 4,	Variant = 0,	DisplayIcon="ui/arena/mercenary_ranged.png",	Script = "scripts/entity/tactical/humans/mercenary_ranged" }

			Swordmaster					= { ID = Const.EntityType.Swordmaster,		Type = "Swordmaster",				Strength = 40,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/swordmaster.png",			Script = "scripts/entity/tactical/humans/swordmaster" }
			HedgeKnight					= { ID = Const.EntityType.HedgeKnight,		Type = "HedgeKnight",				Strength = 40,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/hedge_knight.png",		Script = "scripts/entity/tactical/humans/hedge_knight" }
			MasterArcher				= { ID = Const.EntityType.MasterArcher,		Type = "MasterArcher",				Strength = 40,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/master_archer.png",		Script = "scripts/entity/tactical/humans/master_archer" }
			ChampionSwordmaster			= { ID = Const.EntityType.Swordmaster,		Type = "ChampionSwordmaster",		Strength = 65,	MaxInComp = 1,	Variant = 1,	DisplayIcon="ui/arena/swordmaster_ch.png",		Script = "scripts/entity/tactical/humans/swordmaster",		NameList = Const.Strings.CharacterNames,			TitleList = Const.Strings.SwordmasterTitles }
			ChampionHedgeKnight			= { ID = Const.EntityType.HedgeKnight,		Type = "ChampionHedgeKnight",		Strength = 65,	MaxInComp = 1,	Variant = 1,	DisplayIcon="ui/arena/hedge_knight_ch.png",		Script = "scripts/entity/tactical/humans/hedge_knight",		NameList = Const.Strings.HedgeKnightTitles,			TitleList = null }
			ChampionMasterArcher		= { ID = Const.EntityType.MasterArcher,		Type = "ChampionMasterArcher",		Strength = 65,	MaxInComp = 1,	Variant = 1,	DisplayIcon="ui/arena/master_archer_ch.png",	Script = "scripts/entity/tactical/humans/master_archer",	NameList = Const.Strings.MasterArcherNames,			TitleList = null }

			Oathbringer					= { ID = Const.EntityType.Oathbringer,		Type = "Oathbringer",				Strength = 40,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/oathbringer.png",			Script = "scripts/entity/tactical/humans/oathbringer" }
			ChampionOathbringer			= { ID = Const.EntityType.Oathbringer,		Type = "ChampionOathbringer",		Strength = 65,	MaxInComp = 1,	Variant = 1,	DisplayIcon="ui/arena/oathbringer_ch.png",		Script = "scripts/entity/tactical/humans/oathbringer",		NameList = Const.Strings.OathbringerNames,			TitleList = null }

			Direwolf					= { ID = Const.EntityType.Direwolf,			Type = "Direwolf",					Strength = 15,	MaxInComp = 5,	Variant = 0,	DisplayIcon="ui/arena/direwolf.png",			Script = "scripts/entity/tactical/enemies/direwolf" }
			FrenziedDirewolf			= { ID = Const.EntityType.Direwolf,			Type = "FrenziedDirewolf",			Strength = 20,	MaxInComp = 5,	Variant = 0,	DisplayIcon="ui/arena/frenzied_direwolf.png",	Script = "scripts/entity/tactical/enemies/direwolf_high" }
			NachzehrerLow				= { ID = Const.EntityType.Ghoul,			Type = "NachzehrerLow",				Strength = 10,	MaxInComp = 5,	Variant = 0,	DisplayIcon="ui/arena/nachzehrer_low.png",		Script = "scripts/entity/tactical/enemies/ghoul" }
			NachzehrerMedium			= { ID = Const.EntityType.Ghoul,			Type = "NachzehrerMedium",			Strength = 15,	MaxInComp = 3,	Variant = 0,	DisplayIcon="ui/arena/nachzehrer_medium.png",	Script = "scripts/entity/tactical/enemies/ghoul_medium" }
			NachzehrerHigh				= { ID = Const.EntityType.Ghoul,			Type = "NachzehrerHigh",			Strength = 25,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/nachzehrer_high.png",		Script = "scripts/entity/tactical/enemies/ghoul_high" }

			Lindwurm					= { ID = Const.EntityType.Lindwurm,			Type = "Lindwurm",					Strength = 100,	MaxInComp = 3,	Variant = 0,	DisplayIcon="ui/arena/lindwurm.png",			Script = "scripts/entity/tactical/enemies/lindwurm" }

			Unhold						= { ID = Const.EntityType.Unhold,			Type = "Unhold",					Strength = 50,	MaxInComp = 4,	Variant = 0,	DisplayIcon="ui/arena/unhold.png",				Script = "scripts/entity/tactical/enemies/unhold" }
			Webknecht					= { ID = Const.EntityType.Spider,			Type = "Webknecht",					Strength = 13,	MaxInComp = 8,	Variant = 0,	DisplayIcon="ui/arena/webknecht.png",			Script = "scripts/entity/tactical/enemies/spider" }

			Serpent						= { ID = Const.EntityType.Serpent,			Type = "Serpent",					Strength = 20,	MaxInComp = 5,	Variant = 0,	DisplayIcon="ui/arena/serpent.png",				Script = "scripts/entity/tactical/enemies/serpent" }
			Hyena						= { ID = Const.EntityType.Hyena,			Type = "Hyena",						Strength = 15,	MaxInComp = 5,	Variant = 0,	DisplayIcon="ui/arena/hyena.png",				Script = "scripts/entity/tactical/enemies/hyena" }
			FrenziedHyena				= { ID = Const.EntityType.Hyena,			Type = "FrenziedHyena",				Strength = 20,	MaxInComp = 5,	Variant = 0,	DisplayIcon="ui/arena/frenzied_hyena.png",		Script = "scripts/entity/tactical/enemies/hyena_high" }
			IfritLow					= { ID = Const.EntityType.SandGolem,		Type = "IfritLow",					Strength = 13,	MaxInComp = 6,	Variant = 0,	DisplayIcon="ui/arena/ifrit_low.png",			Script = "scripts/entity/tactical/enemies/sand_golem" }
			IfritMedium					= { ID = Const.EntityType.SandGolem,		Type = "IfritMedium",				Strength = 35,	MaxInComp = 2,	Variant = 0,	DisplayIcon="ui/arena/ifrit_medium.png",		Script = "scripts/entity/tactical/enemies/sand_golem_medium" }
			IfritHigh					= { ID = Const.EntityType.SandGolem,		Type = "IfritHigh",					Strength = 70,	MaxInComp = 1,	Variant = 0,	DisplayIcon="ui/arena/ifrit_high.png",			Script = "scripts/entity/tactical/enemies/sand_golem_high" }

			Wardog						= { ID = Const.EntityType.Wardog,			Type = "Wardog",					Strength = 10,	MaxInComp = 10,	Variant = 0,	DisplayIcon="ui/arena/wardog.png",				Script = "scripts/entity/tactical/wardog" }
			ArmoredWardog				= { ID = Const.EntityType.ArmoredWardog,	Type = "ArmoredWardog",				Strength = 13,	MaxInComp = 10,	Variant = 0,	DisplayIcon="ui/arena/wardog_armored.png",		Script = "scripts/entity/tactical/armored_wardog" }
			Warhound					= { ID = Const.EntityType.Warhound,			Type = "Warhound",					Strength = 13,	MaxInComp = 10,	Variant = 0,	DisplayIcon="ui/arena/warhound.png",			Script = "scripts/entity/tactical/warhound" }
		}
		CompositionNames = {
			BladeDancer		= [ "Blade Dancer", "Blade Dancer", "Blade Dancer", "Desert Devil", "Sword Devil", "Sword Saint" ]
			Direwolves		= [ "Direwolves", "Direwolves", "Direwolves", "Hounds", "Bloodhounds", "Pack Hunters", "Wardogs", "Canines", "Wolf Pack" ]
			Gladiators		= [ "Pit Fighters", "Gladiators", "Gladiators", "Gladiators", "Champions", "Fighters", "Arena Masters", "Men" ]
			Hyenas			= [ "Hyenas", "Hyenas", "Hyenas", "Blood Pack", "Mongrels", "Carrion Eaters" ]
			Indebted		= [ "Indebted", "Indebted", "Indebted", "Slaves", "Laborers", "War Criminals", "Deserters" ]
			Lindwurms		= [ "Lindwurms", "Lindwurms", "Lindwurms", "Lindwurms", "Great Serpents", "Giant Serpents", "Dragons", "Demi-Dragons", "Northwurms" ]
			Mercenaries		= [ "Iron Ravens", "Golden Order", "Swords of the South", "Wolves of Bleak Forest", "Black Shields", "Iron Crown Company", "Radobrecht's Swords", "Whistling Arrows", "Azure Boars", "Fang and Coin", "Red Legion", "Hungry Hounds", "Crimson Daggers", "King's End Company", "Black Company", "Second Sons", "Walther's Fellowship", "Grudgebringers", "Bernhard's Bears", "Silver Claw", "Iron Brotherhood", "Orcbane Company", "Iron Covenant", "Unbroken Third", "Dogs of War", "Falkenberg's Legion", "Free Men", "Lords of War", "Northern Company", "Forsaken Returned", "White Company", "Widowmakers", "Cold Hearts Company", "Burning Sun Company", "Chosen Few", "Dead Men", "Bronzeheads", "Markland Pikes", "Hammerguard", "Crowntakers", "Silverreach Spears", "Iron Pact", "Blood Bound", "Bulwark", "Dawn's March", "Sons of Winter", "Company of the River House", "Flaming Comet Company", "Grand Company", "Rightful Ravagers", "Forsaken Brigade", "Battle's Chosen", "Bringers of Peace", "Shields of the Night", "Mongrels", "Bone Wardens", "Lost Legion", "Jackals of Seigau" ]
			Nachzehrers		= [ "Nachzehrers", "Nachzehrers", "Nachzehrers", "Ghouls", "Devourers", "Gore Eaters" ]
			Nomads			= [ "Nomads", "Nomads", "Nomads", "Scourge", "Tyrants", "Serpents", "Scorpions", "Wanderers", "Bandits", "Outlaws", "Men" ]
			Unholds			= [ "Unholds", "Unholds", "Unholds", "Giants", "Giants", "Trolls" ]
			Serpents		= [ "Serpents", "Serpents", "Serpents", "Snakes", "Snakes", "Constrictors" ]
			Webknechts		= [ "Webknechts", "Webknechts", "Webknechts", "Spiders", "Spiders", "Arachnids", "Beholders" ]
		}
		CompositionTitles = {
			Desert			= [ "the Dune Sea", "the Silver Sands", "the Dead Sands", "the Golden Flats", "the Timeless Sands", "the Glittering Sands", "the Scorching Desert", "Emptiness", "the Emptiness", "the Burning Barrens", "the Southern Sands", "the Dusty Desert", "the Sea of Sand", "the Great Desert", "the Neverending Sands", "the Southern Reach", "the Mumbling Sands", "the Whispering Sands", "the Shifting Sands", "the Moaning Sands", "the Sparkling Sands", "the Glistening Flats", "the Dry Wastes", "the Lost Oasis", "the Green Shallows", "the Emerald Basin", "the Fruitful Shallows", "the Springs of Life", "the Gift of God", "the Prophet's Salvation", "the Wetlands" ]
			Forest			= [ "Bleak Forest", "Dire Woods", "Dismal Woods", "Dusky Forest", "Scoundrels' Forest", "Boar Woods", "Bandit's Rest", "Splinterdale", "Spiderwood", "Tickbrake", "the Druid's Grove", "Brittle Branch Woods", "Ravenhold", "Needlegrove", "the Rustling Thicket", "Mossy Pine Woods", "Crows Nest", "Black Forest", "Prowlers' Woods", "Gloomy Woods", "Wolfwood", "Black Woods", "Murmuring Woods", "Dark Thorn Wilds", "Hedgehog Thicket", "the Misty Covert", "Borderdale", "the Temple Grove", "Wretched Woods", "Elder Woods", "the Hexenwald", "the Ancient Forest", "Ranger's Rest", "Oldgrowth", "Hunter's Bosk", "Sylvan Woods", "Snapping Twig Forest", "Antlerfold", "Old Forest", "Greenwood Forest", "Mossy Woods", "Misty Woods", "Timberland", "Whispering Groves", "Grand Hare Woods", "the Chestnut Grove", "Blackwood Forest", "Stormy Woods", "the Wicked Woods", "Gray Toad Woodlands", "Crowned Oak Forest", "Elderberry Woods", "the Elm Grove", "Black Mole Woods", "Brookwood", "Springwood", "Everwoods", "Red Worm Woods", "Fiery Woods", "Smoldering Woods", "Ember Forest", "the Vibrant Grove", "Foxfold Forest", "Somerhurst", "Fireander", "Blood Woods", "Blazing Forest", "the Vermillion Woods", "Crimson Forest", "Auburn Woods", "Redwood", "Birch Timberland", "Waterwood Forest", "Pyrewood", "Beatroot Wilds", "Bogwood Grove", "Yellowleaf's Range", "Bloodbloom Woods", "Redbark Forest", "Firerock Grove" ]
			Hill			= [ "Bonefold Barrow", "Knight's Axe Hills", "Skullsbreath Mound", "the Ancient Knolls", "Oldlock Hills", "the Hummocks", "Knowesfold", "the Ancient Cairns", "Humming Hills", "the Misty Barrows", "Boulderhills", "the Ghost Hills", "the Shinglehumps", "Earthwatch Hills", "the Giant's Pebbles", "Buried Snake Hills", "Skullslide Hills", "Rustcave Hills", "Witchmount Hills", "Juniper Hills", "White Goat Mounds", "Barum", "the Reach", "the Whispering Hills", "the Bronze Hills", "Willowshire Hillside", "the Scarlet Hills", "the Giant's Slopes", "the Gloomy Hills", "the Collapsing Hills" ]
			Mountain		= [ "the Spine of the World", "Sleeping Giant's Back", "the Jagged Spires", "the Wall of the Gods", "the Dreaded Rocks", "Rocky Ridge", "Jagged Summit", "Silver Ridge", "Misty Summit", "the Iron Mountains", "Dragonteeth Mountain", "Eagleflight Mountain", "Mount Grimroof", "the Dunspike", "Dreadhorn", "Ravensbeak", "Mount Bulkhead", "the Bulwark", "the Cloddheads", "Hero's Fall", "the Yawning Gaps", "Mammothshoulders", "Swellpike Heights", "the Cloudcrest Mountains", "the Evermist Mountains", "Slaughtermount", "the Rift", "Thundering Peaks", "Glistening Heights", "the Deserted Rise", "the Vast Rise", "Moonlit Peaks", "the Ashen Pinnacle", "the Bare Peaks", "Shadow Mountain", "Grimestone Peaks", "Brimstone Shoulders", "the Iron Peaks" ]
			Plain			= [ "Vendland", "Speedwell Fields", "Plainshire", "Vinland", "the Lowlands", "the Windlands", "the Wide Watch", "the Glaucious Domain", "Markland", "Fast Clouds County", "Fairdale", "Fleetfeet's Range", "Wanderer's Boon", "Valeshire", "Ridland", "Greenfold", "Hogfolk", "Durum", "Shallowford", "Two Fields", "Kingmill", "Minceacre", "Glendale", "Brillfold", "Kindon", "Greenmere", "Mooseridge", "Altmark", "Neumark", "Fair Range", "Middlemark", "the Grasslands", "Moss Valley", "Wideacre", "Southbloom", "Dawnland", "Oak Wood Meadows", "Southwind Acres", "Meadowcove", "Willow's Fields", "Nightingale Valley", "Silversage Fields", "Heartsong's Range" ]
			Steppe			= [ "the Scrublands", "the Drylands", "the Torched Plains", "the Red Lowlands", "the Scorching Shire", "Golden Valley", "the Southern Steppe", "Southmark", "the Scald", "Bleached Bone Dale", "Droughtshire", "the Sunpan", "the Dryweeds", "Thornvale", "the Bronze Flats", "Dire Hold", "Parcheim", "Smallriver Hold", "Razorshrub", "Gnarlheim", "Gritstone", "Suderos", "Suderland", "Solsweald", "Rustyblade Mesa", "Muskena", "Solstein", "Southwatch", "Sunreach", "Sandshear", "Skauna", "Caskain", "Maraman", "Jundland", "the Borderlands" ]
			Swamp			= [ "the Black Marshes", "the Dead Ponds", "the Tar Fields", "Peatfold", "the Suffocating Bog", "the Eerie Marshes", "the Black Morass", "the Sticky Wallow", "the Dreaded Mire", "the Murky Swamplands", "Mortun", "Blackfan", "Gallowsbog", "Dungslump", "Houndsmarsh", "Shipreath Marsh", "the Cursed Lands", "Grimdowns", "the Reeds", "Froghold", "Spidergrove", "Duke's Demise", "the Bottomless Pits", "Poisonbreath Marshes", "Froglickers Grove", "Deadbottom", "the Wetlands", "the Marshlands", "the Desolate Moor", "Black Fumes Polder", "the Endless Polder", "Riverland Glades", "Southland Bowels", "the Azure Marsh", "Thousand Mirrors Bog", "the Narrow Quag", "the Glades of Decay", "the Ashen Wetlands", "the Savage Bog", "the Forbidden Waters", "Dreadmoor" ]

			BladeDancer		= [  ]
			Direwolves		= [  ]
			Hyenas			= [  ]
			Indebted		= [  ]
			Lindwurms		= [  ]
			Mercenaries		= [  ]
			Nachzehrers		= [ "Shuffling Bones Swale", "the Plague Graves", "Rotting Bones Rest", "White Bones Hollow", "Adventure's End", "Last Hope's End", "the Sunken Battlefield", "the Overflowing Grave", "the Field of Bones", "the Doomed Fields", "the Defiled Battlefield", "White Bones Menagerie", "Vulture's Feast", "Last Lord's Demise", "Skeleton Mountains" ]
			Nomads			= [ "the Desert Tents", "the Hidden Tents", "the Fleeting Camp", "the Flying Tents", "the Moving Tents", "the Golden Tents", "the Crimson Tents", "the Blazing Shelter", "the Wandering Tents", "the Sandcovered Tents", "the Hidden Camp", "the Travelers' Camp", "the Desert Shelter", "Desert Scourge Camp", "Raiders' Retreat", "Red Sands Camp", "Burning Sands Camp", "White Sands Camp", "Free-Souls Encampment", "Golden Sun Hideout", "Shifting Sands Hideout", "the City of Tents", "the Wandering City", "Blazing Sun Camp", "the Wandering Kingdom", "Dead Oasis Camp", "the City of Golden Sands" ]
			Unholds			= [ "the North", "the Highlands", "the Hills", "the Shadowed Lands" ]
			Serpents		= [ "the Slitherer's Den", "the Hissing Fang", "the Iridescent Scale" ]
			Webknechts		= [ "the Broodmother", "the Silk Oasis" ]
		}
	}
	Crownlings = {
		MaxParties				= 1
		MaxPartiesHolyWar		= 2
		MaxPartyResources		= 330
		WorldmapDescription		= "A free crownling company travelling the lands and lending their swords to the highest bidder."
		FoodLoot				= [
			"supplies/dates_item"
			"supplies/dried_lamb_item"
			"supplies/rice_item"
			"supplies/wine_item"
		]
		CrownlingCompanyNames	= [
			"Peregrine's Answer"
			"Scorpions"
			"Hand of Al-Kashim"
			"Tearful Hyenas"
			"Keepers of the Vault"
			"Sand and Sulphur Company"
			"Company of the Lone Tree"
		]
	}
}

::BDP.Crownlings.CrownlingCompanyNames.extend(Const.Strings.MercenaryCompanyNames);
