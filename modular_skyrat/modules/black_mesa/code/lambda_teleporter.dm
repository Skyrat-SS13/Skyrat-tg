
/datum/looping_sound/lambda
	mid_sounds = list('modular_skyrat/modules/black_mesa/sound/lc_mainbeam.ogg' = 1)
	mid_length = 8.1 SECONDS
	volume = 100

/obj/effect/bump_teleporter/lambda
	name = "\improper Lambda Teleporter"
	desc = "A super powerful teleporter capable of transporting you across dimensions."
	icon = 'icons/obj/machines/engine/energy_ball.dmi'
	icon_state = "energy_ball"
	pixel_x = -32
	pixel_y = -32
	invisibility = 0
	light_range = 6
	color = COLOR_CYAN
	var/datum/looping_sound/lambda/looping_sound
	var/atom/movable/warp_effect/effect

/obj/effect/bump_teleporter/lambda/Initialize(mapload)
	. = ..()
	looping_sound = new(src, TRUE)
	effect = new(src)
	vis_contents += effect

/obj/effect/bump_teleporter/lambda/Destroy()
	QDEL_NULL(looping_sound)
	vis_contents -= effect
	QDEL_NULL(effect)
	return ..()

/obj/effect/bump_teleporter/lambda/teleport_action(atom/movable/target, turf/destination)
	// Play sound before moving.
	playsound(src, 'modular_skyrat/modules/black_mesa/sound/lc_teleport.ogg', 100)

	. = ..()

	if(isliving(target))
		var/mob/living/teleporting_mob = target
		teleporting_mob.flash_act(10, 1, 1, /atom/movable/screen/fullscreen/flash/lambda, length = 3 SECONDS)
		teleporting_mob.Unconscious(15 SECONDS)

/atom/movable/screen/fullscreen/flash/lambda
	color = COLOR_GREEN
