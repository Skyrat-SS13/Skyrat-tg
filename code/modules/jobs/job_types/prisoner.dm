/datum/job/prisoner
	title = JOB_PRISONER
	description = "Keep yourself occupied in permabrig."
	department_head = list("The Security Team")
	faction = FACTION_STATION
	total_positions = 12		// SKYRAT EDIT: Original value (0)
	spawn_positions = 2
	supervisors = "the security team"
	selection_color = "#ffe1c3"
	exp_granted_type = EXP_TYPE_CREW
	paycheck = PAYCHECK_LOWER

	outfit = /datum/outfit/job/prisoner
	plasmaman_outfit = /datum/outfit/plasmaman/prisoner

	display_order = JOB_DISPLAY_ORDER_PRISONER
	department_for_prefs = /datum/job_department/assistant // SKYRAT EDIT - ORIGINAL: /datum/job_department/security

	exclusive_mail_goodies = TRUE
	mail_goodies = list (
		/obj/effect/spawner/random/contraband/prison = 1
	)

	family_heirlooms = list(/obj/item/pen/blue)
	rpg_title = "Defeated Miniboss"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

//SKYRAT ADDITION START
/datum/job/prisoner/skyrat_precheck()
	var/security_count = 0
	for(var/datum/job/potential_security in SSjob.all_occupations)
		if(potential_security.departments_bitflags & DEPARTMENT_BITFLAG_SECURITY)
			security_count += potential_security.current_positions
	var/prisoners_per = CONFIG_GET(number/prisoners_per_security)
	var/max_prisoners = CONFIG_GET(number/max_prisoners_per_security)
	if(prisoners_per > 0)
		var/prisoner_positions = round(prisoners_per * security_count)
		if(max_prisoners)
			prisoner_positions = min(prisoner_positions, max_prisoners)
		SSjob.JobDebug("Setting open prisoner positions to [prisoner_positions], due to [security_count] filled security positions. Maximum prisoners is set to [max_prisoners].")
		total_positions = prisoner_positions
		spawn_positions = prisoner_positions
	..()
//SKYRAT ADDITION END

/datum/outfit/job/prisoner
	name = "Prisoner"
	jobtype = /datum/job/prisoner

	id = /obj/item/card/id/advanced/prisoner
	id_trim = /datum/id_trim/job/prisoner
	uniform = /obj/item/clothing/under/rank/prisoner
	belt = null
	ears = null
	shoes = /obj/item/clothing/shoes/sneakers/orange

/datum/outfit/job/prisoner/pre_equip(mob/living/carbon/human/H)
	..()
	if(prob(1)) // D BOYYYYSSSSS
		head = /obj/item/clothing/head/beanie/black/dboy

/datum/outfit/job/prisoner/post_equip(mob/living/carbon/human/new_prisoner, visualsOnly)
	. = ..()
	if(!length(SSpersistence.prison_tattoos_to_use) || visualsOnly)
		return
	var/obj/item/bodypart/tatted_limb = pick(new_prisoner.bodyparts)
	var/list/tattoo = pick(SSpersistence.prison_tattoos_to_use)
	tatted_limb.AddComponent(/datum/component/tattoo, tattoo["story"])
	SSpersistence.prison_tattoos_to_use -= tattoo
