#define MODE_ENERGY	"energy"
#define MODE_BALLISTICS "ballistic"
#define MODE_WELDER "welder"
#define MODE_MECH "mech"
#define MODE_OFF "off"

/obj/item/gun/ballistic
	var/has_ammo_display = FALSE //Does this gun have an ammo display on it? No? Okay don't show the ammo hud.

//GUI toggles - NEEDS TO BE SIGNALS
/*
/obj/item/gun/Initialize()
	. = ..()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/user = loc
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		hud.turn_on()
*/


//GUNS
/obj/item/gun/ballistic/Initialize()
	. = ..()
	if(has_ammo_display)
		empty_alarm = TRUE

/obj/item/gun/update_overlays()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/user = src.loc
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		hud.handle()
	. = ..()

/obj/item/gun/pickup(mob/user)
	. = ..()
	if(ishuman(user))
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		hud.turn_on()

/obj/item/gun/dropped(mob/user)
	. = ..()
	if(ishuman(user))
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		hud.turn_off()

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	if(ishuman(user))
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		hud.turn_on()

//WELDER
/obj/item/weldingtool/update_overlays()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/user = src.loc
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		hud.handle()
	. = ..()

/obj/item/weldingtool/pickup(mob/user)
	. = ..()
	if(ishuman(user))
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		hud.turn_on()

/obj/item/weldingtool/dropped(mob/user)
	. = ..()
	if(ishuman(user))
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		hud.turn_off()

/obj/item/weldingtool/equipped(mob/user, slot, initial)
	. = ..()
	if(ishuman(user))
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		hud.turn_on()

/*shitcode
/obj/item/weldingtool/process()
	if(ishuman(src.loc))
		var/mob/living/carbon/human/user = src.loc
		var/obj/screen/ammo_counter/hud = user.hud_used.ammo_counter
		to_chat(src.loc, "CHECK WELDER PROCESS")
		to_chat(hud)
		hud.handle()
	..()
*/

//HUMAN

//Ammo counter
/obj/screen/ammo_counter
	name = "ammo counter"
	icon = 'modular_skyrat/modules/gunhud/icons/hud/gun_hud.dmi'
	icon_state = ""
	screen_loc = ui_ammocounter
	invisibility = 0
	var/status = FALSE
	var/mode
	var/backing_color = COLOR_RED
	var/oth_backing = "oth_light"
	var/oth_o
	var/oth_t
	var/oth_h
	var/indicator
	var/active = list(/obj/item/gun/, /obj/item/weldingtool)

/obj/screen/ammo_counter/update_overlays()
	. = ..()
	cut_overlays()
	switch(mode)
		if(MODE_OFF)
			return
		if(MODE_ENERGY)
			return
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

/obj/screen/ammo_counter/proc/turn_off()
	invisibility = INVISIBILITY_ABSTRACT
	status = FALSE
	maptext = null
	mode = MODE_OFF

/obj/screen/ammo_counter/proc/turn_on()
	invisibility = 0
	status = TRUE
	handle()

/obj/screen/ammo_counter/proc/handle()
	if(!status)
		return
	if(isobserver(usr))
		return
	if(!usr.mind)
		return
	if(!usr.hud_used)
		return
	if(!usr.hud_used.ammo_counter)
		return
	maptext = ""
	oth_o = ""
	oth_t = ""
	oth_h = ""
	indicator = ""
	var/helditem = usr.get_active_held_item()
	if(!helditem)
		turn_off()
		return
	if(istype(helditem, /obj/item/gun/ballistic))
		gun_ballistic(helditem)
	if(istype(helditem, /obj/item/gun/energy))
		gun_energy(helditem)
	if(istype(helditem, /obj/item/weldingtool))
		welder(helditem)

//ENERGY GUNS
/obj/screen/ammo_counter/proc/gun_energy(var/obj/item/gun/energy/pew)
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

//BALLISTIC GUNS
/obj/screen/ammo_counter/proc/gun_ballistic(var/obj/item/gun/ballistic/pew)
	if(!istype(pew, /obj/item/gun/ballistic))
		turn_off()
		return
	if(!pew.has_ammo_display)
		turn_off()
		return

	backing_color = COLOR_CYAN

	mode = MODE_BALLISTICS

	icon_state = "backing"

	if(!pew.magazine)
		oth_o = "oe"
		oth_t = "te"
		oth_h = "he"
		indicator = "no_mag"
		update_icon()
		return

	if(!pew.get_ammo())
		oth_o = "oe"
		oth_t = "te"
		oth_h = "he"
		indicator = "empty_flash"
		update_icon()
		return

	if(pew.safety)
		indicator = "safe"
	else if(istype(pew, /obj/item/gun/ballistic/automatic))
		var/obj/item/gun/ballistic/automatic/auto = pew
		if(auto.select > 0)
			indicator = "auto"
		else
			indicator = "semi"
	else
		indicator = "semi"

	var/rounds = num2text(pew.get_ammo(TRUE))

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
	update_icon()

//WELDER
/obj/screen/ammo_counter/proc/welder(var/obj/item/weldingtool/welder)
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

/obj/screen/ammo_counter/proc/mech()

//BALLISTIC GUNS WITH AMMO DISPLAY GO HERE
/obj/item/gun/ballistic/automatic/wt550
	has_ammo_display = TRUE

/obj/item/gun/ballistic/automatic/c20r
	has_ammo_display = TRUE

/obj/item/gun/ballistic/automatic/m90
	has_ammo_display = TRUE

/obj/item/gun/ballistic/automatic/ar
	has_ammo_display = TRUE

/obj/item/gun/ballistic/automatic/sniper_rifle/syndicate
	has_ammo_display = TRUE

/obj/item/gun/ballistic/minigun
	has_ammo_display = TRUE

/obj/item/gun/ballistic/automatic/toy
	has_ammo_display = TRUE

/obj/item/gun/ballistic/automatic/laser
	has_ammo_display = TRUE

/obj/item/gun/ballistic/shotgun/bulldog
	has_ammo_display = TRUE

#undef MODE_ENERGY
#undef MODE_BALLISTICS
#undef MODE_WELDER
#undef MODE_MECH
#undef MODE_OFF
