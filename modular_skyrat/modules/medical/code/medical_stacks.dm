/obj/item/stack/medical/gauze
	var/gauze_type = /datum/bodypart_aid/gauze
	var/splint_type = /datum/bodypart_aid/splint

/obj/item/stack/medical/gauze/improvised
	gauze_type = /datum/bodypart_aid/gauze/improvised
	splint_type = /datum/bodypart_aid/splint/improvised

// gauze is only relevant for wounds, which are handled in the wounds themselves
/obj/item/stack/medical/gauze/try_heal(mob/living/patient, mob/user, silent)

	var/treatment_delay = (user == patient ? self_delay : other_delay)

	var/obj/item/bodypart/limb = patient.get_bodypart(check_zone(user.zone_selected))
	if(!limb)
		patient.balloon_alert(user, "missing limb!")
		return
	if(!LAZYLEN(limb.wounds))
		patient.balloon_alert(user, "no wounds!") // good problem to have imo
		return

	var/gauzeable_wound = FALSE
	var/splintable_wound = FALSE
	var/datum/wound/woundies
	for(var/i in limb.wounds)
		woundies = i
		if(woundies.wound_flags & (ACCEPTS_GAUZE | ACCEPTS_SPLINT))
			if(woundies.wound_flags & ACCEPTS_GAUZE)
				gauzeable_wound = TRUE
				continue
			if(woundies.wound_flags & ACCEPTS_SPLINT)
				splintable_wound = TRUE
				continue
	if(!gauzeable_wound && !splintable_wound)
		patient.balloon_alert(user, "can't heal those!")
		return

	if(limb.current_gauze && gauzeable_wound)
		gauzeable_wound = FALSE
	if(limb.current_splint && splintable_wound)
		splintable_wound = FALSE
	if(!gauzeable_wound && !splintable_wound)
		balloon_alert(user, "already bandaged!")
		return

	if(HAS_TRAIT(woundies, TRAIT_WOUND_SCANNED))
		treatment_delay *= 0.5
		if(user == patient)
			user.visible_message(span_warning("[user] begins expertly [gauzeable_wound ? "wrapping the wounds on their [limb.plaintext_zone]" : "splinting their [limb.plaintext_zone]"] with [src]..."), span_notice("You keep in mind the indications from the holo-image about your injury, and expertly begin [gauzeable_wound ? "wrapping your wounds" : "splinting your [limb.plaintext_zone]"] with [src]."))
		else
			user.visible_message(span_warning("[user] begins expertly [gauzeable_wound ? "wrapping the wounds on [patient]'s [limb.plaintext_zone]" : "splinting [patient]'s [limb.plaintext_zone]"] with [src]..."), span_warning("You begin quickly [gauzeable_wound ? "wrapping the wounds on [patient]'s [limb.plaintext_zone]" : "splinting [patient]'s [limb.plaintext_zone]"] with [src], keeping the holo-image indications in mind..."))
	else
		user.visible_message(span_warning("[user] begins [gauzeable_wound ? "wrapping the wounds on [patient]'s [limb.plaintext_zone]" : "splinting [patient]'s [limb.plaintext_zone]"] with [src]..."), span_warning("You begin [gauzeable_wound ? "wrapping the wounds on" : "splinting"] [user == patient ? "your" : "[patient]'s"] [limb.plaintext_zone] with [src]..."))

	if(!do_after(user, treatment_delay, target = patient))
		return

	user.visible_message("<span class='infoplain'><span class='green'>[user] [gauzeable_wound ? "wraps the wounds on" : "splints"] [user == patient ? "[user.p_their()]" : "[patient]'s"] [limb.plaintext_zone] with [src].</span></span>", "<span class='infoplain'><span class='green'>You [gauzeable_wound ? "wrap the wounds on" : "splint"]  [user == patient ? "your" : "[patient]'s"] [limb.plaintext_zone].</span></span>")
	if(gauzeable_wound)
		limb.apply_gauze(src)
		return
	if(splintable_wound)
		limb.apply_splint(src)
		return

