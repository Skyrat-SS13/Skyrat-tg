/datum/uplink_item/dangerous/foamsmg_traitor
	name = "Toy Submachine Gun"
	desc = "A fully-loaded Donksoft bullpup submachine gun that fires riot grade darts with a 20-round magazine."
	item = /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted/riot
	cost = 4
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/dangerous/cortical_borer
	name = "Cortical Borer Egg"
	desc = "The egg of a cortical borer. The cortical borer is a parasite that can produce chemicals upon command, as well as \
			learn new chemicals through the blood if old enough. Be careful as there is no way to get the borer to pledge allegiance \
			to yourself. The egg is extremely fragile, do not crush it in your hand nor throw it. \
			The egg is required to sit out in the open in order to hatch. (Cannot be hidden in closets, etc.)"
	progression_minimum = 20 MINUTES
	item = /obj/effect/mob_spawn/ghost_role/borer_egg/traitor
	cost = 20
