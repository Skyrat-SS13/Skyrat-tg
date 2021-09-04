/area/planet
	icon_state = "mining"
	has_gravity = STANDARD_GRAVITY
	flags_1 = NONE
	always_unpowered = TRUE
	requires_power = TRUE
	power_environ = FALSE
	power_equip = FALSE
	power_light = FALSE
	area_flags = VALID_TERRITORY | UNIQUE_AREA | CAVES_ALLOWED | FLORA_ALLOWED | MOB_SPAWN_ALLOWED | MEGAFAUNA_SPAWN_ALLOWED | NO_ALERTS
	ambience_index = AMBIENCE_AWAY
	outdoors = TRUE

/datum/biome/mountain
	turf_type = /turf/closed/mineral/random/jungle

/datum/biome/water
	turf_type = /turf/open/floor/planetary/water

/turf/open/floor/planetary
	icon = 'icons/planet/planet_floors.dmi'
	broken = FALSE
	initial_gas_mix = PLANETARY_ATMOS
	planetary_atmos = TRUE
	tiled_dirt = FALSE
	intact = FALSE
	baseturfs = /turf/open/floor/planetary/rock
	can_have_catwalk = TRUE
	var/can_build_on = TRUE

/turf/open/floor/planetary/ex_act(severity, target)
	. = SEND_SIGNAL(src, COMSIG_ATOM_EX_ACT, severity, target)
	contents_explosion(severity, target)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		if(EXPLODE_HEAVY)
			if(prob(33))
				ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
			else
				break_tile()
		if(EXPLODE_LIGHT)
			if(prob(50))
				break_tile()
	hotspot_expose(500,CELL_VOLUME)

/turf/open/floor/planetary/attackby(obj/item/C, mob/user, params)
	if(..())
		return
	if(can_build_on)
		try_place_tile(C, user, TRUE, FALSE)

/turf/open/floor/planetary/examine(mob/user)
	. = ..()
	if(broken || burnt)
		. += SPAN_NOTICE("It looks like it had better days.")
	if(can_build_on)
		. += SPAN_NOTICE("You might be able to build ontop of it with some <i>tiles</i> or reinforcement <i>rods</i>.")

/turf/open/floor/planetary/setup_broken_states()
	return list(base_icon_state)

/turf/open/floor/planetary/setup_burnt_states()
	return

/turf/open/floor/planetary/water
	gender = PLURAL
	name = "water"
	desc = "A pool of water, very wet."
	baseturfs = /turf/open/floor/planetary/water
	icon_state = "water"
	base_icon_state = "water"
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER
	slowdown = 2

/turf/open/floor/planetary/water/tar
	gender = PLURAL
	name = "tar"
	desc = "A pool of viscous and sticky tar."
	slowdown = 10

/turf/open/floor/planetary/water/Initialize()
	. = ..()
	if(!color)
		var/datum/space_level/level = SSmapping.z_list[z]
		color = level.water_color

/turf/open/floor/planetary/grass
	name = "grass"
	desc = "A patch of grass."
	icon = 'icons/planet/planet_grass.dmi'
	icon_state = "grass0"
	base_icon_state = "grass"
	baseturfs = /turf/open/floor/planetary/dirt
	bullet_bounce_sound = null
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	clawfootstep = FOOTSTEP_GRASS
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_FLOOR_GRASS)
	canSmoothWith = list(SMOOTH_GROUP_CLOSED_TURFS, SMOOTH_GROUP_FLOOR_GRASS)
	layer = HIGH_TURF_LAYER

/turf/open/floor/planetary/grass/setup_broken_states()
	return list("damaged")

/turf/open/floor/planetary/grass/Initialize()
	. = ..()
	var/matrix/translation = new
	translation.Translate(-9, -9)
	transform = translation
	var/datum/space_level/level = SSmapping.z_list[z]
	color = level.grass_color

/turf/open/floor/planetary/dirt
	gender = PLURAL
	name = "dirt"
	desc = "Upon closer examination, it's still dirt."
	icon_state = "cracked_dirt"
	base_icon_state = "cracked_dirt"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY


/turf/open/floor/planetary/rock
	name = "rock"
	icon_state = "rock_floor"
	base_icon_state = "rock_floor"
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/planetary/rock/Initialize()
	. = ..()
	var/datum/space_level/level = SSmapping.z_list[z]
	color = level.rock_color

/turf/open/floor/planetary/mud
	gender = PLURAL
	name = "mud"
	desc = "Thick, claggy and waterlogged."
	icon_state = "dark_mud"
	base_icon_state = "dark_mud"
	bullet_bounce_sound = null
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/planetary/sand
	gender = PLURAL
	name = "sand"
	desc = "It's coarse and gets everywhere."
	baseturfs = /turf/open/floor/planetary/sand
	icon_state = "sand"
	base_icon_state = "sand"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/planetary/sand/Initialize()
	. = ..()
	if(prob(10))
		icon_state = "[base_icon_state][rand(1,5)]"

/turf/open/floor/planetary/dry_seafloor
	gender = PLURAL
	name = "dry seafloor"
	desc = "Should have stayed hydrated."
	baseturfs = /turf/open/floor/planetary/dry_seafloor
	icon_state = "dry"
	base_icon_state = "dry"
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/planetary/dry_seafloor/Initialize()
	. = ..()
	if(prob(3))
		AddComponent(/datum/component/digsite)

/turf/open/floor/planetary/wasteland
	name = "cracked earth"
	desc = "Looks a bit dry."
	icon = 'icons/turf/floors.dmi'
	icon_state = "wasteland"
	base_icon_state = "wasteland"
	slowdown = 1

/turf/open/floor/planetary/wasteland/setup_broken_states()
	return list("[initial(icon_state)]0")

/turf/open/floor/planetary/wasteland/Initialize()
	.=..()
	if(prob(15))
		icon_state = "[initial(icon_state)][rand(0,12)]"
	if(prob(3))
		AddComponent(/datum/component/digsite)

/turf/open/floor/planetary/dirt
	gender = PLURAL
	name = "dirt"
	desc = "Upon closer examination, it's still dirt."
	icon = 'icons/turf/floors.dmi'
	icon_state = "dirt"
	base_icon_state = "dirt"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/planetary/dirt/dark
	icon_state = "greenerdirt"
	base_icon_state = "greenerdirt"

/turf/open/floor/planetary/dirt/jungle
	slowdown = 0.5

/turf/open/floor/planetary/dirt/jungle/dark
	icon_state = "greenerdirt"
	base_icon_state = "greenerdirt"

/turf/closed/mineral/random/jungle
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 40, /obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/bluespace_crystal = 1)
	baseturfs = /turf/open/floor/planetary/rock

/obj/structure/flora/planetary
	name = "bush"
	desc = "Some kind of plant."
	icon = 'icons/planet/grayscale_flora.dmi'
	var/variants = 0

/obj/structure/flora/planetary/Initialize()
	. = ..()
	if(!color)
		var/datum/space_level/level = SSmapping.z_list[z]
		color = level.plant_color
	icon_state = "[icon_state]_[rand(1,variants)]"

/obj/structure/flora/planetary/firstbush
	icon_state = "firstbush"
	variants = 4

/obj/structure/flora/planetary/leafybush
	icon_state = "leafybush"
	variants = 3

/obj/structure/flora/planetary/palebush
	icon_state = "palebush"
	variants = 4

/obj/structure/flora/planetary/grassybush
	icon_state = "grassybush"
	variants = 4

/obj/structure/flora/planetary/fernybush
	icon_state = "fernybush"
	variants = 3

/obj/structure/flora/planetary/sunnybush
	icon_state = "sunnybush"
	variants = 3

/obj/structure/flora/planetary/genericbush
	icon_state = "genericbush"
	variants = 4

/obj/structure/flora/planetary/pointybush
	icon_state = "pointybush"
	variants = 4

/obj/structure/flora/planetary/lavendergrass
	name = "grass"
	icon_state = "lavendergrass"
	variants = 4

/obj/structure/flora/planetary_grass
	name = "grass"
	desc = "Some kind of plant."
	icon = 'icons/planet/grayscale_flora.dmi'
	var/variants = 0

/obj/structure/flora/planetary_grass/Initialize()
	. = ..()
	if(!color)
		var/datum/space_level/level = SSmapping.z_list[z]
		color = level.grass_color
	icon_state = "[icon_state]_[rand(1,variants)]"

/obj/structure/flora/planetary_grass/sparsegrass
	icon_state = "sparsegrass"
	variants = 3

/obj/structure/flora/planetary_grass/fullgrass
	icon_state = "fullgrass"
	variants = 3

/turf/open/floor/planetary/concrete
	gender = PLURAL
	name = "concrete"
	desc = "A flat expanse of artificial stone-like material."
	icon_state = "concrete"
	base_icon_state = "concrete"
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/planetary/concrete/reinforced
	name = "reinforced concrete"
	icon_state = "hexacrete"
	base_icon_state = "hexacrete"
