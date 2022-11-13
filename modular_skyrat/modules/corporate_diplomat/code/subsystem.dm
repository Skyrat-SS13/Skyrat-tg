/datum/controller/subsystem/job
	/// The role type that was chosen for corporate diplomat
	var/datum/corporate_diplomat_role/corporate_diplomat_type

/datum/job/proc/job_setup()
	return

/datum/job/corporate_diplomat/job_setup()
	var/datum/corporate_diplomat_role/picked_role = pick(subtypesof(/datum/corporate_diplomat_role) - /datum/corporate_diplomat_role/nanotrasen_consultant) //revert when not TMed
	picked_role = new picked_role

	SSjob.corporate_diplomat_type = picked_role.type

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
	job_spawn_title = picked_role.title
	qdel(picked_role)
