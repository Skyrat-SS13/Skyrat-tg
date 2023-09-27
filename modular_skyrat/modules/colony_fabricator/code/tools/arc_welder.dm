/obj/item/arc_welder
	name = "arc welding tool"
	desc = "A specialized welding tool utilizing high powered arcs of electricity to weld things together. \
		Specialized is an important word here, these are <b>incapable of some welding tasks</b> due to how they \
		operate. So what are the upsides? \
		Due to a closed loop power cycler, the welder requires <b>no power or fuel</b> to \
		function. Just be sure to use the tool once every decade or it'll explode."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "arc_welder"
	inhand_icon_state = "exwelder"
	worn_icon_state = "exwelder"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 5
	throwforce = 5
	hitsound = SFX_SWING_HIT
	usesound = list(
		'modular_skyrat/modules/colony_fabricator/sound/arc_furnace/arc_furnace_mid_1.wav',
		'modular_skyrat/modules/colony_fabricator/sound/arc_furnace/arc_furnace_mid_2.wav',
		'modular_skyrat/modules/colony_fabricator/sound/arc_furnace/arc_furnace_mid_3.wav',
		'modular_skyrat/modules/colony_fabricator/sound/arc_furnace/arc_furnace_mid_4.wav',
	)
	drop_sound = 'sound/items/handling/weldingtool_drop.ogg'
	pickup_sound = 'sound/items/handling/weldingtool_pickup.ogg'
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 0.75
	light_color = LIGHT_COLOR_HALOGEN
	light_on = FALSE
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	armor_type = /datum/armor/item_weldingtool
	resistance_flags = FIRE_PROOF
	heat = 3800
	tool_behaviour = TOOL_WELDER
	toolspeed = 1.2
	custom_materials = list(
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/plasma =HALF_SHEET_MATERIAL_AMOUNT * 1.5,
	)

/obj/item/arc_welder/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/tool_flash, light_range)
	AddElement(/datum/element/falling_hazard, damage = force, wound_bonus = wound_bonus, hardhat_safety = TRUE, crushes = FALSE, impact_sound = hitsound)
