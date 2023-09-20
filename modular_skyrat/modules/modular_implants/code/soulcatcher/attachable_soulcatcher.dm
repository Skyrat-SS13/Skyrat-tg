/datum/component/soulcatcher/attachable_soulcatcher
	max_souls = 1
	communicate_as_parent = TRUE
	removable = TRUE

/datum/component/soulcatcher/attachable_soulcatcher/New()
	. = ..()
	var/obj/item/parent_item = parent
	if(!istype(parent_item))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(bring_up_ui))

/// Adds text to the examine text of the parent item, explaining that the item can be used to enable the use of NIFSoft HUDs
/datum/component/soulcatcher/attachable_soulcatcher/proc/on_examine(datum/source, mob/user, list/examine_text)
	SIGNAL_HANDLER
	examine_text += span_cyan("[source] has a soulcatcher attached to it, <b>Ctrl+Shift+Click</b> to use it.")

/datum/component/soulcatcher/attachable_soulcatcher/proc/bring_up_ui(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(ui_interact), user)

/datum/component/soulcatcher/attachable_soulcatcher/Destroy(force)
	UnregisterSignal(parent, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT)
	return ..()

/datum/component/soulcatcher/attachable_soulcatcher/remove_self()
	var/obj/item/parent_item = parent
	var/turf/drop_turf = get_turf(parent_item)
	new /obj/item/attachable_soulcatcher (drop_turf)

	return ..()

/obj/item/attachable_soulcatcher
	name = "Poltergeist-Type RSD"
	desc = "This device, a polymorphic nanomachine net, wraps around objects of most sizes and allows them to function as a container for Resonance. The soul in question within the vessel is imbued much like it would be in a body or a normal Soulcatcher, perceiving the world and even speaking out of their new form. The nanomachine net of the device allows for the consciousness to somewhat manipulate their container, but any large-scale movement is out of the question."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "attachable-soulcatcher"
	/// Do we want to destory the item once it is attached to an item?
	var/destroy_on_use = TRUE
	/// What items do we want to prevent the viewer from attaching this to?
	var/list/blacklisted_items = list(
		/obj/item/organ,
		/obj/item/mmi,
		/obj/item/pai_card,
		/obj/item/aicard,
		/obj/item/card,
		/obj/item/radio,
		/obj/item/disk/nuclear, // Woah there
	)

/obj/item/attachable_soulcatcher/afterattack(obj/item/target_item, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!proximity_flag || !istype(target_item))
		return FALSE

	if(GetComponent(/datum/component/soulcatcher))
		balloon_alert(user, "already attached!")
		return FALSE

	if(is_type_in_list(target_item, blacklisted_items))
		balloon_alert(user, "incompatible!")
		return FALSE

	target_item.AddComponent(/datum/component/soulcatcher/attachable_soulcatcher)
	playsound(target_item.loc, 'sound/weapons/circsawhit.ogg', 50, vary = TRUE)

	if(destroy_on_use)
		qdel(src)
