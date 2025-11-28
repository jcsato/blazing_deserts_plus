bdp_assassin_vs_killer_on_the_run_event <- inherit("scripts/events/event", {
	m = {
		Assassin	= null
		KillerOnTheRun	= null
	}

	function create() {
		m.ID		= "event.bdp_assassin_vs_killer_on_the_run";
		m.Title		= "During camp...";
		m.Cooldown	= 70.0 * World.getTime().SecondsPerDay;

		m.Screens.push({
			ID			= "A"
			Text		= "[img]gfx/ui/events/event_05.png[/img]{You decide to check on the men and find %assassin% and %killer_on_the_run% conversing at the fire. You decide you're not entirely comfortable with a professional assassin conspiring with an amateur one and listen in.%SPEECH_ON%I'll tell you what I'm sick of, is those farkers wearing a whole mine's worth of metal. What the hell are we supposed to do? Dagger work is all well and good but there needs to be a gap in the armor to puncture in the first place!%SPEECH_OFF%The killer grumbles, idly picking at his teeth with a knifepoint.%SPEECH_ON%Is the foe taller or shorter?%SPEECH_OFF%%killer_on_the_run% cocks his head at the assassin's question, clearly not following. %assassin% slowly brings two fingers to his neck, near the collarbone, and draws them down to his chest.%SPEECH_ON%If shorter, you bring your blade through here, entering the body just as the air that brings them life does. No matter the armor, it is always weak to directed blows at the neck. Whether you pierce the throat or the lung, all it takes is a strike brought depth by purpose.%SPEECH_OFF%He then lifts one arm and places his fingers at the base of the armpit.%SPEECH_ON%If taller, you will not be able to bring enough force to bear. Instead, aim here, where significant would just impede their ability to attack. Again, you must commit to the blow. Drive your weapon through, all the way to the heart or lungs. A nihilistic blade will only wound, not kill. Armor or no, it is intent that spells a man's end. This is why, in the guilds, it is taught that you should always spend twice the effort planning the strike as you do on executing it. To do any less is a disrespect to your target, and thus yourself. Do you understand?%SPEECH_OFF%%killer_on_the_run% doesn't say anything at first, his eyes wide and darting between %assassin%'s neck and armpit with excitement. He starts suddenly from his reverie, realizing he missed the question.%SPEECH_ON%Ah, yeah, right...hehehe. Makes sense. Hehehe...%SPEECH_OFF%}"
			Image		= ""
			List		= [ ]
			Characters	= [ ]
			Options		= [
				{
					Text = "Best use those learnings on the enemy, %killer_on_the_run%."
					function getResult(_event) { return 0; }
				}
			]

			function start(_event) {
				Characters.push(_event.m.Assassin.getImagePath());
				Characters.push(_event.m.KillerOnTheRun.getImagePath());

				_event.m.Assassin.improveMood(0.5, "Successfully imparted some wisdom to another killer");
				_event.m.KillerOnTheRun.improveMood(1.0, "Learned new ways to kill");
				local meleeSkillBoost = Math.rand(1, 3);
				_event.m.KillerOnTheRun.getBaseProperties().MeleeSkill += meleeSkillBoost;
				_event.m.KillerOnTheRun.getSkills().update();

				List.push({ id = 16, icon = "ui/icons/melee_skill.png", text = _event.m.KillerOnTheRun.getName() + " gains [color=" + Const.UI.Color.PositiveEventValue + "]+" + meleeSkillBoost + "[/color] Melee Skill" });

				if (_event.m.KillerOnTheRun.getMoodState() >= Const.MoodState.Neutral)
					List.push( { id = 10, icon = Const.MoodStateIcon[_event.m.KillerOnTheRun.getMoodState()], text = _event.m.KillerOnTheRun.getName() + Const.MoodStateEvent[_event.m.KillerOnTheRun.getMoodState()] } );

				if (_event.m.Assassin.getMoodState() >= Const.MoodState.Neutral)
					List.push( { id = 10, icon = Const.MoodStateIcon[_event.m.Assassin.getMoodState()], text = _event.m.Assassin.getName() + Const.MoodStateEvent[_event.m.Assassin.getMoodState()] } );
			}
		});
	}

	function onUpdateScore() {
		local brothers = World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local assassin_candidates = [];
		local killer_on_the_run_candidates = [];

		foreach (bro in brothers) {
			if (bro.getBackground().getID() == "background.assassin_southern")
				assassin_candidates.push(bro);
			else if (bro.getBackground().getID() == "background.killer_on_the_run")
				killer_on_the_run_candidates.push(bro);
		}

		if (assassin_candidates.len() == 0 || killer_on_the_run_candidates.len() == 0)
			return;

		m.Assassin = assassin_candidates[Math.rand(0, assassin_candidates.len() - 1)];
		m.KillerOnTheRun = killer_on_the_run_candidates[Math.rand(0, killer_on_the_run_candidates.len() - 1)];
		m.Score = 5;
	}

	function onPrepareVariables(_vars) {
		_vars.push([ "assassin", m.Assassin.getNameOnly() ]);
		_vars.push([ "killer_on_the_run", m.KillerOnTheRun.getNameOnly() ]);
	}

	function onClear() { }
});
