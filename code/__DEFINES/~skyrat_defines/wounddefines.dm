#define WOUND_TYPE_ORGANIC "organic"
#define WOUND_TYPE_SYNTHETIC "synthetic"
#define WOUND_TYPE_CRYSTAL "crystalline"

GLOBAL_LIST_INIT(global_wound_types_synth, list(WOUND_SLASH = list(/datum/wound/synthetic/slash/critical, /datum/wound/synthetic/slash/severe, /datum/wound/synthetic/slash/moderate),
		WOUND_PIERCE = list(/datum/wound/synthetic/pierce/critical, /datum/wound/synthetic/pierce/severe, /datum/wound/synthetic/pierce/moderate),
		WOUND_BURN = list(/datum/wound/synthetic/burn/critical, /datum/wound/synthetic/burn/severe, /datum/wound/synthetic/burn/moderate),
		WOUND_MUSCLE = list(/datum/wound/synthetic/muscle/severe, /datum/wound/synthetic/muscle/moderate)
		))

// every single type of wound that can be rolled naturally, in case you need to pull a random one
GLOBAL_LIST_INIT(global_all_wound_types_synth, list(/datum/wound/synthetic/slash/critical, /datum/wound/synthetic/slash/severe, /datum/wound/synthetic/slash/moderate,
	/datum/wound/synthetic/pierce/critical, /datum/wound/synthetic/pierce/severe, /datum/wound/synthetic/pierce/moderate,
	/datum/wound/synthetic/burn/critical, /datum/wound/synthetic/burn/severe, /datum/wound/synthetic/burn/moderate, /datum/wound/synthetic/muscle/severe, /datum/wound/synthetic/muscle/moderate))


