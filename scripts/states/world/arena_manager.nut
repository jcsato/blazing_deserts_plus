arena_manager <- {
	m = {
		NextArenaID			= 1
		Arenas				= []
		CurrentArena		= null
		CurrentComposition	= null
		ChosenBros			= []
		EntityAlterations	= []
		LastUpdatedDay		= 0
	}

	function getArenas()		{ return m.Arenas; }
	function addArena(_arena)	{ m.Arenas.push(_arena); }

	function create() { }

	function getArena(_arenaID) {
		for (local i = 0; i < m.Arenas.len(); ++i) {
			if (m.Arenas[i].getID() == _arenaID)
				return m.Arenas[i];
		}

		return null;
	}

	function getArenaByCityStateID(_cityStateID) {
		for (local i = 0; i < m.Arenas.len(); ++i) {
			if (m.Arenas[i].getCityState().getID() == _cityStateID)
				return m.Arenas[i];
		}

		return null;
	}

	function getCurrentArena()			{ return m.CurrentArena; }
	function getCurrentComposition()	{ return m.CurrentComposition; }
	function getChosenBros()			{ return m.ChosenBros; }
	function getEntityAlterations()		{ return m.EntityAlterations; }

	function setCurrentArena(_arena) { m.CurrentArena = _arena; }

	function setCurrentComposition(_compID) {
		foreach (comp in m.CurrentArena.getCompositions()) {
			if (comp.getID() == _compID) {
				m.CurrentComposition = comp;
				return;
			}
		}
	}

	function addEntityAlteration(alteration) {
		m.EntityAlterations.push(alteration);
	}

	function resetEntityAlterations() {
		m.EntityAlterations = [];
	}

	function buildArena(_cityState) {
		local arena = new("scripts/arena/arena");

		arena.setID(m.NextArenaID++);
		arena.setName(generateArenaName(_cityState));
		arena.setCityState(_cityState);
		arena.buildCompositions();

		addArena(arena);
	}

	function generateArenaName(_cityState) {
		local names = [ "Arena", "Coliseum", "Pits", "Fighting Pit", "Ampitheater" ];
		local prefixes = [ "Great", "Glorious", "Crimson", "Gilder's", "Gilded" ];
		local suffixes = [ _cityState.getOwner().getNameOnly(), "the Sands", "the South" ];

		foreach (vizier in _cityState.getOwner().getRoster().getAll()) {
			suffixes.push(vizier.getNameOnly());
		}

		local name = "The ";
		local hasPrefix = Math.rand(1, 100) < 50;
		if (hasPrefix)
			name += prefixes[Math.rand(0, prefixes.len() - 1)] + " ";

		name += names[Math.rand(0, names.len() - 1)];

		if (!hasPrefix || (Math.rand(1, 100) + (hasPrefix ? 20 : 0)) < 60)
			name += " of " + suffixes[Math.rand(0, suffixes.len() - 1)];

		return name;
	}

	function applyEntityAlterations(_entity) {
		foreach (alteration in m.EntityAlterations)
			alteration(_entity);
	}

	function update() {
		// Only need to check once a day
		if (m.LastUpdatedDay >= World.getTime().Days)
			return;

		m.LastUpdatedDay = World.getTime().Days;

		foreach (arena in m.Arenas)
			arena.update();
	}

	function cleanup() {
		m.CurrentArena.removeComposition(m.CurrentComposition.getID());
		m.CurrentArena.incrementMatchesFought();

		local comps = m.CurrentArena.getCompositions();

		if (m.CurrentArena.isActiveTournament()) {
			foreach (comp in comps) {
				local currentStrength = comp.getTotalStrength();
				comp.strengthenComposition(::BDP.Arena.TournamentStrengthModifier * m.CurrentArena.getTournamentMatchesFought())
				local strengthIncrease = (comp.getTotalStrength() * 1.0) / currentStrength;
				comp.setPay(::BDP.Helpers.beautifyNumber(comp.getPay() * strengthIncrease));
				comp.setAllowedEntrants(comp.getAllowedEntrants() + 1);
			}

			if (comps.len() > 1)
				m.CurrentArena.removeComposition(comps[Math.rand(0, comps.len() - 1)].getID());

			local tournament = m.CurrentArena.getCityState().getSituationByID("situation.arena_tournament");

			if (tournament != null)
				tournament.setValidForDays(Math.max(1, tournament.getDefaultDays()));

			if (m.CurrentArena.getCompositions().len() == 0) {
				m.CurrentArena.endTournament();
			}
		}

		setCurrentComposition(null);
	}

	function setChosenBros(_broIDs) { m.ChosenBros = _broIDs; }

	function clear() {
		m.NextArenaID = 1;
		m.Arenas = [];
	}

	function onSerialize(_out) {
		_out.writeI32(m.NextArenaID);
		_out.writeU8(m.LastUpdatedDay);

		_out.writeU8(m.Arenas.len());
		foreach (arena in m.Arenas) {
			_out.writeI32(arena.getCityState().getID());
			arena.onSerialize(_out);
		}
	}

	function onDeserialize(_in) {
		clear();

		m.NextArenaID = _in.readI32();
		m.LastUpdatedDay = _in.readI8();

		local numArenas = _in.readI8();
		local settlements = World.EntityManager.getSettlements();
		for (local i = 0; i < numArenas; ++i) {
			local cityStateID = _in.readI32();
			local cityState = null;
			foreach (settlement in settlements) {
				if (settlement.getID() == cityStateID) {
					cityState = settlement;
					break;
				}
			}

			local arena = new("scripts/arena/arena");
			arena.onDeserialize(_in);
			arena.setCityState(cityState);
			m.Arenas.push(arena);
		}
	}
}
