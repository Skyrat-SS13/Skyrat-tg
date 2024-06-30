// Like the power drill, except no speed buff but has wirecutters as well? Just trust me on this one.

/obj/item/screwdriver/omni_drill
	name = "powered driver"
	desc = "The ultimate in multi purpose construction tools. With heads for wire cutting, bolt driving, and driving \
		screws, what's not to love? Well, the slow speed. Compared to other power drills these tend to be \
		<b>not much quicker than unpowered tools</b>."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "drill"
	belt_icon_state = null
	inhand_icon_state = "drill"
	worn_icon_state = "drill"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT * 1.5,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	force = 10
	throwforce = 8
	throw_speed = 2
	throw_range = 3
	attack_verb_continuous = list("drills", "screws", "jabs", "whacks")
	attack_verb_simple = list("drill", "screw", "jab", "whack")
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 1
	random_color = FALSE
	greyscale_config = null
	greyscale_config_belt = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	/// Used on Initialize, how much time to cut cable restraints and zipties.
	var/snap_time_weak_handcuffs = 0 SECONDS
	/// Used on Initialize, how much time to cut real handcuffs. Null means it can't.
	var/snap_time_strong_handcuffs = null

/obj/item/screwdriver/omni_drill/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/item/screwdriver/omni_drill/get_all_tool_behaviours()
	return list(TOOL_WIRECUTTER, TOOL_SCREWDRIVER, TOOL_WRENCH)

/obj/item/screwdriver/omni_drill/examine(mob/user)
	. = ..()
	. += span_notice("Use <b>in hand</b> to switch configuration.\n")
	. += span_notice("It functions as a <b>[tool_behaviour]</b> tool.")

/obj/item/screwdriver/omni_drill/update_icon_state()
	. = ..()
	switch(tool_behaviour)
		if(TOOL_SCREWDRIVER)
			icon_state = initial(icon_state)
		if(TOOL_WRENCH)
			icon_state = "[initial(icon_state)]_bolt"
		if(TOOL_WIRECUTTER)
			icon_state = "[initial(icon_state)]_cut"

/obj/item/screwdriver/omni_drill/attack_self(mob/user, modifiers)
	. = ..()
	if(!user)
		return
	var/list/tool_list = list(
		"Screwdriver" = image(icon = icon, icon_state = "drill"),
		"Wrench" = image(icon = icon, icon_state = "drill_bolt"),
		"Wirecutters" = image(icon = icon, icon_state = "drill_cut"),
	)
	var/tool_result = show_radial_menu(user, src, tool_list, custom_check = CALLBACK(src, PROC_REF(check_menu), user), require_near = TRUE, tooltips = TRUE)
	if(!check_menu(user) || !tool_result)
		return
	RemoveElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
	switch(tool_result)
		if("Wrench")
			tool_behaviour = TOOL_WRENCH
			sharpness = NONE
		if("Wirecutters")
			tool_behaviour = TOOL_WIRECUTTER
			sharpness = NONE
			AddElement(/datum/element/cuffsnapping, snap_time_weak_handcuffs, snap_time_strong_handcuffs)
		if("Screwdriver")
			tool_behaviour = TOOL_SCREWDRIVER
			sharpness = SHARP_POINTY
	playsound(src, 'sound/items/change_drill.ogg', 50, vary = TRUE)
	update_appearance(UPDATE_ICON)

/obj/item/screwdriver/omni_drill/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

// Just a completely normal crowbar except its normal sized

/obj/item/crowbar/large/doorforcer
	name = "prybar"
	desc = "A large, sturdy crowbar, painted orange. Nothing special, or unique about it. Waste of money, honestly."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "prybar"
	toolspeed = 1.3
	force_opens = FALSE
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 1.75,
		/datum/material/titanium = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/crowbar/large/doorforcer/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// Backpackable mining drill

/obj/item/pickaxe/drill/compact
	name = "compact mining drill"
	desc = "A powered mining drill, it drills all over the place. Compact enough to hopefully fit in a backpack."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "drilla"
	worn_icon_state = "drill"
	w_class = WEIGHT_CLASS_NORMAL
	toolspeed = 0.6
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/pickaxe/drill/compact/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// Electric welder but not quite as strong

/obj/item/weldingtool/electric/arc_welder
	name = "arc welding tool"
	desc = "A specialized welding tool utilizing high powered arcs of electricity to weld things together. \
		Compared to other electrically-powered welders, this model is slow and highly power inefficient, \
		but it still gets the job done and chances are you printed this bad boy off for free."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/tools.dmi'
	icon_state = "arc_welder"
	usesound = 'modular_skyrat/modules/colony_fabricator/sound/arc_welder/arc_welder.ogg'
	light_range = 2
	light_power = 0.75
	toolspeed = 1
	power_use_amount = POWER_CELL_USE_INSANE

/obj/item/weldingtool/electric/arc_welder/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
