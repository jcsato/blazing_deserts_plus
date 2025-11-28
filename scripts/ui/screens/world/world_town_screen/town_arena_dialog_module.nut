town_arena_dialog_module <- inherit("scripts/ui/screens/ui_module", {
	m = {
		ArenaBuilding = null
	}

	function getArenaBuilding()			{ return m.ArenaBuilding; }
	function setArenaBuilding(_arena)	{ m.ArenaBuilding = _arena; }

	function create() {
		m.ID = "ArenaDialogModule";

		ui_module.create();
	}

	function destroy() {
		ui_module.destroy();
	}

	function clear() { }

	function onStartButtonPressed(_arenaSettings) {
		local settings = parseSettingsFromJS(_arenaSettings);

		local settlement = m.ArenaBuilding.getSettlement();
		local arena = World.Arena.getArenaByCityStateID(settlement.getID());
		World.Arena.setCurrentArena(arena);
		World.Arena.setCurrentComposition(settings.Composition);
		World.Arena.setChosenBros(settings.Bros);

		local event = new("scripts/events/events/special/arena_event");
		event.onPrepare();
		event.setScreen(event.getScreen(event.onDetermineStartScreen()));
		World.Events.m.ActiveEvent = event;

		m.Parent.onModuleClosed();
		World.State.showEventScreenFromTown(event, false, true);
	}

	function onLeaveButtonPressed() {
		m.Parent.onModuleClosed();
	}

	function parseSettingsFromJS(_arenaSettings) {
		return {
			Composition	= _arenaSettings.selectedFight
			Bros		= _arenaSettings.selectedBros
		}
	}

	function queryArenaInformation() {
		local settlement = m.ArenaBuilding.getSettlement();
		local arena = World.Arena.getArenaByCityStateID(settlement.getID());
		local comps = [];

		foreach (comp in arena.getCompositions()) {
			comps.push({
				CompositionID	= comp.getID()
				ImagePath		= comp.getDisplayIcon()
				Difficulty		= comp.getDifficulty()
				Pay				= comp.getPay()
				Name			= comp.getDisplayName()
				Text			= comp.getDisplayText()
				MaxBros			= comp.getAllowedEntrants()
				Conditions  	= comp.getConditions([])
			});
		}

		local brothers = World.getPlayerRoster().getAll();
		local roster = [];

		foreach(bro in brothers) {
			local skills = bro.getSkills();

			local entity = {
				ID					= bro.getID()
				Name				= bro.getName()
				ImagePath			= bro.getImagePath()
				Injuries			= []
				Traits				= []
				Stats				= {}
			};

			local injuries = skills.query(Const.SkillType.TemporaryInjury | Const.SkillType.SemiInjury);
			foreach(injury in injuries)
				entity.Injuries.push({ id = injury.getID(), imagePath = injury.getIconColored(), name = injury.getNameOnly() });

			local traits = skills.query(Const.SkillType.Trait | Const.SkillType.PermanentInjury)
			foreach(trait in traits)
				entity.Traits.push({ id = trait.getID(), imagePath = trait.getIconColored() });

			UIDataHelper.addStatsToUIData(bro, entity.Stats);

			roster.push(entity);
		}

		return {
			Title = arena.getName()
			Fights = comps
			Bros = roster
		};
	}
});
