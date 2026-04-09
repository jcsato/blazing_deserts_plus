coward_afraid_of_gladiators_twist <- inherit("scripts/arena/twists/arena_twist", {
	m = {
		Coward = null
	}

	function create() {
		arena_twist.create();

		m.ID					= "arena_twist.coward_afraid_of_gladiators"
		m.Name					= "Coward Afraid of Gladiators"

		m.Screens.extend([
			{
				ID			= "GladiatorsCowardStart"
				Text		= ""
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [ ]

				function start(_event) {
					_event.m.Title = "As you approach the Arena...";

					_event.m.Coward.worsenMood(0.75, "Lost his nerve in the arena");

					if (_event.m.Coward.getMoodState() < Const.MoodState.Neutral)
						List.push({ id = 10, icon = Const.MoodStateIcon[_event.m.Coward.getMoodState()], text = _event.m.Coward.getName() + Const.MoodStateEvent[_event.m.Coward.getMoodState()] });

					Characters.push(_event.m.Coward.getImagePath());

					Text = "[img]gfx/ui/events/event_155.png[/img]%SPEECH_ON%I'm telling you, it's hopeless!%SPEECH_OFF%It seems that the upcoming match against professional gladiators has " + _event.m.Coward.getNameOnly() + " losing his nerve.%SPEECH_ON%The arena is THEIR territory. Naught but a few of us, strolling in? We're like lambs going to the slaughter!%SPEECH_OFF%You give the man a sharp smack upside the head and remind him that his opponents are men, nothing more. The %companyname% have slain plenty like them before, and will slay plenty more tomorrow as well. You can tell your words have little effect on his confidence, but at least you put a stop to his hysterics before they started to affect anyone else.";

					local roster = World.getPlayerRoster().getAll();
					foreach (bro in roster) {
						if (World.Arena.getChosenBros().find(bro.getID()) != null)
							_event.m.Bros.push(bro);
					}

					Options.push({
						Text = "Keep it together, man."
						function getResult(_event) {
							local properties = _event.buildArenaCombatProperties(_event.m.Bros, World.Arena.getCurrentComposition().getEntities());
							local victoryScreen = null;
							switch (Math.rand(1, 3)) {
								case 1:
									victoryScreen = "GladiatorsCowardVictoryRegret";
									break;
								case 2:
									victoryScreen = "GladiatorsCowardVictoryTrait";
									break;
								case 3:
									victoryScreen = "GladiatorsCowardVictoryResolve";
									break;
							}

							_event.registerToShowAfterCombat(victoryScreen, "ArenaDefeat");

							World.State.startScriptedCombat(properties, false, false, true);

							return 0;
						}
					});
				}
			},
			{
				ID			= "GladiatorsCowardVictoryRegret"
				Text		= ""
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "See that you don't."
						function getResult(_event) {
							_event.postFightCleanup(true);
							return 0;
						}
					}
				]

				function start(_event) {
					Text = "[img]gfx/ui/events/event_147.png[/img]After the match, you find " + _event.m.Coward.getNameOnly() + " sulking in a corner. Seeing you approach, he straightens up and tries to clear his throat.%SPEECH_ON%Ah, sorry about before, captain. Feel stupid now, but I couldn't get the thought out of my head, being hunted down alone in the ring by those pit fighters, it...%SPEECH_OFF%He trails off and seems to choke up a bit.%SPEECH_ON%Won't let it happen again, sir.%SPEECH_OFF%";

					_event.giveRewards(List);

					_event.m.Coward.getFlags().add("GladiatorsCowardEvent");

					Characters.push(_event.m.Coward.getImagePath());
				}
			},
			{
				ID			= "GladiatorsCowardVictoryTrait"
				Text		= ""
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "Glad to hear it."
						function getResult(_event) {
							_event.postFightCleanup(true);
							return 0;
						}
					}
				]

				function start(_event) {
					Text = "[img]gfx/ui/events/event_147.png[/img]" + _event.m.Coward.getNameOnly() + " comes to find you after the match.%SPEECH_ON%Cap, did you see that! I was sure those pit fighters would be the end of me, right up until I was standing over their corpses! Look at me now, standing here just how they thought they'd be. Ha!%SPEECH_OFF%He leans in and adopts a more serious tone.%SPEECH_ON%In truth, that whole fight has got me rethinking some things, and, well. Not quite sure how to put it yet, but it feels better. Thanks, cap.%SPEECH_OFF%";

					local trait = null;
					local skills = _event.m.Coward.getSkills();
					if (skills.hasSkill("trait.fainthearted"))
						trait = skills.getSkillByID("trait.fainthearted");
					else if (skills.hasSkill("trait.craven"))
						trait = skills.getSkillByID("trait.craven");
					else if (skills.hasSkill("trait.dastard"))
						trait = skills.getSkillByID("trait.dastard");

					skills.removeByID(trait.getID());
					List = [ { id = 10, icon = trait.getIcon(), text = _event.m.Coward.getName() + " is no longer a coward" } ];

					_event.giveRewards(List);

					_event.m.Coward.getFlags().add("GladiatorsCowardEvent");

					Characters.push(_event.m.Coward.getImagePath());
				}
			},
			{
				ID			= "GladiatorsCowardVictoryResolve"
				Text		= ""
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "Just don't lose your nerve next time."
						function getResult(_event) {
							_event.postFightCleanup(true);
							return 0;
						}
					}
				]

				function start(_event) {
					Text = "[img]gfx/ui/events/event_147.png[/img]You check on the fighters after the match and find " + _event.m.Coward.getNameOnly() + " in a good mood.%SPEECH_ON%Didja see us, cap? We trounced 'em! Ha! And to think I was scared, those arena whelps are nothing, nothing I say!%SPEECH_OFF%You decide overconfidence is preferable to the alternative and leave the man to his jubilations.";

					local resolveBoost = Math.rand(1, 3);

					_event.m.Coward.getBaseProperties().Bravery += resolveBoost;
					_event.m.Coward.getSkills().update();

					List.push({ id = 16, icon = "ui/icons/bravery.png", text = _event.m.Coward.getName() + " gains [color=" + Const.UI.Color.PositiveEventValue + "]+" + resolveBoost + "[/color] Resolve" });

					_event.giveRewards(List);

					_event.m.Coward.getFlags().add("GladiatorsCowardEvent");

					Characters.push(_event.m.Coward.getImagePath());
				}
			},
		]);
	}

	function isBroCoward(bro) {
		return (bro.getSkills().hasSkill("trait.fainthearted") || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.dastard")) && !bro.getFlags().has("GladiatorsCowardEvent")
	}

	function isValid() {
		local brothers = World.getPlayerRoster().getAll();

		local coward_candidates = [];

		foreach (bro in brothers) {
			if (isBroCoward(bro))
				coward_candidates.push(bro);
		}

		return coward_candidates.len() > 0;
	}

	function getStartScreenID() {
		return "GladiatorsCowardStart";
	}

	function eventSetup(_event) {
		local brothers = World.getPlayerRoster().getAll();

		local coward_candidates = [];

		foreach (bro in brothers) {
			if (isBroCoward(bro))
				coward_candidates.push(bro);
		}

		m.Coward = coward_candidates[Math.rand(0, coward_candidates.len() - 1)];
		_event.m.Coward <- m.Coward;
	}

	function onClear() {
		m.Coward = null;
	}
});
