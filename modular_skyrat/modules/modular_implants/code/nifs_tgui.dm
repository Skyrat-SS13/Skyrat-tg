/obj/item/organ/cyberimp/brain/nif/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NifPanel", name)
		ui.open()

/obj/item/organ/cyberimp/brain/nif/ui_data(mob/user)
	var/data = list()
	//User Preference Variables
	data["linked_mob_name"] = linked_mob.name
	data["examine_text"] = linked_mob.nif_examine_text
	data["product_notes"] = manufacturer_notes
	//Power Variables
	data["power_level"] = power_level
	data["max_power"] = max_power

	data["nutrition_drain"] = nutrition_drain
	data["nutrition_level"] = linked_mob.nutrition

	//Durability Variables.
	data["durability"] = durability
	data["max_durability"] = max_durability

	return data

/obj/item/organ/cyberimp/brain/nif/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggle_nutrition_drain")
			toggle_nutrition_drain()

		if("change_examine_text")
			var/text_to_use = html_encode(params["new_text"])
			linked_mob.nif_examine_text = span_purple("<b>[text_to_use]</b><br>")
