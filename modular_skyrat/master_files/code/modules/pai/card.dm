/obj/item/pai_card/ui_data(mob/user)
	. = ..()
	if(!pai)
		return

	.["pai"]["leash_enabled"] = pai.leash.enabled

/obj/item/pai_card/ui_act(action, list/params, datum/tgui/ui)
	. = ..()
	if(.)
		return TRUE

	if(pai && action == "toggle_leash")
		pai.leash.toggle_leash()
		return TRUE

	return FALSE
