crownling_ranged <- inherit("scripts/entity/tactical/human", {
	m = { }

	function create() {
		m.Type				= Const.EntityType.CrownlingRanged;
		m.BloodType			= Const.BloodType.Red;
		m.XP				= Const.Tactical.Actor.CrownlingRanged.XP;

		human.create();

		m.Bodies			= Const.Bodies.SouthernMale;
		m.Faces				= Const.Faces.SouthernMale;
		m.Hairs				= Const.Hair.SouthernMale;
		m.HairColors		= Const.HairColors.Southern;
		m.Beards			= Const.Beards.Southern;
		m.Ethnicity			= 1;

		m.AIAgent = new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		m.AIAgent.setActor(this);
	}

	function onInit() {
		human.onInit();

		local b = m.BaseProperties;
		b.setValues(Const.Tactical.Actor.CrownlingRanged);
		b.TargetAttractionMult = 1.1;

		m.ActionPoints			= b.ActionPoints;
		m.Hitpoints				= b.Hitpoints;
		m.CurrentProperties 	= clone b;

		setAppearance();

		getSprite("socket").setBrush("bust_base_militia");

		m.Skills.add(new("scripts/skills/perks/perk_mastery_bow"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_crossbow"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_dagger"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_mace"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_sword"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_throwing"));

		m.Skills.add(new("scripts/skills/perks/perk_quick_hands"));
		m.Skills.add(new("scripts/skills/perks/perk_crippling_strikes"));
		m.Skills.add(new("scripts/skills/perks/perk_coup_de_grace"));
		m.Skills.add(new("scripts/skills/perks/perk_fast_adaption"));
		m.Skills.add(new("scripts/skills/perks/perk_nimble"));
		m.Skills.add(new("scripts/skills/perks/perk_overwhelm"));
		m.Skills.add(new("scripts/skills/perks/perk_fearsome"));

		m.Skills.add(new("scripts/skills/actives/rotation"));
		m.Skills.add(new("scripts/skills/actives/footwork"));
		m.Skills.add(new("scripts/skills/actives/recover_skill"));
	}

	function onAppearanceChanged(_appearance, _setDirty = true) {
		actor.onAppearanceChanged(_appearance, false);
		setDirty(true);
	}

	function assignRandomEquipment() {
		local weaponKits = [
			[
				"weapons/oriental/composite_bow"
				"ammo/quiver_of_arrows"
			],
			[
				"weapons/war_bow"
				"ammo/quiver_of_arrows"
			],
			[
				"weapons/oriental/handgonne"
				"ammo/powder_bag"
			],
			[
				"weapons/oriental/handgonne"
				"ammo/powder_bag"
			]
		];

		local r = Math.rand(0, weaponKits.len() - 1);
		foreach (item in weaponKits[r])
			m.Items.equip(new("scripts/items/" + item));

		if (r > 1) {
			m.AIAgent = new("scripts/ai/tactical/agents/military_gunner_agent");
			m.AIAgent.setActor(this);
		}

		local backupWeapons = [
			"weapons/dagger"
			"weapons/oriental/qatal_dagger"
			"weapons/oriental/nomad_mace"
			"weapons/oriental/saif"
		];

		m.Items.equip(new("scripts/items/" + backupWeapons[Math.rand(0, backupWeapons.len() - 1)]));

		local armor = [
			"armor/oriental/linothorax"
			"armor/oriental/southern_mail_shirt"
			"armor/oriental/plated_nomad_mail"
			"armor/oriental/mail_and_lamellar_plating"
		];
		m.Items.equip(new("scripts/items/" + armor[Math.rand(0, armor.len() - 1)]));

		local helmets = [
			"helmets/oriental/southern_head_wrap"
			"helmets/oriental/wrapped_southern_helmet"
			"helmets/oriental/spiked_skull_cap_with_mail"
			"helmets/oriental/nomad_light_helmet"
			"helmets/oriental/nomad_reinforced_helmet"
		];
		m.Items.equip(new("scripts/items/" + helmets[Math.rand(0, helmets.len() - 1)]));
	}
});
