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
	visible_contents = FALSE
	base_build_path = /obj/machinery/smartfridge/producebin
	use_power = NO_POWER_USE
	light_power = 0
	idle_power_usage = 0
	circuit = null
	has_emissive = FALSE
	can_atmos_pass = ATMOS_PASS_YES
	visible_contents = FALSE

/obj/machinery/smartfridge/producebin/accept_check(obj/item/weapon)
	return (istype(weapon, /obj/item/food/grown))

/obj/machinery/smartfridge/producebin/structure_examine()
	. = ""
	if(anchored)
		. += span_info("It's currently anchored to the floor. It can be [EXAMINE_HINT("wrenched")] loose.")
	else
		. += span_info("It's not anchored to the floor. It can be [EXAMINE_HINT("wrenched")] down.")
	. += span_info("The whole rack can be [EXAMINE_HINT("pried")] apart.")
/obj/machinery/smartfridge/producebin/welder_act(mob/living/user, obj/item/tool)
/obj/machinery/smartfridge/producebin/welder_act_secondary(mob/living/user, obj/item/tool)
/obj/machinery/smartfridge/producebin/default_deconstruction_screwdriver()
/obj/machinery/smartfridge/producebin/exchange_parts()
/obj/machinery/smartfridge/producebin/on_deconstruction()
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
/obj/machinery/smartfridge/producebin/crowbar_act(mob/living/user, obj/item/tool)
	. = TOOL_ACT_TOOLTYPE_SUCCESS

	default_deconstruction_crowbar(tool, ignore_panel = TRUE)

/obj/machinery/smartfridge/seedshelf
	name = "Seedshelf"
	desc = "A wooden shelf, used to hold seeds preventing them from germinating early."
	icon_state = "seedshelf"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	visible_contents = FALSE
	base_build_path = /obj/machinery/smartfridge/seedshelf
	use_power = NO_POWER_USE
	light_power = 0
	idle_power_usage = 0
	circuit = null
	has_emissive = FALSE
	can_atmos_pass = ATMOS_PASS_YES
	visible_contents = FALSE

/obj/machinery/smartfridge/seedshelf/accept_check(obj/item/weapon)
	return istype(weapon, /obj/item/seeds)

/obj/machinery/smartfridge/seedshelf/structure_examine()
	. = ""
	if(anchored)
		. += span_info("It's currently anchored to the floor. It can be [EXAMINE_HINT("wrenched")] loose.")
	else
		. += span_info("It's not anchored to the floor. It can be [EXAMINE_HINT("wrenched")] down.")
	. += span_info("The whole rack can be [EXAMINE_HINT("pried")] apart.")
/obj/machinery/smartfridge/seedshelf/welder_act(mob/living/user, obj/item/tool)
/obj/machinery/smartfridge/seedshelf/welder_act_secondary(mob/living/user, obj/item/tool)
/obj/machinery/smartfridge/seedshelf/default_deconstruction_screwdriver()
/obj/machinery/smartfridge/seedshelf/exchange_parts()
/obj/machinery/smartfridge/seedshelf/on_deconstruction()
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
/obj/machinery/smartfridge/seedshelf/crowbar_act(mob/living/user, obj/item/tool)
	. = TOOL_ACT_TOOLTYPE_SUCCESS

	default_deconstruction_crowbar(tool, ignore_panel = TRUE)
