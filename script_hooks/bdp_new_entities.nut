::Const.Tactical.Actor.Indemnifier <- {
	XP					= 450
	ActionPoints		= 9
	Hitpoints			= 150
	Bravery				= 110
	Stamina				= 150
	MeleeSkill			= 85
	RangedSkill			= 50
	MeleeDefense		= 25
	RangedDefense		= 20
	Initiative			= 100
	FatigueEffectMult	= 1.0
	MoraleEffectMult	= 1.0
	Armor				= [0, 0]
	FatigueRecoveryRate	= 25
};

::Const.Tactical.Actor.Crownling <- {
	XP					= 350
	ActionPoints		= 9
	Hitpoints			= 90
	Bravery				= 70
	Stamina				= 135
	MeleeSkill			= 75
	RangedSkill			= 65
	MeleeDefense		= 20
	RangedDefense		= 10
	Initiative			= 125
	FatigueEffectMult	= 1.0
	MoraleEffectMult	= 1.0
	Armor				= [0, 0]
	FatigueRecoveryRate	= 20
};

::Const.Tactical.Actor.CrownlingRanged <- {
	XP					= 300
	ActionPoints		= 9
	Hitpoints			= 65
	Bravery				= 70
	Stamina				= 135
	MeleeSkill			= 65
	RangedSkill			= 75
	MeleeDefense		= 10
	RangedDefense		= 15
	Initiative			= 125
	FatigueEffectMult	= 1.0
	MoraleEffectMult	= 1.0
	Armor				= [0, 0]
	FatigueRecoveryRate	= 20
};

local max = 0;
foreach (key, value in ::Const.EntityType) {
	if (typeof value == "integer" && value > max)
		max = value;
}

// global
::Const.EntityType.Crownling <- ++max;
::Const.Strings.EntityName.push("Crownling");
::Const.Strings.EntityNamePlural.push("Crownlings");
::Const.EntityIcon.push("crownling_orientation");

::Const.EntityType.CrownlingRanged <- ++max;
::Const.Strings.EntityName.push("Crownling");
::Const.Strings.EntityNamePlural.push("Crownlings");
::Const.EntityIcon.push("crownling_orientation");

::Const.EntityType.Indemnifier <- ++max;
::Const.Strings.EntityName.push("Indemnifier");
::Const.Strings.EntityNamePlural.push("Indemnifiers");
::Const.EntityIcon.push("indemnifier_orientation");

::Const.Strings.IndemnifierTitles <- [
	"the Gilded"
];

// spawnlist_master
::Const.World.Spawn.Troops.Crownling		<- {	ID = ::Const.EntityType.Crownling,		Variant = 0,	Strength = 30,	Cost = 25,	Row = 0,	Script = "scripts/entity/tactical/humans/crownling" }
::Const.World.Spawn.Troops.CrownlingLow		<- {	ID = ::Const.EntityType.Crownling,		Variant = 0,	Strength = 20,	Cost = 18,	Row = 0,	Script = "scripts/entity/tactical/humans/crownling_low" }
::Const.World.Spawn.Troops.CrownlingRanged	<- {	ID = ::Const.EntityType.Crownling,		Variant = 0,	Strength = 25,	Cost = 25,	Row = 1,	Script = "scripts/entity/tactical/humans/crownling_ranged" }
::Const.World.Spawn.Troops.Indemnifier		<- {	ID = ::Const.EntityType.Indemnifier,	Variant = 0,	Strength = 40,	Cost = 40,	Row = 0,	Script = "scripts/entity/tactical/humans/indemnifier" }

// spawnlist_southern
local gilded_spawn_types = [
	::Const.World.Spawn.Troops.Indemnifier,
	::Const.World.Spawn.Troops.Conscript,
	::Const.World.Spawn.Troops.ConscriptPolearm,
	::Const.World.Spawn.Troops.Gunner,
	::Const.World.Spawn.Troops.Officer,
	::Const.World.Spawn.Troops.Assassin,
	::Const.World.Spawn.Troops.Slave,
	::Const.World.Spawn.Troops.Engineer,
	::Const.World.Spawn.Troops.Mortar
];

local gilded_troop_comps = [
// [ Ind, Con, ConP, Gun, Off, Asn, Slv, Eng, Mor  ]
	[ 1,   3,   1,    1,   0,   0,   0,   0,   0  ],
	[ 1,   3,   2,    1,   0,   0,   0,   0,   0  ],
	[ 1,   2,   1,    2,   0,   0,   0,   0,   0  ],
	[ 1,   3,   2,    2,   0,   0,   0,   0,   0  ],
	[ 1,   6,   2,    2,   0,   0,   0,   0,   0  ],
	[ 1,   2,   1,    2,   0,   0,   6,   0,   0  ],
	[ 1,   3,   2,    2,   0,   0,   8,   0,   0  ],
	[ 1,   6,   2,    2,   0,   0,   8,   0,   0  ],
	[ 1,   7,   4,    2,   0,   0,   0,   0,   0  ],
	[ 2,   3,   2,    2,   0,   0,   0,   0,   0  ],
	[ 2,   3,   2,    2,   1,   0,   0,   0,   0  ],
	[ 2,   3,   1,    0,   0,   1,   0,   0,   0  ],
	[ 3,   6,   3,    0,   0,   0,   0,   0,   0  ],
	[ 3,   6,   2,    0,   0,   1,   0,   0,   0  ],
	[ 3,   8,   3,    1,   0,   0,   0,   0,   0  ],
	[ 3,   8,   3,    0,   1,   0,   0,   0,   0  ],
	[ 3,   8,   2,    0,   0,   1,   0,   0,   0  ],
	[ 3,   12,  4,    0,   0,   0,   0,   0,   0  ],
	[ 3,   8,   3,    0,   1,   0,   0,   0,   0  ],
	[ 3,   7,   3,    0,   1,   0,   0,   0,   0  ],
	[ 3,   7,   2,    0,   0,   1,   0,   0,   0  ],
	[ 3,   7,   3,    0,   1,   0,   0,   0,   0  ],
	[ 3,   7,   3,    1,   0,   1,   0,   1,   1  ],
	[ 3,   10,  4,    1,   0,   0,   3,   1,   1  ],
	[ 3,   10,  3,    1,   0,   1,   3,   1,   1  ],
	[ 3,   11,  4,    1,   1,   0,   3,   1,   1  ],
	[ 3,   11,  4,    1,   1,   1,   3,   1,   1  ],
	[ 3,   13,  4,    1,   1,   0,   3,   2,   1  ],
	[ 3,   13,  4,    1,   2,   0,   3,   2,   1  ],
	[ 3,   13,  4,    1,   2,   2,   3,   2,   1  ],
	[ 3,   13,  4,    1,   1,   0,   6,   2,   1  ],
	[ 3,   13,  4,    1,   2,   0,   6,   2,   1  ],
	[ 3,   13,  4,    1,   2,   2,   6,   2,   1  ]
];
foreach (index, comp in gilded_troop_comps) {
	local spawn = { MovementSpeedMult	= 1.0,	VisibilityMult	= 1.0,	VisionMult	= 1.0,	Body	= "figure_indemnifier_01",	Troops	= [ ] };
	foreach(troop_type, count in comp) {
		if (count > 0)
			spawn.Troops.push({ Type = gilded_spawn_types[troop_type], Num = count });
	}

	::Const.World.Spawn.Southern.push(spawn);
};

// spawnlist_humans
local crownling_spawn_types = [
	::Const.World.Spawn.Troops.CrownlingLow,
	::Const.World.Spawn.Troops.Crownling,
	::Const.World.Spawn.Troops.CrownlingRanged,
	::Const.World.Spawn.Troops.Executioner,
	::Const.World.Spawn.Troops.DesertDevil,
	::Const.World.Spawn.Troops.DesertStalker
];

local crownling_troop_comps = [
// [ CrnLow, Crn, CrnRng, Exe, BlD, Stk  ]
	[   4,    0,    1,     0,   0,   0  ],
	[   6,    0,    2,     0,   0,   0  ],
	[   4,    2,    1,     0,   0,   0  ],
	[   3,    3,    2,     0,   0,   0  ],
	[   3,    6,    2,     0,   0,   0  ],
	[   1,    9,    4,     0,   0,   0  ],
	[   1,    3,    1,     1,   0,   0  ],
	[   1,    3,    1,     0,   1,   0  ],
	[   1,    3,    1,     0,   0,   1  ],
	[   0,    6,    3,     0,   0,   0  ],
	[   0,    6,    2,     0,   0,   1  ],
	[   0,    8,    3,     1,   0,   0  ],
	[   0,    8,    3,     0,   1,   0  ],
	[   0,    8,    2,     0,   0,   1  ],
	[   0,    12,   4,     0,   0,   0  ],
	[   0,    8,    3,     0,   1,   0  ],
	[   7,    0,    3,     0,   1,   0  ],
	[   7,    0,    2,     0,   0,   1  ],
	[   2,    6,    3,     0,   1,   0  ],
	[   9,    0,    3,     1,   0,   0  ],
	[   0,    10,   4,     1,   0,   0  ],
	[   0,    10,   3,     1,   0,   1  ],
	[   0,    11,   4,     1,   1,   0  ],
	[   0,    11,   3,     1,   1,   1  ],
	[   0,    13,   4,     1,   1,   0  ],
	[   3,    13,   4,     1,   2,   0  ],
	[   3,    13,   4,     1,   2,   2  ]
];

::Const.World.Spawn.Crownlings <- [];

foreach (index, comp in crownling_troop_comps) {
	local spawn = { MovementSpeedMult	= 1.0,	VisibilityMult	= 1.0,	VisionMult	= 1.0,	Body	= "",	Troops	= [ ] };
	spawn.Body = (index < (crownling_troop_comps.len() / 2)) ? "figure_crownling_01" : "figure_crownling_02";

	foreach(troop_type, count in comp) {
		if (count > 0)
			spawn.Troops.push({ Type = crownling_spawn_types[troop_type], Num = count });
	}

	::Const.World.Spawn.Crownlings.push(spawn);
};

function onCostCompare(_t1, _t2) {
	if (_t1.Cost < _t2.Cost)
		return -1;
	else if (_t1.Cost > _t2.Cost)
		return 1;

	return 0;
}

function calculateCosts(_p) {
	foreach (p in _p) {
		p.Cost <- 0;

		foreach (t in p.Troops)
			p.Cost += t.Type.Cost * t.Num;

		if (!("MovementSpeedMult" in p))
			p.MovementSpeedMult <- 1.0;

		if (!("VisibilityMult" in p))
			p.VisibilityMult <- 1.0;

		if (!("VisionMult" in p))
			p.VisionMult <- 1.0;
	}

	_p.sort(onCostCompare);
}

calculateCosts(::Const.World.Spawn.Southern);
calculateCosts(::Const.World.Spawn.Crownlings);

::Const.EntityIcon.insert(::Const.EntityType.PeasantSouthern, "citizen_orientation");
::Const.EntityIcon.remove(::Const.EntityType.PeasantSouthern + 1);
