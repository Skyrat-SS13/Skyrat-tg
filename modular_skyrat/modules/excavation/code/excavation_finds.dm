GLOBAL_LIST_INIT(excavation_finds_weight, InitExcavFinds())

/proc/InitExcavFinds()
	var/list/returned = list()
	for(var/path in subtypesof(/datum/excavation_find))
		var/datum/excavation_find/EF = path
		if(initial(EF.type_to_spawn))
			returned[path] = initial(EF.weight)
	return returned

/datum/excavation_find
	var/clearance //Internal
	var/type_to_spawn
	var/weight = 10
	var/signature = "unknown"

/datum/excavation_find/New()
	clearance = rand(1,4)

/datum/excavation_find/fossil
	type_to_spawn = /obj/item/fossil
	weight = 15

/datum/excavation_find/anomalous_crystal
	type_to_spawn = /obj/item/anomalous_sliver/crystal
	weight = 10

//Doesnt do anything, just flavor, but can be sold
/datum/excavation_find/excavation_junk
	type_to_spawn = /obj/item/excavation_junk
	weight = 15

/datum/excavation_find/strange_seed
	type_to_spawn = /obj/item/seeds/random
	weight = 5

//Currently doesnt do anything, placeholder
/datum/excavation_find/unknown_artifact
	type_to_spawn = /obj/item/unknown_artifact
	weight = 5

//Guess this can exist until more stuff is introduced
/datum/excavation_find/relic
	type_to_spawn = /obj/item/relic
	weight = 5
