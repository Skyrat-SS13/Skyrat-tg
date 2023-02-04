/datum/smite/tablewide
	name = "Tablewide"

/datum/smite/tablewide/effect(client/user, mob/living/target)
	. = ..()

	priority_announce(html_decode("[target] has brought the wrath of the gods upon themselves and is now being tableslammed across the station. Please stand by."), null, 'sound/misc/announce.ogg', "CentCom")
	var/list/areas = list()
	for(var/area/A in world)
		if(A.z == SSmapping.station_start)
			areas += A
	SEND_SOUND(target, sound('nebula_modular/sound/slamofthenorthstar.ogg',volume=60))
	for(var/area/A in areas)
		for(var/obj/structure/table/T in A)
			T.tablepush(target, target)
			sleep(1)
