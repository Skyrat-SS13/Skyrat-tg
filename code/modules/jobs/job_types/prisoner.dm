/datum/job/prisoner
	title = "Prisoner"
	department_head = list("The Security Team")
	faction = "Station"
	total_positions = 12		// SKYRAT EDIT: Original value (0)
	spawn_positions = 2
	supervisors = "the security team"
	selection_color = "#ffe1c3"
	paycheck = PAYCHECK_PRISONER

	outfit = /datum/outfit/job/prisoner
	plasmaman_outfit = /datum/outfit/plasmaman/prisoner

	display_order = JOB_DISPLAY_ORDER_PRISONER

	family_heirlooms = list(/obj/item/pen/blue)

/datum/outfit/job/prisoner
	name = "Prisoner"
	jobtype = /datum/job/prisoner

	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	id = /obj/item/card/id/advanced/prisoner
	ears = null
	belt = null

	id_trim = /datum/id_trim/job/prisoner

// SKYRAT EDIT: Start - Adds spawn text to prisoners.
/datum/job/prisoner/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	to_chat(M, "<span class='userdanger'>You <b><u>MUST</b></u> ahelp before attempting breakouts or rioting. Being a shitter = perma prisoner job-ban.")
	to_chat(M, "<span class='warning'>Being a shitter includes but is not limited to: Critting other prisoners, constantly breaking things, and occupying too much of security's time as a result. <b>Remember: You aren't an antagonist.</b>")
	to_chat(M, "<b>You are a prisoner being held in Space Station 13, awaiting transfer to a secure prison facility or to the courthouse to stand trial.</b>")
	to_chat(M, "It's up to you to decide why you're in here. Chances are, the case against you might not be strong enough to convict you. Or is it?<br>")
// SKYRAT EDIT : End - Adds spawn text to prisoners.

