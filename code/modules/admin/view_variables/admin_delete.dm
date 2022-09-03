/client/proc/admin_delete(datum/D)
	var/atom/A = D
	var/coords = ""
	var/jmp_coords = ""
	var/turf/T // SKYRAT EDIT -- Bluespace sparks on admin delete
	if(istype(A))
		T = get_turf(A) // SKYRAT EDIT, orginal: var/turf/T = get_turf(A)
		if(T)
			var/atom/a_loc = A.loc
			var/is_turf = isturf(a_loc)
			coords = "[is_turf ? "at" : "from [a_loc] at"] [AREACOORD(T)]"
			jmp_coords = "[is_turf ? "at" : "from [a_loc] at"] [ADMIN_VERBOSEJMP(T)]"
		else
			jmp_coords = coords = "in nullspace"

	if (tgui_alert(usr, "Are you sure you want to delete:\n[D]\n[coords]?", "Confirmation", list("Yes", "No")) == "Yes")
		log_admin("[key_name(usr)] deleted [D] [coords]")
		message_admins("[key_name_admin(usr)] deleted [D] [jmp_coords]")
		SSblackbox.record_feedback("tally", "admin_verb", 1, "Delete") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
		if(isturf(D))
			T = D // SKYRAT EDIT, orginal: var/turf/T = D
			T.ScrapeAway()
		else
			vv_update_display(D, "deleted", VV_MSG_DELETED)
			qdel(D)
			if(!QDELETED(D))
				vv_update_display(D, "deleted", "")
		// Skyrat edit addition start -- optional bluespace sparks on delete
		if(T && prefs.read_preference(/datum/preference/toggle/admin/delete_sparks))
			playsound(T, 'sound/magic/Repulse.ogg', 100, 1)
			var/datum/effect_system/spark_spread/quantum/sparks = new
			sparks.set_up(10, 1, T)
			sparks.attach(T)
			sparks.start()
