/obj/effect/bump_teleporter/lambda
	name = "\improper Lambda Teleporter"
	desc = "A super powerful teleporter capable of transporting you across dimensions."
	icon = 'icons/obj/tesla_engine/energy_ball.dmi'
	icon_state = "energy_ball"
	pixel_x = -32
	pixel_y = -32

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
	movable_atom.forceMove(get_turf(picked_teleporter))

	if(ishuman(movable_atom))
		var/mob/living/carbon/human/teleporting_human = movable_atom
		teleporting_human.Unconscious(10 SECONDS)
		teleporting_human.playsound_local(get_turf(teleporting_human), 'modular_skyrat/modules/black_mesa/sound/lc_teleport.ogg', 100)
