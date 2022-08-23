/datum/admins/proc/toggleeorg()
	set category = "Server"
	set desc="Toggle round-end grief"
	set name="Toggle EORG"

	var/eorg = CONFIG_GET(flag/allow_eorg)
	CONFIG_SET(flag/allow_eorg, !eorg)
	eorg = !eorg
	log_admin("[key_name(usr)] toggled [eorg ? "on" : "off"] EORG.")
	message_admins("[key_name_admin(usr)] toggled [eorg ? "on" : "off"] EORG.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle EORG", "[eorg ? "Enabled" : "Disabled"]")) //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/mob/living/carbon/human/Topic(href, href_list)
	..()

	if(href_list["eorg_teleport_switch"])
		var/datum/preferences/preferences = client.prefs
		var/eorg_choice = client.prefs.read_preference(/datum/preference/toggle/eorg_join)
		to_chat(src, "You choose to [eorg_choice ?  "end the round in peace." : "fight. Prepare for blood!"]")
		preferences.write_preference(GLOB.preference_entries[/datum/preference/toggle/eorg_join], !eorg_choice)

/proc/process_eorg_announce()
	if(!(CONFIG_GET(flag/allow_eorg)))
		return
	for(var/mob/living/carbon/human/eorg_candidate in GLOB.human_list)
		if(eorg_candidate.client)
			var/eorg_choice = eorg_candidate.client.prefs?.read_preference(/datum/preference/toggle/eorg_join)
			to_chat(eorg_candidate, "The round will end up soon. You have choose to [eorg_choice ? "join in" : "stay away"] before. \
			<a href='?src=[REF(eorg_candidate)];eorg_teleport_switch=1'>Shall you change your mind?</a>")

/proc/process_eorg_teleport()
	if(!(CONFIG_GET(flag/allow_eorg)))
		return
	var/static/llist/EORG_teleports = list()
	var/static/llist/EORG_outfits = list(\
		/datum/outfit/spacepol, /datum/outfit/russian_hunter, \
		/datum/outfit/bountyarmor, /datum/outfit/syndicate, \
		/datum/outfit/ctf/medisim, /datum/outfit/centcom/ert/marine/security)
	var/static/llist/EORG_outfits_rare = list(\
		/datum/outfit/syndicate/clownop, /datum/outfit/ctf/assault/red, \
		/datum/outfit/centcom/spec_ops, /datum/outfit/mobster, /datum/outfit/pirate/enclave_officer)
	var/static/llist/EORG_outfits_rare_survivor = list(\
		/datum/outfit/butler, /datum/outfit/prisoner, /datum/outfit/job/assistant, /datum/outfit/chicken, /datum/outfit/ashwalker)

	for(var/area/centcom/ctf/eorg_zone in GLOB.sortedAreas)
		for(var/turf/open/floor/eorg_turf in eorg_zone)
			if(!eorg_turf.is_blocked_turf(TRUE)) //the turf should be at least not blocked
				EORG_teleports += eorg_turf

		if(!EORG_teleports) //empty list, for some reason
			EORG_teleports += eorg_zone.loc

	if(!EORG_teleports) //literally a safe check if CTF area will be lost somehow (should never happend)
		for(var/area/centcom/tdome/arena/eorg_zone in GLOB.sortedAreas)
			for(var/turf/open/floor/circuit/green/eorg_turf in eorg_zone)
				EORG_teleports += eorg_turf

			if(!EORG_teleports)
				EORG_teleports += eorg_zone.loc

			//temporary before a real map will be made
			for(var/obj/machinery/door/poddoor/door in eorg_zone)
				INVOKE_ASYNC(door, /obj/machinery/door/poddoor.proc/open)

	for(var/mob/living/carbon/human/eorg_player in GLOB.human_list)
		if(eorg_player.ckey)
			if(eorg_player.client?.prefs?.read_preference(/datum/preference/toggle/eorg_join))
				new /obj/effect/particle_effect/sparks/quantum (eorg_player.loc)
				eorg_player.uncuff()
				eorg_player.user_unbuckle_mob(eorg_player, eorg_player)
				eorg_player.revive(1, 1) //full healing + getting back on legs
				eorg_player.delete_equipment()
				switch(rand(1,100))
					if(1 to 80)
						eorg_player.equipOutfit(pick(EORG_outfits))
					if(81 to 90)
						eorg_player.equipOutfit(pick(EORG_outfits_rare))
					if(91 to 100)
						eorg_player.equipOutfit(pick(EORG_outfits_rare_survivor))
				eorg_player.visible_message(span_notice("[eorg_player] is teleported back home, hopefully to an everloving family!"), span_userdanger("THERE CAN BE ONLY ONE!"))
				var/turf/picked_turf = pick(EORG_teleports)
				eorg_player.forceMove(picked_turf)

	INVOKE_ASYNC(GLOBAL_PROC, /proc/process_eorg_bans)
