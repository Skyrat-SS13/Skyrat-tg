/**
 * Checks is the parent mob is currently off duty. Returns `FALSE` if the mob isn't clocked out.
 *
 * Arguements
 * * `whitelisted_deparments` - This list contains the paths of `/datum/job_department`s we want to check if the parent mob is part of.
 * If present, we will only check if the mob is off-duty if they are a member of one of the departments in the list
 * Otherwise, if we have nothing in the list, we will check all departments
 * * `blacklisted_jobs` - This is a list that contains paths of the `/datum/job`s that we will always return `TRUE` for
 * This typically applies for jobs like assistant where clock status probably wouldn't really matter.
*/

/mob/living/carbon/human/proc/check_if_off_duty(list/whitelisted_deparments = list(), list/blacklisted_jobs = list(/datum/job/assistant))
	if(!mind?.assigned_role)
		return TRUE //If someone lacks a job or mind, we probably don't need to worry about their clock status.

	var/datum/job/job_datum = mind.assigned_role
	if(!istype(job_datum))
		return TRUE

	var/need_to_check = FALSE
	if(length(whitelisted_deparments))
		for(var/department as anything in whitelisted_deparments)
			if(is_path_in_list(department, job_datum.departments_list))
				need_to_check = TRUE

	if(blacklisted_jobs && need_to_check)
		if(is_path_in_list(job_datum, blacklisted_jobs))
			need_to_check = FALSE

	if(!need_to_check)
		return TRUE

	return mind.clocked_out_of_job

/obj/item/duty_checker //Test item
	name = "duty checker"
	desc = "Checks if the mob this is used on is off-duty. You probably shouldn't see this in-game..."
	icon = 'icons/obj/devices/remote.dmi'
	icon_state = "gangtool-purple"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	inhand_icon_state = "electronic"

/obj/item/duty_checker/attack(mob/living/carbon/human/target_human, mob/living/user, params)
	. = ..()
	if(!istype(target_human))
		return FALSE

	if(target_human.check_if_off_duty(list(/datum/job_department/security)))
		to_chat(user, span_notice("[target_human] is off-duty!"))
		return TRUE

	to_chat(user, span_notice("[target_human] is not off-duty!"))
	return FALSE
