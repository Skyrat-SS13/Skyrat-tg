/obj/item/scythe
	name = "scythe"
	desc = "A sharp and curved blade on a long fibremetal handle, this tool makes it easy to reap what you sow."
	icon = 'modular_skyrat/modules/apocolypse_of_scythes/icons/items_and_weapons.dmi'
	icon_state = "scythe"
	worn_icon = 'modular_skyrat/modules/apocolypse_of_scythes/icons/back.dmi'
	lefthand_file = 'modular_skyrat/modules/apocolypse_of_scythes/icons/polearms_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/apocolypse_of_scythes/icons/polearms_righthand.dmi'
	force = 10
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1
	armour_penetration = 10
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("chops", "slices", "cuts", "reaps")
	attack_verb_simple = list("chop", "slice", "cut", "reap")
	hitsound = 'sound/weapons/bladeslice.ogg'

	var/hit_range = 0
	var/venus_chance = 0
	var/swiping = FALSE

/obj/item/scythe/pre_attack(atom/A, mob/living/user, params)
	if(!istype(A, /obj/structure/spacevine) && !istype(A, /mob/living/simple_animal/hostile/venus_human_trap))
		return ..()
	if(swiping)
		return ..()
	swiping = TRUE
	if(istype(A, /obj/structure/spacevine) && hit_range >= 1)
		for(var/obj/structure/spacevine/choose_vine in range(hit_range, A))
			if(prob(venus_chance/2))
				choose_vine.Destroy()
				continue
			melee_attack_chain(user, choose_vine)
		swiping = FALSE
		return
	if(istype(A, /mob/living/simple_animal/hostile/venus_human_trap))
		var/mob/living/simple_animal/hostile/venus_human_trap/hostile_venus = A
		if(prob(venus_chance))
			hostile_venus.death()
	swiping = FALSE

/obj/item/scythe/tier1
	name = "scythe (tier 1)"
	icon_state = "scythe_t1"

/obj/item/scythe/tier2
	name = "scythe (tier 2)"
	icon_state = "scythe_t2"
	force = 13
	hit_range = 1
	venus_chance = 20

/obj/item/scythe/tier3
	name = "scythe (tier 3)"
	icon_state = "scythe_t3"
	force = 16
	hit_range = 2
	venus_chance = 40

/obj/item/scythe/tier4
	name = "scythe (tier 4)"
	icon_state = "scythe_t4"
	force = 20
	hit_range = 3
	venus_chance = 60

/datum/design/scythe_t1
	name = "Scythe (Tier 1)"
	desc = "A sharp and curved blade on a long fibremetal handle, this tool makes it easy to reap what you sow."
	id = "scythet1"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/scythe/tier1
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/scythe_t2
	name = "Scythe (Tier 2)"
	desc = "A sharp and curved blade on a long fibremetal handle, this tool makes it easy to reap what you sow."
	id = "scythet2"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/scythe/tier2
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/scythe_t3
	name = "Scythe (Tier 3)"
	desc = "A sharp and curved blade on a long fibremetal handle, this tool makes it easy to reap what you sow."
	id = "scythet3"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/scythe/tier3
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/design/scythe_t4
	name = "Scythe (Tier 4)"
	desc = "A sharp and curved blade on a long fibremetal handle, this tool makes it easy to reap what you sow."
	id = "scythet4"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	build_path = /obj/item/scythe/tier4
	category = list("Equipment")
	departmental_flags = DEPARTMENTAL_FLAG_SERVICE

/datum/techweb_node/scythe_t1
	id = "t1scythe"
	display_name = "Scythe (Tier 1)"
	description = "Culling tools"
	prereq_ids = list("adv_engi", "biotech", "botany")
	design_ids = list(
		"scythet1",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
	discount_experiments = list(/datum/experiment/scanning/random/plants/wild = 500)

/datum/techweb_node/scythe_t2
	id = "t2scythe"
	display_name = "Scythe (Tier 2)"
	description = "Culling tools"
	prereq_ids = list("t1scythe")
	design_ids = list(
		"scythet2",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2000)
	discount_experiments = list(/datum/experiment/scanning/random/plants/wild = 1000)

/datum/techweb_node/scythe_t3
	id = "t3scythe"
	display_name = "Scythe (Tier 3)"
	description = "Culling tools"
	prereq_ids = list("t2scythe")
	design_ids = list(
		"scythet3",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3000)
	discount_experiments = list(/datum/experiment/scanning/random/plants/wild = 1500)

/datum/techweb_node/scythe_t4
	id = "t4scythe"
	display_name = "Scythe (Tier 4)"
	description = "Culling tools"
	prereq_ids = list("t3scythe")
	design_ids = list(
		"scythet4",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4000)
	discount_experiments = list(/datum/experiment/scanning/random/plants/wild = 2000)
