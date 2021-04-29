/obj/item/weldingtool_electric
	name = "electrical welding tool"
	desc = "An experimental welding tool capable of creating a flame using electricity."
	icon = 'modular_skyrat/modules/aesthetics/tools/tools.dmi'
	icon_state = "elwelder"
	inhand_icon_state = "elwelder"
	worn_icon_state = "welder"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	flags_1 = CONDUCT_1
	slot_flags = ITEM_SLOT_BELT
	force = 3
	throwforce = 5
	hitsound = "swing_hit"
	usesound = list('sound/items/welder.ogg', 'sound/items/welder2.ogg')
	drop_sound = 'sound/items/handling/weldingtool_drop.ogg'
	pickup_sound =  'sound/items/handling/weldingtool_pickup.ogg'
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_HALOGEN
	light_on = FALSE
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 30)
	resistance_flags = FIRE_PROOF
	tool_behaviour = NONE
	toolspeed = 0.2
	power_use_amount = POWER_CELL_USE_LOW
	var/cell_override = /obj/item/stock_parts/cell/high
	var/powered = FALSE

/obj/item/weldingtool_electric/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/cell, cell_override, CALLBACK(src, .proc/turn_off))
	AddElement(/datum/element/update_icon_updates_onmob)
	AddElement(/datum/element/tool_flash, light_range)

/obj/item/weldingtool_electric/attack_self(mob/user, modifiers)
	. = ..()
	if(!powered)
		if(!(item_use_power(power_use_amount, user, TRUE) & COMPONENT_POWER_SUCCESS))
			return
	powered = !powered
	playsound(src, 'sound/effects/sparks4.ogg', 100, TRUE)
	if(powered)
		to_chat(user, "<span class='notice'>You turn [src] on.</span>")
		turn_on()
	else
		to_chat(user, "<span class='notice'>You turn [src] off.</span>")
		turn_off()


/obj/item/weldingtool_electric/proc/turn_off()
	powered = FALSE
	light_on = FALSE
	force = initial(force)
	damtype = BRUTE
	set_light_on(powered)
	tool_behaviour = NONE
	update_appearance()
	STOP_PROCESSING(SSobj, src)

/obj/item/weldingtool_electric/proc/turn_on()
	tool_behaviour = TOOL_WELDER
	light_on = TRUE
	force = 15
	damtype = BURN
	set_light_on(powered)
	update_appearance()
	START_PROCESSING(SSobj, src)

/obj/item/weldingtool_electric/process(delta_time)
	if(!powered)
		turn_off()
		return
	if(!(item_use_power(power_use_amount) & COMPONENT_POWER_SUCCESS))
		turn_off()
		return

/obj/item/weldingtool_electric/update_overlays()
	. = ..()
	if(powered)
		. += mutable_appearance('modular_skyrat/modules/aesthetics/tools/tools.dmi', "elwelder_on")

/obj/item/weldingtool_electric/examine()
	. = ..()
	. += "[src] is currently [powered ? "powered" : "unpowered"]." //SKYRAT EDIT ADDITION

/obj/item/weldingtool_electric/update_icon_state()
	if(powered)
		inhand_icon_state = "[initial(inhand_icon_state)]1"
	else
		inhand_icon_state = "[initial(inhand_icon_state)]"
	return ..()

// Disabled cause it's broke as shit
/* /datum/design/exwelder
	name = "Electrical Welding Tool"
	desc = "An experimental welding tool capable of creating a flame using electricity."
	id = "exwelder"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000, /datum/material/glass = 500, /datum/material/plasma = 1500, /datum/material/uranium = 200)
	build_path = /obj/item/weldingtool_electric
	category = list("Tool Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE | DEPARTMENTAL_FLAG_ENGINEERING */
