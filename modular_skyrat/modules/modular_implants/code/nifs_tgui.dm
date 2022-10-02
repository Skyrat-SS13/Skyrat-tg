/obj/item/organ/internal/cyberimp/brain/nif
	///Currently Avalible themese for the NIFs
	var/static/list/ui_themes = list(
		"abductor",
		"cardtable",
		"hackerman",
		"malfunction",
		"ntos",
		"wizard",
	)
	///What theme is currently being used on the NIF?
	var/current_theme = "ntos"

/obj/item/organ/internal/cyberimp/brain/nif/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "NifPanel", name)
		ui.open()

/obj/item/organ/internal/cyberimp/brain/nif/ui_state(mob/user)
	return GLOB.conscious_state

/obj/item/organ/internal/cyberimp/brain/nif/ui_data(mob/user)
	var/data = list()
	//User Preference Variables
	data["linked_mob_name"] = linked_mob.name
	data["examine_text"] = linked_mob.nif_examine_text
	data["product_notes"] = manufacturer_notes
	data["loaded_nifsofts"] = list()

	data["current_theme"] = current_theme
	data["ui_themes"] = ui_themes

	//NIFSoft Variables
	data["max_nifsofts"] = max_nifsofts

	for(var/datum/nifsoft/nifsoft as anything in loaded_nifsofts)
		if(nifsoft == null)
			qdel(nifsoft)
			continue

		var/list/nifsoft_data = list(
			"name" = nifsoft.name,
			"desc" = nifsoft.program_desc,
			"active" = nifsoft.active,
			"active_mode" = nifsoft.active_mode,
			"activation_cost" = nifsoft.activation_cost,
			"active_cost" = nifsoft.active_cost,
			"reference" = REF(nifsoft),
		)
		data["loaded_nifsofts"] += list(nifsoft_data)

	//Power Variables
	data["power_level"] = power_level
	data["max_power"] = max_power
	data["power_usage"] = power_usage

	data["nutrition_drain"] = nutrition_drain
	data["nutrition_level"] = linked_mob.nutrition

	data["blood_level"] = linked_mob.blood_volume
	data["max_blood_level"] = linked_mob.blood_volume_normal
	data["blood_drain"] = blood_drain
	data["minimum_blood_level"] = minimum_blood_level

	//Durability Variables.
	data["durability"] = durability
	data["max_durability"] = max_durability

	return data

/obj/item/organ/internal/cyberimp/brain/nif/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggle_nutrition_drain")
			toggle_nutrition_drain()

		if("toggle_blood_drain")
			toggle_blood_drain()

		if("change_examine_text")
			var/text_to_use = html_encode(params["new_text"])
			if(text_to_use == "")
				text_to_use = FALSE
				return FALSE

			linked_mob.nif_examine_text = span_purple("<b>[text_to_use]</b><br>")

		if("uninstall_nifsoft")
			var/nifsoft_to_remove = locate(params["nifsoft_to_remove"]) in loaded_nifsofts
			if(!nifsoft_to_remove)
				return FALSE

			remove_nifsoft(nifsoft_to_remove)

		if("change_theme")
			var/target_theme = params["target_theme"]

			if(!target_theme || !(target_theme in ui_themes))
				return FALSE
			current_theme = target_theme

		if("activate_nifsoft")
			var/datum/nifsoft/activated_nifsoft = locate(params["activated_nifsoft"]) in loaded_nifsofts
			if(!activated_nifsoft)
				return FALSE

			activated_nifsoft.activate()
