GLOBAL_LIST_EMPTY(anti_eorg_teleports)

/obj/effect/landmark/anti_eorg_teleport
	name = "Anti-EORG teleport"

/obj/effect/landmark/anti_eorg_teleport/Initialize(mapload)
	..()
	GLOB.anti_eorg_teleports += loc
	return INITIALIZE_HINT_QDEL

/mob/living/carbon/human/Topic(href, href_list)
	. = ..()
	if(.)
		return
	if(href_list["eorg_teleport_bypass"])
		client.prefs.anti_eorg_teleport = !client.prefs.anti_eorg_teleport
		to_chat(src, span_info("You choose to [client.prefs.anti_eorg_teleport ? "teleport" : "stay"]. Relax as you wish."))
