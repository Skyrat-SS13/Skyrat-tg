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
	name = "mini-soulcatcher kit"
	desc = "A kit that allows an attached object to function as a soulcatcher"
	icon = 'modular_skyrat/master_files/icons/donator/obj/kits.dmi'
	icon_state = "partskit"
	/// Do we want to destory the item once it is attached to an item?
	var/destroy_on_use = TRUE

/obj/item/attachable_soulcatcher/afterattack(obj/item/target_item, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!proximity_flag || !istype(target_item))
		return FALSE

	if(GetComponent(/datum/component/soulcatcher))
		balloon_alert("already attached!")
		return FALSE

	target_item.AddComponent(/datum/component/soulcatcher/attachable_soulcatcher)
	playsound(target_item.loc, 'sound/weapons/circsawhit.ogg', 50, vary = TRUE)

	if(destroy_on_use)
		qdel(src)
