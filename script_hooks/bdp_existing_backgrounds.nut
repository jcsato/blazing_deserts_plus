::mods_hookExactClass("skills/backgrounds/manhunter_background", function(mb) {
	local excludedTraits = ::mods_getField(mb, "Excluded");

	excludedTraits.push("trait.superstitious");
	::mods_addField(mb, "manhunter_background", "Excluded", excludedTraits);
});

::mods_hookExactClass("skills/backgrounds/assassin_southern_background", function(asb) {
	local create = ::mods_getMember(asb, "create");
	local onAddEquipment = ::mods_getMember(asb, "onAddEquipment");

	::mods_override(asb, "create", function() {
		create();

		m.HiringCost = 600;
		m.Level = Math.rand(1, 3);
	});

	::mods_override(asb, "onAddEquipment", function() {
		onAddEquipment();

		if (getContainer().getActor().getItems().getItemAtSlot(Const.ItemSlot.Body).getID() == "armor.body.assassin_robe" && Math.rand(1, 100) <= 33) {
			getContainer().getActor().getItems().unequip(getContainer().getActor().getItems().getItemAtSlot(Const.ItemSlot.Head));
			getContainer().getActor().getItems().equip(new("scripts/items/helmets/oriental/assassin_face_mask"));
		}
	});
});

::mods_hookExactClass("skills/backgrounds/nomad_ranged_background", function(nrb) {
	local onAddEquipment = ::mods_getMember(nrb, "onAddEquipment");

	::mods_override(nrb, "onAddEquipment", function() {
		onAddEquipment();

		if (getContainer().getActor().getItems().getItemAtSlot(Const.ItemSlot.Mainhand).getID() == "weapon.composite_bow" && Math.rand(1, 100) <= 20) {
			getContainer().getActor().getItems().unequip(getContainer().getActor().getItems().getItemAtSlot(Const.ItemSlot.Head));
			getContainer().getActor().getItems().equip(new("scripts/items/helmets/oriental/desert_stalker_head_wrap"));
		}
	});
});

::mods_hookExactClass("skills/backgrounds/gladiator_background", function(gb) {
	local onUpdate = ::mods_getMember(gb, "onUpdate");
	local getTooltip = ::mods_getMember(gb, "getTooltip");

	::mods_override(gb, "onUpdate", function(_properties) {
		onUpdate(_properties);

		local actor = getContainer().getActor();
		if (actor.isPlacedOnMap() && Time.getRound() < 1) {
			local isArena = ("State" in Tactical && Tactical.State != null && Tactical.State.getStrategicProperties() != null && Tactical.State.getStrategicProperties().IsArenaMode);

			if (isArena && actor.getMoraleState() < Const.MoraleState.Confident)
				actor.setMoraleState(Const.MoraleState.Confident);
		}
	});

	::mods_override(gb, "getTooltip", function() {
		local ret = getTooltip();

		ret.push({ id = 10, type = "text", icon = "ui/icons/morale.png", text = "Will start combat at confident morale when fighting in the arena" });

		return ret;
	});
});
