/datum/component/carrier/soulcatcher/small_device
	max_mobs = 1

/datum/component/carrier/soulcatcher/attachable
	max_mobs = 1
	communicate_as_parent = TRUE
	removable = TRUE

/datum/component/carrier/soulcatcher/attachable/New()
	. = ..()
	var/obj/item/parent_item = parent
	if(!istype(parent_item))
		return COMPONENT_INCOMPATIBLE

	name = parent_item.name
	var/datum/carrier_room/first_room = carrier_rooms[1]
	first_room.name = parent_item.name
	first_room.room_description = parent_item.desc

	RegisterSignal(parent, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT, PROC_REF(bring_up_ui))
	RegisterSignal(parent, COMSIG_PREQDELETED, PROC_REF(remove_self))

/// Adds text to the examine text of the parent item, explaining that the item can be used to enable the use of NIFSoft HUDs
/datum/component/carrier/soulcatcher/attachable/proc/on_examine(datum/source, mob/user, list/examine_text)
	SIGNAL_HANDLER
	examine_text += span_cyan("[source] has a soulcatcher attached to it, <b>Ctrl+Shift+Click</b> to use it.")

/datum/component/carrier/soulcatcher/attachable/proc/bring_up_ui(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(ui_interact), user)

/datum/component/carrier/soulcatcher/attachable/Destroy(force)
	UnregisterSignal(parent, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(parent, COMSIG_CLICK_CTRL_SHIFT)
	UnregisterSignal(parent, COMSIG_PREQDELETED)
	return ..()

/datum/component/carrier/soulcatcher/attachable/remove_self()
	var/obj/item/parent_item = parent
	var/turf/drop_turf = get_turf(parent_item)
	var/obj/item/attachable_soulcatcher/dropped_item = new (drop_turf)

	var/datum/component/carrier/dropped_soulcatcher = dropped_item.GetComponent(/datum/component/carrier)
	var/datum/carrier_room/target_room = dropped_soulcatcher.carrier_rooms[1]
	var/list/current_mobs = get_current_mobs()

	if(current_mobs) // If we have souls inside of here, they should be transferred to the new object
		for(var/mob/living/soul as anything in current_mobs)
			transfer_mob(soul, target_room)

	return ..()

/obj/item/attachable_soulcatcher
	name = "Poltergeist-Type RSD"
	desc = "This device, a polymorphic nanomachine net, wraps around objects of most sizes and allows them to function as a container for Resonance. The soul in question within the vessel is imbued much like it would be in a body or a normal Soulcatcher, perceiving the world and even speaking out of their new form. The nanomachine net of the device allows for the consciousness to somewhat manipulate their container, but any large-scale movement is out of the question."
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "attachable-soulcatcher"
	w_class = WEIGHT_CLASS_SMALL
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
	/// What soulcathcer component is currnetly linked to this object?
	var/datum/component/carrier/soulcatcher/small_device/linked_soulcatcher

/obj/item/attachable_soulcatcher/Initialize(mapload)
	. = ..()
	linked_soulcatcher = AddComponent(/datum/component/carrier/soulcatcher/small_device)
	linked_soulcatcher.name = name

/obj/item/attachable_soulcatcher/attack_self(mob/user, modifiers)
	linked_soulcatcher.ui_interact(user)

/obj/item/attachable_soulcatcher/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!isitem(interacting_with) || is_type_in_list(interacting_with, blacklisted_items))
		balloon_alert(user, "incompatible!")
		return NONE

	if(interacting_with.GetComponent(/datum/component/carrier/soulcatcher))
		balloon_alert(user, "already attached!")
		return ITEM_INTERACT_BLOCKING

	var/datum/component/carrier/soulcatcher/new_soulcatcher = interacting_with.AddComponent(/datum/component/carrier/soulcatcher/attachable)
	playsound(interacting_with.loc, 'sound/weapons/circsawhit.ogg', 50, vary = TRUE)

	var/datum/carrier_room/target_room = new_soulcatcher.carrier_rooms[1]
	var/list/current_mobs = linked_soulcatcher.get_current_mobs()
	if(current_mobs)
		for(var/mob/living/soul as anything in current_mobs)
			linked_soulcatcher.transfer_mob(soul, target_room)

	if(destroy_on_use)
		qdel(src)
