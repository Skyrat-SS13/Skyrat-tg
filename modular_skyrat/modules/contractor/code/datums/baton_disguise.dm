/datum/action/item_action/disguise
	name = "Toggle Baton Disguise"
	/// If it is applied or not
	var/disguised = FALSE

/datum/action/item_action/disguise/Trigger(trigger_flags)
	var/obj/item/melee/baton/telescopic/contractor_baton/baton = target
	if(disguised)
		baton.undisguise(src, null, owner)
		return
	baton.disguise(src, owner)
