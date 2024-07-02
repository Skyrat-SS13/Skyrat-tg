/// Custom computer for synth brains
/obj/item/modular_computer/pda/synth
	name = "virtual persocom"

	base_active_power_usage = 0 WATTS
	base_idle_power_usage = 0 WATTS

	long_ranged = TRUE //Synths have good antennae

	max_idle_programs = 3

	max_capacity = 64

/obj/item/modular_computer/pda/synth/Initialize(mapload)
	. = ..()

	// prevent these from being created outside of synth brains
	if(!istype(loc, /obj/item/organ/internal/brain/synth))
		return INITIALIZE_HINT_QDEL

/* Action for opening the synthbrain computer */
/datum/action/item_action/synth/open_internal_computer
	name = "Open persocom emulation"
	desc = "Accesses your built-in virtual machine."
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/synth/open_internal_computer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/brain/synth/targetmachine = target
	targetmachine.internal_computer.interact(owner)

/*
Various overrides necessary to get the persocom working, namely ui status, power, and ID handling
*/
/obj/item/modular_computer/pda/synth/ui_state(mob/user)
	return GLOB.default_state

/obj/item/modular_computer/pda/synth/ui_status(mob/user)
	var/obj/item/organ/internal/brain/synth/brain_loc = loc
	if(!istype(brain_loc))
		return UI_CLOSE

	if(!QDELETED(brain_loc.owner))
		return min(
			ui_status_user_is_abled(user, src),
			ui_status_only_living(user),
			ui_status_user_is_adjacent(user, brain_loc.owner),
		)
	return ..()

// Needed to tell the power check that we're handling power ourselves
/obj/item/modular_computer/pda/synth/check_power_override(amount)
	return TRUE

// Handles the id slot reading our id
/obj/item/modular_computer/pda/synth/proc/handle_id_slot(mob/living/carbon/human/synth)
	if(!istype(synth))
		return
	var/obj/item = synth.wear_id
	if(item)
		if(istype(item, /obj/item/card/id))
			computer_id_slot = item
		else if(istype(item, /obj/item/modular_computer))
			var/obj/item/modular_computer/pda = item
			computer_id_slot = pda.computer_id_slot
		else
			computer_id_slot = null
	else
		computer_id_slot = null

/obj/item/modular_computer/pda/synth/RemoveID(mob/user, silent = TRUE)
	return

/obj/item/modular_computer/pda/synth/get_ntnet_status()
	. = ..()
	if(is_centcom_level(loc.z)) // Centcom is excluded because cafe would allow people to abuse these
		. = NTNET_NO_SIGNAL
	return .

/obj/item/modular_computer/pda/attack(mob/living/target_mob, mob/living/user, params)
	var/mob/living/carbon/human/targetmachine = target_mob
	if(!istype(targetmachine))
		return ..()

	var/obj/item/organ/internal/brain/synth/robotbrain = targetmachine.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(robotbrain))
		if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
			balloon_alert(user, "Establishing SSH login with persocom...")
			if(do_after(user, 5 SECONDS))
				balloon_alert(user, "Connection established!")
				to_chat(targetmachine, span_notice("[user] establishes an SSH connection between [src] and your persocom emulation."))
				robotbrain.internal_computer.interact(user)
			return
	return ..()

/obj/item/modular_computer/pda/synth/get_header_data()
	var/list/data = ..()
	var/obj/item/organ/internal/brain/synth/brain_loc = loc
	// Battery level is now according to the synth charge
	if(istype(brain_loc))
		var/charge_level = (brain_loc.owner.nutrition / NUTRITION_LEVEL_ALMOST_FULL) * 100
		switch(charge_level)
			if(80 to 110)
				data["PC_batteryicon"] = "batt_100.gif"
			if(60 to 80)
				data["PC_batteryicon"] = "batt_80.gif"
			if(40 to 60)
				data["PC_batteryicon"] = "batt_60.gif"
			if(20 to 40)
				data["PC_batteryicon"] = "batt_40.gif"
			if(5 to 20)
				data["PC_batteryicon"] = "batt_20.gif"
			else
				data["PC_batteryicon"] = "batt_5.gif"
		data["PC_batterypercent"] = "[round(charge_level)]%"
	return data
