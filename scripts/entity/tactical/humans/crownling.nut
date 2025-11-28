crownling <- inherit("scripts/entity/tactical/human", {

	m = { }

	function create() {
		m.Type				= Const.EntityType.Crownling;
		m.BloodType			= Const.BloodType.Red;
		m.XP				= Const.Tactical.Actor.Crownling.XP;

		human.create();

		m.Bodies			= Const.Bodies.SouthernMale;
		m.Faces				= Const.Faces.SouthernMale;
		m.Hairs				= Const.Hair.SouthernMale;
		m.HairColors		= Const.HairColors.Southern;
		m.Beards			= Const.Beards.Southern;
		m.Ethnicity			= 1;

		m.AIAgent = new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		m.AIAgent.setActor(this);
	}

	function onInit() {
		human.onInit();

		local b = m.BaseProperties;
		b.setValues(Const.Tactical.Actor.Crownling);

		m.ActionPoints			= b.ActionPoints;
		m.Hitpoints				= b.Hitpoints;
		m.CurrentProperties 	= clone b;

		setAppearance();

		getSprite("socket").setBrush("bust_base_militia");

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
		m.Skills.add(new("scripts/skills/perks/perk_quick_hands"));
		m.Skills.add(new("scripts/skills/perks/perk_battle_forged"));
		m.Skills.add(new("scripts/skills/perks/perk_anticipation"));
		m.Skills.add(new("scripts/skills/perks/perk_fast_adaption"));
		m.Skills.add(new("scripts/skills/perks/perk_backstabber"));
		m.Skills.add(new("scripts/skills/perks/perk_overwhelm"));

		m.Skills.add(new("scripts/skills/actives/rotation"));
		m.Skills.add(new("scripts/skills/actives/recover_skill"));
	}

	function onAppearanceChanged(_appearance, _setDirty = true) {
		actor.onAppearanceChanged(_appearance, false);
		setDirty(true);
	}

	function assignRandomEquipment() {
		local weapons = [
			"weapons/oriental/swordlance"
			"weapons/oriental/polemace"
			"weapons/oriental/two_handed_saif"
			"weapons/oriental/two_handed_scimitar"
			"weapons/oriental/firelance"
			"weapons/fighting_spear"
			"weapons/oriental/light_southern_mace"
			"weapons/oriental/heavy_southern_mace"
			"weapons/scimitar"
			"weapons/shamshir"
			"weapons/oriental/qatal_dagger"
			"weapons/two_handed_wooden_hammer"
		];

		if (Const.DLC.Unhold) {
			weapons.extend([
				"weapons/polehammer"
				"weapons/three_headed_flail"
			]);
		}

		if (Const.DLC.Wildmen) {
			weapons.extend([ "weapons/bardiche" ]);
		}

		m.Items.equip(new("scripts/items/" + weapons[Math.rand(0, weapons.len() - 1)]));

		if (m.Items.getItemAtSlot(Const.ItemSlot.Offhand) == null && Math.rand(0, 100) < 75) {
			local offhand = [
				"shields/oriental/southern_light_shield"
				"shields/oriental/metal_round_shield"
				"tools/daze_bomb_item"
				"tools/fire_bomb_item"
				"tools/throwing_net"
			];
			m.Items.equip(new("scripts/items/" + offhand[Math.rand(0, offhand.len() - 1)]));
		}

		if (getIdealRange() == 1 && Math.rand(1, 100) <= 50) {
			local secondaries = [
				"weapons/throwing_axe"
				"weapons/javelin"
			];
			m.Items.addToBag(new("scripts/items/" + secondaries[Math.rand(0, secondaries.len() - 1)]));
		}

		local armor = [
			"armor/oriental/southern_mail_shirt"
			"armor/oriental/mail_and_lamellar_plating"
			"armor/oriental/southern_long_mail_with_padding"
			"armor/mail_hauberk"
			"armor/reinforced_mail_hauberk"
			"armor/lamellar_harness"
		];

		if (Const.DLC.Unhold) {
			armor.extend([
				"armor/sellsword_armor"
				"armor/footman_armor"
				"armor/light_scale_armor"
			]);
		}

		m.Items.equip(new("scripts/items/" + armor[Math.rand(0, armor.len() - 1)]));

		local helmets = [
			"helmets/oriental/wrapped_southern_helmet"
			"helmets/oriental/spiked_skull_cap_with_mail"
			"helmets/oriental/nomad_reinforced_helmet"
			"helmets/reinforced_mail_coif"
			"helmets/oriental/southern_helmet_with_coif"
			"helmets/oriental/heavy_lamellar_helmet"
		];
		if (Const.DLC.Wildmen)
			helmets.extend([ "helmets/conic_helmet_with_closed_mail" ]);

		if (::mods_getRegisteredMod("sato_additional_equipment") != null)
			helmets.extend([ "helmets/oriental/southern_conic_helmet_with_closed_mail" ]);

		m.Items.equip(new("scripts/items/" + helmets[Math.rand(0, helmets.len() - 1)]));
	}
});
