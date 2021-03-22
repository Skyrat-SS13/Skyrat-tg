/datum/component/ammo_hud
	var/atom/movable/screen/ammo_counter/hud

/datum/component/ammo_hud/Initialize()
	. = ..()
	if(!istype(parent, /obj/item/gun) && !istype(parent, /obj/item/weldingtool))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ITEM_EQUIPPED, .proc/wake_up)
	var/obj/item = parent
	if(ismob(item.loc))
		var/mob/user = item.loc
		wake_up(src, user)

/datum/component/ammo_hud/Destroy()
	turn_off()
	return ..()

/datum/component/ammo_hud/proc/wake_up(datum/source, mob/user, slot)
	SIGNAL_HANDLER

	RegisterSignal(parent, list(COMSIG_PARENT_PREQDELETED, COMSIG_ITEM_DROPPED), .proc/turn_off)

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.is_holding(parent))
			hud = H.hud_used.ammo_counter
			turn_on(user)
		else
			turn_off(user)

/datum/component/ammo_hud/proc/turn_on(mob/user)
	SIGNAL_HANDLER

	RegisterSignal(parent, COMSIG_UPDATE_AMMO_HUD, .proc/update_hud)

	hud.turn_on()
	update_hud(user)

/datum/component/ammo_hud/proc/turn_off(mob/user)
	SIGNAL_HANDLER

	UnregisterSignal(parent, list(COMSIG_PARENT_PREQDELETED, COMSIG_ITEM_DROPPED, COMSIG_UPDATE_AMMO_HUD))

	hud.turn_off()
	hud = null

/datum/component/ammo_hud/proc/update_hud()
	if(istype(parent, /obj/item/gun/ballistic))
		var/obj/item/gun/ballistic/pew = parent
		hud.maptext = null
		hud.icon_state = "backing"
		var/backing_color = COLOR_CYAN
		if(!pew.magazine)
			hud.set_hud(backing_color, "oe", "te", "he", "no_mag")
			return
		if(!pew.get_ammo())
			hud.set_hud(backing_color, "oe", "te", "he", "empty_flash")
			return
		if(pew.safety)
			hud.set_hud(backing_color, "oe", "te", "he", "safe")
			return
		var/indicator = "auto"
		var/rounds = num2text(pew.get_ammo(TRUE))
		var/oth_o
		var/oth_t
		var/oth_h
		switch(length(rounds))
			if(1)
				oth_o = "o[rounds[1]]"
			if(2)
				oth_o = "o[rounds[2]]"
				oth_t = "t[rounds[1]]"
			if(3)
				oth_o = "o[rounds[3]]"
				oth_t = "t[rounds[2]]"
				oth_h = "h[rounds[1]]"
			else
				oth_o = "o9"
				oth_t = "t9"
				oth_h = "h9"
		hud.set_hud(backing_color, oth_o, oth_t, oth_h, indicator)

	else if(istype(parent, /obj/item/gun/energy))
		var/obj/item/gun/energy/pew = parent
		hud.icon_state = "eammo_counter"
		hud.cut_overlays()
		hud.maptext_x = -12
		var/obj/item/ammo_casing/energy/shot = pew.ammo_type[pew.select]
		var/batt_percent = FLOOR(clamp(pew.cell.charge / pew.cell.maxcharge, 0, 1) * 100, 1)
		var/shot_cost_percent = FLOOR(clamp(shot.e_cost / pew.cell.maxcharge, 0, 1) * 100, 1)
		if(batt_percent > 99 || shot_cost_percent > 99)
			hud.maptext_x = -12
		else
			hud.maptext_x = -8
		if(!pew.can_shoot())
			hud.icon_state = "eammo_counter_empty"
			hud.maptext = "<span class='maptext'><div align='center' valign='middle' style='position:relative'><font color='[COLOR_RED]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div></span>"
			return
		if(batt_percent <= 25)
			hud.maptext = "<span class='maptext'><div align='center' valign='middle' style='position:relative'><font color='[COLOR_YELLOW]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div></span>"
			return
		hud.maptext = "<span class='maptext'><div align='center' valign='middle' style='position:relative'><font color='[COLOR_VIBRANT_LIME]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div></span>"

	else if(istype(parent, /obj/item/weldingtool))
		var/obj.item/weldingtool/welder = parent
		hud.maptext = null
		var/backing_color = COLOR_TAN_ORANGE
		hud.icon_state = "backing"

		if(welder.get_fuel() < 1)
			hud.set_hud(backing_color, "oe", "te", "he", "empty_flash")
			return

		var/indicator
		var/fuel = num2text(welder.get_fuel())
		var/oth_o
		var/oth_t
		var/oth_h

		if(welder.welding)
			indicator = "flame_on"
		else
			indicator = "flame_off"

		fuel = num2text(welder.get_fuel())

		switch(length(fuel))
			if(1)
				oth_o = "o[fuel[1]]"
			if(2)
				oth_o = "o[fuel[2]]"
				oth_t = "t[fuel[1]]"
			if(3)
				oth_o = "o[fuel[3]]"
				oth_t = "t[fuel[2]]"
				oth_h = "h[fuel[1]]"
			else
				oth_o = "o9"
				oth_t = "t9"
				oth_h = "h9"
		hud.set_hud(backing_color, oth_o, oth_t, oth_h, indicator)

/obj/item/gun/ballistic
	var/has_ammo_display = FALSE

/obj/item/gun/ballistic/automatic
	has_ammo_display = TRUE

/obj/item/gun/ballistic/shotgun/bulldog
	has_ammo_display = TRUE

/obj/item/gun/ballistic/ComponentInitialize()
	. = ..()
	if(has_ammo_display)
		AddComponent(/datum/component/ammo_hud)

/obj/item/gun/energy/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ammo_hud)

/obj/item/weldingtool/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/ammo_hud)
