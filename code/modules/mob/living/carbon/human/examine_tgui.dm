/datum/examine_panel
	var/mob/living/holder //client of whoever is using this datum
	var/mob/living/carbon/human/dummy/dummy_holder
	var/atom/movable/screen/examine_panel_dummy/examine_panel_screen

/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/examine_panel/ui_close(mob/user)
	user.client.clear_map(examine_panel_screen.assigned_map)

/atom/movable/screen/examine_panel_dummy
	name = "examine panel dummy"

/datum/examine_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!examine_panel_screen)
		if(ishuman(holder))
			dummy_holder = generate_dummy_lookalike(REF(holder), holder)
			var/datum/job/job_ref = SSjob.GetJob(holder.job)
			if(job_ref && job_ref.outfit)
				var/datum/outfit/outfit_ref = new()
				outfit_ref.copy_outfit_from_target(holder)
				outfit_ref.equip(dummy_holder, visualsOnly=TRUE)
		/*
		else if(issilicon(holder))
			dummy_holder = image('icons/mob/robots.dmi', icon_state = "robot", dir = SOUTH) // this doesn't work and just shows a black screen, idk a solution though feel free to pitch in
		*/
		examine_panel_screen = new
		examine_panel_screen.vis_contents += dummy_holder
		examine_panel_screen.name = "screen"
		examine_panel_screen.assigned_map = "examine_panel_[REF(holder)]_map"
		examine_panel_screen.del_on_map_removal = FALSE
		examine_panel_screen.screen_loc = "[examine_panel_screen.assigned_map]:1,1"
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		user.client.register_map_obj(examine_panel_screen)
		ui = new(user, src, "ExaminePanel")
		ui.open()

/datum/examine_panel/ui_data(mob/user)
	var/list/data = list()

	var/datum/preferences/preferences = holder.client?.prefs

	var/flavor_text
	var/custom_species
	var/custom_species_lore
	var/obscured
	var/ooc_notes = ""
	var/headshot = ""

	//  Handle OOC notes first
	if(preferences && preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		var/e_prefs = preferences.read_preference(/datum/preference/choiced/erp_status)
		var/e_prefs_nc = preferences.read_preference(/datum/preference/choiced/erp_status_nc)
		var/e_prefs_v = preferences.read_preference(/datum/preference/choiced/erp_status_v)
		var/e_prefs_mechanical = preferences.read_preference(/datum/preference/choiced/erp_status_mechanics)
		ooc_notes += "ERP: [e_prefs]\n"
		ooc_notes += "Non-Con: [e_prefs_nc]\n"
		ooc_notes += "Vore: [e_prefs_v]\n"
		ooc_notes += "ERP Mechanics: [e_prefs_mechanical]\n"
		ooc_notes += "\n"

	// Now we handle silicon and/or human, order doesn't really matter
	// If other variants of mob/living need to be handled at some point, put them here
	if(issilicon(holder))
		flavor_text = preferences.read_preference(/datum/preference/text/silicon_flavor_text)
		custom_species = "Silicon"
		custom_species_lore = "A cyborg unit."
		ooc_notes += preferences.read_preference(/datum/preference/text/ooc_notes)
		headshot += preferences.read_preference(/datum/preference/text/headshot)

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = (holder_human.wear_mask && (holder_human.wear_mask.flags_inv & HIDEFACE)) || (holder_human.head && (holder_human.head.flags_inv & HIDEFACE))
		custom_species = obscured ? "Obscured" : holder_human.dna.features["custom_species"]
		flavor_text = obscured ? "Obscured" :  holder_human.dna.features["flavor_text"]
		custom_species_lore = obscured ? "Obscured" : holder_human.dna.features["custom_species_lore"]
		ooc_notes += holder_human.dna.features["ooc_notes"]
		if(!obscured)
			headshot += holder_human.dna.features["headshot"]

	var/name = obscured ? "Unknown" : holder.name

	data["obscured"] = obscured ? TRUE : FALSE
	data["character_name"] = name
	data["assigned_map"] = examine_panel_screen.assigned_map
	data["flavor_text"] = flavor_text
	data["ooc_notes"] = ooc_notes
	data["custom_species"] = custom_species
	data["custom_species_lore"] = custom_species_lore
	data["headshot"] = headshot
	return data
