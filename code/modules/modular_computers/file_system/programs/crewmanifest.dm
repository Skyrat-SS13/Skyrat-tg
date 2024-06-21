/datum/computer_file/program/crew_manifest
	filename = "plexagoncrew"
	filedesc = "Plexagon Crew List"
	downloader_category = PROGRAM_CATEGORY_SECURITY
	program_open_overlay = "id"
	extended_desc = "Program for viewing and printing the current crew manifest"
	download_access = list(ACCESS_SECURITY, ACCESS_COMMAND)
	program_flags = PROGRAM_ON_NTNET_STORE | PROGRAM_REQUIRES_NTNET
	size = 4
	tgui_id = "NtosCrewManifest"
	program_icon = "clipboard-list"
	detomatix_resistance = DETOMATIX_RESIST_MAJOR

/datum/computer_file/program/crew_manifest/ui_static_data(mob/user)
	var/list/data = list()
	data["manifest"] = GLOB.manifest.get_manifest()
	return data

/datum/computer_file/program/crew_manifest/ui_act(action, params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("PRG_print")
			if(computer) //This option should never be called if there is no printer
				var/contents = {"<h4>Crew Manifest</h4>
								<br>
								[GLOB.manifest ? GLOB.manifest.get_html(0) : ""]
								"}
				if(!computer.print_text(contents, "crew manifest ([station_time_timestamp()])"))
					to_chat(usr, span_notice("Printer is out of paper."))
					return
				else
					computer.visible_message(span_notice("\The [computer] prints out a paper."))
