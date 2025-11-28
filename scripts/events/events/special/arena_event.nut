arena_event <- inherit("scripts/events/event", {
	m = {
		Bros	= []
		Twist	= null
	}

	function create() {
		m.ID		= "event.arena";
		m.Title		= "";
		m.IsSpecial = true;

		m.Screens.push({
			ID			= "ArenaFight"
			Text		= ""
			Image		= ""
			List		= [ ]
			Characters	= [ ]
			Options		= [
				{
					Text = "{Let's give the crowd something to cheer for! | We shall turn the sand red with blood! | I want to hear the crowd chant our names! | We'll slaughter them like lambs!}"
					function getResult(_event) {
						local properties = _event.buildArenaCombatProperties(_event.m.Bros, World.Arena.getCurrentComposition().getEntities());

						_event.registerToShowAfterCombat("ArenaVictory", "ArenaDefeat");

						World.State.startScriptedCombat(properties, false, false, true);

						return 0;
					}
				}
			]

			function start(_event) {
				_event.m.Title = "In " + World.Arena.getCurrentArena().getName() + "...";
				Text = "[img]gfx/ui/events/event_155.png[/img]Dozens of men mingle about the arena's entrance. Some stand stoically, not wishing to give any hint of their capabilities. Others, however, boast and brag with aplomb, either sincerely confident in their martial skills or hoping their bravado masks any holes in their game.\n\n";
				Text += "A grizzled man, the master of the arena, holds up a scroll and taps it with a hook for a hand.\n\n";
				Text += "You'll be facing the " + World.Arena.getCurrentComposition().getDisplayName() + ". Either you leave the arena alive, or they do. See that it's you, aye? May your path be ever Gilded.";

				local roster = World.getPlayerRoster().getAll();
				foreach (bro in roster) {
					if (World.Arena.getChosenBros().find(bro.getID()) != null)
						_event.m.Bros.push(bro);
				}

				_event.setArenaFlags();
			}
		});

		m.Screens.push({
			ID			= "ArenaVictory"
			Text		= "[img]gfx/ui/events/event_147.png[/img]{The arena master talks as if he doesn't even remember your face, then again he probably doesn't.%SPEECH_ON%Here's your pay, please come again.%SPEECH_OFF%The arena will be closed for the day, but you could return as early as tomorrow. | Without even raising his head from a rag of papyrus, the arena master throws you a purse of coin.%SPEECH_ON%I heard the crowds, and so here are your crowns. May you come visit the pits again.%SPEECH_OFF%The arena will be closed for the day, but you could return as early as tomorrow. | The arena master is waiting for you.%SPEECH_ON%That was a mighty fine show, Crownling. Would not mind it in the slightest if you come back again.%SPEECH_OFF%The arena will be closed for the day, but you could return as early as tomorrow.}"
			Image		= ""
			List		= [ ]
			Characters	= [ ]
			Options		= [
				{
					Text = "{Victory! | Are you not entertained?! | Killed it. | A bloody spectacle.}"
					function getResult(_event) {
						_event.postFightCleanup(true);

						return 0;
					}
				}
			]

			function start(_event) {
				local rewards = _event.getRewards();

				World.Assets.addBusinessReputation(rewards.Reputation);
				World.Assets.addMoney(rewards.Pay);

				List.push({ id = 10, icon = "ui/icons/asset_money.png", text = "You gain [color=" + Const.UI.Color.PositiveEventValue + "]" + rewards.Pay + "[/color] Crowns" });

				foreach (loot in rewards.Loot) {
					// Need to call onCombatFinished and removeFromContainer to properly deal with champion items
					loot.onCombatFinished();
					loot.removeFromContainer();
					World.Assets.getStash().add(loot);
					List.push( { id = 10, icon = "ui/items/" + loot.getIcon(), text = "You gain " + Const.Strings.getArticle(loot.getName()) + loot.getName() } );
				}

				foreach (loot in World.Arena.getCurrentArena().getAdditionalLoot().getItems()) {
					loot.removeFromContainer();
					World.Assets.getStash().add(loot);
					List.push( { id = 10, icon = "ui/items/" + loot.getIcon(), text = "You gain " + Const.Strings.getArticle(loot.getName()) + loot.getName() } );
				}

				World.Arena.getCurrentArena().getAdditionalLoot().clear();

				local promotions = _event.getPromotions();

				foreach (promotion in promotions)
					List.push(promotion);
			}
		});

		m.Screens.push({
			ID			= "ArenaDefeat"
			Text		= "[img]gfx/ui/events/event_147.png[/img]{The %companyname%'s men have been defeated, either dead or, perhaps worse, badly mangled. At least the crowds are happy. In the pits, any showing, even that which ends in demise, is a good showing.}"
			Image		= ""
			List		= [ ]
			Characters	= [ ]
			Options		= [
				{
					Text = "Damnit!"
					function getResult(_event) {
						_event.postFightCleanup(false);

						return 0;
					}
				}
			]

			function start(_event) { }
		});
	}

	function buildArenaCombatProperties(_players, _entities) {
		Math.seedRandom(World.Arena.getCurrentComposition().getSeed());

		local properties = Const.Tactical.CombatInfo.getClone();
		properties.LocationTemplate = clone Const.Tactical.LocationTemplate;

		properties.CombatID = "Arena";
		properties.TerrainTemplate = "tactical.arena";
		properties.LocationTemplate.Template[0] = "tactical.arena_floor";
		properties.Music = Const.Music.ArenaTracks;
		properties.Ambience[0] = Const.SoundAmbience.ArenaBack;
		properties.Ambience[1] = Const.SoundAmbience.ArenaFront;
		properties.AmbienceMinDelay[0] = 0;
		properties.PlayerDeploymentType = Const.Tactical.DeploymentType.Arena;
		properties.EnemyDeploymentType = Const.Tactical.DeploymentType.Arena;
		properties.IsUsingSetPlayers = true;
		properties.IsFleeingProhibited = true;
		properties.IsLootingProhibited = true;
		properties.IsWithoutAmbience = true;
		properties.IsFogOfWarVisible = false;
		properties.IsArenaMode = true;
		properties.IsAutoAssigningBases = false;
		properties.AfterDeploymentCallback = OnAfterDeployment.bindenv(this);

		properties.Entities = [];

		// Sort champions to the end of the list so any seed resetting doesn't affect other entities
		_entities.sort(function(_entity1, _entity2) {
			if (_entity1.Variant < _entity2.Variant)
				return -1;
			else if (_entity1.Variant < _entity2.Variant)
				return 1;
			return 0;
		});

		foreach (entity in _entities) {
			// Callback is called in tactical_entity_manager.setupEntity, after spawnEntity, setWorldTroop, and
			//  setFaction but *before* makeMiniboss, assignRandomEquipment, setName, and the addition of the
			//  night effect
			local onSpawn = function(_entity, _tag) {
				World.Arena.applyEntityAlterations(_entity);
			};

			local onSpawnChampion = function(_entity, _tag) {
				// Re-seed, as champions can sometimes muck up seeding for some reason
				Math.seedRandom(World.Arena.getCurrentComposition().getSeed());

				World.Arena.applyEntityAlterations(_entity);
			}

			local entityToPush = { ID = entity.ID, Variant = entity.Variant, Row = 0, Script = entity.Script, Faction = Const.Faction.Enemy, Callback = entity.Variant != 0 ? onSpawnChampion : onSpawn };

			if (entityToPush.Variant != 0 && "NameList" in entity) {
				entityToPush.Name <- Const.World.Common.generateName(entity.NameList) + (entity.TitleList != null ? " " + entity.TitleList[Math.rand(0, entity.TitleList.len() - 1)] : "");
			}

			properties.Entities.push(entityToPush);
		}

		properties.Players = [];
		foreach (bro in _players)
			properties.Players.push(bro);

		return properties;
	}

	function OnAfterDeployment() {
		local enemies = Tactical.Entities.getAllHostilesAsArray();

		// Hack to add named items from champions to loot without touching corpses or tactical state arena logic
		foreach (enemy in enemies) {
			foreach (item in enemy.getItems().getAllItems()) {
				if (item.isUnique())
					World.Arena.getCurrentComposition().addLoot(item);
			}
		}
	}

	function setArenaFlags() {
		local composition = World.Arena.getCurrentComposition();
		World.Statistics.getFlags().set(::BDP.Arena.Flags.EntrantsUnderMax, composition.getAllowedEntrants() - m.Bros.len());
		World.Statistics.getFlags().set(::BDP.Arena.Flags.Deaths, 0);

		local difficulty = composition.getDifficulty();
		foreach (bro in m.Bros) {
			bro.getFlags().increment(::BDP.Arena.Flags.MatchesFought);

			if (difficulty > bro.getFlags().getAsInt(::BDP.Arena.Flags.HighestDifficulty))
				bro.getFlags().increment(::BDP.Arena.Flags.HighestDifficulty);
		}
	}

	function postFightCleanup(victorious) {
		if (victorious)
			World.Statistics.getFlags().increment("ArenaFightsWon");

		World.Arena.cleanup();
	}

	function getPromotions() {
		local promotions = [];

		foreach (bro in m.Bros) {
			local skills = bro.getSkills();
			local flags = bro.getFlags();
			local matchesFought = flags.getAsInt(::BDP.Arena.Flags.MatchesFought)
			local highestDifficulty = flags.getAsInt(::BDP.Arena.Flags.HighestDifficulty)
			local skill = null;
			local isPitFighter = skills.hasSkill("trait.pit_fighter");
			local isFighter = skills.hasSkill("trait.arena_fighter");
			local isVeteran = skills.hasSkill("trait.arena_veteran");

			if (!isVeteran && isFighter && matchesFought >= ::BDP.Arena.RankRequirements.Veteran.Matches && highestDifficulty >= ::BDP.Arena.RankRequirements.Veteran.Difficulty) {
				skills.removeByID("trait.pit_fighter");
				skills.removeByID("trait.arena_fighter");
				skill = new("scripts/skills/traits/arena_veteran_trait");
				skills.add(skill);

				promotions.push({ id = 10, icon = skill.getIcon(), text = bro.getName() + " is now " + Const.Strings.getArticle(skill.getName()) + skill.getName() });
			} else if (!isFighter && isPitFighter && matchesFought >= ::BDP.Arena.RankRequirements.Fighter.Matches && highestDifficulty >= ::BDP.Arena.RankRequirements.Fighter.Difficulty) {
				skills.removeByID("trait.pit_fighter");
				skill = new("scripts/skills/traits/arena_fighter_trait");
				skills.add(skill);

				promotions.push({ id = 10, icon = skill.getIcon(), text = bro.getName() + " is now " + Const.Strings.getArticle(skill.getName()) + skill.getName() });
			} else if (!isVeteran && !isFighter && !isPitFighter && matchesFought >= ::BDP.Arena.RankRequirements.PitFighter.Matches && highestDifficulty >= ::BDP.Arena.RankRequirements.PitFighter.Difficulty) {
				skill = new("scripts/skills/traits/arena_pit_fighter_trait");
				skills.add(skill);

				promotions.push({ id = 10, icon = skill.getIcon(), text = bro.getName() + " is now " + Const.Strings.getArticle(skill.getName()) + skill.getName() });
			}
		}

		return promotions;
	}

	function getRewards() {
		local pay = World.Arena.getCurrentComposition().getPay();
		pay += pay * ::BDP.Arena.PartialForceModifier * World.Statistics.getFlags().getAsInt(::BDP.Arena.Flags.EntrantsUnderMax);
		pay += pay * ::BDP.Arena.CasualtyModifier * World.Statistics.getFlags().getAsInt(::BDP.Arena.Flags.Deaths);

		// Re-round in case modifiers made number a decimal
		if (pay != World.Arena.getCurrentComposition().getPay())
			pay = ::BDP.Helpers.beautifyNumber(pay);

		return {
			Loot = World.Arena.getCurrentComposition().getLoot().getItems()
			Pay = pay
			Reputation = Const.World.Assets.ReputationOnContractSuccess
		}
	}

	function onUpdateScore() {
		return;
	}

	function onPrepare() {
		m.Bros = [];
		m.Twist = null;
	}

	function onPrepareVariables(_vars) { }

	function onClear() {
		if (m.Twist != null)
			m.Twist.onClear();
	}

	function onDetermineStartScreen() {
		local composition = World.Arena.getCurrentComposition();
		local potentialTwists = clone composition.getPotentialTwists();

		// Re-seed to keep twist generation intact between loads
		Math.seedRandom(composition.getSeed());

		if (Math.rand(1, 100) <= ::BDP.Arena.TwistChance && potentialTwists.len() > 0) {
			do {
				local twist_script = potentialTwists.remove(Math.rand(0, potentialTwists.len() - 1));
				local twist = new("scripts/arena/twists/" + twist_script);

				if (twist.isValid())
					m.Twist = twist;
			} while (potentialTwists.len() > 0)

			if (m.Twist != null) {
				// Let twist do any set up it needs to do
				m.Twist.eventSetup(this);

				local twistScreens = m.Twist.getScreens();
				foreach (screen in twistScreens)
					m.Screens.push(screen);

				return m.Twist.getStartScreenID();
			}
		}

		return "ArenaFight";
	}
});
