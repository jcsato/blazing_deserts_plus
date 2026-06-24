arena <- {
	m = {
		NextCompositionID		= 1
		ID						= 0
		KnownCompositions		= []
		Compositions			= []
		FightsPerDay			= 1
		Name					= ""	// Serialized
		CityState				= null
		LastUpdatedDay			= 1		// Serialized
		MatchesFought			= 0		// Serialized
		MatchesFoughtTotal		= 0		// Serialized
		LastMatchLootUpdate		= 0		// Serialized
		AdditionalLoot			= null	// Serialized
		AdditionalPay			= 0
		ActiveTournament		= false	// Serialized
		TournamentMatchesFought	= 0		// Serialized
	}

	function getID()						{ return m.ID; }
	function getCompositions()				{ return m.Compositions; }
	function getFightsPerDay()				{ return m.FightsPerDay; }
	function getMatchesFought()				{ return m.MatchesFought; }
	function getMatchesFoughtTotal()		{ return m.MatchesFoughtTotal; }
	function getLastMatchLootUpdate()		{ return m.LastMatchLootUpdate; }
	function getAdditionalLoot()			{ return m.AdditionalLoot; }
	function getName()						{ return m.Name; }
	function getCityState()					{ return m.CityState; }
	function getTournamentMatchesFought()	{ return m.TournamentMatchesFought; }
	function isActiveTournament()			{ return m.ActiveTournament; }

	function setID(_id)						{ m.ID = _id; }
	function setName(_name)					{ m.Name = _name; }
	function setCityState(_c)				{ m.CityState = WeakTableRef(_c); }
	function setActiveTournament(_a)		{ m.ActiveTournament = _a; }

	function getAdditionalPay() {
		local extra = m.AdditionalPay;

		if (getCityState().hasSituation("situation.bread_and_games"))
			extra += ::BDP.Arena.RewardModifiers.BreadAndGames;

		return extra;
	}

	function create() {
		local compositionScripts = IO.enumerateFiles("scripts/arena/compositions/");
		foreach (compositionScript in compositionScripts) {
			// Don't create abstract compositions, and in the game
			if(compositionScript != "scripts/arena/compositions/arena_composition")
				m.KnownCompositions.push(compositionScript);
		}

		m.AdditionalLoot = new("scripts/items/stash_container");
		m.AdditionalLoot.setResizable(true);
	}

	function incrementMatchesFought()	{
		m.MatchesFought++;
		m.MatchesFoughtTotal++;

		if (m.ActiveTournament)
			m.TournamentMatchesFought++;
	}

	function removeComposition(_compID) {
		foreach (i, comp in m.Compositions) {
			if (comp.getID() == _compID) {
				m.Compositions.remove(i);
				break;
			}
		}
	}

	function addComposition(_comp) {
		m.Compositions.push(_comp);
	}

	function buildCompositions() {
		do {
			generateAndAddComposition();
		} while(m.Compositions.len() < ::BDP.Arena.BaselineCompositions);
	}

	function update() {
		if (getCityState().hasSituation("situation.arena_tournament") && !m.ActiveTournament)
			startTournament();

		// *Should* only get here (the situation timing out and getting removed) if the player hasn't fought a match in
		// the last day
		if (m.ActiveTournament && !getCityState().hasSituation("situation.arena_tournament"))
			endTournament();

		if (m.ActiveTournament)
			return;

		local updatePressure = World.getTime().Days - m.LastUpdatedDay;

		if (updatePressure <= 0)
			return;

		m.LastUpdatedDay = World.getTime().Days;
		m.MatchesFought = 0;

		local compsToRemove = [];

		// First, see if we should remove any existing comps
		foreach (i, comp in m.Compositions) {
			local daysSinceCompAdded = World.getTime().Days - comp.getDayAdded();
			if (daysSinceCompAdded > 3 && Math.rand(1, 100) < (50 + daysSinceCompAdded))
				m.Compositions.remove(i);
		}

		// Now, add the minimum number of comps
		while (m.Compositions.len() < ::BDP.Arena.MinCompositions) {
			generateAndAddComposition();
		}

		// Finally, add comps based on number of days away
		while (m.Compositions.len() < ::BDP.Arena.MaxCompositions && updatePressure > 0) {
			if (Math.rand(1, 100) < 90)
				generateAndAddComposition();

			updatePressure--;
		}

		updateAdditionalLoot();
	}

	function startTournament() {
		m.ActiveTournament = true;
		m.TournamentMatchesFought = 0;

		clear();

		m.FightsPerDay = ::BDP.Arena.TournamentCompositions;

		while (m.Compositions.len() < ::BDP.Arena.TournamentCompositions)
			generateAndAddComposition();
	}

	function endTournament() {
		m.ActiveTournament = false;
		m.TournamentMatchesFought = 0;

		m.FightsPerDay = 1;

		while (m.Compositions.len() < ::BDP.Arena.BaselineCompositions)
			generateAndAddComposition();

		// close the arena
		m.MatchesFought = getFightsPerDay();

		updateAdditionalLoot();
	}

	function updateAdditionalLoot() {
		if (m.MatchesFoughtTotal > m.LastMatchLootUpdate && m.MatchesFoughtTotal % 5 == 0) {
			m.LastMatchLootUpdate = m.MatchesFoughtTotal;

			if (Math.rand(1, 2) == 1) {
				local armor = new("scripts/items/armor/oriental/gladiator_harness");
				local upgrades = [ "scripts/items/armor_upgrades/light_gladiator_upgrade" ];

				if (m.MatchesFoughtTotal > 5)
					upgrades.push("scripts/items/armor_upgrades/heavy_gladiator_upgrade")

				armor.setUpgrade(new(upgrades[Math.rand(0, upgrades.len() - 1)]));

				m.AdditionalLoot.add(armor);
			} else {
				local helmet = new("scripts/items/helmets/oriental/gladiator_helmet");
				m.AdditionalLoot.add(helmet);
			}
		}
	}

	function generateAndAddComposition() {
		local comp = null;
		local days = World.getTime().Days;

		do {
			comp = new(m.KnownCompositions[Math.rand(0, m.KnownCompositions.len() - 1)]);

			if (days > comp.getMinDay())
				break;

			if (isActiveTournament() && ::BDP.Arena.TournamentCompositionTypes.find(comp.getID()) != null)
				break;
			else if (!isActiveTournament() && ::BDP.Arena.RegularCompositionTypes.find(comp.getID()) != null)
				break;
		} while(1);

		local difficulty = Math.rand(isActiveTournament() ? 2 : 1, 3);
		if (difficulty == 3) {
			if (days <= 5)
				difficulty = Math.rand(1, 2);
			else if (days <= 15)
				difficulty = Math.rand(1, 3);
		}

		comp.setID(m.NextCompositionID++);
		comp.setDifficulty(difficulty);
		comp.setArena(this);
		comp.buildComposition(comp.getBaseStrength() * comp.getDifficulty());
		comp.generateDisplayName();

		m.Compositions.push(comp);
	}

	function clear() {
		m.NextCompositionID = 1;
		m.Compositions = [];
	}

	function onSerialize(_out) {
		_out.writeI32(m.NextCompositionID);
		_out.writeI32(m.ID)
		_out.writeString(m.Name);
		_out.writeU8(m.LastUpdatedDay);
		_out.writeU8(m.MatchesFought);
		_out.writeU8(m.MatchesFoughtTotal);
		_out.writeU8(m.LastMatchLootUpdate);
		_out.writeU8(m.TournamentMatchesFought);
		_out.writeBool(m.ActiveTournament);

		_out.writeU8(m.Compositions.len());

		foreach (composition in m.Compositions) {
			_out.writeI32(composition.ClassNameHash);
			composition.onSerialize(_out);
		}

		m.AdditionalLoot.onSerialize(_out);
	}

	function onDeserialize(_in) {
		clear();

		m.NextCompositionID = _in.readI32();

		m.ID = _in.readI32();
		m.Name = _in.readString();
		m.LastUpdatedDay = _in.readU8();
		m.MatchesFought = _in.readU8();

		if (World.Statistics.getFlags().getAsInt("BDPVersion") >= 2) {
			m.MatchesFoughtTotal = _in.readU8();
			m.LastMatchLootUpdate = _in.readU8();
		} else {
			m.MatchesFoughtTotal = m.MatchesFought;
			m.LastMatchLootUpdate = m.MatchesFought;
		}

		if (World.Statistics.getFlags().getAsInt("BDPVersion") >= 4) {
			m.TournamentMatchesFought = _in.readU8();
			m.ActiveTournament = _in.readBool();
		}

		local numCompositions = _in.readU8();
		for (local i = 0; i < numCompositions; ++i) {
			local composition = new(IO.scriptFilenameByHash(_in.readI32()));
			composition.onDeserialize(_in);
			composition.setArena(this);
			m.Compositions.push(composition);
		}

		if (World.Statistics.getFlags().getAsInt("BDPVersion") >= 2)
			m.AdditionalLoot.onDeserialize(_in);

		if (m.ActiveTournament) {
			m.FightsPerDay = ::BDP.Arena.TournamentCompositions;
			foreach (composition in m.Compositions)
				composition.setAllowedEntrants(composition.getAllowedEntrants() + m.TournamentMatchesFought);
		}
	}
}
