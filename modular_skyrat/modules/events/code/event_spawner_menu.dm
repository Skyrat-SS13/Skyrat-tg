/datum/event_spawner_instance
	var/id
	var/list/species_whitelist
	var/list/ckey_whitelist
	var/used_outfit
	var/job_name
	var/gets_loadout = TRUE
	var/access_override
	var/headset_override
	var/flavor_text = ""
	var/list/additional_equipment

	var/show_outfit_equipment = FALSE

/datum/event_spawner_instance/New(_id, template_id)
	id = _id

/datum/event_spawner_manager
	var/next_id = 0
	var/list/managed_instances = list()

/datum/event_spawner_manager/proc/ShowPanel(mob/user, panel_id)
	if(!user || !user.client)
		return
	var/list/dat = list("<center>")
	if(panel_id)
		var/datum/event_spawner_instance/ESI = managed_instances["[panel_id]"]
		if(!ESI)
			return
		//Buttons for easy override for the faction stuff (for access and headset keys)

	else
		dat += "cock"

	winshow(usr, "event_spawn_window", TRUE)
	var/datum/browser/popup = new(usr, "event_spawn_window", "<div align='center'>Event Spawners</div>", 950, 750)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(usr, "event_spawn_window", src)


/client/proc/admin_open_event_spawners_menu()
	set category = "Admin.Events"
	set name = "Event Spawners Menu"

	if(!check_rights(R_ADMIN))
		return

	var/datum/event_spawner_manager/ESM = GLOB.event_spawner_manager
	ESM.ShowPanel(usr, null)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "Event Spawner Menu") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	return
