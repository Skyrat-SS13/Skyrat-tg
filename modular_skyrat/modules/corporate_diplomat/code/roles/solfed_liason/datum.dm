/datum/corporate_diplomat_role/solfed_liaison
	title = JOB_SOLFED_LIAISON
	description = "Make sure law and order is upheld on the station, tattle on the Head of Security abusing the clown, bore people to death with your ballpoint pen collection."
	department_head = list(
		"Solar Federation",
	)
	supervisors = "Solar Federation"
	departments_list = list(
		/datum/job_department/command,
	)

	outfit = /datum/outfit/job/solfed_liaison
	plasmaman_outfit = /datum/outfit/plasmaman/solfed_liaison
	department_for_prefs = /datum/job_department/captain

	display_order = JOB_DISPLAY_ORDER_SOLFED_LIAISON

	family_heirlooms = list(
		/obj/item/pen/fountain,
		/obj/item/pen/screwdriver,
		/obj/item/pen/survival,
		/obj/item/pen/red,
	) // I WAS NOT LYING ABOUT THE BALLPOINT PEN COLLECTION

	mail_goodies = list(
		/obj/item/storage/fancy/cigarettes/cigpack_robustgold = 15,
		/obj/item/reagent_containers/cup/glass/bottle/champagne = 10,
		/obj/item/clothing/accessory/pocketprotector/full = 10,
	)

	used_access = ACCESS_SOLFED
