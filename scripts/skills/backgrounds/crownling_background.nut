crownling_background <- inherit("scripts/skills/backgrounds/character_background", {
	m = { }

	function create() {
		character_background.create();

		m.ID			= "background.crownling";
		m.Name			= "Crownling";
		m.Icon			= "ui/backgrounds/background_bd_plus_02.png";

		m.BackgroundDescription	= "Crownlings charge a premium for their services, but any who live long in the profession can back it up with skill.";
		m.GoodEnding			= "%name% the crownling eventually left the %companyname% and started his own mercenary company. Last you heard, they're so highly regarded that the viziers keep them on retainer just to ensure no northern lord gains control of their services.";
		m.BadEnding				= "%name% the crownling left the %companyname% and started his own competing company. The venture was cut short when a vizier decided the man had a poor attitude and ordered them slain on the spot. He made it palace gates before a conscript ran him through.";

		m.HiringCost	= 100;
		m.DailyCost		= 35;

		m.Excluded			= [
			"trait.weasel",
			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.superstitious",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];

		m.Bodies		= Const.Bodies.SouthernMuscular;
		m.Faces			= Const.Faces.SouthernMale;
		m.Hairs			= Const.Hair.SouthernMale;
		m.HairColors	= Const.HairColors.Southern;
		m.Beards		= Const.Beards.Southern;
		m.Ethnicity		= 1;

		m.Names			= Const.Strings.SouthernNames;
		m.LastNames		= Const.Strings.SouthernNamesLast;

		m.Level			= Math.rand(2, 4);

		m.IsCombatBackground = true;
	}

	function getTooltip() {
		return [
			{ id = 1, type = "title", text = getName() }
			{ id = 2, type = "description", text = getDescription() }
		];
	}

	function onBuildDescription() {
		return "{Uncommon in the south, %name% is a Crownling, a sword for hire. | Though not as common than their northern counterparts, the Crownlings of the south are no less eager for combat if the coin is right. %name% is one such mercenary. | %name% was once a dockworker, until one day he got into a fight with a Crownling and killed the man. The mercenary's captain hired him on the spot, and he's risen through death ever since. | Always drawing the wrong kind of attention to himself, %name% joined a passing Crownling band to avoid being branded indebted. | %name% is a consummate Crownling, a cutthroat killer ready to ply his trade for coin. | Crownlings are often looked down upon in the south, viewed as just another kind of slave, shackled by the pursuit of gold. %name%'s own trail of blood and coin as a mercenary suggests he doesn't particularly care. | A former gladiator, %name% turned to mercenary work when he realized his career in the arena would be short. His long stint as a Crownling has proven much more successful and no less bloody. | Though often shunned in the south, Crownlings like %name% never go long without work.} {An expert with weapons both exotic and common, his skills have been tested by battle over and over again. | The man boasts he once negotiated a contract over breakfast, slaughtered per its terms before lunch, and used his pay to buy dinner. | Absentmindedly tending this piece of gear and that, he carries himself with the practiced efficiency of a seasoned warrior. | Though he claims to have an affinity for firearms and other exotic weapons, he's clearly no stranger to the shieldwall, either. | With practiced ease, the man recites how many men he's killed in the past month. He says he doesn't keep track of beasts. | From guarding caravans to manhunts to fighting professional soldiers, the man has seen it all.} {A loner at heart, %name% mostly keeps to himself but will occasionally share a tale from this campaign or that. | %name% keeps his own company in camp, having seen too many in his trade die already to grow attached. | %name% has seen bloody carnage and wanton destruction that would scar most men, but to him are just another day on the job. | While the prospect of combat brings out despair in some, it seems to be the only thing that elicits cheer from %name%. | Some passersby whisper that %name% is ensorcelled by an ifrit, and now carries their bloodlust in his heart. A raised eyebrow sends them scuttling off in fear.} {Murmuring some aphorism about the Gilder's gleam, he claps his hands together and inquires about pay. | He gives an easy smile with no emotion behind it, and sits down to discuss contract terms. | With the slightest of nods, he agrees to sign off if the pay is acceptable. | Though he claims he follows the Gilder's will, you know he'll tread any trail as long as it's paved with gold. | With a quick flourish of his weapon and a quicker prayer, he says he'll offer you a fair rate if you wish to hire him on.}"
	}


	function onSetAppearance()
	{
		local actor = getContainer().getActor();

		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if(Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if(Math.rand(1, 100) <= 30)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = getContainer().getActor();

		local tattoo_body = actor.getSprite("tattoo_body");

		if(tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes() {
		local c = {
			Hitpoints		= [ 0	,	0	]
			Bravery			= [ 8	,	5	]
			Stamina			= [ 0	,	0	]
			MeleeSkill		= [ 11	,	11	]
			RangedSkill		= [ 12	,	12	]
			MeleeDefense	= [ 4	,	7	]
			RangedDefense	= [ 4	,	7	]
			Initiative		= [ 0	,	0	]
		};

		return c;
	}

	function onAddEquipment() {
		local items = getContainer().getActor().getItems();

		local weapons = [
			"weapons/scimitar"
			"weapons/oriental/firelance"
			"weapons/oriental/firelance"
			"weapons/oriental/firelance"
			"weapons/oriental/firelance"
			"weapons/oriental/qatal_dagger"
			"weapons/oriental/light_southern_mace"
			"weapons/oriental/heavy_southern_mace"
			"weapons/oriental/swordlance"
			"weapons/oriental/polemace"
			"weapons/oriental/handgonne"
			"weapons/oriental/handgonne"
		];

		if (Const.DLC.Wildmen)
			weapons.push("weapons/scimitar");

		items.equip(new("scripts/items/" + weapons[Math.rand(0, weapons.len() - 1)]));

		if (items.getItemAtSlot(Const.ItemSlot.Mainhand).getID() == "weapon.handgonne")
			items.equip(new("scripts/items/ammo/powder_bag"));


		if (items.hasEmptySlot(Const.ItemSlot.Offhand) && Math.rand(1, 100) < 60) {
			local offhand = [
				"tools/throwing_net"
				"tools/daze_bomb_item"
				"tools/fire_bomb_item"
				"shields/oriental/southern_light_shield"
				"shields/oriental/metal_round_shield"
			];

			items.equip(new("scripts/items/" + offhand[Math.rand(0, offhand.len() - 1)]));
		}

		local armors = [
			"armor/oriental/linothorax"
			"armor/oriental/stitched_nomad_armor"
			"armor/oriental/southern_mail_shirt"
			"armor/oriental/southern_mail_shirt"
			"armor/oriental/mail_and_lamellar_plating"
			"armor/mail_hauberk"
		];

		items.equip(new("scripts/items/" + armors[Math.rand(0, armors.len() - 1)]));

		local chosenArmor = items.getItemAtSlot(Const.ItemSlot.Body);
		if (chosenArmor.getID() == "armor.body.mail_hauberk") {
			chosenArmor.setVariant(28);
			chosenArmor.updateVariant();
			chosenArmor.updateAppearance();
		}

		local helmets = [
			"helmets/oriental/nomad_head_wrap"
			"helmets/oriental/leather_head_wrap"
			"helmets/oriental/wrapped_southern_helmet"
			"helmets/oriental/wrapped_southern_helmet"
			"helmets/oriental/spiked_skull_cap_with_mail"
			"helmets/oriental/spiked_skull_cap_with_mail"
		];

		items.equip(new("scripts/items/" + helmets[Math.rand(0, helmets.len() - 1)]));
	}
});
