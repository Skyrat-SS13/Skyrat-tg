/datum/carrier_effect/vore
	name = "Vore effect"

/datum/carrier_effect/vore/absorb
	name = "Absorb"
	desc = "Absorbs all of the nutrients of the mobs inside of you."
	/// How many nutrients have we absorbed from those inside?
	var/stored_nutrients = 0
	/// How fast do we want to drain nutrients from those inside of us?
	var/nutrient_drain_rate = 0

/datum/carrier_effect/vore/absorb/apply_to_carrier_mob(mob/living/target_mob)
	. = ..()
	if(!.)
		return FALSE

	if(target_mob.nutrition < nutrient_drain_rate) // They empty :3
		if(!HAS_TRAIT_FROM(target_mob, TRAIT_HANDS_BLOCKED, TRAIT_CARRIER))
			ADD_TRAIT(target_mob, TRAIT_HANDS_BLOCKED, TRAIT_CARRIER)

		return TRUE

	target_mob.nutrition = max((target_mob.nutrition - nutrient_drain_rate), 0)
	stored_nutrients += nutrient_drain_rate

/datum/carrier_effect/vore/absorb/remove_from_carrier_mob(mob/living/target_mob)
	. = ..()
	if(!.)
		return FALSE

	REMOVE_TRAIT(target_mob, TRAIT_HANDS_BLOCKED, TRAIT_CARRIER)

/datum/carrier_effect/vore/absorb/apply_to_owner()
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carrier_owner = .
	carrier_owner.nutrition += stored_nutrients
	stored_nutrients = 0

	return TRUE

/datum/carrier_effect/vore/digestion
	name = "Digestion"
	desc = "Melts the prey currently inside of you into nutrients"
	/// How fast do we want to melt the prey inside?
	var/digestion_rate = 3

/datum/carrier_effect/vore/digestion/apply_to_carrier_mob(mob/living/target_mob)
	. = ..()
	if(!.)
		return FALSE

	if(target_mob.stat == DEAD) // No need to melt further.
		return TRUE

	target_mob.adjustBruteLoss(digestion_rate)
	return TRUE

/datum/carrier_effect/vore/numbing
	name = "Numbing"
	desc = "Numbs all of those currently inside of this carrier."

/datum/carrier_effect/vore/numbing/apply_to_carrier_mob(mob/living/target_mob)
	. = ..()
	if(!.)
		return FALSE

	if(HAS_TRAIT(target_mob, TRAIT_ANALGESIA)) // Our work is already done here.
		return TRUE

	ADD_TRAIT(target_mob, TRAIT_ANALGESIA, TRAIT_CARRIER)
	return TRUE

/datum/carrier_effect/vore/numbing/remove_from_carrier_mob(mob/living/target_mob)
	. = ..()
	if(!.)
		return FALSE

	REMOVE_TRAIT(target_mob, TRAIT_ANALGESIA, TRAIT_CARRIER)
	return TRUE

/datum/carrier_effect/vore/strip
	name = "Stripping"
	desc = "Strips of everything they are wearing."

/datum/carrier_effect/vore/strip/apply_to_carrier_mob(mob/living/target_mob)
	. = ..()
	if(!. || !target_mob?.get_all_gear(TRUE)) // We've removed what we can.
		return FALSE

	var/datum/component/carrier/parent_carrier = current_carrier?.resolve()
	var/mob/living/carbon/human/target_human = target_mob
	if(!istype(parent_carrier) || !istype(target_human) || !target_human.ckey)
		return FALSE

	var/obj/item/item_box/current_box = parent_carrier.linked_item_boxes[target_human.ckey]
	if(!istype(current_box))
		current_box = new (parent_carrier.parent) // Put it in the object the parent carrier is parented to.
		parent_carrier.linked_item_boxes[target_human.ckey] = current_box
		current_box.ckey_locked = FALSE

	if(!istype(target_human))
		return FALSE

	target_human.strip_clothing(current_box)
	return TRUE

/datum/carrier_effect/vore/jamming
	name = "Jamming"
	desc = "Jams all forms of communication for the prey inside."

/datum/carrier_effect/vore/jamming/apply_to_carrier_mob(mob/living/target_mob)
	. = ..()
	if(!.)
		return FALSE

	if(!HAS_TRAIT(target_mob, TRAIT_NO_COMMS)) // Our work is already done here.
		ADD_TRAIT(target_mob, TRAIT_NO_COMMS, TRAIT_CARRIER)

	var/mob/living/carbon/human/target_human = target_mob
	if(!istype(target_human))
		return FALSE

	var/obj/item/clothing/under/worn_uniform = target_human.w_uniform
	if(!istype(worn_uniform) || (worn_uniform.sensor_mode == NO_SENSORS))
		return TRUE

	worn_uniform.sensor_mode = NO_SENSORS
	return TRUE

/datum/carrier_effect/vore/jamming/remove_from_carrier_mob(mob/living/target_mob)
	. = ..()
	if(!.)
		return FALSE

	REMOVE_TRAIT(target_mob, TRAIT_NO_COMMS, TRAIT_CARRIER)

/datum/computer_file/program/messenger/send_message_signal(atom/source, message, list/datum/computer_file/program/messenger/targets, photo_path, everyone, rigged, fake_name, fake_job)
	var/mob/sender
	if(ismob(source))
		sender = source

	if(istype(sender) && HAS_TRAIT(sender, TRAIT_NO_COMMS))
		to_chat(sender, span_warning("There seems to be something stopping you from communicating with the outside world!"))
		return FALSE

	return ..()

/obj/item/radio/talk_into_impl(atom/movable/talking_movable, message, channel, list/spans, datum/language/language, list/message_mods)
	var/mob/living/talker = talking_movable
	if(istype(talker) && HAS_TRAIT(talker, TRAIT_NO_COMMS))
		to_chat(talker, span_warning("There seems to be something stopping you from communicating with the outside world!"))
		return FALSE

	return ..()
