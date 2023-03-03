// This'll take a bit of explaining.
// Clock cult, the (shitty) gamemode is not coming back, this antagonist datum is for the soon-to-come OPFOR bundle
// However, the bundle gives `/datum/antagonist/clock_cultist/solo`, which is the same as `/datum/antagonist/clock_cultist`, but lacks conversion.

/datum/antagonist/clock_cultist
	name = "\improper Clock Cultist"
	antagpanel_category = "Clock Cultist"
	preview_outfit = /datum/outfit/clock/preview
	job_rank = ROLE_CLOCK_CULTIST
	antag_moodlet = /datum/mood_event/cult
	show_to_ghosts = TRUE
	suicide_cry = ",r For Ratvar!!!"
	ui_name = "AntagInfoClock"
	/// If this one has access to conversion scriptures
	var/can_convert = TRUE // TODO: Implement this and the antag as a whole (beyond just checks) once the groundwork PR gets merged


/datum/antagonist/clock_cultist/on_gain()
	. = ..()
	owner.current.playsound_local(get_turf(owner.current), 'sound/magic/clockwork/scripture_tier_up.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)


/datum/antagonist/clock_cultist/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current
	current.faction |= FACTION_CLOCK
	current.grant_language(/datum/language/ratvar, TRUE, TRUE, LANGUAGE_CULTIST)


/datum/antagonist/clock_cultist/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current
	current.faction -= FACTION_CLOCK
	current.remove_language(/datum/language/ratvar, TRUE, TRUE, LANGUAGE_CULTIST)


/datum/outfit/clock/preview
	name = "Clock Cultist (Preview only)"

	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/clockwork
	head = /obj/item/clothing/head/helmet/clockwork
	l_hand = /obj/item/clockwork/weapon/brass_sword


/datum/antagonist/clock_cultist/solo
	name = "Clock Cultist (Solo)"
	show_to_ghosts = FALSE
	can_convert = FALSE
