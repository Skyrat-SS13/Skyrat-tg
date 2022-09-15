
/datum/looping_sound/lambda
	mid_sounds = list('modular_skyrat/modules/black_mesa/sound/lc_mainbeam.ogg' = 1)
	mid_length = 8.1 SECONDS
	volume = 100

/obj/effect/bump_teleporter/lambda
	name = "\improper Lambda Teleporter"
	desc = "A super powerful teleporter capable of transporting you across dimensions."
	icon = 'icons/obj/engine/energy_ball.dmi'
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

/obj/effect/bump_teleporter/lambda/Bumped(atom/movable/movable_atom)
	if(!id_target)
		return

	var/list/compatable_teleporters = list()
	for(var/obj/effect/bump_teleporter/teleporter in AllTeleporters)
		if(teleporter.id == src.id_target)
			compatable_teleporters += teleporter
	if(!LAZYLEN(compatable_teleporters))
		return
	var/obj/picked_teleporter = pick(compatable_teleporters)
	playsound(src, 'modular_skyrat/modules/black_mesa/sound/lc_teleport.ogg', 100)
	movable_atom.forceMove(get_turf(picked_teleporter))

	if(ishuman(movable_atom))
		var/mob/living/carbon/human/teleporting_human = movable_atom
		teleporting_human.flash_act(10, 1, 1, /atom/movable/screen/fullscreen/flash/lambda, length = 3 SECONDS)
		teleporting_human.Unconscious(15 SECONDS)

/atom/movable/screen/fullscreen/flash/lambda
	color = COLOR_GREEN
