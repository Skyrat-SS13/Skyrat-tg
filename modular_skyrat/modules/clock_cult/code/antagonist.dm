// This'll take a bit of explaining.
// Clock cult, the (shitty) gamemode is not coming back, this antagonist datum is for the soon-to-come OPFOR bundle
// However, the bundle gives `/datum/antagonist/clock_cultist/solo`, which is the same as `/datum/antagonist/clock_cultist`, but lacks conversion.

/datum/antagonist/clock_cultist
	name = "\improper Clock Cultist"
	antagpanel_category = "Clock Cultist"
	preview_outfit = /datum/outfit/clock_preview
	job_rank = ROLE_CLOCK_CULTIST
	antag_moodlet = /datum/mood_event/cult
	show_to_ghosts = TRUE
	suicide_cry = ",r For Ratvar!!!"
	ui_name = "AntagInfoClock"
	/// If this one has access to conversion scriptures
	var/can_convert = TRUE // TODO: Implement this and the antag as a whole (beyond just checks) once the groundwork PR gets merged


/datum/outfit/clock_preview
	name = "Clock Cultist (Preview only)"

	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/clockwork
	head = /obj/item/clothing/head/helmet/clockwork
	l_hand = /obj/item/clockwork/weapon/brass_sword


/datum/outfit/clock_preview/pre_equip(mob/living/carbon/human/clock, visualsOnly)
	. = ..()
	clock.faction |= FACTION_CLOCK


/datum/antagonist/clock_cultist/solo
	name = "Clock Cultist (Solo)"
	show_to_ghosts = FALSE
	can_convert = FALSE
