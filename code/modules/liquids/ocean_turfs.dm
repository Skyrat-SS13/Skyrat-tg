/turf/open/openspace/ocean
	name = "ocean"
	planetary_atmos = TRUE

/turf/open/openspace/ocean/Initialize()
	. = ..()
	if(liquids)
		qdel(liquids, TRUE)
	liquids = new /obj/effect/abstract/liquid_turf/immutable/ocean(src)

/turf/open/floor/plating/ocean/ironsand
	baseturfs = /turf/open/floor/plating/ocean/ironsand
	icon_state = "ironsand"
	base_icon_state = "ironsand"
	rand_variants = 15
	rand_chance = 100

/turf/open/floor/plating/ocean/rock
	name = "rock"
	baseturfs = /turf/open/floor/plating/ocean/rock
	icon = 'icons/turf/mining.dmi'
	icon_state = "rockyash"
	base_icon_state = "rockyash"
	rand_variants = 0

/turf/open/floor/plating/ocean/rock/warm
	liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean/warm

/turf/open/floor/plating/ocean/rock/warm/fissure
	name = "fissure"
	icon = 'icons/horizon/turf/fissure.dmi'
	icon_state = "fissure-0"
	base_icon_state = "fissure"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_FISSURE)
	canSmoothWith = list(SMOOTH_GROUP_FISSURE)
	light_range = 3
	light_color = LIGHT_COLOR_LAVA

/turf/open/floor/plating/ocean/rock/medium
	icon_state = "rock2"
	base_icon_state = "rock2"
	baseturfs = /turf/open/floor/plating/ocean/rock/medium

/turf/open/floor/plating/ocean/rock/heavy
	icon_state = "wateryrock"
	base_icon_state = "wateryrock"
	baseturfs = /turf/open/floor/plating/ocean/rock/heavy

/turf/open/floor/plating/ocean
	gender = PLURAL
	name = "ocean sand"
	baseturfs = /turf/open/floor/plating/ocean
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	planetary_atmos = TRUE
	var/rand_variants = 12
	var/rand_chance = 30
	var/liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean

/turf/open/floor/plating/ocean/Initialize()
	. = ..()
	if(liquids)
		qdel(liquids, TRUE)
	liquids = new liquid_type(src)
	if(rand_variants && prob(rand_chance))
		var/random = rand(1,rand_variants)
		icon_state = "[icon_state][random]"
		base_icon_state = "[icon_state][random]"

/turf/open/floor/plating/ocean_plating
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/plating/ocean_plating/Initialize()
	. = ..()
	if(liquids)
		qdel(liquids, TRUE)
	liquids = new /obj/effect/abstract/liquid_turf/immutable/ocean(src)

/turf/open/floor/plasteel/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plasteel/ocean

/turf/open/floor/plasteel/ocean/Initialize()
	. = ..()
	if(liquids)
		qdel(liquids, TRUE)
	liquids = new /obj/effect/abstract/liquid_turf/immutable/ocean(src)

/turf/closed/mineral/random/low_chance/ocean
	baseturfs = /turf/open/floor/plating/ocean/rock/heavy

//extremely low chance of rare ores, meant mostly for populating stations with large amounts of asteroid
/turf/closed/mineral/random/stationside
	icon_state = "rock_nochance"
	mineralChance = 4
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 1, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 3, /obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/silver = 4, /obj/item/stack/ore/plasma = 3, /obj/item/stack/ore/iron = 50)

/turf/closed/mineral/random/stationside/ocean
	baseturfs = /turf/open/floor/plating/ocean/rock/heavy

/obj/effect/abstract/liquid_turf/immutable/canal
	starting_mixture = list(/datum/reagent/water = 100)

/turf/open/floor/plating/canal
	gender = PLURAL
	name = "canal"
	baseturfs = /turf/open/floor/plating/canal
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	liquid_height = -30
	turf_height = -30

/turf/open/floor/plating/canal/Initialize()
	. = ..()
	if(liquids)
		qdel(liquids, TRUE)
	liquids = new /obj/effect/abstract/liquid_turf/immutable/canal(src)

/turf/open/floor/plating/canal_mutable
	gender = PLURAL
	name = "canal"
	baseturfs = /turf/open/floor/plating/canal_mutable
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	liquid_height = -30
	turf_height = -30

/turf/open/floor/plasteel/submarine
	name = "submarine floor"
	icon = 'icons/horizon/turf/submarine.dmi'
	base_icon_state = "submarine_floor"
	icon_state = "submarine_floor"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/plasteel/submarine/setup_broken_states()
	return list("submarine_floor")

/turf/open/floor/plasteel/submarine/setup_burnt_states()
	return list("submarine_floor")

/turf/open/floor/plasteel/submarine/rust_heretic_act()
	return

/turf/open/floor/plasteel/submarine_vents
	name = "submarine floor"
	icon = 'icons/horizon/turf/submarine.dmi'
	base_icon_state = "submarine_vents"
	icon_state = "submarine_vents"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/plasteel/submarine_vents/setup_broken_states()
	return list("submarine_vents")

/turf/open/floor/plasteel/submarine_vents/setup_burnt_states()
	return list("submarine_vents")

/turf/open/floor/plasteel/submarine_vents/rust_heretic_act()
	return

/turf/open/floor/plasteel/submarine_perf
	name = "submarine floor"
	icon = 'icons/horizon/turf/submarine.dmi'
	base_icon_state = "submarine_perf"
	icon_state = "submarine_perf"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/plasteel/submarine_perf/setup_broken_states()
	return list("submarine_perf")

/turf/open/floor/plasteel/submarine_perf/setup_burnt_states()
	return list("submarine_perf")

/turf/open/floor/plasteel/submarine_perf/rust_heretic_act()
	return

//For now just a titanium wall. I'll make sprites for it later
/turf/closed/wall/mineral/titanium/submarine
	name = "submarine wall"
