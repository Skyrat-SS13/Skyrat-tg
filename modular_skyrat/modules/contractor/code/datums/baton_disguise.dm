/datum/action/item_action/disguise
	name = "Toggle Baton Disguise"
	/// If it is applied or not
	var/disguised = FALSE

/datum/action/item_action/disguise/Trigger(trigger_flags)
	var/obj/item/melee/baton/telescopic/contractor_baton/baton = target
	if(disguised)
		baton.undisguise(src, null, owner)
		return
	baton.lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	baton.righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	baton.inhand_icon_state = "rods"
	baton.name = "iron rod"
	baton.icon = 'icons/obj/stack_objects.dmi'
	baton.icon_state = "rods"
	disguised = TRUE
	owner.regenerate_icons()
	baton.update_appearance()
	baton.balloon_alert(owner, "baton disguised")
