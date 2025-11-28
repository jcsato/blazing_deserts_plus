indemnifier <- inherit("scripts/entity/tactical/human", {
	m = { }

	function create() {
		m.Type				= Const.EntityType.Indemnifier;
		m.BloodType			= Const.BloodType.Red;
		m.XP				= Const.Tactical.Actor.Indemnifier.XP;

		human.create();

		if (Math.rand(0, 100) < 70) {
			m.Bodies			= Const.Bodies.Gladiator;
			m.Faces				= Const.Faces.SouthernMale;
			m.Hairs				= Const.Hair.SouthernMale;
			m.HairColors		= Const.HairColors.Southern;
			m.Beards			= Const.Beards.Southern;
			m.Ethnicity			= 1;
			m.Body				= Math.rand(0, m.Bodies.len() - 1);
		} else {
			m.Faces				= Const.Faces.AllMale;
			m.Hairs				= Const.Hair.CommonMale;
			m.HairColors		= Const.HairColors.All;
			m.Beards			= Const.Beards.All;
			m.Ethnicity			= 0;
		}

		m.AIAgent = new("scripts/ai/tactical/agents/military_melee_agent");
		m.AIAgent.setActor(this);
	}

	function onOtherActorDeath(_killer, _victim, _skill) {
		if (_victim.getType() == Const.EntityType.Slave && _victim.isAlliedWith(this))
			return;

		actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing(_actor) {
		if (_actor.getType() == Const.EntityType.Slave && _actor.isAlliedWith(this))
			return;

		actor.onOtherActorFleeing(_actor);
	}

	function onInit() {
		human.onInit();

		local b = m.BaseProperties;
		b.setValues(Const.Tactical.Actor.Indemnifier);
		b.TargetAttractionMult	= 1.0;

		m.ActionPoints			= b.ActionPoints;
		m.Hitpoints				= b.Hitpoints;
		m.CurrentProperties 	= clone b;

		setAppearance();

		getSprite("socket").setBrush("bust_base_southern");

		m.Skills.add(new("scripts/skills/perks/perk_mastery_axe"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_bow"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_cleaver"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_crossbow"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_dagger"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_flail"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_hammer"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_mace"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_polearm"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_spear"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_sword"));
		m.Skills.add(new("scripts/skills/perks/perk_mastery_throwing"));

		m.Skills.add(new("scripts/skills/perks/perk_brawny"));
		m.Skills.add(new("scripts/skills/perks/perk_shield_expert"));
		m.Skills.add(new("scripts/skills/perks/perk_fast_adaption"));
		m.Skills.add(new("scripts/skills/perks/perk_devastating_strikes"));
		m.Skills.add(new("scripts/skills/perks/perk_battle_forged"));
		m.Skills.add(new("scripts/skills/perks/perk_fearsome"));
		m.Skills.add(new("scripts/skills/perks/perk_hold_out"));
		m.Skills.add(new("scripts/skills/perks/perk_reach_advantage"));
		m.Skills.add(new("scripts/skills/actives/rotation"));

		m.Skills.add(new("scripts/skills/actives/recover_skill"));
	}

	function assignRandomEquipment() {
		local r;

		if (m.Items.hasEmptySlot(Const.ItemSlot.Mainhand)) {
			local weapons = [
				"weapons/shamshir"
				"weapons/oriental/heavy_southern_mace"
			];

			if (m.Items.hasEmptySlot(Const.ItemSlot.Offhand)) {
				weapons.extend([
					"weapons/oriental/swordlance"
					"weapons/oriental/two_handed_scimitar"
				]);

				if (Const.DLC.Unhold) {
					weapons.extend([
						"weapons/polehammer"
						"weapons/two_handed_flanged_mace"
					]);
				}

				if (Const.DLC.Wildmen)
					weapons.push("weapons/bardiche");
			}

			m.Items.equip(new("scripts/items/" + weapons[Math.rand(0, weapons.len() - 1)]));
		}

		if (m.Items.getItemAtSlot(Const.ItemSlot.Offhand) == null && Math.rand(0, 1) == 1)
			m.Items.equip(new("scripts/items/shields/oriental/metal_round_shield"));

		if (m.Items.hasEmptySlot(Const.ItemSlot.Body)) {
			local armors = [
				"armor/oriental/mail_and_lamellar_plating"
				"armor/oriental/southern_long_mail_with_padding"
				"armor/lamellar_harness"
				"armor/scale_armor"
				"armor/oriental/padded_mail_and_lamellar_hauberk"
			];

			m.Items.equip(new("scripts/items/" + armors[Math.rand(0, armors.len() - 1)]));
		}

		if (m.Items.hasEmptySlot(Const.ItemSlot.Head)) {
			local helmets = [
				"helmets/oriental/southern_helmet_with_coif"
				"helmets/oriental/heavy_lamellar_helmet"
				"helmets/oriental/turban_helmet"
			];

			if (Const.DLC.Wildmen)
				helmets.extend([ "helmets/conic_helmet_with_closed_mail" ]);

			if (::mods_getRegisteredMod("sato_additional_equipment") != null)
				helmets.extend([ "helmets/oriental/southern_conic_helmet_with_closed_mail" ]);

			m.Items.equip(new("scripts/items/" + helmets[Math.rand(0, helmets.len() - 1)]));
		}
	}
});
