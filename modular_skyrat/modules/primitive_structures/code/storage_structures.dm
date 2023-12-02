// Wooden shelves that force items placed on them to be visually placed them

/obj/structure/rack/wooden
	name = "shelf"
	icon_state = "shelf_wood"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	flags_1 = NODECONSTRUCT_1

/obj/structure/rack/wooden/MouseDrop_T(obj/object, mob/user, params)
	. = ..()
	var/list/modifiers = params2list(params)
	if(!LAZYACCESS(modifiers, ICON_X) || !LAZYACCESS(modifiers, ICON_Y))
		return

	object.pixel_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size / 3), world.icon_size / 3)
	object.pixel_y = text2num(LAZYACCESS(modifiers, ICON_Y)) > 16 ? 10 : -4

/obj/structure/rack/wooden/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/clay(drop_location(), 5)
	deconstruct(TRUE)
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/structure/rack/wooden/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 2)
	return ..()

// Barrel but it works like a crate

/obj/structure/closet/crate/wooden/storage_barrel
	name = "storage barrel"
	desc = "This barrel can't hold liquids, it can just hold things inside of it however!"
	icon_state = "barrel"
	base_icon_state = "barrel"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	flags_1 = NODECONSTRUCT_1

/obj/structure/closet/crate/wooden/storage_barrel/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/clay(drop_location(), 5)
	deconstruct(TRUE)
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/structure/closet/crate/wooden/storage_barrel/deconstruct(disassembled = TRUE)
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 4)
	return ..()

/obj/machinery/smartfridge/producebin
	name = "Produce Bin"
	desc = "A wooden hamper, used to hold plant products and try keep them safe from pests."
	icon_state = "producebin"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	base_build_path = /obj/machinery/smartfridge/producebin
	contents_icon_state = "produce"
	use_power = NO_POWER_USE
	light_power = 0
	idle_power_usage = 0
	circuit = null
	has_emissive = FALSE
	can_atmos_pass = ATMOS_PASS_YES
	visible_contents = TRUE

/obj/machinery/smartfridge/producebin/accept_check(obj/item/weapon)
	return (istype(weapon, /obj/item/food/grown))

/obj/machinery/smartfridge/producebin/structure_examine()
	. = span_info("The whole rack can be [EXAMINE_HINT("pried")] apart.")


/obj/machinery/smartfridge/producebin/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	deconstruct(TRUE)
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/machinery/smartfridge/seedshelf
	name = "Seedshelf"
	desc = "A wooden shelf, used to hold seeds preventing them from germinating early."
	icon_state = "seedshelf"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	base_build_path = /obj/machinery/smartfridge/seedshelf
	contents_icon_state = "seed"
	use_power = NO_POWER_USE
	light_power = 0
	idle_power_usage = 0
	circuit = null
	has_emissive = FALSE
	can_atmos_pass = ATMOS_PASS_YES
	visible_contents = TRUE

/obj/machinery/smartfridge/seedshelf/accept_check(obj/item/weapon)
	return istype(weapon, /obj/item/seeds)

/obj/machinery/smartfridge/seedshelf/structure_examine()
	. = span_info("The whole rack can be [EXAMINE_HINT("pried")] apart.")

/obj/machinery/smartfridge/seedshelf/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	deconstruct(TRUE)
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/machinery/smartfridge/rationshelf
	name = "Ration shelf"
	desc = "A wooden shelf, used to store food... preferably preserved."
	icon_state = "rationshelf"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	base_build_path = /obj/machinery/smartfridge/rationshelf
	contents_icon_state = "ration"
	use_power = NO_POWER_USE
	light_power = 0
	idle_power_usage = 0
	circuit = null
	has_emissive = FALSE
	can_atmos_pass = ATMOS_PASS_YES
	visible_contents = TRUE

/obj/machinery/smartfridge/rationshelf/accept_check(obj/item/weapon)
	return (IS_EDIBLE(weapon) || (istype(weapon,/obj/item/reagent_containers/cup/bowl) && length(weapon.reagents?.reagent_list)))

/obj/machinery/smartfridge/rationshelf/structure_examine()
	. = span_info("The whole rack can be [EXAMINE_HINT("pried")] apart.")

/obj/machinery/smartfridge/rationshelf/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	deconstruct(TRUE)
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/machinery/smartfridge/producedisplay
	name = "Produce display"
	desc = "A wooden table with awning, used to display produce items."
	icon_state = "producedisplay"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	base_build_path = /obj/machinery/smartfridge/producedisplay
	contents_icon_state = "nonfood"
	use_power = NO_POWER_USE
	light_power = 0
	idle_power_usage = 0
	circuit = null
	has_emissive = FALSE
	can_atmos_pass = ATMOS_PASS_YES
	visible_contents = TRUE

/obj/machinery/smartfridge/producedisplay/accept_check(obj/item/weapon)
	return (istype(weapon, /obj/item/grown) || istype(weapon, /obj/item/bouquet) || istype(weapon, /obj/item/clothing/head/costume/garland))

/obj/machinery/smartfridge/producedisplay/structure_examine()
	. = span_info("The whole rack can be [EXAMINE_HINT("pried")] apart.")

/obj/machinery/smartfridge/producedisplay/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	deconstruct(TRUE)
	return TOOL_ACT_TOOLTYPE_SUCCESS
