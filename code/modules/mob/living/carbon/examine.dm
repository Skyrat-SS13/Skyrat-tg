/mob/living/carbon/examine(mob/user)
	var/t_He = p_They()
	var/t_His = p_Their()
	var/t_his = p_their()
	var/t_him = p_them()
	var/t_has = p_have()
	var/t_is = p_are()

	. = list("<span class='info'>This is [icon2html(src, user)] \a <EM>[src]</EM>!", EXAMINE_SECTION_BREAK) // SKYRAT EDIT CHANGE - HR padding
	var/obscured = check_obscured_slots()

	if (handcuffed)
		. += span_warning("[t_He] [t_is] [icon2html(handcuffed, user)] handcuffed!")
	if (head)
		. += "[t_He] [t_is] wearing [head.get_examine_string(user)] on [t_his] head. "
	if(wear_mask && !(obscured & ITEM_SLOT_MASK))
		. += "[t_He] [t_is] wearing [wear_mask.get_examine_string(user)] on [t_his] face."
	if(wear_neck && !(obscured & ITEM_SLOT_NECK))
		. += "[t_He] [t_is] wearing [wear_neck.get_examine_string(user)] around [t_his] neck."

	for(var/obj/item/held_thing in held_items)
		if(held_thing.item_flags & (ABSTRACT|EXAMINE_SKIP|HAND_ITEM))
			continue
		. += "[t_He] [t_is] holding [held_thing.get_examine_string(user)] in [t_his] [get_held_index_name(get_held_index_of_item(held_thing))]."

	if (back)
		. += "[t_He] [t_has] [back.get_examine_string(user)] on [t_his] back."

	. += EXAMINE_SECTION_BREAK // SKYRAT EDIT ADDITION - hr sections

	var/appears_dead = FALSE
	if (stat == DEAD)
		appears_dead = TRUE
		if(get_organ_by_type(/obj/item/organ/internal/brain))
			. += span_deadsay("[t_He] [t_is] limp and unresponsive, with no signs of life.")
		else if(get_bodypart(BODY_ZONE_HEAD))
			. += span_deadsay("It appears that [t_his] brain is missing...")

	var/list/msg = list("<span class='warning'>")
	for(var/obj/item/bodypart/bodypart as anything in bodyparts)
		for(var/obj/item/embedded_item as anything in bodypart.embedded_objects)
			if(embedded_item.isEmbedHarmless())
				msg += "<B>[t_He] [t_has] [icon2html(embedded_item, user)] \a [embedded_item] stuck to [t_his] [bodypart.name]!</B>\n"
			else
				msg += "<B>[t_He] [t_has] [icon2html(embedded_item, user)] \a [embedded_item] embedded in [t_his] [bodypart.name]!</B>\n"
		for(var/datum/wound/bodypart_wound as anything in bodypart.wounds)
			msg += "[bodypart_wound.get_examine_description(user)]\n"

	for(var/obj/item/bodypart/disabled_limb as anything in get_disabled_limbs())
		var/damage_text
		damage_text = (disabled_limb.brute_dam >= disabled_limb.burn_dam) ? disabled_limb.heavy_brute_msg : disabled_limb.heavy_burn_msg
		msg += "<B>[t_His] [disabled_limb.name] is [damage_text]!</B>\n"

	for(var/obj/item/bodypart/missing_limb as anything in get_missing_limbs())
		if(missing_limb == BODY_ZONE_HEAD)
			msg += "[span_deadsay("<B>[t_His] [parse_zone(missing_limb)] is missing!</B>")]\n"
			continue
		msg += "[span_warning("<B>[t_His] [parse_zone(missing_limb)] is missing!</B>")]\n"


	var/temp = getBruteLoss()
	if(!(user == src && has_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy))) //fake healthy
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] minor bruising.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> bruising!\n"
			else
				msg += "<B>[t_He] [t_has] severe bruising!</B>\n"

		temp = getFireLoss()
		if(temp)
			if (temp < 25)
				msg += "[t_He] [t_has] minor burns.\n"
			else if (temp < 50)
				msg += "[t_He] [t_has] <b>moderate</b> burns!\n"
			else
				msg += "<B>[t_He] [t_has] severe burns!</B>\n"

	if(HAS_TRAIT(src, TRAIT_DUMB))
		msg += "[t_He] seem[p_s()] to be clumsy and unable to think.\n"

	if(has_status_effect(/datum/status_effect/fire_handler/fire_stacks))
		msg += "[t_He] [t_is] covered in something flammable.\n"
	if(has_status_effect(/datum/status_effect/fire_handler/wet_stacks))
		msg += "[t_He] look[p_s()] a little soaked.\n"

	if(pulledby?.grab_state)
		msg += "[t_He] [t_is] restrained by [pulledby]'s grip.\n"

	var/scar_severity = 0
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(S.is_visible(user))
			scar_severity += S.severity

	switch(scar_severity)
		if(1 to 4)
			msg += "[span_tinynoticeital("[t_He] [t_has] visible scarring, you can look again to take a closer look...")]\n"
		if(5 to 8)
			msg += "[span_smallnoticeital("[t_He] [t_has] several bad scars, you can look again to take a closer look...")]\n"
		if(9 to 11)
			msg += "[span_notice("<i>[t_He] [t_has] significantly disfiguring scarring, you can look again to take a closer look...</i>")]\n"
		if(12 to INFINITY)
			msg += "[span_notice("<b><i>[t_He] [t_is] just absolutely fucked up, you can look again to take a closer look...</i></b>")]\n"

	msg += "</span>"

	. += msg.Join("")

	if(!appears_dead)
		switch(stat)
			if(SOFT_CRIT)
				. += "[t_His] breathing is shallow and labored."
			if(UNCONSCIOUS, HARD_CRIT)
				. += "[t_He] [t_is]n't responding to anything around [t_him] and seems to be asleep."

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam

	if(mob_mood)
		switch(mob_mood.shown_mood)
			if(-INFINITY to MOOD_SAD4)
				. += "[t_He] look[p_s()] depressed."
			if(MOOD_SAD4 to MOOD_SAD3)
				. += "[t_He] look[p_s()] very sad."
			if(MOOD_SAD3 to MOOD_SAD2)
				. += "[t_He] look[p_s()] a bit down."
			if(MOOD_HAPPY2 to MOOD_HAPPY3)
				. += "[t_He] look[p_s()] quite happy."
			if(MOOD_HAPPY3 to MOOD_HAPPY4)
				. += "[t_He] look[p_s()] very happy."
			if(MOOD_HAPPY4 to INFINITY)
				. += "[t_He] look[p_s()] ecstatic."
	. += "</span>"

	SEND_SIGNAL(src, COMSIG_ATOM_EXAMINE, user, .)

/mob/living/carbon/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You examine [src] closer, and note the following...</i>")

	if(dna) //not all carbons have it. eg - xenos
		//On closer inspection, this man isnt a man at all!
		var/list/covered_zones = get_covered_body_zones()
		for(var/obj/item/bodypart/part as anything in bodyparts)
			if(part.body_zone in covered_zones)
				continue
			if(part.limb_id != dna.species.examine_limb_id)
				. += "[span_info("[p_They()] [p_have()] \an [part.name].")]"

	var/list/visible_scars
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(S.is_visible(user))
			LAZYADD(visible_scars, S)

	for(var/i in visible_scars)
		var/datum/scar/S = i
		var/scar_text = S.get_examine_description(user)
		if(scar_text)
			. += "[scar_text]"

	return .
