/obj/item/organ/cyberimp/brain/nif/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NifPanel", name)
		ui.open()

/obj/item/organ/cyberimp/brain/nif/ui_data(mob/user)
	var/data = list()
	data["linked_mob_name"] = linked_mob.name
	data["power_level"] = power_level
	data["max_power"] = max_power
	data["durability"] = durability
	data["max_durability"] = max_durability
	return data

/obj/item/organ/cyberimp/brain/nif/ui_act(action, list/params)
	. = ..()
	if(.)
		return
