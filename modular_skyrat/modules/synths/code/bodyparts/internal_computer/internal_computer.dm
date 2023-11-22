/// Custom computer for synth brains
/obj/item/modular_computer/pda/synth
	name = "virtual persocom"

	base_active_power_usage = 0
	base_idle_power_usage = 0

	long_ranged = TRUE //Synths have good antenae

	max_idle_programs = 3

	max_capacity = 32

	var/obj/item/organ/internal/brain/synth/owner_brain

/obj/item/modular_computer/pda/synth/RemoveID(mob/user)
	if(!computer_id_slot)
		return ..()

	if(crew_manifest_update)
		GLOB.manifest.modify(computer_id_slot.registered_name, computer_id_slot.assignment, computer_id_slot.get_trim_assignment())

	if(user && !issilicon(user) && in_range(physical, user))
		user.put_in_hands(computer_id_slot)
	else
		computer_id_slot.forceMove(physical.loc) //We actually update the physical on brain removal/insert

	computer_id_slot = null
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
	balloon_alert(user, "removed ID")

/obj/item/modular_computer/pda/synth/get_ntnet_status()
	// NTNet is down and we are not connected via wired connection. The synth is no more
	if(!find_functional_ntnet_relay() || !owner_brain.owner)
		return NTNET_NO_SIGNAL
	var/turf/current_turf = get_turf(physical)
	if(is_station_level(current_turf.z))
		return NTNET_GOOD_SIGNAL
	else if(long_ranged)
		return NTNET_LOW_SIGNAL
	return NTNET_NO_SIGNAL

/obj/item/modular_computer/pda/synth/Destroy()
	physical = null
	owner_brain = null
	return ..()

/*
I give up, this is how borgs have their own menu coded in.
Snowflake codes the interaction check because the default tgui one does not work as I want it.
*/
/mob/living/carbon/human/can_interact_with(atom/machine, treat_mob_as_adjacent)
	. = ..()
	if(istype(machine, /obj/item/modular_computer/pda/synth))
		var/obj/item/modular_computer/pda/synth/robotbrain = machine
		if(Adjacent(robotbrain.physical))
			. = TRUE
	return

/*
So, I am not snowflaking more code.. except this
Attacking a synth with an id loads it into its slot.. pain and probably shitcode
*/

/obj/item/card/id/attack(mob/living/target_mob, mob/living/user, params)
	var/mob/living/carbon/human/targetmachine = target_mob
	if(!istype(targetmachine))
		return ..()
	var/obj/item/organ/internal/brain/synth/robotbrain = targetmachine.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(istype(robotbrain))
		if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
			balloon_alert(user, "Inserting ID into persocom slot...")
			if(do_after(user, 5 SECONDS))
				balloon_alert(user, "ID slot interface registered!")
				to_chat(targetmachine, span_notice("[user] inserts [src] into your persocom's card slot."))
				robotbrain.internal_computer.InsertID(src, user)
			return
	return ..()

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
