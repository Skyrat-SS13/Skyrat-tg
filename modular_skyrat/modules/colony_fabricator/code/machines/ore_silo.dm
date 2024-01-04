/obj/machinery/ore_silo/colony_lathe
	name = "colony ore silo"
	desc = "An all-in-one materials management solution. Connects resource-using machines \
		through a network of distribution systems."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/ore_silo.dmi'
	circuit = null
	/// What this unpacks into
	var/unpacked_type = /obj/item/flatpacked_machine/ore_silo

/obj/machinery/ore_silo/colony_lathe/silo_log(obj/machinery/machinery_in_question, action, amount, noun, list/mats)
	. = ..()
	playsound(src, 'sound/machines/beep.ogg', 30, TRUE)

// Item for deploying ore silos
/obj/item/flatpacked_machine/ore_silo
	name = "flat-packed ore silo"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/ore_silo.dmi'
	icon_state = "ore_silo"
	type_to_deploy = /obj/machinery/ore_silo/colony_lathe
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 5,
	)
