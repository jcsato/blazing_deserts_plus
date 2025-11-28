::mods_hookNewObject("events/event_manager", function(em) {
	local onActorKilled = ::mods_getMember(em, "onActorKilled");

	em.onActorKilled = function(_actor, _killer, _combatID) {
		if (_combatID == "Arena" && _actor.isPlayerControlled())
			World.Statistics.getFlags().increment(::BDP.Arena.Flags.Deaths);

		onActorKilled(_actor, _killer, _combatID);
	};
});
