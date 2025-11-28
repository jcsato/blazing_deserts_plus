wardogs_twist <- inherit("scripts/arena/twists/arena_twist", {
	m = {
		Houndmaster	= null
		Wardogs		= [ ]
	}

	function create() {
		arena_twist.create();

		m.ID					= "arena_twist.wardogs"
		m.Name					= "Wardogs"

		m.Screens.extend([
			{
				ID			= "WardogsStart"
				Text		= ""
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [ ]

				function start(_event) {
					_event.m.Title = "As you approach the Arena...";

					Text = "[img]gfx/ui/events/event_47.png[/img]As you prepare to enter the arena, %randombrother% comes up to you.%SPEECH_ON%Uh, hey, cap? Maybe you should take a look at this.%SPEECH_OFF%You follow the man around a side passage to an animal pen. Specifically, the pen holding the beasts you're soon to fight, only it's inhabitants aren't vicious direwolves, but a collection of scared-looking dogs.\n\nWhile certainly dangerous in their own way, these mongrels hardly represent the same dangers as a wolfpack. The sad creatures cower at the mere passing of their captors, and some no longer even have the energy to growl.%SPEECH_ON%What kind of match are we supposed to have against a bunch of mutts?%SPEECH_OFF%%randombrother% despondently says. The man's got a point. You get paid either way, but the coliseum wants bloodsport, not just blood. No matter how ferocious the match organizers think they are, you won't win many fans just by putting down dogs.";

					Options.push({
						Text = "Coin is coin. If they want to send dogs at us, so be it."
						function getResult(_event) {
							return "WardogsFight";
						}
					});
					Options.push({
						Text = "We'd only harm our reputation putting on such a sad spectacle. Call off the fight."
						function getResult(_event) {
							return "WardogsCancelled";
						}
					});

					if (_event.m.Houndmaster != null) {
						Options.push({
							Text = "I wonder what " + _event.m.Houndmaster.getNameOnly() + " the houndmaster would think of this?"
							function getResult(_event) {
								return "WardogsHoundmaster";
							}
						});
					}
				}
			},
			{
				ID			= "WardogsFight"
				Text		= "[img]gfx/ui/events/event_155.png[/img]You enter the arena with little enthusiasm, as if to match the beasts being poked and prodded out opposite you. The hounds are no more ferocious than they were in the pens, but with a particularly desperate whipping from their handler they reluctantly muster one final charge, snarling and whimpering, in your direction..."
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "To arms!"
						function getResult(_event) {
							local demoralizeDogs = function(entity) {
								switch (entity.getType()) {
									case Const.EntityType.ArmoredWardog:
									case Const.EntityType.Wardog:
									case Const.EntityType.Warhound:
										if (Math.rand(0, 1) == 0)
											entity.setMoraleState(Const.MoraleState.Wavering);
										else
											entity.setMoraleState(Const.MoraleState.Breaking);

										break;
								}
							};

							World.Arena.addEntityAlteration(demoralizeDogs);

							local properties = _event.buildArenaCombatProperties(_event.m.Bros, _event.m.Wardogs);

							_event.registerToShowAfterCombat("WardogsFightVictory", "ArenaDefeat");

							World.State.startScriptedCombat(properties, false, false, true);

							return 0;
						}
					}
				]

				function start(_event) {
					local roster = World.getPlayerRoster().getAll();
					foreach (bro in roster) {
						if (World.Arena.getChosenBros().find(bro.getID()) != null)
							_event.m.Bros.push(bro);
					}

					foreach (entity in World.Arena.getCurrentComposition().getEntities()) {
						if (Math.rand(0, 100) < 66)
							_event.m.Wardogs.push(::BDP.Arena.EntityTypes.Wardog);
						else
							_event.m.Wardogs.push(::BDP.Arena.EntityTypes.ArmoredWardog);
					}

					_event.setArenaFlags();
				}
			},
			{
				ID			= "WardogsFightVictory"
				Text		= "[img]gfx/ui/events/event_147.png[/img]The fight was about as entertaining as you feared. You return to the arena master to collect your pay, but a man you don't recognize awaits.%SPEECH_ON%You played your role, crownling, and so here is your pay. You may leave now.%SPEECH_OFF%You take the pouch of coins and leave. Around town, disparaging rumors have started to circulate about a band of mercenaries, 'The Muttslayers', who played foil to one of the least exciting arena matches in remembrance. The reputation will fade in the time, but for now the %companyname% will have to endure a stain on its record."
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "Damn."
						function getResult(_event) {
							_event.postFightCleanup(true);

							return 0;
						}
					}
				]

				function start(_event) {
					// Give renown hit
					World.Assets.addBusinessReputation(-10.0);
					List.push({ id = 10, icon = "ui/icons/special.png", text = "The company lost renown" });
				}
			},
			{
				ID			= "WardogsCancelled"
				Text		= "[img]gfx/ui/events/event_163.png[/img]Mercenaries are already looked down upon in the south. Cementing a reputation as a band only capable of killing dogs will just hurt the company in the long run. You tell the arena master you're out and turn your back on the ensuing litany of protests and curses.\n\nLater that day, word gets around to you about how poorly the show went, and how apparently the dogs just ran into a corner and cowered, awaiting death. Amidst the general disappointment in the show, you do also hear the occasional mention of the %companyname% and how they refused to be a part of such an insulting match. The arena master may not be happy with your decision, but the audience certainly holds you in higher regard now."
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "It all works  out in the end."
						function getResult(_event) {
							_event.postFightCleanup(false);

							return 0;
						}
					}
				]

				function start(_event) {
					// Vanilla contract cancel is -10.0
					World.Arena.getCurrentArena().getCityState().getOwner().addPlayerRelation(-5.0, "Backed out of an arena fight after agreeing to it");

					// Vanilla contract success is 25
					World.Assets.addBusinessReputation(25);
					List.push({ id = 10, icon = "ui/icons/special.png", text = "The company gained renown" });
				}
			},
			{
				ID			= "WardogsHoundmaster"
				Text		= ""
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "At least we got something out of this."
						function getResult(_event) {
							_event.postFightCleanup(false);

							return 0;
						}
					}
				]

				function start(_event) {
					Text = "[img]gfx/ui/events/event_47.png[/img]" + _event.m.Houndmaster.getNameOnly() + " the houndmaster walks up to the dogs, and, ignoring the panicked warning of the nearby handler, makes a subtle hand motion and sticks his arm into the pen. The dogs within immediately walk up and start sniffing and licking at the appendage, somehow intuiting the mercenary is a friend. He turns to the handler.%SPEECH_ON%They can be trained, but they'll never be show dogs, you know? Not the right kind of beast.%SPEECH_OFF%The handler's shoulders slump in resignation.%SPEECH_ON%Yes, I suppose you're right. Not the right kind.%SPEECH_OFF%He wanders off, dejected. " + _event.m.Houndmaster.getNameOnly() + " turns to you, a smile cracking his face as the mutts crowd around him.%SPEECH_ON%Think we can keep a few of 'em, sir?%SPEECH_OFF%You glance at a nearby attendant, who shrugs.%SPEECH_ON%Yeah, alright.%SPEECH_OFF%";
					// Maybe also give the Houndmaster a mood boost

					local potential_dogs = [ "wardog_item", "wardog_item", "wardog_item", "wardog_item", "warhound_item"];
					local item = null;

					for (local i = 0; i < 3; ++i) {
						item = new("scripts/items/accessory/" + potential_dogs[Math.rand(0, potential_dogs.len() - 1)]);
						World.Assets.getStash().add(item);
						List.push( { id = 10, icon = "ui/items/" + item.getIcon(), text = "You gain " + item.getName() } );
					}
				}
			}
		]);
	}

	function isValid() {
		return true;
	}

	function getStartScreenID() {
		return "WardogsStart";
	}

	function eventSetup(_event) {
		local brothers = World.getPlayerRoster().getAll();

		local houndmaster_candidates = [];

		foreach (bro in brothers) {
			if (bro.getBackground().getID() == "background.houndmaster")
				houndmaster_candidates.push(bro);
		}

		if (houndmaster_candidates.len() > 0)
			m.Houndmaster = houndmaster_candidates[Math.rand(0, houndmaster_candidates.len() - 1)];

		_event.m.Houndmaster <- m.Houndmaster;
		_event.m.Wardogs <- m.Wardogs;
	}

	function onClear() {
		m.Houndmaster = null;
		m.Wardogs = [];
	}
});
