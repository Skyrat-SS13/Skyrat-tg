#define TOOL_ALIEN_BONESET "alien bonesetter"

/obj/item/bonesetter/alien
	name = "alien bonesetter"
	desc = "A reversed engineered bonesetter... <b> This does not look nice to be on the receiving end of... </b>."
	icon = 'modular_skyrat/modules/filtersandsetters/icons/surgery_tools.dmi'
	icon_state = "bonesetter"
	toolspeed = 0.25

/obj/item/bonesetter/alien/get_all_tool_behaviours()
    return list(TOOL_BONESET, TOOL_ALIEN_BONESET)

/datum/wound/item_can_treat(obj/item/potential_treater, mob/user)
	. = ..()
	// check if we have a valid treatable tool
	for(var/behaviour in potential_treater.get_all_tool_behaviours())
		if(behaviour in treatable_tools)
			return TRUE

/datum/wound/blunt/bone/severe
	treatable_tools = list(TOOL_ALIEN_BONESET)

/datum/wound/blunt/bone/severe/treat(obj/item/I, mob/user)
	var/scanned = HAS_TRAIT(src, TRAIT_WOUND_SCANNED)
	var/self_penalty_mult = user == victim ? 1.5 : 1
	var/scanned_mult = scanned ? 0.5 : 1
	var/treatment_delay = base_treat_time * self_penalty_mult * scanned_mult

	if(victim == user)
		victim.visible_message(span_danger("[user] begins [scanned ? "expertly" : ""] realigning [victim.p_their()] [limb.plaintext_zone] with [I]."), span_warning("You begin realigning your [limb.plaintext_zone] with [I][scanned ? ", keeping the holo-image's indications in mind" : ""]..."))
	else
		user.visible_message(span_danger("[user] begins [scanned ? "expertly" : ""] realigning [victim]'s [limb.plaintext_zone] with [I]."), span_notice("You begin realigning [victim]'s [limb.plaintext_zone] with [I][scanned ? ", keeping the holo-image's indications in mind" : ""]..."))

	if(!do_after(user, treatment_delay, target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	if(victim == user)
		limb.receive_damage(brute=25, wound_bonus=CANT_WOUND)
		victim.visible_message(span_danger("[user] finishes realigning [victim.p_their()] [limb.plaintext_zone] with a disturbing <b>crunch</b>!"), span_userdanger("You reset your [limb.plaintext_zone] with a disturbing <b>crunch</b>!"))
	else
		limb.receive_damage(brute=20, wound_bonus=CANT_WOUND)
		user.visible_message(span_danger("[user] finishes realigning [victim]'s [limb.plaintext_zone] with a disturbing <b>crunch</b>!"), span_nicegreen("You finish realigning [victim]'s [limb.plaintext_zone] with a disturbing <b>crunch</b>!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] resets your [limb.plaintext_zone] with a disturbing <b>crunch</b>!"))

	victim.emote("scream")
	playsound(user, 'sound/effects/wounds/crack1.ogg', 70, TRUE)
	qdel(src)

/datum/wound/blunt/bone/critical
	treatable_tools = list(TOOL_ALIEN_BONESET)

/datum/wound/blunt/bone/critical/treat(obj/item/I, mob/user)
	var/scanned = HAS_TRAIT(src, TRAIT_WOUND_SCANNED)
	var/self_penalty_mult = user == victim ? 1.5 : 1
	var/scanned_mult = scanned ? 0.5 : 1
	var/treatment_delay = base_treat_time * self_penalty_mult * scanned_mult

	if(victim == user)
		victim.visible_message(span_danger("[user] begins [scanned ? "expertly" : ""] realigning [victim.p_their()] [limb.plaintext_zone] with [I]."), span_warning("You begin realigning your [limb.plaintext_zone] with [I][scanned ? ", keeping the holo-image's indications in mind" : ""]..."))
	else
		user.visible_message(span_danger("[user] begins [scanned ? "expertly" : ""] realigning [victim]'s [limb.plaintext_zone] with [I]."), span_notice("You begin realigning [victim]'s [limb.plaintext_zone] with [I][scanned ? ", keeping the holo-image's indications in mind" : ""]..."))

	if(!do_after(user, treatment_delay, target = victim, extra_checks=CALLBACK(src, PROC_REF(still_exists))))
		return

	if(victim == user)
		limb.receive_damage(brute=45, wound_bonus=CANT_WOUND)
		victim.visible_message(span_danger("[user] finishes realigning [victim.p_their()] [limb.plaintext_zone] with a disturbing <b>crunch</b>!"), span_userdanger("You reset your [limb.plaintext_zone] with a disturbing <b>crunch</b>!"))
	else
		limb.receive_damage(brute=40, wound_bonus=CANT_WOUND)
		user.visible_message(span_danger("[user] finishes realigning [victim]'s [limb.plaintext_zone] with a disturbing <b>crunch</b>!"), span_nicegreen("You finish realigning [victim]'s [limb.plaintext_zone] with a disturbing <b>crunch</b>!"), ignored_mobs=victim)
		to_chat(victim, span_userdanger("[user] resets your [limb.plaintext_zone] with a disturbing <b>crunch</b>!"))

	victim.emote("scream")
	playsound(user, 'sound/effects/wounds/crack2.ogg', 70, TRUE)
	qdel(src)

/datum/design/alienbonesetter
	name = "Alien Bonesetter"
	desc = "An abomination of reverse engineered tech, designed by a madman."
	id = "alien_bonesetter"
	build_path = /obj/item/bonesetter/alien
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/obj/item/blood_filter/alien
	name = "alien bloodfilter"
	desc = "A reversed engineered bloodfilter... <b> This does not look nice to be on the receiving end of... </b>."
	icon = 'modular_skyrat/modules/filtersandsetters/icons/surgery_tools.dmi'
	icon_state = "bloodfilter"
	toolspeed = 0.25

/datum/design/alienbloodfilter
	name = "Alien Blood filter"
	desc = "An abomination of reverse engineered tech, designed by a madman."
	id = "alien_bloodfilter"
	build_path = /obj/item/blood_filter/alien
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron =SHEET_MATERIAL_AMOUNT, /datum/material/silver =HALF_SHEET_MATERIAL_AMOUNT * 1.5, /datum/material/plasma =SMALL_MATERIAL_AMOUNT*5, /datum/material/titanium =HALF_SHEET_MATERIAL_AMOUNT * 1.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ALIEN
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/obj/item/blood_filter/advanced
	name = "medical combitool"
	desc = "An unholy combination of bonesetter and bloodfilter."
	icon = 'modular_skyrat/modules/filtersandsetters/icons/surgery_tools.dmi'
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*6, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*2, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5)
	icon_state = "combitool"
	inhand_icon_state = "adv_retractor"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.7

/obj/item/blood_filter/advanced/get_all_tool_behaviours()
	return list(TOOL_BLOODFILTER, TOOL_BONESET)

/obj/item/blood_filter/advanced/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = force, \
		throwforce_on = throwforce, \
		hitsound_on = hitsound, \
		w_class_on = w_class, \
		clumsy_check = FALSE, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Toggles between bonesetter and bloodfilter and gives feedback to the user.
 */
/obj/item/blood_filter/advanced/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	tool_behaviour = (active ? TOOL_BONESET : TOOL_BLOODFILTER)
	balloon_alert(user, "tools set to [active ? "set bones" : "filter blood"]")
	playsound(user ? user : src, 'sound/items/change_drill.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/blood_filter/advanced/examine()
	. = ..()
	. += span_notice("It resembles a [tool_behaviour == TOOL_BLOODFILTER ? "bloodfilter" : "bonesetter"].")

/datum/design/combitool
	name = "Medical Combitool"
	desc = "This tool can be either used as bloodfilter or bonesetter."
	id = "combitool"
	build_path = /obj/item/blood_filter/advanced
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT*6, /datum/material/glass = SHEET_MATERIAL_AMOUNT*2, /datum/material/silver = SHEET_MATERIAL_AMOUNT*2, /datum/material/titanium =SHEET_MATERIAL_AMOUNT * 2.5)
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MEDICAL_ADVANCED
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/techweb_node/surgery_tools/New()
	design_ids += list(
		"combitool",
	)
	return ..()

/datum/techweb_node/alien_surgery/New()
	design_ids += list(
		"alien_bloodfilter",
		"alien_bonesetter",
	)
	return ..()

