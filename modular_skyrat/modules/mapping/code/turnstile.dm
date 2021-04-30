/obj/machinery/turnstile
	name = "turnstile"
	desc = "A mechanical door that permits one-way access and prevents tailgating."
	icon = 'modular_skyrat/modules/mapping/icons/turnstile.dmi'
	icon_state = "turnstile_map"
	density = TRUE
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 50, bomb = 10, bio = 100, rad = 100, fire = 90, acid = 70)
	anchored = TRUE
	use_power = FALSE
	idle_power_usage = 2
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	layer = OPEN_DOOR_LAYER

/obj/machinery/turnstile/Initialize()
	. = ..()
	icon_state = "turnstile"

	var/static/list/loc_connections = list(
		COMSIG_ATOM_EXIT = .proc/on_exit,
	)

	AddElement(/datum/element/connect_loc, loc_connections)

/obj/machinery/turnstile/CanAtmosPass(turf/T)
	return TRUE

/obj/machinery/turnstile/bullet_act(obj/projectile/P, def_zone)
	return -1 //Pass through!

/obj/machinery/turnstile/proc/allowed_access(var/mob/B)
	if(B.pulledby && ismob(B.pulledby))
		return allowed(B.pulledby) | allowed(B)
	else
		return allowed(B)

/obj/machinery/turnstile/Cross(atom/movable/AM, turf/T)
	if(ismob(AM))
		var/mob/B = AM
		if(isliving(AM))
			var/mob/living/M = AM

			if(world.time - M.last_bumped <= 5)
				return FALSE
			M.last_bumped = world.time

			var/allowed_access = FALSE
			var/turf/behind = get_step(src, dir)

			if(B in behind.contents)
				allowed_access = allowed_access(B)
			else
				to_chat(usr, "<span class='notice'>\the [src] resists your efforts.</span>")
				return FALSE

			if(allowed_access)
				flick("operate", src)
				playsound(src,'sound/items/ratchet.ogg',50,0,3)
				return TRUE
			else
				flick("deny", src)
				playsound(src,'sound/machines/deniedbeep.ogg',50,0,3)
				return FALSE
	return..()

/obj/machinery/turnstile/proc/on_exit(datum/source, atom/movable/leaving, atom/new_location)
	SIGNAL_HANDLER

	if(isliving(leaving))
		var/mob/living/M = leaving
		var/outdir = dir
		if(allowed_access(M))
			outdir = REVERSE_DIR(dir)
		var/turf/outturf = get_step(src, outdir)
		var/canexit = (new_location == src.loc) | (new_location == outturf)

		if(!canexit && world.time - M.last_bumped <= 5)
			to_chat(usr, "<span class='notice'>\the [src] resists your efforts.</span>")
		M.last_bumped = world.time

		if(!canexit)
			return COMPONENT_ATOM_BLOCK_EXIT
