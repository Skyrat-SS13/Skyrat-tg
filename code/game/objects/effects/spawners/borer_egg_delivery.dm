/obj/effect/spawner/borer_egg_delivery
	name = "borer egg delivery"
	icon = 'modular_skyrat/modules/cortical_borer/icons/animal.dmi'
	icon_state = "brainegg"
	var/announcement_time = 1200

/obj/effect/spawner/borer_egg_delivery/Initialize(mapload)
	..()
	var/turf/T = get_turf(src)

	new /obj/structure/alien/egg(T)
	new /obj/effect/temp_visual/gravpush(T)
	playsound(T, 'sound/items/party_horn.ogg', 50, TRUE, -1)

	message_admins("A borer egg has been delivered to [ADMIN_VERBOSEJMP(T)].")
	log_game("A borer egg has been delivered to [AREACOORD(T)]")
	var/message = "Attention [station_name()], we have entrusted you with a research specimen in [get_area_name(T, TRUE)]. Remember to follow all safety precautions when dealing with the specimen."
	SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, /proc/_addtimer, CALLBACK(GLOBAL_PROC, /proc/print_command_report, message), announcement_time))
	return INITIALIZE_HINT_QDEL
