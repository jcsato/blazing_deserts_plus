beast_slayer_twist <- inherit("scripts/arena/twists/arena_twist", {
	m = { }

	function create() {
		arena_twist.create();

		m.ID					= "arena_twist.beast_slayer"
		m.Name					= "Beast Slayer"

		m.Screens.extend([
			{
				ID			= "BeastSlayerStart"
				Text		= ""
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [ ]

				function start(_event) {
					// _event.m.Title = "As you approach " + World.Arena.getCurrentArena().getName() + "..."; // Too long :(
					_event.m.Title = "As you approach the Arena...";

					local bribe = World.Arena.getCurrentComposition().getPay() * 0.15;
					bribe = Math.round(bribe * 0.1) * 10.0;

					Text = "[img]gfx/ui/events/event_plus_02.png[/img]A shifty looking man in a cloak stops you on your way to the arena.%SPEECH_ON%Hey, you're the mercs fighting those monsters in the pits, ain't you? I've got an offer to make you.%SPEECH_OFF%Your hand reflexively fingering the pommel of your sword, you nod for him to continue.%SPEECH_ON%My mates and I had a deal with the arena master here to supply him with beasts for the games. Well, our last run went bad and not all of us made it back. The pit boss decided we weren't owed the dead men's pay.%SPEECH_OFF%He sneers, hocks and spits on the ground, and points to a discrete entrance in the side of the arena, which you understand leads to holding pens of some sort.%SPEECH_ON%I know how to capture them creatures you'll be fighting, and I know how to weaken 'em too. Gimme " + bribe + " crowns for me mates' dues, and I'll see to it that your monsters ain't quite so monstrous when you go to fight 'em, yeah?%SPEECH_OFF%";

					Options.push({
						Text = "Alright, you have a deal. " + bribe + " crowns."
						function getResult(_event) {
							return "BeastSlayerCutDeal";
						}
					});
					Options.push({
						Text = "We don't need your help."
						function getResult(_event) {
							return "BeastSlayerRefusedDeal";
						}
					});
				}
			},
			{
				ID			= "BeastSlayerCutDeal"
				Text		= "[img]gfx/ui/events/event_155.png[/img]You agree and hand the man a pouch of crowns. He quickly hides it underneath his cloak and gives you a curt nod.%SPEECH_ON%Pleasure doing business with you. I'll be watching from the stands, hurt 'em extra for me, yeah?%SPEECH_OFF%He slinks off and you move to the holding area, wondering how this will pay off.\n\nAs you await your turn, you focus on the roars and cheers of the crowd above. The sounds are almost calming, settling you into the familiar soundscape of battle and bloodlust and distracting you from the comings and goings of the guards. You stay in that state for what felt like an instant but what must have been some time, for your reverie is broken as you're thrust out the gate into the blinding light of the arena..."
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "{Let's give the crowd something to cheer for! | We shall turn the sand red with blood! | I want to hear the crowd chant our names! | We'll slaughter them like lambs!}"
						function getResult(_event) {
							local poisonBeasts = function(entity) {
								if (entity.getCurrentProperties().IsImmuneToPoison)
									return;

								switch (entity.getType()) {
									case Const.EntityType.Hyena:
									case Const.EntityType.Direwolf:
									case Const.EntityType.Unhold:
									case Const.EntityType.Serpent:
										local effect = new("scripts/skills/effects/spider_poison_effect");
										entity.getSkills().add(effect);
										break;
								}
							};

							World.Arena.addEntityAlteration(poisonBeasts);

							local properties = _event.buildArenaCombatProperties(_event.m.Bros, World.Arena.getCurrentComposition().getEntities());
							local victoryScreen = Math.rand(1, 3) < 3 ? "BeastSlayerVictory" : "BeastSlayerVictoryCaught";

							_event.registerToShowAfterCombat(victoryScreen, "ArenaDefeat");

							World.State.startScriptedCombat(properties, false, false, true);

							return 0;
						}
					}
				]

				function start(_event) {
					local bribe = World.Arena.getCurrentComposition().getPay() * 0.15;
					bribe = Math.round(bribe * 0.1) * 10.0;

					List.push({ id = 10, icon = "ui/icons/asset_money.png", text = "You lose [color=" + Const.UI.Color.NegativeEventValue + "]" + bribe + "[/color] Crowns" });

					local roster = World.getPlayerRoster().getAll();
					foreach (bro in roster) {
						if (World.Arena.getChosenBros().find(bro.getID()) != null)
							_event.m.Bros.push(bro);
					}

					_event.setArenaFlags();
				}
			},
			{
				ID			= "BeastSlayerRefusedDeal"
				Text		= "[img]gfx/ui/events/event_155.png[/img]You shake your head slowly.%SPEECH_ON%Settle your grudge yourself.%SPEECH_OFF%The man spits and stalks off.%SPEECH_ON%Pah, fine. You'll be wishing you took my offer when your throat gets ripped out, but I'll be enjoying my view from the stands.%SPEECH_OFF%You continue into the holding area and await your turn. In a dark corner you vaguely make out the shape of a mongrel picking at a meaty bone. You stop looking before you can make out what manner of creature it came from and focus on the fight ahead of you..."
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
					local roster = World.getPlayerRoster().getAll();
					foreach (bro in roster) {
						if (World.Arena.getChosenBros().find(bro.getID()) != null)
							_event.m.Bros.push(bro);
					}

					_event.setArenaFlags();
				}
			},
			{
				ID			= "BeastSlayerVictory"
				Text		= "[img]gfx/ui/events/event_147.png[/img]You walk up to the arena master for your pay. He gives you a puzzled look.%SPEECH_ON%Those beasts are usually much more vicious, you know?%SPEECH_OFF%You shrug. He returns the gesture.%SPEECH_ON%I suppose yours was the Gilded path, not theirs. Here's your pay, come again.%SPEECH_OFF%"
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "That went well."
						function getResult(_event) {
							_event.postFightCleanup(true);

							return 0;
						}
					}
				]

				function start(_event) {
					_event.giveRewards(List);
				}
			},
			{
				ID			= "BeastSlayerVictoryCaught"
				Text		= "[img]gfx/ui/events/event_147.png[/img]You walk up to the arena master for your pay. He hands you a pouch of crowns, but holds it back as you reach to take it.%SPEECH_ON%I know what you've been up to, Crownling. Don't let it happen again, for I don't intend to.%SPEECH_OFF%He lets go and you snatch the crowns away. As you leave, you hand the crowns to %randombrother% and realize that there's blood on your hand, and that the pouch you held is actually a familiar looking hood..."
				Image		= ""
				List		= [ ]
				Characters	= [ ]
				Options		= [
					{
						Text = "Let's hope they have short memories here..."
						function getResult(_event) {
							_event.postFightCleanup(true);

							return 0;
						}
					}
				]

				function start(_event) {
					_event.giveRewards(List, Const.World.Assets.ReputationOnContractFail);
				}
			}
		]);
	}

	function isValid() {
		return true;
	}

	function getStartScreenID() {
		return "BeastSlayerStart";
	}
});
