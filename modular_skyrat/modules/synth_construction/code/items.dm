#define CHOICE_TEXT "Select an interface to convert to."
#define CHOICE_TITLE "Interface Conversion"
#define BRAIN_RECONSTRUCTION_TIME 20 SECONDS

#define CHOICE_SYNTH "Synthetic-Compatible Interface"
#define CHOICE_CYBORG "Cyborg-Compatible Interface"

#define CHOICE_ITEMS list( \
	CHOICE_SYNTH, \
	CHOICE_CYBORG, \
)

/obj/machinery/mecha_part_fabricator/attackby(obj/item/attacking_item, mob/user, params)
	if(!istype(attacking_item, /obj/item/mmi) && !istype(attacking_item, /obj/item/organ/internal/brain/ipc_positron))
		return ..()

	if(tgui_alert(user, "Do you want to reconstruct this interface?", CHOICE_TITLE, list("Yes", "No")) != "Yes")
		return FALSE

	if(being_built)
		playsound(src, pick('sound/machines/buzz-sigh.ogg', 'sound/machines/buzz-two.ogg'), 25, ignore_walls = FALSE)
		user.show_message(span_warning("This fabricator is already doing something!"))
		return FALSE

	var/choice = tgui_input_list(user, CHOICE_TEXT, CHOICE_TITLE, CHOICE_ITEMS)

	if(!(choice in CHOICE_ITEMS))
		return FALSE

	var/obj/item/organ/internal/brain/old_brain = attacking_item

	if(!old_brain.brainmob.client?.prefs)
		playsound(src, pick('sound/machines/buzz-sigh.ogg', 'sound/machines/buzz-two.ogg'), 25, ignore_walls = FALSE)
		user.show_message(span_warning("The inserted brain is not functioning!"))
		return FALSE

	var/obj/item/organ/internal/brain/brain = old_brain.brainmob.prefs_get_brain_to_use(old_brain.brainmob.client.prefs.read_preference(/datum/preference/choiced/brain_type), choice == CHOICE_CYBORG)
	brain = new brain()
	if(old_brain )
	old_brain.before_organ_replacement(brain) // Avoid deleting skillchips.
	brain.transfer_identity(old_brain.brainmob)
	user.temporarilyRemoveItemFromInventory(old_brain, TRUE)
	playsound(src, 'modular_skyrat/modules/synth_construction/sounds/piston_lower_raise.ogg', 50)
	qdel(old_brain)
	return FALSE

/datum/design/cursed_shit
	var/obj/parent_machine
	var/obj/item/held_item
	construction_time = BRAIN_RECONSTRUCTION_TIME
	desc = "If cancelled, this will eject the brain." // Not sure if this is even seen outside the design list. Still setting it.

/datum/design/cursed_shit/Destroy()
	if(istype(build_path, /obj/item))
		var/obj/item/item = build_path
		build_path = null
		item.forceMove(get_turf(parent_machine))
	. = ..()

/datum/design/cursed_shit/proc/get_item()
	return build_path

/datum/design/cursed_shit/brain_reprint
	materials = list(/datum/material/iron = 2000, /datum/material/silver = 2000, /datum/material/gold = 2000)
	var/choice

/datum/design/cursed_shit/brain_reprint/get_item()
	var/obj/item/organ/internal/brain/old_brain = build_path

	// Lmao, both brain and MMI have this field name, so cursed but performant code it is.
	if(!old_brain.brainmob?.client?.prefs)
		build_path = null
		return old_brain

	if(istype(old_brain, /obj/item/mmi))
		var/obj/item/mmi/old_mmi = old_brain
		old_brain = old_mmi.brain
		old_mmi.brain = null
		qdel(old_mmi)

	var/obj/item/organ/internal/brain/brain = old_brain.brainmob.prefs_get_brain_to_use(old_brain.brainmob.client.prefs.read_preference(/datum/preference/choiced/brain_type), choice == CHOICE_CYBORG)
	brain = new brain()
	old_brain.before_organ_replacement(brain) // Avoid deleting skillchips.
	brain.transfer_identity(old_brain.brainmob)
	qdel(old_brain)
	return brain


/datum/design/c10mm
