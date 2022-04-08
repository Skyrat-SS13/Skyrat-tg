// USED FOR THE MIDROUND
/datum/antagonist/contractor
	name = "Drifting Contractor"
	antagpanel_category = "DriftingContractor"
	preview_outfit = /datum/outfit/contractor_preview
	job_rank = ROLE_DRIFTING_CONTRACTOR
	hud_icon = 'modular_skyrat/modules/contractor/icons/hud_icon.dmi'
	antag_hud_name = "contractor"
	antag_moodlet = /datum/mood_event/focused
	show_to_ghosts = TRUE
	suicide_cry = "FOR THE CONTRACTS!!"
	/// The outfit the contractor is equipped with
	var/contractor_outfit = /datum/outfit/contractor

/datum/antagonist/contractor/proc/equip_guy()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/person = owner.current
	person.equipOutfit(contractor_outfit)
	return TRUE

/datum/antagonist/contractor/on_gain()
	forge_objectives()
	. = ..()
	equip_guy()

/datum/antagonist/contractor/proc/forge_objectives()
	objectives += new/datum/objective/contractor_total

/datum/job/drifting_contractor
	title = ROLE_DRIFTING_CONTRACTOR
