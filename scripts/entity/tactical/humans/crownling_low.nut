crownling_low <- inherit("scripts/entity/tactical/humans/crownling", {
	m = { }

	function create() {
		crownling.create();

		m.XP				= Const.Tactical.Actor.BanditRaider.XP;
	}

	function onInit() {
		crownling.onInit();

		m.BaseProperties.MeleeSkill -= 5;
		m.BaseProperties.MeleeDefense -= 5;
		m.BaseProperties.RangedDefense -= 5;
		m.BaseProperties.FatigueRecoveryRate = 15;
		m.Skills.update();

		m.Skills.removeByID("perk.backstabber");
		m.Skills.removeByID("perk.overwhelm");
		m.Skills.removeByID("perk.fast_adaption");
	}

	function onAppearanceChanged(_appearance, _setDirty = true) {
		actor.onAppearanceChanged(_appearance, false);
		setDirty(true);
	}

	function assignRandomEquipment() {
		local weapons = [
			"weapons/oriental/polemace"
			"weapons/oriental/two_handed_saif"
			"weapons/oriental/firelance"
			"weapons/boar_spear"
			"weapons/oriental/light_southern_mace"
			"weapons/scimitar"
			"weapons/two_handed_wooden_hammer"
		];

		if (Const.DLC.Unhold)
			weapons.push("weapons/three_headed_flail");

		m.Items.equip(new("scripts/items/" + weapons[Math.rand(0, weapons.len() - 1)]));

		if (m.Items.getItemAtSlot(Const.ItemSlot.Offhand) == null && Math.rand(0, 100) < 75) {
			local offhand = [
				"shields/oriental/southern_light_shield"
				"tools/daze_bomb_item"
				"tools/fire_bomb_item"
				// "tools/smoke_bomb_item"
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
			"armor/oriental/padded_vest"
			"armor/oriental/linothorax"
			"armor/oriental/southern_mail_shirt"
			"armor/oriental/stitched_nomad_armor"
			"armor/oriental/plated_nomad_mail"
			"armor/oriental/leather_nomad_robe"
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
