arena_composition <- {
	m = {
		ID					= 0
		Type				= ""
		DisplayName			= ""		// Serialized
		DisplayText			= ""
		Difficulty			= 1
		SignatureEntities	= []
		PotentialEntities	= []
		PotentialChampions	= []
		Entities			= []		// Serialized
		AllowedEntrants		= 3
		Pay					= 0			// Serialized
		Loot				= null		// Serialized
		PotentialTwists		= []
		Flags				= null		// Serialized
		Arena				= null
		Seed				= -1		// Serialized
		DayAdded			= 0			// Serialized
		BaseStrength		= 30
		MinDay				= 0
	}

	function getID()					{ return m.ID; }
	function getType()					{ return m.Type; }
	function getDisplayName()			{ return m.DisplayName; }
	function getDisplayText()			{ return m.DisplayText; }
	function getDifficulty()			{ return m.Difficulty; }
	function getPotentialEntities()		{ return m.PotentialEntities; }
	function getEntities()				{ return m.Entities; }
	function getAllowedEntrants()		{ return m.AllowedEntrants; }
	function getPay()					{ return m.Pay + getArena().getAdditionalPay(); }
	function getSeed()					{ return m.Seed; }
	function getDayAdded()				{ return m.DayAdded; }
	function getLoot()					{ return m.Loot; }
	function getPotentialTwists()		{ return m.PotentialTwists; }
	function getFlags()					{ return m.Flags; }
	function getArena()					{ return m.Arena; }
	function getBaseStrength()			{ return m.BaseStrength; }
	function getMinDay()				{ return m.MinDay; }

	function setID(_id)					{ m.ID = _id; }
	function setDisplayIcon(_icon)		{ m.DisplayIcon = _icon; }
	function setDisplayName(_name)		{ m.DisplayName = _name; }
	function setDisplayText(_text)		{ m.DisplayText = _text; }
	function setDifficulty(_difficulty)	{ m.Difficulty = _difficulty; }
	function setAllowedEntrants(_num)	{ m.AllowedEntrants = _num; }
	function setPay(_pay)				{ m.Pay = _pay; }
	function setSeed(_seed)				{ m.Seed = _seed; }
	function addLoot(_loot)				{ m.Loot.add(_loot); }
	function setArena(_arena)			{ m.Arena = WeakTableRef(_arena); }

	function generateDisplayName()		{ }

	function create() {
		m.Loot = new("scripts/items/stash_container");
		m.Loot.setResizable(true);

		m.Flags = new("scripts/tools/tag_collection");
	}

	function getConditions(_conditions = []) {
		_conditions.push({ Text = "Take up to " + getAllowedEntrants() + " brothers into battle" });

		foreach (item in m.Loot.getItems())
			_conditions.push({ Icon = item.getIcon(), Text = "Gain " + Const.Strings.getArticle(item.getName()) + item.getName() + " upon victory" });

		foreach (item in getArena().getAdditionalLoot().getItems())
			_conditions.push({ Icon = item.getIcon(), Text = "Gain " + Const.Strings.getArticle(item.getName()) + item.getName() + " upon victory" });

		if (hasChampions())
			_conditions.push({ Text = "Gain a named item upon victory" });

		_conditions.push({ Text = "Gain " + getPay() + " Crowns upon victory" });

		_conditions.push({ Text = "Gain up to " + ::BDP.Helpers.beautifyNumber(getPay() * ::BDP.Arena.PartialForceModifier * (getAllowedEntrants() - 1)) + " Crowns upon victory for fielding a partial force" });
		_conditions.push({ Text = "Gain " + ::BDP.Helpers.beautifyNumber(getPay() * ::BDP.Arena.CasualtyModifier) + " Crowns upon victory for each of your casualties" });

		return _conditions;
	}

	function buildComposition(_strength) {
		if (m.Seed == -1)
			m.Seed = Time.getRealTime() + Math.rand(1, 1000);

		m.Entities = [];

		// Get a mult between 0.85-0.95, 1.0, and 1.05-1.15
		local difficultyMult = 1.0 + (m.Difficulty - 2) * Math.rand(5, 15) * 0.01;
		local iterations = 0;
		local entityCounts = {};
		local allocatedStrength = 0;
		_strength = ::BDP.Helpers.beautifyNumber(_strength * difficultyMult);

		foreach (entity in m.SignatureEntities) {
			m.Entities.push(entity);
			entityCounts[entity.Type] <- 1;
			allocatedStrength += entity.Strength;
		}

		local championChance = 5;
		championChance += World.Assets.m.ChampionChanceAdditional;
		if (World.getTime().Days < 70)
			championChance -= 1

		if (m.Difficulty > 2 && m.PotentialChampions.len() > 0 && Math.rand(1, 100) < championChance) {
			local champion = m.PotentialChampions[Math.rand(0, m.PotentialChampions.len() - 1)];
			m.Entities.push(champion);
			entityCounts[champion.Type] <- 1;

			allocatedStrength += champion.Strength;
		}

		while(allocatedStrength < _strength && iterations < 100) {
			iterations++;
			local entity = m.PotentialEntities[Math.rand(0, m.PotentialEntities.len() - 1)];
			if (!((entity.Type in entityCounts) && entityCounts[entity.Type] + 1 == entity.MaxInComp)) {
				m.Entities.push(entity);
				if (entity.Type in entityCounts)
					entityCounts[entity.Type] += 1;
				else
					entityCounts[entity.Type] <- 1;

				allocatedStrength += entity.Strength;
			}
		}

		local strengthPayout = ::BDP.Helpers.beautifyNumber(_strength * ::BDP.Arena.PayoutStrengthMultiplier);
		local difficultyPayout = ::BDP.Helpers.beautifyNumber(difficultyMult * m.Difficulty * ::BDP.Arena.PayoutDifficultyBase);
		local payRandomizer = ::BDP.Helpers.beautifyNumber(Math.rand(-1 * (m.Difficulty * 10), (m.Difficulty * 15)));
		setPay(m.Pay + strengthPayout + difficultyPayout + payRandomizer);

		onAfterBuild();
	}

	function onAfterBuild() { }

	function hasChampions() {
		local hasChampions = false;

		foreach (entity in m.Entities) {
			if (entity.Variant != 0) {
				hasChampions = true;
				break;
			}
		}

		return hasChampions;
	}


	function getDisplayIcon() {
		m.Entities.sort(function(_entity1, _entity2) {
			if (_entity1.Strength > _entity2.Strength)
				return -1;
			else if (_entity1.Strength < _entity2.Strength)
				return 1;
			return 0;
		});

		if (m.Entities[0].Strength > m.SignatureEntities[0].Strength)
			return m.Entities[0].DisplayIcon;
		else
			return m.SignatureEntities[0].DisplayIcon;
	}

	function onSerialize(_out) {
		_out.writeI32(m.ID);
		_out.writeString(m.DisplayName);
		_out.writeI16(m.Difficulty);
		_out.writeF32(m.Pay);
		_out.writeU8(m.DayAdded);
		_out.writeI32(m.Seed);

		_out.writeU8(m.Entities.len())

		foreach (entity in m.Entities) {
			_out.writeString(entity.Type)
		}

		m.Loot.onSerialize(_out);

		m.Flags.onSerialize(_out);
	}

	function onDeserialize(_in) {
		m.ID = _in.readI32();
		m.DisplayName = _in.readString();
		m.Difficulty = _in.readI16();
		m.Pay = _in.readF32();
		m.DayAdded = _in.readU8();
		m.Seed = _in.readI32();

		local numEntities = _in.readU8();
		for (local i = 0; i < numEntities; ++i) {
			local entityType = _in.readString();

			if (entityType in ::BDP.Arena.EntityTypes)
				m.Entities.push(::BDP.Arena.EntityTypes[entityType]);
		}

		m.Loot.onDeserialize(_in);

		m.Flags.onDeserialize(_in, false);
	}
}
