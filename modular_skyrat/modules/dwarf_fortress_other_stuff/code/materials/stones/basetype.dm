GLOBAL_LIST_INIT(dwarf_brick_recipes, list(
	new /datum/stack_recipe( \
	"brick wall", \
	/obj/structure/window/fulltile/material, \
	req_amount = 1, \
	res_amount = 1, \
	time = 3 SECONDS, \
	one_per_turf = TRUE, \
	on_solid_ground = FALSE, \
	applies_mats = TRUE \
	), \
))

/datum/material/dwarf_certified/rock
	name = "generic rock"
	desc = "Hey... you shouldn't see this!"

	color = "#ffffff"
	greyscale_colors = "#ffffff"

	sheet_type = /obj/item/stack/dwarf_certified/rock

	strength_modifier = 1
	integrity_modifier = 1
	armor_modifiers = list(MELEE = 0.7, BULLET = 0.7, LASER = 1, ENERGY = 1, BOMB = 0.5, BIO = 1, FIRE = 1, ACID = 1)

	// wood is 0.1, diamond is 0.3, iron is 0
	beauty_modifier = 0.1

	item_sound_override = null
	turf_sound_override = FOOTSTEP_FLOOR

/obj/item/stack/dwarf_certified/rock
	name = "generic boulder"
	singular_name = "generic boulder"

	desc = "Strange... Maybe you shouldn't be seeing this."

	icon_state = "chunk"

	inhand_icon_state = "stonelike"

	merge_type = /obj/item/stack/dwarf_certified/rock

	mats_per_unit = list(/datum/material/dwarf_certified/rock = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock

	max_amount = 1

	// What this boulder cuts into when a chisel or pickaxe is used on it
	var/cut_type = /obj/item/stack/dwarf_certified/brick

/obj/item/stack/dwarf_certified/rock/examine()
	. = ..()
	. += span_notice("With a <b>chisel</b> or even a <b>pickaxe</b> of some kind, you could cut this into <b>blocks</b>.")

/obj/item/stack/dwarf_certified/rock/attackby(obj/item/attacking_item, mob/user, params)
	if((attacking_item.tool_behaviour != TOOL_MINING) && !(istype(attacking_item, /obj/item/chisel)))
		return ..()
	playsound(src, 'sound/effects/picaxe1.ogg', 50, TRUE)
	balloon_alert_to_viewers("cutting...")
	if(!do_after(user, 2 SECONDS, target = src))
		balloon_alert_to_viewers("stopped cutting")
		return FALSE
	new cut_type(get_turf(src), amount)
	qdel(src)

/obj/item/stack/dwarf_certified/brick
	name = "generic brick"
	singular_name = "generic brick"

	desc = "Strange... Maybe you shouldn't be seeing this."

	icon_state = "block"

	inhand_icon_state = "barlike"

	merge_type = /obj/item/stack/dwarf_certified/brick

	mats_per_unit = list(/datum/material/dwarf_certified/rock = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock

	max_amount = 6 // Blocks are so much easier to store and move around, don't you know?

/obj/item/stack/dwarf_certified/brick/get_main_recipes()
	. = ..()
	. += GLOB.dwarf_brick_recipes

/turf/closed/wall/mineral/stone/material
	name = "brick wall"
	desc = "A wall made of solid bricks."
	sheet_type = null
	custom_materials = null
	baseturfs = /turf/baseturf_bottom
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
