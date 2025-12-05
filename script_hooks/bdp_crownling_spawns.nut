::mods_hookNewObject("entity/world/entity_manager", function(em) {
	em.m.Crownlings <- [];
	em.m.LastCrownlingUpdateTime <- 0;

	local manageAIMercenaries = ::mods_getMember(em, "manageAIMercenaries");
	local onSerialize = ::mods_getMember(em, "onSerialize");
	local onDeserialize = ::mods_getMember(em, "onDeserialize");

	::mods_override(em, "manageAIMercenaries", function() {
		manageAIMercenaries();

		local dead = [];

		foreach (index, crownlingParty in m.Crownlings) {
			if (crownlingParty.isNull() || !crownlingParty.isAlive())
				dead.push(index);
		}

		dead.reverse();

		foreach (crownlingParty in dead)
			m.Crownlings.remove(crownlingParty);

		if (m.LastCrownlingUpdateTime + 3.0 > Time.getVirtualTimeF())
			return;

		m.LastCrownlingUpdateTime = Time.getVirtualTimeF();

		if (m.Crownlings.len() < ::BDP.Crownlings.MaxParties || (World.FactionManager.isHolyWar() && m.Crownlings.len() < ::BDP.Crownlings.MaxPartiesHolyWar)) {
			local playerTile = World.State.getPlayer().getTile();
			local candidateSettlements = [];

			foreach (settlement in World.EntityManager.getSettlements()) {
				if (settlement.isIsolated())
					continue;

				if (settlement.getTile().getDistanceTo(playerTile) <= 10)
					continue;

				candidateSettlements.push(settlement);
			}

			local selectedSettlement = candidateSettlements[Math.rand(0, candidateSettlements.len() - 1)];

			local party = World.spawnEntity("scripts/entity/world/party", selectedSettlement.getTile().Coords);
			party.setPos(createVec(party.getPos().X - 50, party.getPos().Y - 50));
			party.setDescription(::BDP.Crownlings.WorldmapDescription);
			party.setFootprintType(Const.World.FootprintsType.Mercenaries);

			// Used for the merc party ambition, an achievement, "Hired by" in the world map tooltip, and some faction order stuff
			party.getFlags().set("IsMercenaries", true);

			// Used to make mercenary_order spawn crownlings and not mercs upon reaching destination settlements
			party.getFlags().set("IsCrownlings", true);

			if (selectedSettlement.getFactions().len() == 1)
				party.setFaction(selectedSettlement.getOwner().getID());
			else
				party.setFaction(selectedSettlement.getFactionOfType(Const.FactionType.Settlement).getID());

			local r = Math.min(::BDP.Crownlings.MaxPartyResources, 150 + World.getTime().Days);
			Const.World.Common.assignTroops(party, Const.World.Spawn.Crownlings, Math.rand(r * 0.8, r), 0);

			party.getLoot().Money = Math.rand(300, 600);
			party.getLoot().ArmorParts = Math.rand(0, 25);
			party.getLoot().Medicine = Math.rand(0, 10);
			party.getLoot().Ammo = Math.rand(0, 50);

			for (local i = 0; i < 2; ++i) {
				local r = Math.rand(1, 4);
				party.addToInventory(::BDP.Crownlings.FoodLoot[Math.rand(0, ::BDP.Crownlings.FoodLoot.len() - 1)]);
			}

			party.getSprite("base").setBrush("world_base_07");
			party.getSprite("body").setBrush("figure_crownling_0" + Math.rand(1, 2));

			// Technically possible for a merc (not crownling) company that spawns after a crownling company to have a
			//  duplicate name/banner, since we aren't altering the merc company spawn to check for crownlings.
			local mercList = [];
			mercList.extend(m.Crownlings);
			mercList.extend(m.Mercenaries);

			while (true) {
				local name = ::BDP.Crownlings.CrownlingCompanyNames[Math.rand(0, ::BDP.Crownlings.CrownlingCompanyNames.len() - 1)];

				if (name == World.Assets.getName())
					continue;

				local abort = false;

				foreach (crownlingParty in mercList) {
					if (crownlingParty.getName() == name) {
						abort = true;
						break;
					}
				}

				if (abort)
					continue;

				party.setName(name);
				break;
			}

			while (true) {
				local banner = Const.PlayerBanners[Math.rand(0, Const.PlayerBanners.len() - 1)];

				if (banner == World.Assets.getBanner())
					continue;

				local abort = false;

				foreach(crownlingParty in mercList) {
					if (crownlingParty.getBanner() == banner) {
						abort = true;
						break;
					}
				}

				if (abort)
					continue;

				party.getSprite("banner").setBrush(banner);
				break;
			}

			m.Crownlings.push(WeakTableRef(party));
		}

		foreach (crownlingParty in m.Crownlings) {
			crownlingParty.updatePlayerRelation();

			if (!crownlingParty.getController().hasOrders()) {
				local candidateSettlements = [];

				foreach (settlement in m.Settlements) {
					if (!settlement.isAlive() || settlement.isIsolated())
						continue;

					if (!settlement.isAlliedWith(crownlingParty))
						continue;

					if (settlement.getTile().ID == crownlingParty.getTile().ID)
						continue;

					candidateSettlements.push(settlement);
				}

				if (candidateSettlements.len() == 0)
					continue;

				local destination = candidateSettlements[Math.rand(0, candidateSettlements.len() - 1)];
				local controller = crownlingParty.getController();

				local wait1 = new("scripts/ai/world/orders/wait_order");
				wait1.setTime(Math.rand(10, 60) * 1.0);
				controller.addOrder(wait1);

				local move = new("scripts/ai/world/orders/move_order");
				move.setDestination(destination.getTile());
				move.setRoadsOnly(false);
				controller.addOrder(move);

				local wait2 = new("scripts/ai/world/orders/wait_order");
				wait2.setTime(Math.rand(10, 60) * 1.0);
				controller.addOrder(wait2);

				local mercenary = new("scripts/ai/world/orders/mercenary_order");
				mercenary.setSettlement(destination);
				controller.addOrder(mercenary);
			}
		}
	});

	::mods_override(em, "onSerialize", function(_out) {
		onSerialize(_out);

		if (_out.getMetaData().getInt("BDPVersion") >= 3) {
			local numCrownlings = 0;

			foreach (crownling in m.Crownlings) {
				if (crownling != null && !crownling.isNull() && crownling.isAlive())
					++numCrownlings;
			}

			_out.writeU8(numCrownlings);

			foreach (crownling in m.Crownlings) {
				if (crownling != null && !crownling.isNull() && crownling.isAlive())
					_out.writeU32(crownling.getID());
			}
		}
	});

	::mods_override(em, "onDeserialize", function(_in) {
		onDeserialize(_in);

		if (_in.getMetaData().getInt("BDPVersion") >= 3) {
			local numCrownlings = _in.readU8();
			for (local i = 0; i != numCrownlings; ++i) {
				local crownling = World.getEntityByID(_in.readU32());

				if(crownling != null)
					m.Crownlings.push(WeakTableRef(crownling));
			}
		}
	});
});

::mods_hookExactClass("ai/world/orders/mercenary_order", function(mo) {
	local onExecute = ::mods_getMember(mo, "onExecute");

	::mods_override(mo, "onExecute", function(_entity, _hasChanged) {
		local respawning = true;
		if (m.TargetSettlement == null || m.TargetSettlement.isNull() || !m.TargetSettlement.isAlive())
			respawning = false;

		if (m.TargetSettlement.getTile().ID != _entity.getTile().ID)
			respawning = false;

		local ret = onExecute(_entity, _hasChanged);

		if (_entity.getFlags().get("IsCrownlings")) {
			_entity.clearTroops();

			local r = Math.min(350, 150 + World.getTime().Days);
			local brush = _entity.getSprite("body").getBrush().Name;
			Const.World.Common.assignTroops(_entity, Const.World.Spawn.Crownlings, Math.rand(r * 0.8, r), 0);
			_entity.getSprite("body").setBrush(brush);
		}

		return ret;
	});
});
