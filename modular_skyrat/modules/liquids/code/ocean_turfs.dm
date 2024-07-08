/turf/open/openspace/ocean
	name = "ocean"
	planetary_atmos = TRUE
	baseturfs = /turf/open/openspace/ocean
	var/replacement_turf = /turf/open/misc/ocean

/turf/open/openspace/ocean/Initialize(mapload)
	. = ..()

	for(var/obj/structure/flora/plant in contents)
		qdel(plant)
	var/turf/T = GET_TURF_BELOW(src)
	//I wonder if I should error here
	if(!T)
		return
	if(T.turf_flags & NO_RUINS)
		var/turf/newturf = ChangeTurf(replacement_turf, null, CHANGETURF_IGNORE_AIR)
		if(!isopenspaceturf(newturf)) // only openspace turfs should be returning INITIALIZE_HINT_LATELOAD
			return INITIALIZE_HINT_NORMAL
		return
	if(!ismineralturf(T))
		return
	var/turf/closed/mineral/M = T
	M.mineralAmt = 0
	M.gets_drilled()
	baseturfs = /turf/open/openspace/ocean //This is to ensure that IF random turf generation produces a openturf, there won't be other turfs assigned other than openspace.

/turf/open/openspace/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean)
	new_immmutable.add_turf(src)

/turf/open/misc/ironsand/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/ocean

/turf/open/misc/ironsand/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)


/turf/open/misc/ocean/rock
	name = "rock"
	desc = "Polished over centuries of undersea weather conditions and a distinct lack of light."
	baseturfs = /turf/open/misc/ocean/rock
	icon = 'modular_skyrat/modules/liquids/icons/turf/seafloor.dmi'
	icon_state = "seafloor"
	base_icon_state = "seafloor"
	rand_variants = 0

/turf/open/misc/ocean/rock/warm
	liquid_type = /obj/effect/abstract/liquid_turf/immutable/ocean/warm

/turf/open/misc/ocean/rock/warm/fissure
	name = "fissure"
	desc = "A comfortable, warm tempature eminates from these - followed immediately after by toxic chemicals in liquid or gaseous forms; but warmth all the same!"
	icon = 'modular_skyrat/modules/liquids/icons/turf/fissure.dmi'
	icon_state = "fissure-0"
	base_icon_state = "fissure"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_FISSURE
	canSmoothWith = SMOOTH_GROUP_FISSURE
	light_range = 3
	light_color = LIGHT_COLOR_LAVA

/turf/open/misc/ocean/rock/medium
	icon_state = "seafloor_med"
	base_icon_state = "seafloor_med"
	baseturfs = /turf/open/misc/ocean/rock/medium

/turf/open/misc/ocean/rock/heavy
	icon_state = "seafloor_heavy"
	base_icon_state = "seafloor_heavy"
	baseturfs = /turf/open/misc/ocean/rock/heavy

/turf/open/misc/ocean
	gender = PLURAL
	name = "ocean sand"
	desc = "If you can't escape sandstorms underwater, is anywhere safe?"
	baseturfs = /turf/open/misc/ocean
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

/turf/open/misc/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(liquid_type, src)
	new_immmutable.add_turf(src)

	if(rand_variants && prob(rand_chance))
		var/random = rand(1,rand_variants)
		icon_state = "[icon_state][random]"
		base_icon_state = "[icon_state][random]"

/turf/open/floor/plating/ocean_plating
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/ocean

/turf/open/floor/plating/ocean_plating/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/iron/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/iron/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/iron/solarpanel/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/iron/solarpanel/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/engine/hull/reinforced/ocean
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	temperature = T20C
	planetary_atmos = TRUE
	baseturfs = /turf/open/misc/ocean

/turf/open/floor/engine/hull/reinforced/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/glass/reinforced/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/glass/reinforced/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/glass/plasma/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/glass/plasma/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/open/floor/glass/reinforced/plasma/ocean
	planetary_atmos = TRUE
	baseturfs = /turf/open/floor/plating/ocean_plating

/turf/open/floor/glass/reinforced/plasma/ocean/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/ocean, src)
	new_immmutable.add_turf(src)

/turf/closed/mineral/random/ocean
	baseturfs = /turf/open/misc/ocean/rock/heavy
	turf_type = /turf/open/misc/ocean/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/high_chance/ocean
	baseturfs = /turf/open/misc/ocean/rock/heavy
	turf_type = /turf/open/misc/ocean/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/low_chance/ocean
	baseturfs = /turf/open/misc/ocean/rock/heavy
	turf_type = /turf/open/misc/ocean/rock/heavy
	color = "#58606b"

/turf/closed/mineral/random/stationside/ocean
	baseturfs = /turf/open/misc/ocean/rock/heavy
	turf_type = /turf/open/misc/ocean/rock/heavy
	color = "#58606b"

/obj/effect/abstract/liquid_turf/immutable/canal
	starting_mixture = list(/datum/reagent/water = 100)

/turf/open/misc/canal
	gender = PLURAL
	name = "canal"
	desc = "A section of the earth given way to form a natural aqueduct."
	baseturfs = /turf/open/misc/canal
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	liquid_height = -30
	turf_height = -30

/turf/open/misc/canal/Initialize(mapload)
	. = ..()
	if(liquids)
		if(liquids.immutable)
			liquids.remove_turf(src)
		else
			qdel(liquids, TRUE)
	var/obj/effect/abstract/liquid_turf/immutable/new_immmutable = SSliquids.get_immutable(/obj/effect/abstract/liquid_turf/immutable/canal, src)
	new_immmutable.add_turf(src)

/turf/open/misc/canal_mutable
	gender = PLURAL
	name = "canal"
	desc = "A section of the earth given way to form a natural aqueduct."
	baseturfs = /turf/open/misc/canal_mutable
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/submarine
	name = "submarine floor"
	icon = 'modular_skyrat/modules/liquids/icons/turf/submarine.dmi'
	base_icon_state = "submarine_floor"
	icon_state = "submarine_floor"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/submarine/rust_heretic_act()
	return

/turf/open/floor/iron/submarine_vents
	name = "submarine floor"
	icon = 'modular_skyrat/modules/liquids/icons/turf/submarine.dmi'
	base_icon_state = "submarine_vents"
	icon_state = "submarine_vents"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/submarine_vents/rust_heretic_act()
	return

/turf/open/floor/iron/submarine_perf
	name = "submarine floor"
	icon = 'modular_skyrat/modules/liquids/icons/turf/submarine.dmi'
	base_icon_state = "submarine_perf"
	icon_state = "submarine_perf"
	liquid_height = -30
	turf_height = -30

/turf/open/floor/iron/submarine_perf/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/iron/submarine_perf/rust_heretic_act()
	return

//For now just a titanium wall. I'll make sprites for it later
/turf/closed/wall/mineral/titanium/submarine
	name = "submarine wall"
