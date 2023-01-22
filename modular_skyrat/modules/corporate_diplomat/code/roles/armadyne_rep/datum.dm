/datum/corporate_diplomat_role/armadyne_representative
	title = JOB_ARMADYNE_REP
	description = "Look out for the company's interests, sell the HoS an armory, beg for a PMC from corporate when your shoes get stolen."
	department_head = list(
		"Armadyne Corporation",
	)
	supervisors = "Armadyne Corporation"
	departments_list = list(
		/datum/job_department/armadyne_corporation,
	)

	outfit = /datum/outfit/job/armadyne_representative
	plasmaman_outfit = /datum/outfit/plasmaman/armadyne_representative
	department_for_prefs = /datum/job_department/captain

	display_order = JOB_DISPLAY_ORDER_ARMADYNE_REPRESENTATIVE

	family_heirlooms = list(
		/obj/item/clothing/glasses/eyepatch,
	) //find smth better later

	mail_goodies = list(
		/obj/item/clothing/mask/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/cup/glass/bottle/champagne = 10,
	)

	used_access = ACCESS_ARMADYNE
