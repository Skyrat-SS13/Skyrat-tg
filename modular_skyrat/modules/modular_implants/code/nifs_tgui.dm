/obj/item/organ/cyberimp/brain/nif/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "NifPanel", name)
		ui.open()

/obj/item/organ/cyberimp/brain/nif/ui_data(mob/user)
	var/data = list()
	data["linked_mob_name"] = linked_mob.name
	return data

/obj/item/organ/cyberimp/brain/nif/ui_act(action, list/params)
	. = ..()
	if(.)
		return
