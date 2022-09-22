/obj/effect/spawner/xeno_egg_delivery
	name = "xeno egg delivery"
	icon = 'icons/mob/alien.dmi'
	icon_state = "egg_growing"
	var/announcement_time = 1200

/obj/effect/spawner/xeno_egg_delivery/Initialize(mapload)
	..()
	var/turf/T = get_turf(src)

	new /obj/effect/mob_spawn/ghost_role/borer_egg/xenobio(T) // SkyRat Edit: Swaps Xeno egg for Borer egg
	new /obj/effect/temp_visual/gravpush(T)
	playsound(T, 'sound/items/party_horn.ogg', 50, TRUE, -1)

	// SKYRAT EDIT START - Borer egg xenobio spawn
	message_admins("A borer egg has been delivered to [ADMIN_VERBOSEJMP(T)].")
	log_game("A borer egg has been delivered to [AREACOORD(T)]")
	// SKYRAT EDIT END
	var/message = "Attention [station_name()], we have entrusted you with a research specimen in [get_area_name(T, TRUE)]. Remember to follow all safety precautions when dealing with the specimen."
	SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, /proc/_addtimer, CALLBACK(GLOBAL_PROC, /proc/print_command_report, message), announcement_time))
	return INITIALIZE_HINT_QDEL
