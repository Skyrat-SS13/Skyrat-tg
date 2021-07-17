/obj/item/clothing/neck/tie/disco
	name = "Horrific Necktie"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "eldritch_tie"
	desc = "The necktie is adorned with a garish pattern. It's disturbingly vivid. Somehow you feel as if it would be wrong to ever take it off. It's your friend now. You will betray it if you change it for some boring scarf."


/obj/item/clothing/neck/toggle/AltClick(mob/user)
	..()
	if(!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, !iscyborg(user)))
		return
	else
		neck_toggle(user)

/obj/item/clothing/neck/toggle/ui_action_click()
	neck_toggle()

/obj/item/clothing/neck/toggle/proc/neck_toggle()
	set src in usr

	if(!can_use(usr))
		return 0

	to_chat(usr, span_notice("You toggle [src]'s [togglename]."))
	if(src.necktoggled)
		src.icon_state = "[initial(icon_state)]"
		src.necktoggled = FALSE
	else if(!src.necktoggled)
		src.icon_state = "[initial(icon_state)]_t"
		src.necktoggled = TRUE
	usr.update_inv_wear_neck()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/clothing/neck/toggle/examine(mob/user)
	. = ..()
	. += "Alt-click on [src] to toggle the [togglename]."
