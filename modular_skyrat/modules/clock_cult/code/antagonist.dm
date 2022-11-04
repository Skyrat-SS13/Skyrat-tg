// This'll take a bit of explaining.
// Clock cult, the (shitty) gamemode is not coming back, this antagonist datum is for the soon-to-come traitor bundle
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

/*
/datum/antagonist/contractor/on_gain()
	forge_objectives()
	. = ..()
	equip_guy()

/datum/antagonist/contractor/proc/forge_objectives()
	var/datum/objective/contractor_total/contract_objectives = new
	contract_objectives.owner = owner
	objectives += contract_objectives

/datum/antagonist/contractor/roundend_report()
	var/list/report = list()

	if(!owner)
		CRASH("antagonist datum without owner")

	report += "<b>[printplayer(owner)]</b>"

	var/objectives_complete = TRUE
	if(length(objectives))
		report += printobjectives(objectives)
		for(var/datum/objective/objective as anything in objectives)
			if(!objective.check_completion())
				objectives_complete = FALSE
				break

	report += owner.opposing_force.contractor_round_end()

	if(!length(objectives) || objectives_complete)
		report += "<span class='greentext big'>The [name] was successful!</span>"
	else
		report += "<span class='redtext big'>The [name] has failed!</span>"

	return report.Join("<br>")*/

/datum/outfit/clock_preview
	name = "Clock Cultist (Preview only)"

	uniform = /obj/item/clothing/under/syndicate
	suit = /obj/item/clothing/suit/clockwork
	head = /obj/item/clothing/head/helmet/clockwork
	l_hand = /obj/item/clockwork/weapon/brass_sword

/datum/outfit/clock_preview/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	H.faction |= FACTION_CLOCK

/datum/antagonist/clock_cultist/solo
	name = "Clock Cultist (Solo)"
	show_to_ghosts = FALSE
	can_convert = FALSE
