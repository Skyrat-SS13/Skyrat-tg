/obj/machinery/biogenerator/medstation
	name = "wall med-station"
	desc = "An advanced machine seen in frontier outposts and colonies capable of turning organic plant matter into \
		various emergency medical supplies and injectors. Doctors love and hate these things, as they provide a reliable \
		source of medical supplies in places where shipments may not be so reliable, but the selection of supplies is quite \
		bare-bones."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/medstation.dmi'
	circuit = null
	anchored = TRUE
	efficiency = 1
	productivity = 2
	show_categories = list(
		RND_CATEGORY_AKHTER_MEDICAL,
		RND_CATEGORY_AKHTER_MEDICAL_INJECTORS,
	)
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/wallframe/cell_charger_multi

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/biogenerator/medstation, 29)

/obj/machinery/biogenerator/medstation/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/biogenerator/medstation/RefreshParts()
	. = ..()
	efficiency = 1
	productivity = 2

/obj/machinery/biogenerator/medstation/default_unfasten_wrench(mob/user, obj/item/wrench/tool, time)
	user.balloon_alert(user, "deconstructing...")
	tool.play_tool_sound(src)
	if(tool.use_tool(src, user, 1 SECONDS))
		playsound(loc, 'sound/items/deconstruct.ogg', 50, TRUE)
		deconstruct(TRUE)
		return

/obj/machinery/cell_charger_multi/wall_mounted/deconstruct(disassembled)
	if(disassembled)
		new repacked_type(drop_location())
	return ..()

/obj/machinery/biogenerator/medstation/default_deconstruction_crowbar()
	return

// Deployable item for cargo for the medstation

/obj/item/wallframe/frontier_medstation
	name = "unmounted wall med-station"
	desc = "The innovative technology of a biogenerator to print medical supplies, but able to be mounted neatly on a wall out of the way!"
	icon = 'modular_skyrat/modules/colony_fabricator/icons/packed_machines.dmi'
	icon_state = "cell_charger_packed"
	w_class = WEIGHT_CLASS_NORMAL
	result_path = /obj/machinery/biogenerator/medstation
	pixel_shift = 29
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT,
	)
