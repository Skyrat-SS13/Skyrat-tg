
// Smallest explosion
/obj/effect/explosion_skyrat
	name = "fire"
	icon = 'modular_skyrat/goon/icons/effects/explosions/32x32.dmi'
	icon_state = "explosion"
	opacity = TRUE
	anchored = TRUE
	plane = ABOVE_GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/qdel_time = 1 SECONDS

/obj/effect/explosion_skyrat/Initialize(mapload)
	. = ..()
	QDEL_IN(src, qdel_time)

/datum/effect_system/explosion_skyrat
	var/explosion_effect = /obj/effect/explosion_skyrat

/datum/effect_system/explosion_skyrat/set_up(location)
	src.location = get_turf(location)

/datum/effect_system/explosion_skyrat/start()
	new explosion_effect(location)
	var/datum/effect_system/expl_particles/explosion_particles = new /datum/effect_system/expl_particles()
	explosion_particles.set_up(10, 0, location)
	explosion_particles.start()

/obj/effect/explosion_skyrat/medium
	icon = 'modular_skyrat/goon/icons/effects/explosions/96x96.dmi'
	icon_state = "explosion"
	pixel_x = -32
	pixel_y = -32
	qdel_time = 2.5 SECONDS

/datum/effect_system/explosion_skyrat/medium
	explosion_effect = /obj/effect/explosion_skyrat/medium

/obj/effect/explosion_skyrat/large
	icon = 'modular_skyrat/goon/icons/effects/explosions/224x224.dmi'
	icon_state = "explosion"
	pixel_x = -96
	pixel_y = -96
	qdel_time = 5 SECONDS

/datum/effect_system/explosion_skyrat/large
	explosion_effect = /obj/effect/explosion_skyrat/large
