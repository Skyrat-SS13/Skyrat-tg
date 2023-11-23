/// Custom computer for synth brains
/obj/item/modular_computer/pda/synth
	name = "virtual persocom"

	base_active_power_usage = 0
	base_idle_power_usage = 0

	long_ranged = TRUE //Synths have good antenae

	max_idle_programs = 3

	max_capacity = 32

/obj/item/modular_computer/pda/synth/Initialize(mapload)
	. = ..()

	// prevent these from being created outside of synth brains
	if(!istype(loc, /obj/item/organ/internal/brain/synth))
		return INITIALIZE_HINT_QDEL

/datum/action/item_action/synth/open_internal_computer
	name = "Open persocom emulation"
	desc = "Accesses your built-in virtual machine."
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/synth/open_internal_computer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/brain/synth/targetmachine = target
	targetmachine.internal_computer.interact(owner)

/obj/item/modular_computer/pda/synth/ui_state(mob/user)
	return GLOB.default_state

/obj/item/modular_computer/pda/synth/ui_status(mob/user)
	var/obj/item/organ/internal/brain/synth/brain_loc = loc
	if(!istype(brain_loc))
		return UI_CLOSE

	if(!QDELETED(brain_loc.owner))
		if(brain_loc.owner == user)
			return min(
				ui_status_user_is_abled(user, src),
				ui_status_only_living(user),
			)
		else return UI_CLOSE
	return ..()

/obj/item/modular_computer/pda/synth/RemoveID(mob/user)
	var/obj/item/organ/internal/brain/synth/brain_loc = loc
	if(!istype(brain_loc))
		return ..()

	if(!computer_id_slot)
		return ..()

	if(crew_manifest_update)
		GLOB.manifest.modify(computer_id_slot.registered_name, computer_id_slot.assignment, computer_id_slot.get_trim_assignment())

	if(user && !issilicon(user) && in_range(brain_loc.owner || brain_loc, user))
		user.put_in_hands(computer_id_slot)
	else
		computer_id_slot.forceMove(brain_loc.owner ? brain_loc.owner.drop_location() : brain_loc.drop_location()) //We actually update the physical on brain removal/insert

	computer_id_slot = null
	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
	balloon_alert(user, "removed ID")

/obj/item/modular_computer/pda/synth/get_ntnet_status()
	. = NTNET_NO_SIGNAL
	// NTNet is down and we are not connected via wired connection. The synth is no more
	var/obj/item/organ/internal/brain/synth/brain_loc = loc
	if(!istype(brain_loc))
		return
	if(!find_functional_ntnet_relay() || isnull(brain_loc.owner))
		return
	var/turf/current_turf = get_turf(brain_loc.owner || brain_loc)
	if(is_station_level(current_turf.z))
		return NTNET_GOOD_SIGNAL
	else if(long_ranged && !is_centcom_level(current_turf.z)) // Centcom is excluded because cafe
		return NTNET_LOW_SIGNAL

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
