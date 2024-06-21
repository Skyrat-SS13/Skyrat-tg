/datum/buildmode_mode/advanced
	key = "advanced"
	var/atom/objholder = null

/datum/buildmode_mode/advanced/show_help(client/builder)
	to_chat(builder, span_purple(examine_block(
		"[span_bold("Set object type")] -> Right Mouse Button on buildmode button\n\
		[span_bold("Copy object type")] -> Left Mouse Button + Alt on turf/obj\n\
		[span_bold("Place objects")] -> Left Mouse Button on turf/obj\n\
		[span_bold("Delete objects")] -> Right Mouse Button\n\
		\n\
		Use the button in the upper left corner to change the direction of built objects."))
	)

/datum/buildmode_mode/advanced/change_settings(client/c)
	var/target_path = input(c, "Enter typepath:", "Typepath", "/obj/structure/closet")
	objholder = text2path(target_path)
	if(!ispath(objholder))
		objholder = pick_closest_path(target_path)
		if(!objholder)
			tgui_alert(usr,"No path was selected")
			return
		else if(ispath(objholder, /area))
			objholder = null
			tgui_alert(usr,"That path is not allowed.")
			return
	BM.preview_selected_item(objholder)

/datum/buildmode_mode/advanced/handle_click(client/c, params, obj/object)
	var/list/modifiers = params2list(params)
	var/left_click = LAZYACCESS(modifiers, LEFT_CLICK)
	var/right_click = LAZYACCESS(modifiers, RIGHT_CLICK)
	var/alt_click = LAZYACCESS(modifiers, ALT_CLICK)

	if(left_click && alt_click)
		if (istype(object, /turf) || isobj(object) || istype(object, /mob))
			objholder = object.type
			to_chat(c, span_notice("[initial(object.name)] ([object.type]) selected."))
			BM.preview_selected_item(objholder)
		else
			to_chat(c, span_notice("[initial(object.name)] is not a turf, object, or mob! Please select again."))
	else if(left_click)
		if(ispath(objholder,/turf))
			var/turf/T = get_turf(object)
			log_admin("Build Mode: [key_name(c)] modified [T] in [AREACOORD(object)] to [objholder]")
			T = T.ChangeTurf(objholder)
			T.setDir(BM.build_dir)
		else if(ispath(objholder, /obj/effect/turf_decal))
			var/turf/T = get_turf(object)
			T.AddElement(/datum/element/decal, initial(objholder.icon), initial(objholder.icon_state), BM.build_dir, null, null, initial(objholder.alpha), initial(objholder.color), null, FALSE, null)
			log_admin("Build Mode: [key_name(c)] in [AREACOORD(object)] added a [initial(objholder.name)] decal with dir [BM.build_dir] to [T]")
		else if(!isnull(objholder))
			var/obj/A = new objholder (get_turf(object))
			A.setDir(BM.build_dir)
			log_admin("Build Mode: [key_name(c)] modified [A]'s [COORD(A)] dir to [BM.build_dir]")
		else
			to_chat(c, span_warning("Select object type first."))
	else if(right_click)
		if(isobj(object))
			log_admin("Build Mode: [key_name(c)] deleted [object] at [AREACOORD(object)]")
			// SKYRAT EDIT -- BS delete sparks. Original was just qdel(object)
			var/turf/T = get_turf(object)
			qdel(object)
			if(T && c.prefs.read_preference(/datum/preference/toggle/admin/delete_sparks))
				playsound(T, 'sound/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, T)
				sparks.attach(T)
				sparks.start()
