::mods_hookExactClass("skills/traits/arena_pit_fighter_trait", function(apft) {
	local getTooltip = ::mods_getMember(apft, "getTooltip");

	::mods_override(apft, "getTooltip", function() {
		local matches = getContainer().getActor().getFlags().getAsInt(::BDP.Arena.Flags.MatchesFought);

		local ret = getTooltip();
		ret.remove(1);
		ret.insert(1, { id = 2, type = "description", text = getDescription() + " So far, this character has survived " + (matches > 1 ? "one match." : matches + " matches.") });

		return ret;
	});
});

::mods_hookExactClass("skills/traits/arena_fighter_trait", function(aft) {
	local getTooltip = ::mods_getMember(aft, "getTooltip");

	::mods_override(aft, "getTooltip", function() {
		local matches = getContainer().getActor().getFlags().getAsInt(::BDP.Arena.Flags.MatchesFought);

		local ret = getTooltip();
		ret.remove(1);
		ret.insert(1, { id = 2, type = "description", text = getDescription() + " So far, this character has survived " + matches + " matches." });

		return ret;
	});
});

::mods_hookExactClass("skills/traits/arena_veteran_trait", function(avt) {
	local getTooltip = ::mods_getMember(avt, "getTooltip");

	::mods_override(avt, "getTooltip", function() {
		local matches = getContainer().getActor().getFlags().getAsInt(::BDP.Arena.Flags.MatchesFought);

		local ret = getTooltip();
		ret.remove(1);
		ret.insert(1, { id = 2, type = "description", text = getDescription() + " So far, this character has survived " + matches + " matches." });

		return ret;
	});
});

::mods_hookExactClass("scenarios/world/gladiators_scenario", function(gs) {
	local onSpawnAssets = ::mods_getMember(gs, "onSpawnAssets");

	::mods_override(gs, "onSpawnAssets", function() {
		onSpawnAssets();

		local roster = World.getPlayerRoster();
		local bros = roster.getAll();

		foreach (bro in bros) {
			bro.getFlags().set(::BDP.Arena.Flags.MatchesFought, 5);
			bro.getFlags().set(::BDP.Arena.Flags.HighestDifficulty, 2);
		}
	});
});
