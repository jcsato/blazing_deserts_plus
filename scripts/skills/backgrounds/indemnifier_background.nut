indemnifier_background <- inherit("scripts/skills/backgrounds/character_background", {
	m = { }

	function create() {
		character_background.create();

		m.ID			= "background.indemnifier";
		m.Name			= "Indemnifier";
		m.Icon			= "ui/backgrounds/background_bd_plus_04.png";

		m.BackgroundDescription	= "Indemnifiers are proud, highly disciplined men, all too familiar with the rigors of combat and physical labor.";
		m.GoodEnding			= "%name% the indemnifier eventually left the company, claiming the Gilder's will obligated his presence elsewhere. Last you heard, the knightly slave had returned to the south and remains there to this day, serving as a general for one of the city-state armies. Supposedly his authority on martial matters rivals that of the viziers, and on religious matters, that of the high priests.";
		m.BadEnding				= "%name% the indemnifier eventually left the company, claiming the Gilder's will obligated his presence elsewhere. Not long after, he ran afoul a group of manhunters who mistook him for an escaped slave. He willingly gave himself up, believing the courts of the south would clear up the misunderstanding, but he was sent to labor camp with other indebted without ever setting foot in the city. Last you heard, he was lynched by his fellow slaves when he tried to dissuade them from uprising.";

		m.HiringCost	= 60;
		m.DailyCost		= 10;

		m.Excluded		= [
			"trait.ailing"
			"trait.asthmatic"
			"trait.clumsy"
			"trait.cocky"
			"trait.craven"
			"trait.dastard"
			"trait.fainthearted"
			"trait.fear_undead"
			"trait.fear_beasts"
			"trait.fear_greenskins"
			"trait.fragile"
			"trait.greedy"
			"trait.hesitant"
			"trait.insecure"
			"trait.irrational"
			"trait.loyal"
			"trait.superstitious"
			"trait.teamplayer"
			"trait.tiny"
			"trait.weasel"
		];

		if (Math.rand(1, 100) > 40) {
			m.Bodies			= Const.Bodies.Muscular;
			m.Faces				= Const.Faces.AllMale;
			m.Hairs				= Const.Hair.AllMale;
			m.HairColors		= Const.HairColors.Young;
			m.Beards			= Const.Beards.Untidy;
		} else {
			m.Bodies			= Const.Bodies.SouthernMuscular;
			m.Faces				= Const.Faces.SouthernMale;
			m.Hairs				= Const.Hair.SouthernMale;
			m.HairColors		= Const.HairColors.Southern;
			m.Beards			= Const.Beards.Southern;
			m.Ethnicity			= 1;
		}
		m.BeardChance	= 45;

		m.Level			= Math.rand(1, 3);

		m.IsCombatBackground = true;
	}

	function getTooltip() {
		return [
			{ id = 1, type = "title", text = getName() }
			{ id = 2, type = "description", text = getDescription() }
		];
	}

	function onBuildDescription() {
		return "{As with many indemnifiers, %name% was taken at a young age and raised in a barracks with similarly brawny captives. | %name% is an indemnifier, a slave that has repaid their debt to the Gilder and is granted special privileges and combat training in return. | Once an indebted forced to fight in a gladiatorial pit, a wealthy patron saw %name%'s skill and had the man sent to the indemnifier barracks. | Indemnifiers are slave-knights used as bodyguards, soldiers, and civil servants. %name% is one such man. | For years, %name% toiled in the fields as an indebted. Then a passing vizier took notice of him, and for years more he trained in the barracks as an indemnifier. | %name%'s scarred body cuts an imposing figure, standing taller and wider than most men you've met. Such is the stock of prisoners that are molded into indemnifiers.} {While the man was paid wages and enjoyed a freedom out of reach for slaves and citizens alike, it was pride and esprit de corps that kept him content in his duties. | The man is wholly unlike the typical slaves of the south, bearing the discipline of a drill sergeant, the faith of a priest, and the composure of a statue. | As with most indemnifiers, the man holds no grudges about his imprisonment, instead embracing his role as an executor of the Gilder's will. | He holds a book of scriptures in one hand and a weapon in the other. Both are heavily worn from use. | Clad in heavy armor and shielded by his faith in the Gilder, you've seen fortresses less sturdy than the man before you. | At first embittered by his cruel fate, eventually the man embraced his new role and pursued his duties with an almost unnerving devotion.} {After years of service, some unknown circumstance forced %name% to leave his cohort. He refuses to elaborate on the matter. | As part of his duties, %name% served as a fire fighter. When a city district was set ablaze in the hedonistic carousal of a careless vizier, his entire cohort resigned in disgust. None dared stop them. | While policing the streets, he cut off the hand of a thief who stole from a petitioner. The thief turned out to be the son of a vizier, and the scandal saw %name% quietly expelled from his cohort's ranks. He doesn't seem to mind, affirmed in the justice of his actions. | One day, his patron was caught in a scandal and made indebted. While most of the estate was confiscated, the retainers were turned loose, and %name% found himself with none to command his loyalty. | He and the others in his cohort were sent to fight a hopeless battle, and %name% was the only survivor. Abandoned by the officer he fought under, the man wandered the deserts for a time before ending up here. He's surprisingly circumspect about the situation. | %name%'s cohort found their patron guilty of heresy and summarily executed him. His successor decided it prudent to simply discharge them without further punishment.} {With no where else to go, he now finds himself in the company of Crownlings and scapegraces. Perhaps this, too, is part of the Gilder's path? | While it's unusual to find an indemnifier open to sellswording, any band of fighters would benefit from his skill. | Ready for a career change, the indemnifier now seeks the company of mercenaries, though you suspect he's more interested in testing his loyalty to the Gilder than finding a new regent on the face of a coin. | The indemnifier approaches you with slow, deliberate movements and introduces himself in a steady voice. This act is enough to send the other men nearby fleeing in panic. Hmm. | Seeking new avenues for battles that shall bring glory to his god's name, the indemnifier now finds himself in the company of mercenaries. | Eager to get back to work, the man introduces himself and enthusiastically shakes your hand. Ow.}"
	}

	function onChangeAttributes() {
		local c = {
			Hitpoints		= [ 10	,	10	]
			Bravery			= [ 10	,	5	]
			Stamina			= [ 14	,	11	]
			MeleeSkill		= [ 8	,	9	]
			RangedSkill		= [ 7	,	9	]
			MeleeDefense	= [ 4	,	4	]
			RangedDefense	= [ 2	,	2	]
			Initiative		= [ -8	,	-3	]
		};

		return c;
	}

	function onSetAppearance() {
		local actor = getContainer().getActor();

		if (Math.rand(1, 100) <= 80) {
			local body = actor.getSprite("body");
			local tattoo_body = actor.getSprite("tattoo_body");

			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Color = body.Color;
			tattoo_body.Saturation = body.Saturation;
			tattoo_body.Visible = true;
		}

		if (Math.rand(1, 100) <= 50) {
			local tattoo_head = actor.getSprite("tattoo_head");

			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function onAddEquipment() {
		local items = getContainer().getActor().getItems();

		local weapons = [
			"weapons/oriental/two_handed_scimitar"
			"weapons/oriental/heavy_southern_mace"
			"weapons/oriental/polemace"
			"weapons/oriental/swordlance"
		];

		if (Const.DLC.Unhold) {
			weapons.extend([
				"weapons/polehammer"
				"weapons/two_handed_flanged_mace"
			]);
		}

		if (Const.DLC.Wildmen)
			weapons.push("weapons/bardiche");

		items.equip(new("scripts/items/" + weapons[Math.rand(0, weapons.len() - 1)]));

		if (items.hasEmptySlot(Const.ItemSlot.Offhand) && Math.rand(1, 100) < 50) {
			local offhand = [ "shields/oriental/metal_round_shield" ];

			items.equip(new("scripts/items/" + offhand[Math.rand(0, offhand.len() - 1)]));
		}

		local armors = [
			"armor/oriental/mail_and_lamellar_plating"
			"armor/mail_hauberk"
			"armor/oriental/southern_long_mail_with_padding"
			"armor/lamellar_harness"
			"armor/scale_armor"
			"armor/oriental/padded_mail_and_lamellar_hauberk"
		];

		items.equip(new("scripts/items/" + armors[Math.rand(0, armors.len() - 1)]));

		local chosenArmor = items.getItemAtSlot(Const.ItemSlot.Body);
		if (chosenArmor.getID() == "armor.body.mail_hauberk") {
			chosenArmor.setVariant(28);
			chosenArmor.updateVariant();
			chosenArmor.updateAppearance();
		}

		local helmets = [
			"helmets/oriental/southern_helmet_with_coif"
			"helmets/oriental/heavy_lamellar_helmet"
			"helmets/oriental/turban_helmet"
		];

		if (Const.DLC.Wildmen) {
			helmets.extend([
				"helmets/conic_helmet_with_closed_mail"
			]);
		}

		if (::mods_getRegisteredMod("sato_additional_equipment") != null) {
			helmets.extend([ "helmets/oriental/southern_conic_helmet_with_closed_mail" ]);
		}

		items.equip(new("scripts/items/" + helmets[Math.rand(0, helmets.len() - 1)]));
	}
})
