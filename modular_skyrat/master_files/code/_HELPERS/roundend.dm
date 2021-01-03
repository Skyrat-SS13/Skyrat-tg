/datum/controller/subsystem/ticker/declare_completion()
	..()
	for(var/M in GLOB.player_list)
		var/mob/m = M
		if (!m.client)
			continue
		m.client.verbs += /client/proc/eorg_teleport
		if (m.client && m.client.prefs && m.client.prefs.eorg_teleport)
			var/eorg_tele_loc = pick(GLOB.eorg_teleport.loc)
			if (isobserver(m))
				continue
			m.forceMove(eorg_tele_loc)
			to_chat(m, "<BR><span class='narsiesmall'>You have chosen not to EORG. Do not commit EORG or you will be banned!</span>")
			to_chat(m, "<BR><BR><span class='notice'>You have been successfully recovered from SS13 and are on your way to the nearest transit interchange. There's some time before the next shuttle home comes though, time to relax.</span>")
			to_chat(m, "<span class='greentext'>You've made it.</span>")

/client/proc/eorg_teleport()
	set name = "Go Home"
	set category = "OOC"
	set desc = "Teleport to a no EORG area."
	var/mob/living/H = mob
	H.revive(full_heal=TRUE,admin_revive=TRUE)
	H.unbuckle_mob()
	var/eorg_tele_loc = pick(GLOB.eorg_teleport.loc)
	H.forceMove(pick(eorg_tele_loc))
	to_chat(H, "<BR><BR><span class='narsiesmall'>You are in a safe zone. Do NOT commit EORG.</span>")
	to_chat(H, "<BR><span class='notice'>You have been successfully recovered from SS13 and are on your way to the nearest transit interchange. It's time to go home. You've made it.</span>")


