/datum/design/jawsoflife/science
	name = "Hybrid cutters"
	desc = "An off-shoot of the jaws of life that lacks the door-opening power"
	id = SCIENCE_JAWS_OF_LIFE_DESIGN_ID // added one more requirement since the Jaws of Life are a bit OP
	build_path = /obj/item/crowbar/power/science
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science
	id = SCIENCE_DRILL_DESIGN_ID
	build_type = PROTOLATHE | AWAY_LATHE
	build_path = /obj/item/screwdriver/power/science
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE

/datum/design/handdrill/science/New()
	name = ("Science " + name)
	desc += " with a science paintjob"

	return ..()

/datum/design/laserscalpel
	construction_time = 1 SECONDS

/datum/design/mechanicalpinches
	construction_time = 1 SECONDS

/datum/design/searingtool
	construction_time = 1 SECONDS

/datum/design/healthanalyzer
	construction_time = 5 SECONDS

/datum/design/healthanalyzer_advanced
	construction_time = 5 SECONDS

/datum/design/laserscalpel/New()
	build_type |= MECHFAB
	category += list(RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MEDICAL)

	return ..()

/datum/design/mechanicalpinches/New()
	build_type |= MECHFAB
	category += list(RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MEDICAL)

	return ..()

/datum/design/searingtool/New()
	build_type |= MECHFAB
	category += list(RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MEDICAL)

	return ..()

// it's fine to give them health analyzers, the choke for medibot production is the medkits
/datum/design/healthanalyzer/New()
	build_type |= MECHFAB
	category += list(RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MEDICAL)

	return ..()


/datum/design/healthanalyzer_advanced/New()
	build_type |= MECHFAB
	category += list(RND_CATEGORY_MECHFAB_EQUIPMENT + RND_SUBCATEGORY_MECHFAB_EQUIPMENT_MEDICAL)

	return ..()
