/////////////////////////
//Customizable ammo hud//
/////////////////////////
/atom/movable/screen/ammo_counter
	name = "ammo counter"
	icon = 'modular_skyrat/modules/gunhud/icons/hud/gun_hud.dmi'
	icon_state = "backing"
	screen_loc = ui_ammocounter
	invisibility = INVISIBILITY_ABSTRACT

	var/backing_color = COLOR_RED
	var/oth_backing = "oth_light"
	var/oth_o
	var/oth_t
	var/oth_h
	var/indicator

/atom/movable/screen/ammo_counter/proc/turn_off()
	invisibility = INVISIBILITY_ABSTRACT
	maptext = null

/atom/movable/screen/ammo_counter/proc/turn_on()
	invisibility = 0

/atom/movable/screen/ammo_counter/proc/set_hud(_backing_color, _oth_o, _oth_t, _oth_h, _indicator, _oth_backing = "backing")
	backing_color = _backing_color
	oth_backing = _oth_backing
	oth_o = _oth_o
	oth_t = _oth_t
	oth_h = _oth_h
	indicator = _indicator

	update_overlays()

/atom/movable/screen/ammo_counter/update_overlays()
	. = ..()
	cut_overlays()
	if(oth_backing)
		var/mutable_appearance/oth_backing_overlay = mutable_appearance(icon, oth_backing)
		oth_backing_overlay.color = backing_color
		. += oth_backing_overlay
	if(oth_o)
		var/mutable_appearance/o_overlay = mutable_appearance(icon, oth_o)
		o_overlay.color = backing_color
		. += o_overlay
	if(oth_t)
		var/mutable_appearance/t_overlay = mutable_appearance(icon, oth_t)
		t_overlay.color = backing_color
		. += t_overlay
	if(oth_h)
		var/mutable_appearance/h_overlay = mutable_appearance(icon, oth_h)
		h_overlay.color = backing_color
		. += h_overlay
	if(indicator)
		var/mutable_appearance/indicator_overlay = mutable_appearance(icon, indicator)
		indicator_overlay.color = backing_color
		. += indicator_overlay

/*
//ENERGY GUNS
/atom/movable/screen/ammo_counter/proc/gun_energy(var/obj/item/gun/energy/pew)
	if(!istype(pew, /obj/item/gun/energy))
		return

	cut_overlays()

	icon_state = "eammo_counter"

	maptext_x = -12


	var/obj/item/ammo_casing/energy/shot = pew.ammo_type[pew.select]
	var/batt_percent = FLOOR(clamp(pew.cell.charge / pew.cell.maxcharge, 0, 1) * 100, 1)
	var/shot_cost_percent = FLOOR(clamp(shot.e_cost / pew.cell.maxcharge, 0, 1) * 100, 1)

	if(batt_percent > 99 || shot_cost_percent > 99)
		maptext_x = -12
	else
		maptext_x = -8

	if(!pew.can_shoot())
		icon_state = "eammo_counter_empty"
		maptext = "<span class='maptext'><div align='center' valign='middle' style='position:relative'><font color='[COLOR_RED]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div></span>"
		return

	if(batt_percent <= 25)
		maptext = "<span class='maptext'><div align='center' valign='middle' style='position:relative'><font color='[COLOR_YELLOW]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div></span>"
		return
	maptext = "<span class='maptext'><div align='center' valign='middle' style='position:relative'><font color='[COLOR_VIBRANT_LIME]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div></span>"

//WELDER
/atom/movable/screen/ammo_counter/proc/welder(var/obj/item/weldingtool/welder)
	if(!istype(welder, /obj/item/weldingtool))
		turn_off()
		return

	backing_color = COLOR_TAN_ORANGE

	mode = MODE_WELDER

	icon_state = "backing"

	if(welder.get_fuel() < 1)
		oth_o = "oe"
		oth_t = "te"
		oth_h = "he"
		indicator = "empty_flash"
		update_icon()
		return

	if(welder.welding)
		indicator = "flame_on"
	else
		indicator = "flame_off"

	var/fuel = num2text(welder.get_fuel())
	to_chat(usr, "[fuel]")
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
	update_icon()

*/
