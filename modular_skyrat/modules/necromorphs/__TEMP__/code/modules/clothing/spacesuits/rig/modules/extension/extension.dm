/*
	A simple subtype used as a parent for others.

	When installed and active/enabled/whatever, it applies an extension to the rig's wearer
*/
/obj/item/rig_module/extension
	toggleable        = TRUE
	var/extension_type
	var/datum/extension/E
	active_power_cost = 100


/obj/item/rig_module/extension/activate()
	//Remove any stale version first
	remove_extension()
	.=..()
	if (.)
		E = set_extension(holder.wearer, extension_type)
		if (active_power_cost)
			to_chat(holder.wearer, "[src] activated, now draining [round(active_power_cost*CELLRATE)] Wh. per second")


/obj/item/rig_module/extension/deactivate()

	.=..()
	remove_extension()


/obj/item/rig_module/rig_equipped(var/mob/user, var/slot)
	deactivate()

/obj/item/rig_module/rig_unequipped(var/mob/user, var/slot)
	deactivate()


/obj/item/rig_module/extension/proc/remove_extension()
	if (E)
		E.remove_self()
	E = null