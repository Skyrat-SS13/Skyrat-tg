// Wooden shelves that force items placed on them to be visually placed them

/obj/structure/rack/wooden
	name = "shelf"
	icon_state = "shelf_wood"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE

/obj/structure/rack/wooden/mouse_drop_receive(atom/movable/object, mob/living/user, params)
	. = ..()
	var/list/modifiers = params2list(params)
	if(!LAZYACCESS(modifiers, ICON_X) || !LAZYACCESS(modifiers, ICON_Y))
		return

	object.pixel_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size / 3), world.icon_size / 3)
	object.pixel_y = text2num(LAZYACCESS(modifiers, ICON_Y)) > 16 ? 10 : -4

/obj/structure/rack/wrench_act_secondary(mob/living/user, obj/item/tool)
	return NONE

/obj/structure/rack/wooden/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 2)
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

// Barrel but it works like a crate

/obj/structure/closet/crate/wooden/storage_barrel
	name = "storage barrel"
	desc = "This barrel can't hold liquids, it can just hold things inside of it however!"
	icon_state = "barrel"
	base_icon_state = "barrel"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	resistance_flags = FLAMMABLE
	material_drop = /obj/item/stack/sheet/mineral/wood
	material_drop_amount = 4
	cutting_tool = /obj/item/crowbar

//Wooden-storage "fridges"

/obj/machinery/smartfridge/wooden
	name = "Debug Wooden Smartfridge"
	desc = "You shouldn't be seeing this!"
	icon = 'modular_skyrat/modules/primitive_structures/icons/storage.dmi'
	icon_state = "producebin"
	base_icon_state = "producebin"
	contents_overlay_icon = "produce"
	resistance_flags = FLAMMABLE
	base_build_path = /obj/machinery/smartfridge/wooden
	use_power = NO_POWER_USE
	light_power = 0
	idle_power_usage = 0
	circuit = null
	has_emissive = FALSE
	can_atmos_pass = ATMOS_PASS_YES
	visible_contents = TRUE

/obj/machinery/smartfridge/wooden/Initialize(mapload)
	. = ..()
	if(type == /obj/machinery/smartfridge/wooden) // don't even let these prototypes exist
		return INITIALIZE_HINT_QDEL

// previously NO_DECONSTRUCTION
/obj/machinery/smartfridge/wooden/default_deconstruction_screwdriver(mob/user, icon_state_open, icon_state_closed, obj/item/screwdriver)
	return NONE

/obj/machinery/smartfridge/wooden/crowbar_act(mob/living/user, obj/item/tool)
	user.balloon_alert_to_viewers("disassembling...")
	if(!tool.use_tool(src, user, 2 SECONDS, volume = 100))
		return
	new /obj/item/stack/sheet/mineral/wood(drop_location(), 10)
	deconstruct(TRUE)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/smartfridge/wooden/structure_examine()
	. = span_info("The whole rack can be [EXAMINE_HINT("pried")] apart.")

/obj/machinery/smartfridge/wooden/produce_bin
	name = "produce bin"
	icon_state = "producebin"
	base_icon_state = "producebin"
	contents_overlay_icon = "produce"
	desc = "A wooden hamper, used to hold plant products and try to keep them safe from pests."
	base_build_path = /obj/machinery/smartfridge/wooden/produce_bin

/obj/machinery/smartfridge/wooden/produce_bin/accept_check(obj/item/weapon)
	if(weapon.w_class >= WEIGHT_CLASS_BULKY)
		return FALSE
	if(IS_EDIBLE(weapon))
		return TRUE
	if(istype(weapon, /obj/item/food/grown) || istype(weapon, /obj/item/grown) || istype(weapon, /obj/item/graft))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/wooden/seed_shelf
	name = "seedshelf"
	desc = "A wooden shelf, used to hold seeds preventing them from germinating early."
	icon_state = "seedshelf"
	base_icon_state = "seedshelf"
	contents_overlay_icon = "seed"
	base_build_path = /obj/machinery/smartfridge/wooden/seed_shelf

/obj/machinery/smartfridge/wooden/seed_shelf/accept_check(obj/item/weapon)
	if(istype(weapon, /obj/item/seeds))
		return TRUE
	return FALSE

/obj/machinery/smartfridge/wooden/ration_shelf
	name = "ration shelf"
	desc = "A wooden shelf, used to store food... preferably preserved."
	icon_state = "seedshelf"
	base_icon_state = "seedshelf"
	contents_overlay_icon = "ration"
	base_build_path = /obj/machinery/smartfridge/wooden/ration_shelf

/obj/machinery/smartfridge/wooden/ration_shelf/accept_check(obj/item/weapon)
	if(weapon.w_class >= WEIGHT_CLASS_BULKY)
		return FALSE
	if(IS_EDIBLE(weapon))
		return TRUE
	if(istype(weapon, /obj/item/reagent_containers/cup/bowl) && weapon.reagents?.total_volume > 0)
		return TRUE
	return FALSE

/obj/machinery/smartfridge/wooden/produce_display
	name = "produce display"
	desc = "A wooden table with awning, used to display produce items."
	icon_state = "producedisplay"
	base_icon_state = "producedisplay"
	contents_overlay_icon = "nonfood"
	base_build_path = /obj/machinery/smartfridge/wooden/produce_display

/obj/machinery/smartfridge/wooden/produce_display/accept_check(obj/item/weapon)
	if(istype(weapon, /obj/item/grown) || istype(weapon, /obj/item/bouquet) || istype(weapon, /obj/item/clothing/head/costume/garland))
		return TRUE
	if(istype(weapon, /obj/item/stack/sheet/cloth)  || istype(weapon, /obj/item/stack/sheet/durathread)  || istype(weapon, /obj/item/stack/sheet/leather))
		return TRUE
	if(istype(weapon, /obj/item/stack/sheet/mineral/wood) || istype(weapon, /obj/item/stack/sheet/mineral/bamboo) || istype(weapon, /obj/item/stack/rods))
		return TRUE
