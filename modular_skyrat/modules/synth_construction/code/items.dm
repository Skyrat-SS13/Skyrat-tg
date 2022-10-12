#define CHOICE_TEXT "Select an interface to convert to."
#define CHOICE_TITLE "Interface Conversion"
#define CHOICE_TIME 20 SECONDS

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

	if(istype(attacking_item, /obj/item/mmi))
		var/obj/item/mmi/old_mmi = attacking_item

		if(!old_mmi.brain || !old_mmi.brainmob || !old_mmi.brainmob.mind || !old_mmi.brainmob.client)
			playsound(src, pick('sound/machines/buzz-sigh.ogg', 'sound/machines/buzz-two.ogg'), 25, ignore_walls = FALSE)
			user.show_message(span_warning("The targeted object has no functioning brain!"))
			return

		var/choice = tgui_input_list(user, CHOICE_TEXT, CHOICE_TITLE, CHOICE_ITEMS)

		if(do_after(user, CHOICE_TIME, src, interaction_key = CHOICE_TITLE) && old_mmi.brainmob.client?.prefs)
			switch(choice)
				if(CHOICE_CYBORG)
					var/obj/item/mmi/new_mmi = old_mmi.brainmob.prefs_get_brain_to_use(old_mmi.brainmob.client.prefs.read_preference(/datum/preference/choiced/brain_type), TRUE)
					user.temporarilyRemoveItemFromInventory(attacking_item, TRUE)
					new_mmi = new new_mmi()
					new_mmi.brain = old_mmi.brain
					old_mmi.brain = null // Avoid deleting brain to save skillchips and cycles.
					new_mmi.transfer_identity(old_mmi.brainmob)
					old_mmi.brainmob.mind.transfer_to(new_mmi.brainmob)
					qdel(old_mmi)
					user.put_in_active_hand(new_mmi, ignore_animation = TRUE)
				if(CHOICE_SYNTH)
					var/obj/item/organ/internal/brain/brain = old_mmi.brainmob.prefs_get_brain_to_use(old_mmi.brainmob.client.prefs.read_preference(/datum/preference/choiced/brain_type))
					brain = new brain()
					old_mmi.brain.before_organ_replacement(brain) // Avoid deleting skillchips.
					brain.transfer_identity(old_mmi.brainmob)
					qdel(old_mmi)
					user.put_in_active_hand(brain, ignore_animation = TRUE)
					return FALSE




	return FALSE


