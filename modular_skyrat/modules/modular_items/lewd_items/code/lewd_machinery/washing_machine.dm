/obj/machinery/washing_machine
	can_buckle = TRUE
	/// If we are active, all mobs buckled to us with a penis will have arousal raised by this per second.
	var/buckled_arousal_penis = 0.5
	/// If we are active, all mobs buckled to us with a vagina will have arousal raised by this per second.
	var/buckled_arousal_vagina = 2
	/// If we are active and anchored, our arousal given to buckled mobs will be multiplied against this.
	var/anchored_arousal_mult = 0.25

/obj/machinery/washing_machine/process(seconds_per_tick)
	. = ..()
	if (. == PROCESS_KILL)
		return

	if (!LAZYLEN(buckled_mobs))
		return

	for (var/mob/living/carbon/human/buckled_human in buckled_mobs)
		if (!buckled_human.client?.prefs?.read_preference(/datum/preference/toggle/erp))
			continue

		var/covered = FALSE
		for (var/obj/item/clothing/iter_clothing in buckled_human.get_all_worn_items())
			if (!(iter_clothing.body_parts_covered & GROIN))
				continue
			if (iter_clothing.clothing_flags & THICKMATERIAL)
				covered = TRUE
				break

		if (covered)
			continue

		var/obj/item/organ/external/genital/vagina/found_vagina = buckled_human.get_organ_slot(ORGAN_SLOT_VAGINA)
		var/obj/item/organ/external/genital/vagina/found_penis = buckled_human.get_organ_slot(ORGAN_SLOT_PENIS)

		var/arousal_mult = seconds_per_tick
		var/message_chance = 40
		if (anchored)
			arousal_mult *= anchored_arousal_mult
			message_chance *= anchored_arousal_mult
		var/do_message = FALSE
		if (!isnull(found_vagina))
			buckled_human.adjust_arousal(buckled_arousal_vagina * arousal_mult)
			do_message = TRUE
		if (!isnull(found_penis))
			buckled_human.adjust_arousal(buckled_arousal_penis * arousal_mult)
			do_message = TRUE
		if (do_message && SPT_PROB(message_chance, seconds_per_tick))
			to_chat(buckled_human, span_userlove("[src] vibrates into your groin, and you feel a warm fuzzy feeling..."))
