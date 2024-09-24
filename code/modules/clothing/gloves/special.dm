
/obj/item/clothing/gloves/cargo_gauntlet
	name = "\improper H.A.U.L. gauntlets"
	desc = "These clunky gauntlets allow you to drag things with more confidence on them not getting nabbed from you."
	icon_state = "haul_gauntlet"
	greyscale_colors = "#2f2e31"
	equip_delay_self = 3 SECONDS
	equip_delay_other = 4 SECONDS
	clothing_traits = list(TRAIT_CHUNKYFINGERS)
	undyeable = TRUE
	var/datum/weakref/pull_component_weakref

/obj/item/clothing/gloves/cargo_gauntlet/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_glove_equip))
	RegisterSignal(src, COMSIG_ITEM_POST_UNEQUIP, PROC_REF(on_glove_unequip))

/// Called when the glove is equipped. Adds a component to the equipper and stores a weak reference to it.
/obj/item/clothing/gloves/cargo_gauntlet/proc/on_glove_equip(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!(slot & ITEM_SLOT_GLOVES))
		return

	var/datum/component/strong_pull/pull_component = pull_component_weakref?.resolve()
	if(pull_component)
		stack_trace("Gloves already have a pull component associated with \[[pull_component.parent]\] when \[[equipper]\] is trying to equip them.")
		QDEL_NULL(pull_component_weakref)

	to_chat(equipper, span_notice("You feel the gauntlets activate as soon as you fit them on, making your pulls stronger!"))

	pull_component_weakref = WEAKREF(equipper.AddComponent(/datum/component/strong_pull))

/*
 * Called when the glove is unequipped. Deletes the component if one exists.
 *
 * No component being associated on equip is a valid state, as holding the gloves in your hands also counts
 * as having them equipped, or even in pockets. They only give the component when they're worn on the hands.
 */
/obj/item/clothing/gloves/cargo_gauntlet/proc/on_glove_unequip(datum/source, force, atom/newloc, no_move, invdrop, silent)
	SIGNAL_HANDLER

	var/datum/component/strong_pull/pull_component = pull_component_weakref?.resolve()

	if(!pull_component)
		return

	to_chat(pull_component.parent, span_warning("You have lost the grip power of [src]!"))

	QDEL_NULL(pull_component_weakref)

/obj/item/clothing/gloves/rapid
	name = "Gloves of the North Star"
	desc = "Just looking at these fills you with an urge to beat the shit out of people."
	icon_state = "rapid"
	inhand_icon_state = null
	clothing_traits = list(TRAIT_FINGERPRINT_PASSTHROUGH)

/obj/item/clothing/gloves/rapid/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/punchcooldown)

/obj/item/clothing/gloves/radio
	name = "translation gloves"
	desc = "A pair of electronic gloves which connect to nearby radios wirelessly. Allows for sign language users to 'speak' over comms."
	icon_state = "radio_g"
	inhand_icon_state = null
	clothing_traits = list(TRAIT_CAN_SIGN_ON_COMMS)

/obj/item/clothing/gloves/race
	name = "race gloves"
	desc = "Extremely finely made gloves meant for use by sportsmen in speed-shooting competitions."
	clothing_traits = list(TRAIT_DOUBLE_TAP)
	icon_state = "black"
	greyscale_colors = "#2f2e31"

/obj/item/clothing/gloves/captain
	desc = "Regal blue gloves, with a nice gold trim, a diamond anti-shock coating, and an integrated thermal barrier. Swanky."
	name = "captain's gloves"
	icon_state = "captain"
	inhand_icon_state = null
	greyscale_colors = null
	siemens_coefficient = 0
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	strip_delay = 60
	armor_type = /datum/armor/captain_gloves
	resistance_flags = NONE
	clothing_traits = list(TRAIT_FAST_CUFFING)

/datum/armor/captain_gloves
	bio = 90
	fire = 70
	acid = 50

/obj/item/clothing/gloves/latex
	name = "latex gloves"
	desc = "Cheap sterile gloves made from latex. Provides quicker carrying from a good grip."
	icon_state = "latex"
	inhand_icon_state = "latex_gloves"
	greyscale_colors = null
	siemens_coefficient = 0.3
	armor_type = /datum/armor/latex_gloves
	clothing_traits = list(TRAIT_QUICK_CARRY)
	resistance_flags = NONE

/datum/armor/latex_gloves
	bio = 100

/obj/item/clothing/gloves/latex/nitrile
	name = "nitrile gloves"
	desc = "Pricy sterile gloves that are thicker than latex. Excellent grip ensures very fast carrying of patients along with the faster use time of various chemical related items."
	icon_state = "nitrile"
	inhand_icon_state = "greyscale_gloves"
	greyscale_colors = "#99eeff"
	clothing_traits = list(TRAIT_QUICKER_CARRY, TRAIT_FASTMED)

/obj/item/clothing/gloves/latex/coroner
	name = "coroner's gloves"
	desc = "Black gloves made from latex with a superhydrophobic coating. Useful for picking bodies up instead of dragging blood behind."
	icon_state = "latex_black"
	inhand_icon_state = "greyscale_gloves"
	greyscale_colors = "#15191a"
	clothing_traits = list(TRAIT_QUICK_CARRY, TRAIT_FASTMED)

/obj/item/clothing/gloves/latex/coroner/add_blood_DNA(list/blood_DNA_to_add)
	return FALSE

/obj/item/clothing/gloves/tinkerer
	name = "tinker's gloves"
	desc = "Overdesigned engineering gloves that have automated construction subrutines dialed in, allowing for faster construction while worn."
	inhand_icon_state = "greyscale_gloves"
	icon_state = "clockwork_gauntlets"
	greyscale_colors = "#db6f05"
	siemens_coefficient = 0.8
	armor_type = /datum/armor/tinker_gloves
	clothing_traits = list(TRAIT_QUICK_BUILD)
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT, /datum/material/silver=HALF_SHEET_MATERIAL_AMOUNT*1.5, /datum/material/gold =HALF_SHEET_MATERIAL_AMOUNT)
	resistance_flags = NONE

/datum/armor/tinker_gloves
	bio = 70

/obj/item/clothing/gloves/atmos
	name = "atmospheric extrication gloves"
	desc = "Heavy duty gloves for firefighters. These are thick, non-flammable and let you carry people faster."
	icon_state = "atmos"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	resistance_flags = FIRE_PROOF
	siemens_coefficient = 0.3
	clothing_traits = list(TRAIT_QUICKER_CARRY, TRAIT_CHUNKYFINGERS)
	clothing_flags = THICKMATERIAL

///A pair of gloves that both allow the user to fish without the need of a held fishing rod and provides athletics experience.
/obj/item/clothing/gloves/fishing
	name = "athletic fishing gloves"
	desc = "A pair of gloves to fish without a fishing rod but your raw <b>athletics</b> strength. It doubles as a good workout device. <i><b>WARNING</b>: May cause injuries when catching bigger fish.</i>"
	icon_state = "fishing_gloves"

/obj/item/clothing/gloves/fishing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/profound_fisher, new /obj/item/fishing_rod/mob_fisher/athletic(src))

/obj/item/clothing/gloves/fishing/equipped(mob/user, slot)
	. = ..()
	if(slot == ITEM_SLOT_GLOVES)
		RegisterSignal(user, SIGNAL_ADDTRAIT(TRAIT_ACTIVELY_FISHING), PROC_REF(begin_workout))

/obj/item/clothing/gloves/fishing/dropped(mob/user)
	UnregisterSignal(user, list(SIGNAL_ADDTRAIT(TRAIT_ACTIVELY_FISHING), SIGNAL_REMOVETRAIT(TRAIT_ACTIVELY_FISHING)))
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/item/clothing/gloves/fishing/proc/begin_workout(datum/source)
	SIGNAL_HANDLER
	RegisterSignal(source, SIGNAL_REMOVETRAIT(TRAIT_ACTIVELY_FISHING), PROC_REF(stop_workout))
	if(HAS_TRAIT(source, TRAIT_PROFOUND_FISHER)) //Only begin working out if we're fishing with these gloves and not some other fishing rod..
		START_PROCESSING(SSprocessing, src)

/obj/item/clothing/gloves/fishing/proc/stop_workout(datum/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, SIGNAL_REMOVETRAIT(TRAIT_ACTIVELY_FISHING))
	STOP_PROCESSING(SSprocessing, src)

/obj/item/clothing/gloves/fishing/process(seconds_per_tick)
	var/mob/living/wearer = loc
	var/list/trait_source = GET_TRAIT_SOURCES(wearer, TRAIT_ACTIVELY_FISHING)
	var/datum/fishing_challenge/challenge = trait_source[1]
	var/stamina_exhaustion = 2.5 + challenge.difficulty * 0.025
	var/is_heavy_gravity = wearer.has_gravity() > STANDARD_GRAVITY
	var/obj/item/organ/internal/cyberimp/chest/spine/potential_spine = wearer.get_organ_slot(ORGAN_SLOT_SPINE)
	if(istype(potential_spine))
		stamina_exhaustion *= potential_spine.athletics_boost_multiplier
	if(HAS_TRAIT(wearer, TRAIT_STRENGTH))
		stamina_exhaustion *= 0.5

	var/experience = 0.3 + challenge.difficulty * 0.003
	if(is_heavy_gravity)
		stamina_exhaustion *= 1.5
		experience *= 2

	wearer.adjustStaminaLoss(stamina_exhaustion)
	wearer.mind?.adjust_experience(/datum/skill/athletics, experience)
	wearer.apply_status_effect(/datum/status_effect/exercised)

///The internal fishing rod of the athletic fishing gloves. The more athletic you're, the easier the minigame will be.
/obj/item/fishing_rod/mob_fisher/athletic
	icon = /obj/item/clothing/gloves/fishing::icon
	icon_state = /obj/item/clothing/gloves/fishing::icon_state
	line = null
	bait = null
	ui_description = "The integrated fishing rod of a pair of athletic fishing gloves"

/obj/item/fishing_rod/mob_fisher/athletic/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_FISHING_ROD_CAUGHT_FISH, PROC_REF(noodling_is_dangerous))

/obj/item/fishing_rod/mob_fisher/athletic/get_fishing_overlays()
	return list()

/obj/item/fishing_rod/mob_fisher/athletic/hook_hit(atom/atom_hit_by_hook_projectile, mob/user)
	difficulty_modifier = -3 * user.mind?.get_skill_level(/datum/skill/athletics)
	return ..()

/obj/item/fishing_rod/mob_fisher/athletic/proc/noodling_is_dangerous(datum/source, atom/movable/reward, mob/living/user)
	SIGNAL_HANDLER
	if(!isfish(reward))
		return
	var/damage = 0
	var/obj/item/fish/fishe = reward
	switch(fishe.w_class)
		if(WEIGHT_CLASS_BULKY)
			damage = 10
		if(WEIGHT_CLASS_HUGE)
			damage = 14
		if(WEIGHT_CLASS_GIGANTIC)
			damage = 18
	if(!damage && fishe.weight >= 2000)
		damage = 5
	damage = round(damage * fishe.weight * 0.0005)
	if(damage)
		var/body_zone = pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM)
		user.apply_damage(damage, BRUTE, body_zone, user.run_armor_check(body_zone, MELEE))
		playsound(src,'sound/weapons/bite.ogg', damage * 2, TRUE)
