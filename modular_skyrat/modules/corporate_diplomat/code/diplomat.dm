/datum/job/corporate_diplomat
	// Things that generally |shouldn't| be overridden by role datums
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	minimal_player_age = 14
	exp_requirements = 600
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "CORPORATE_DIPLOMAT"
	department_for_prefs = /datum/job_department/captain
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_CMD
	bounty_types = CIV_JOB_SEC
	veteran_only = TRUE
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS


	// Things that probably will be overridden
	supervisors = "Central Command"
	selection_color = "#c6ffe0"
	title = JOB_CORPORATE_DIPLOMAT
	description = "Represent Nanotrasen on the station, argue with the HoS about why he can't just field execute people for petty theft, get drunk in your office."
	department_head = list(JOB_CENTCOM)
	departments_list = list(
		/datum/job_department/command,
		/datum/job_department/central_command
	)
	outfit = /datum/outfit/job/nanotrasen_consultant
	plasmaman_outfit = /datum/outfit/plasmaman/nanotrasen_consultant
	display_order = JOB_DISPLAY_ORDER_NANOTRASEN_CONSULTANT
	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law)
	mail_goodies = list(
		/obj/item/clothing/mask/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/cup/glass/bottle/champagne = 10
	)

/datum/job/corporate_diplomat/New()
	var/datum/corporate_diplomat_role/picked_role = /datum/corporate_diplomat_role/solfed_liaison //pick(subtypesof(/datum/corporate_diplomat_role) - /datum/corporate_diplomat_role/nanotrasen_consultant) //revert when not TMed
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
	return ..()

// make sure to fill ALL of these out on the subtype
/datum/corporate_diplomat_role
	/// The associated access level with the role
	var/used_access

	// Everything below is mirrored from /datum/job

	var/title
	var/description
	var/list/department_head = list()
	var/supervisors
	var/selection_color
	var/department_for_prefs
	var/list/departments_list = list()
	var/outfit
	var/plasmaman_outfit
	var/display_order
	var/list/family_heirlooms = list()
	var/list/mail_goodies = list()
	var/list/alt_titles = list()

