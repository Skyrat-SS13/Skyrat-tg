/datum/buildmode_mode/basic
	key = "basic"

/datum/buildmode_mode/basic/show_help(client/c)
	to_chat(c, "<span class='notice'>***********************************************************</span>")
	to_chat(c, "<span class='notice'>Left Mouse Button        = Construct / Upgrade</span>")
	to_chat(c, "<span class='notice'>Right Mouse Button       = Deconstruct / Delete / Downgrade</span>")
	to_chat(c, "<span class='notice'>Left Mouse Button + ctrl = R-Window</span>")
	to_chat(c, "<span class='notice'>Left Mouse Button + alt  = Airlock</span>")
	to_chat(c, "")
	to_chat(c, "<span class='notice'>Use the button in the upper left corner to</span>")
	to_chat(c, "<span class='notice'>change the direction of built objects.</span>")
	to_chat(c, "<span class='notice'>***********************************************************</span>")

/datum/buildmode_mode/basic/handle_click(client/c, params, obj/object)
	var/list/modifiers = params2list(params)

	var/left_click = LAZYACCESS(modifiers, LEFT_CLICK)
	var/right_click = LAZYACCESS(modifiers, RIGHT_CLICK)
	var/alt_click = LAZYACCESS(modifiers, ALT_CLICK)
	var/ctrl_click = LAZYACCESS(modifiers, CTRL_CLICK)

	if(istype(object,/turf) && left_click && !alt_click && !ctrl_click)
		var/turf/T = object
		if(isspaceturf(object))
			T.PlaceOnTop(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
		else if(isplatingturf(object))
			T.PlaceOnTop(/turf/open/floor/iron, flags = CHANGETURF_INHERIT_AIR)
		else if(isfloorturf(object))
			T.PlaceOnTop(/turf/closed/wall)
		else if(iswallturf(object))
			T.PlaceOnTop(/turf/closed/wall/r_wall)
		log_admin("Build Mode: [key_name(c)] built [T] at [AREACOORD(T)]")
		return
	else if(right_click)
		log_admin("Build Mode: [key_name(c)] deleted [object] at [AREACOORD(object)]")
		if(isturf(object))
			var/turf/T = object
			T.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
		else if(isobj(object))
			// SKYRAT EDIT -- BS delete sparks. Original was just qdel(object)
			var/turf/T = get_turf(object)
			qdel(object)
			if(T && c.prefs.skyrat_toggles & ADMINDEL_ZAP_PREF)
				playsound(T, 'sound/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, T)
				sparks.attach(T)
				sparks.start()
		return
	else if(istype(object,/turf) && alt_click && left_click)
		log_admin("Build Mode: [key_name(c)] built an airlock at [AREACOORD(object)]")
		new/obj/machinery/door/airlock(get_turf(object))
	else if(istype(object,/turf) && ctrl_click && left_click)
		var/obj/structure/window/reinforced/window
		if(BM.build_dir in GLOB.diagonals)
			window = new /obj/structure/window/reinforced/fulltile(get_turf(object))
		else
			window = new /obj/structure/window/reinforced(get_turf(object))
			window.setDir(BM.build_dir)
		log_admin("Build Mode: [key_name(c)] built a window at [AREACOORD(object)]")
