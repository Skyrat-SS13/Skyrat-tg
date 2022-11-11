// Unfortunately the diplomat gets its own bit of snowflake code
/*datum/controller/subsystem/job/SetupOccupations()
	. = ..()
	var/datum/job/corporate_diplomat/diplomat_datum = SSjob.type_occupations[/datum/job/corporate_diplomat]
	var/datum/corporate_diplomat_role/picked_role = pick(subtypesof(/datum/corporate_diplomat_role))
	picked_role = new picked_role
	name_occupations.Remove(JOB_CORPORATE_DIPLOMAT)
	name_occupations[picked_role.title] = diplomat_datum

	diplomat_datum.title = picked_role.title
	diplomat_datum.description = picked_role.description
	diplomat_datum.department_head = picked_role.department_head.Copy()
	diplomat_datum.supervisors = picked_role.supervisors
	diplomat_datum.selection_color = picked_role.selection_color
	diplomat_datum.department_for_prefs = picked_role.department_for_prefs
	diplomat_datum.departments_list = picked_role.departments_list.Copy()
	diplomat_datum.outfit = picked_role.outfit
	diplomat_datum.plasmaman_outfit = picked_role.plasmaman_outfit
	diplomat_datum.display_order = picked_role.display_order
	diplomat_datum.family_heirlooms = picked_role.family_heirlooms.Copy()
	diplomat_datum.mail_goodies = picked_role.mail_goodies.Copy()
	qdel(picked_role)*/

/datum/job/proc/job_setup()
	return

/datum/job/corporate_diplomat/job_setup()
	var/datum/corporate_diplomat_role/picked_role = pick(subtypesof(/datum/corporate_diplomat_role))
	picked_role = new picked_role

	title = picked_role.title
	description = picked_role.description
	department_head = picked_role.department_head.Copy()
	supervisors = picked_role.supervisors
	selection_color = picked_role.selection_color
	department_for_prefs = picked_role.department_for_prefs
	departments_list = picked_role.departments_list.Copy()
	outfit = picked_role.outfit
	plasmaman_outfit = picked_role.plasmaman_outfit
	display_order = picked_role.display_order
	family_heirlooms = picked_role.family_heirlooms.Copy()
	mail_goodies = picked_role.mail_goodies.Copy()
	alt_titles = picked_role.alt_titles.Copy()
	qdel(picked_role)
