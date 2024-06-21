/datum/buildmode_mode/delete
	key = "delete"

/datum/buildmode_mode/delete/show_help(client/builder)
	to_chat(builder, span_purple(examine_block(
		"[span_bold("Delete an object")] -> Left Mouse Button on obj/turf/mob\n\
		[span_bold("Delete all objects of a type")] -> Right Mouse Button on obj/turf/mob"))
	)

/datum/buildmode_mode/delete/handle_click(client/c, params, object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		if(isturf(object))
			var/turf/T = object
			T.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		else if(isatom(object))
			// SKYRAT EDIT -- BS delete sparks. Original was just qdel(object)
			var/turf/T = get_turf(object)
			qdel(object)
			if(T && c.prefs.read_preference(/datum/preference/toggle/admin/delete_sparks))
				playsound(T, 'sound/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, T)
				sparks.attach(T)
				sparks.start()

	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(check_rights(R_DEBUG|R_SERVER)) //Prevents buildmoded non-admins from breaking everything.
			if(isturf(object))
				return
			var/atom/deleting = object
			var/action_type = tgui_alert(usr,"Strict type ([deleting.type]) or type and all subtypes?",,list("Strict type","Type and subtypes","Cancel"))
			if(action_type == "Cancel" || !action_type)
				return

			if(tgui_alert(usr,"Are you really sure you want to delete all instances of type [deleting.type]?",,list("Yes","No")) != "Yes")
				return

			if(tgui_alert(usr,"Second confirmation required. Delete?",,list("Yes","No")) != "Yes")
				return

			var/O_type = deleting.type
			switch(action_type)
				if("Strict type")
					var/i = 0
					for(var/atom/Obj in world)
						if(Obj.type == O_type)
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No instances of this type exist")
						return
					log_admin("[key_name(usr)] deleted all instances of type [O_type] ([i] instances deleted) ")
					message_admins(span_notice("[key_name(usr)] deleted all instances of type [O_type] ([i] instances deleted) "))
				if("Type and subtypes")
					var/i = 0
					for(var/Obj in world)
						if(istype(Obj,O_type))
							i++
							qdel(Obj)
						CHECK_TICK
					if(!i)
						to_chat(usr, "No instances of this type exist")
						return
					log_admin("[key_name(usr)] deleted all instances of type or subtype of [O_type] ([i] instances deleted) ")
					message_admins(span_notice("[key_name(usr)] deleted all instances of type or subtype of [O_type] ([i] instances deleted) "))
