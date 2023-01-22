/datum/corporate_diplomat_role/nanotrasen_consultant
	title = JOB_NT_REP
	description = "Represent Nanotrasen on the station, argue with the HoS about why he can't just field execute people for petty theft, get drunk in your office."
	department_head = list(JOB_CENTCOM)
	supervisors = "Central Command"
	departments_list = list(
		/datum/job_department/central_command,
	)

	outfit = /datum/outfit/job/nanotrasen_consultant
	plasmaman_outfit = /datum/outfit/plasmaman/nanotrasen_consultant
	department_for_prefs = /datum/job_department/captain

	display_order = JOB_DISPLAY_ORDER_NANOTRASEN_CONSULTANT

	family_heirlooms = list(
		/obj/item/book/manual/wiki/security_space_law,
	)

	mail_goodies = list(
		/obj/item/clothing/mask/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/cup/glass/bottle/champagne = 10
	)

	/*alt_titles = list(
		"Nanotrasen Consultant",
		"Nanotrasen Diplomat",
		"Central Command Consultant",
		"Nanotrasen Representative",
		"Central Command Representative"
	)*/

	used_access = ACCESS_CENT_GENERAL
