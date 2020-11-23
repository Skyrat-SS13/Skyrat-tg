/datum/event_spawner_instance
	var/id
	var/list/species_whitelist = list()
	var/list/ckey_whitelist = list()
	var/used_outfit
	var/job_name = "ass"
	var/gets_loadout = TRUE
	var/access_override
	var/headset_override
	var/flavor_text = "lolol"
	var/list/additional_equipment
	var/disappear_after_spawn = FALSE

	var/show_outfit_equipment = FALSE

/datum/event_spawner_instance/New(_id, template_id)
	id = _id

/datum/event_spawner_manager
	var/next_id = 0
	var/list/managed_instances = list()

/datum/event_spawner_manager/proc/ShowPanel(mob/user, panel_id)
	if(!user || !user.client)
		return
	var/list/dat = list("")
	if(panel_id)
		var/datum/event_spawner_instance/ESI = managed_instances["[panel_id]"]
		if(!ESI)
			return
		dat += "<a href='?src=[REF(src)];inst_pref=return;id=[ESI.id]'>Return</a><HR>"
		dat += "<a href='?src=[REF(src)];inst_pref=job_name;id=[ESI.id]'>Job Name:</a> <b>[ESI.job_name]</b>"
		dat += "<BR><i>This will appear on the person's ID</i>"
		dat += "<BR><a href='?src=[REF(src)];inst_pref=flavor_text;id=[ESI.id]'>Flavor Text:</a> <i>[ESI.flavor_text]</i>"
		dat += "<BR><i>The player will be greeted with the flavor text. Tell him who his supervisors are, if any.</i>"
		var/outfit_name
		var/datum/outfit/OU
		if(ESI.used_outfit)
			OU = ESI.used_outfit
			outfit_name = initial(OU.name)
		dat += "<BR>Allow Loadout: <a href='?src=[REF(src)];inst_pref=loadout;id=[ESI.id]'>[ESI.gets_loadout ? "Yes" : "No"]</a>"
		dat += "<BR><i>Whether loadout from prefs is allowed.</i>"
		dat += "<BR><a href='?src=[REF(src)];inst_pref=used_outfit;id=[ESI.id]'>Used Outfit:</a> [outfit_name]"
		dat += "<BR><i>Which outfit is used for the spawned player. Below you can preview contents of the selected one.</i>"
		if(ESI.used_outfit)
			dat += "<BR><a href='?src=[REF(src)];inst_pref=show_outfit_equipment;id=[ESI.id]'>[ESI.show_outfit_equipment ? "Hide outfit equipment" : "Show outfit equipment"]</a>"
		if(OU && ESI.show_outfit_equipment)
			dat += "<HR><b>Outfit equipment:</b>"
			var/obj/item/display = initial(OU.uniform)
			if(display)
				dat += "<BR>Uniform: [initial(display.name)] ([display])"
			display = initial(OU.suit)
			if(display)
				dat += "<BR>Suit: [initial(display.name)] ([display])"
			display = initial(OU.belt)
			if(display)
				dat += "<BR>Belt: [initial(display.name)] ([display])"
			display = initial(OU.gloves)
			if(display)
				dat += "<BR>Gloves: [initial(display.name)] ([display])"
			display = initial(OU.head)
			if(display)
				dat += "<BR>Head: [initial(display.name)] ([display])"
			display = initial(OU.mask)
			if(display)
				dat += "<BR>Mask: [initial(display.name)] ([display])"
			display = initial(OU.neck)
			if(display)
				dat += "<BR>Neck: [initial(display.name)] ([display])"
			display = initial(OU.ears)
			if(display)
				dat += "<BR>Ears: [initial(display.name)] ([display])"
			display = initial(OU.glasses)
			if(display)
				dat += "<BR>Glasses: [initial(display.name)] ([display])"
			display = initial(OU.id)
			if(display)
				dat += "<BR>Id: [initial(display.name)] ([display])"
			display = initial(OU.l_pocket)
			if(display)
				dat += "<BR>Left pocket: [initial(display.name)] ([display])"
			display = initial(OU.r_pocket)
			if(display)
				dat += "<BR>Right pocket: [initial(display.name)] ([display])"
			display = initial(OU.back)
			if(display)
				dat += "<BR>Back: [initial(display.name)] ([display])"
			var/list/backpack_cont = initial(OU.backpack_contents)
			if(backpack_cont)
				dat += "<BR>+Things in the backpack (due to coding limitations, those cant be established. See the code for the outfit to know more.)"

		dat += "<HR>"
		dat += "<BR><i>Outfits limit on what airlocks can someone access, or what headset and frequences they have. Here you can edit those things</i>"
		dat += "<BR><b>Access overrides:</b>"
		dat += "<BR><i>Add access in NUMBERS. If no numbers are in the list, then the access will not be overriden. If you want to remove all access, add only a 0</i>"
		dat += "<BR><i>See '/code/__DEFINES/access.dm' for an access list. (401-Faction Public, 402-Faction Crew, 403-Faction Captain)</i>"
		dat += "<BR><b>Headset override:</b>"
		dat += "<BR><i>Here you can override the headset, make sure to pick one which has the proper key with radio frequences for your role</i>"
		dat += "<HR>"
		dat += "<b>Allowed Species:</b>"
		for(var/spec in ESI.species_whitelist)
			dat += "<a href='?src=[REF(src)];inst_pref=remove_species;id=[ESI.id];species=[spec]'>[spec]</a>"
		dat += " <- <a href='?src=[REF(src)];inst_pref=add_species;id=[ESI.id]'>Add</a>"
		dat += "<BR><i>If no species are in the list, then any species can join as this role.</i>"
		dat += "<BR><b>Allowed CKEYs:</b>"
		for(var/ckey in ESI.ckey_whitelist)
			dat += "<a href='?src=[REF(src)];inst_pref=remove_ckey;id=[ESI.id];ckey=[ckey]'>[ckey]</a>"
		dat += " <- <a href='?src=[REF(src)];inst_pref=add_ckey;id=[ESI.id]'>Add</a>"
		dat += "<BR><i>If no ckeys are in the list, then any ckey can join as this role.</i>"
		dat += "<BR>Spawner disappears after spawn: <a href='?src=[REF(src)];inst_pref=disappear_after_spawn;id=[ESI.id]'>[ESI.disappear_after_spawn ? "Yes" : "No"]</a>"
		dat += "<HR><center><a href='?src=[REF(src)];inst_pref=make_spawner;id=[ESI.id]'>Create spawner on current location</a></center>"
		//Buttons for easy override for the faction stuff (for access and headset keys)

	else
		dat += "<i>Here you add and configure spawners. People will be able to join to them using their pre-made character in preferences.</i>"
		dat += "<table align='center'; width='100%'; style='background-color:#13171C'>"
		dat += "<tr><td width=5%></td><td width=20%></td><td width=60%></td><td width=10%></td><td width=5%></td></tr>"
		var/even = FALSE
		for(var/key in managed_instances)
			even = !even
			var/bc_col = even ? "#13171C" : "#23272C"
			var/datum/event_spawner_instance/ESI = managed_instances[key]
			var/desc = ESI.flavor_text
			if(length(desc) > 40)
				desc = "[copytext_char(desc, 1, 57)]..."
			dat += "<tr style='background-color:[bc_col]'><td>#[key]</td><td><b>[ESI.job_name]</b></td><td><i>[desc]</i></td><td><a href='?src=[REF(src)];pref=configure_instance;id=[key]'>Configure</a></td><td><a href='?src=[REF(src)];pref=clone_instance;id=[key]'>Clone</a></td></tr>"
		dat += "<tr style='background-color:#33373C'><td>*</td><td><a href='?src=[REF(src)];pref=create_new_instance'>Create new</a></td><td></td><td></td><td></td></tr>"
		dat += "</table>"

	winshow(usr, "event_spawn_window", TRUE)
	var/datum/browser/popup = new(usr, "event_spawn_window", "<div align='center'>Event Spawners</div>", 650, 700)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(usr, "event_spawn_window", src)

/datum/event_spawner_manager/Topic(href, href_list)
	if(href_list["inst_pref"])
		var/numb = text2num(href_list["id"])
		var/datum/event_spawner_instance/ESI = managed_instances["[numb]"]
		if(!ESI)
			ShowPanel(usr, null)
			return
		switch(href_list["inst_pref"])
			if("return")
				ShowPanel(usr, null)
				return
			if("job_name")
				var/msg = input(usr, "Set the job name of this spawner.", "Job name", ESI.job_name) as text|null
				if(msg)
					ESI.job_name = msg
			if("flavor_text")
				var/msg = input(usr, "Set the flavor text of this spawner.", "Flavor Text", ESI.flavor_text) as message|null
				if(msg)
					ESI.flavor_text = msg
			if("used_outfit")
				var/dresscode = usr.client.robust_dress_shop()
				if(dresscode)
					ESI.used_outfit = dresscode
			if("show_outfit_equipment")
				ESI.show_outfit_equipment = !ESI.show_outfit_equipment
			if("loadout")
				ESI.gets_loadout = !ESI.gets_loadout
			if("disappear_after_spawn")
				ESI.disappear_after_spawn = !ESI.disappear_after_spawn
			if("add_ckey")
				var/msg = input(usr, "Add allowed CKEY to the spawner.", "Add CKEY", "") as text|null
				if(msg)
					ESI.ckey_whitelist += msg
			if("add_species")
				var/result = input(usr, "Select a species", "Add species") as null|anything in GLOB.roundstart_races
				if(result)
					ESI.species_whitelist += result
			if("remove_ckey")
				var/ckey_to_rem = href_list["ckey"]
				ESI.ckey_whitelist -= ckey_to_rem
			if("remove_species")
				var/spec_to_rem = href_list["species"]
				ESI.species_whitelist -= spec_to_rem
		ShowPanel(usr, numb)
	if(href_list["pref"])
		switch(href_list["pref"])
			if("create_new_instance")
				next_id++
				var/datum/event_spawner_instance/ESI = new(next_id)
				managed_instances["[next_id]"] = ESI
			if("configure_instance")
				var/numb = text2num(href_list["id"])
				var/datum/event_spawner_instance/ESI = managed_instances["[numb]"]
				if(ESI)
					ShowPanel(usr, numb)
					return
		ShowPanel(usr, null)
		return

/client/proc/admin_open_event_spawners_menu()
	set category = "Admin.Events"
	set name = "Event Spawners Menu"

	if(!check_rights(R_ADMIN))
		return

	var/datum/event_spawner_manager/ESM = GLOB.event_spawner_manager
	ESM.ShowPanel(usr, null)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Event Spawner Menu") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return
