<<<<<<< HEAD
/client/proc/map_template_load()
	set category = "Debug"
	set name = "Map template - Place"

=======
ADMIN_VERB(debug, map_template_load, "Map Template Load", "", R_DEBUG)
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))
	var/datum/map_template/template

	var/map = input(src, "Choose a Map Template to place at your CURRENT LOCATION","Place Map Template") as null|anything in sort_list(SSmapping.map_templates)
	if(!map)
		return
	template = SSmapping.map_templates[map]

	var/turf/T = get_turf(mob)
	if(!T)
		return

	var/list/preview = list()
	var/center
	var/centeralert = tgui_alert(usr,"Center Template.","Template Centering",list("Yes","No"))
	switch(centeralert)
		if("Yes")
			center = TRUE
		if("No")
			center = FALSE
		else
			return
	for(var/turf/place_on as anything in template.get_affected_turfs(T,centered = center))
		var/image/item = image('icons/turf/overlays.dmi', place_on,"greenOverlay")
		SET_PLANE(item, ABOVE_LIGHTING_PLANE, place_on)
		preview += item
	images += preview
	if(tgui_alert(usr,"Confirm location.","Template Confirm",list("Yes","No")) == "Yes")
		if(template.load(T, centered = center))
			var/affected = template.get_affected_turfs(T, centered = center)
			for(var/AT in affected)
				for(var/obj/docking_port/mobile/P in AT)
					if(istype(P, /obj/docking_port/mobile))
						template.post_load(P)
						break

			message_admins(span_adminnotice("[key_name_admin(src)] has placed a map template ([template.name]) at [ADMIN_COORDJMP(T)]"))
		else
			to_chat(src, "Failed to place map", confidential = TRUE)
	images -= preview

<<<<<<< HEAD
/client/proc/map_template_upload()
	set category = "Debug"
	set name = "Map Template - Upload"

	var/map = input(src, "Choose a Map Template to upload to template storage","Upload Map Template") as null|file
=======
ADMIN_VERB(debug, map_template_upload, "Map Template Upload", "", R_DEBUG)
	var/map = input(usr, "Choose a Map Template to upload to template storage","Upload Map Template") as null|file
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))
	if(!map)
		return
	if(copytext("[map]", -4) != ".dmm")//4 == length(".dmm")
		to_chat(src, span_warning("Filename must end in '.dmm': [map]"), confidential = TRUE)
		return
	var/datum/map_template/M
	switch(tgui_alert(usr, "What kind of map is this?", "Map type", list("Normal", "Shuttle", "Cancel")))
		if("Normal")
			M = new /datum/map_template(map, "[map]", TRUE)
		if("Shuttle")
			M = new /datum/map_template/shuttle(map, "[map]", TRUE)
		else
			return
	if(!M.cached_map)
		to_chat(src, span_warning("Map template '[map]' failed to parse properly."), confidential = TRUE)
		return

	var/datum/map_report/report = M.cached_map.check_for_errors()
	var/report_link
	if(report)
		report.show_to(src)
		report_link = " - <a href='?src=[REF(report)];[HrefToken(forceGlobal = TRUE)];show=1'>validation report</a>"
		to_chat(src, span_warning("Map template '[map]' <a href='?src=[REF(report)];[HrefToken()];show=1'>failed validation</a>."), confidential = TRUE)
		if(report.loadable)
			var/response = tgui_alert(usr, "The map failed validation, would you like to load it anyways?", "Map Errors", list("Cancel", "Upload Anyways"))
			if(response != "Upload Anyways")
				return
		else
			tgui_alert(usr, "The map failed validation and cannot be loaded.", "Map Errors", list("Oh Darn"))
			return

	SSmapping.map_templates[M.name] = M
	message_admins(span_adminnotice("[key_name_admin(src)] has uploaded a map template '[map]' ([M.width]x[M.height])[report_link]."))
	to_chat(src, span_notice("Map template '[map]' ready to place ([M.width]x[M.height])"), confidential = TRUE)
