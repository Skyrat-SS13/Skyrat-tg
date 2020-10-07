/obj/item/gun/ballistic
	var/has_ammo_display = FALSE //Does this gun have an ammo display on it? No? Okay don't show the ammo hud.

/mob
	var/ammo_counter_status = FALSE //So we know what state the ammo counter is in.

/obj/item/gun/Initialize()
	. = ..()
	if(iscarbon(src.loc))
		var/mob/living/carbon/user = loc
		user.handle_ammo_counter(TRUE, src)

/obj/item/gun/ballistic/Initialize()
	. = ..()
	if(has_ammo_display)
		empty_alarm = TRUE

/obj/item/gun/update_overlays()
	if(iscarbon(src.loc))
		var/mob/living/carbon/user = loc
		user.handle_ammo_counter(TRUE, src)
	. = ..()

/obj/item/gun/pickup(mob/user)
	. = ..()
	user.handle_ammo_counter(TRUE, src)

/obj/item/gun/dropped(mob/user)
	. = ..()
	user.handle_ammo_counter(FALSE, src)

/obj/item/gun/equipped(mob/living/user, slot)
	. = ..()
	user.handle_ammo_counter(TRUE, src)

/mob/proc/handle_ammo_counter(toggle, var/obj/item/gun/pew)
	if(!istype(pew, /obj/item/gun))
		return
	if(mind && hud_used && hud_used.ammo_counter)
		var/obj/screen/ammo_counter/gui = hud_used.ammo_counter
		gui.maptext_width = 40
		if(istype(pew, /obj/item/gun/energy))
			var/obj/item/gun/energy/egun = pew
			if(toggle)
				gui.icon_state = "eammo_counter"
				gui.invisibility = 0
				gui.maptext_x = -8
				var/obj/item/ammo_casing/energy/shot = egun.ammo_type[egun.select]
				var/batt_percent = FLOOR(clamp(egun.cell.charge / egun.cell.maxcharge, 0, 1) * 100, 1)
				var/shot_cost_percent = FLOOR(clamp(shot.e_cost / egun.cell.maxcharge, 0, 1) * 100, 1)
				if(!egun.can_shoot())
					gui.icon_state = "eammo_counter_empty"
					gui.maptext = "<div align='center' valign='middle' style='position:relative'><font color='[COLOR_YELLOW]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div>"
					return
				if(batt_percent <= 25)
					gui.maptext = "<div align='center' valign='middle' style='position:relative'><font color='[COLOR_YELLOW]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div>"
					return
				gui.maptext = "<div align='center' valign='middle' style='position:relative'><font color='[COLOR_VIBRANT_LIME]'><b>[batt_percent]%</b></font><br><font color='[COLOR_CYAN]'>[shot_cost_percent]%</font></div>"
			else
				gui.invisibility = INVISIBILITY_ABSTRACT
				gui.maptext = null
		else if(istype(pew, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/bgun = pew
			if(!bgun.has_ammo_display)
				gui.invisibility = INVISIBILITY_ABSTRACT
				return
			if(toggle)
				if(!bgun.magazine)
					gui.invisibility = 0
					gui.icon_state = "ammo_counter_empty"
					gui.maptext_x = -20
					gui.maptext = "<div align='center' valign='middle' style='position:relative'><font color='[COLOR_YELLOW]'>NO MAG</font></div>"
					return
				var/ammo_percent = (bgun.get_ammo(FALSE) / bgun.magazine.max_ammo) * 100
				var/display_color = COLOR_CYAN
				if(FLOOR(ammo_percent, 1) <= 25)
					display_color = COLOR_YELLOW
				gui.invisibility = 0
				if(!bgun.get_ammo())
					gui.icon_state = "ammo_counter_empty"
					gui.maptext_x = -15
					gui.maptext = "<div align='center' valign='middle' style='position:relative'><font color='[COLOR_YELLOW]'>EMPTY</font></div>"
				else
					gui.icon_state = "ammo_counter"
					if(bgun.get_ammo() > 99 || bgun.magazine.max_ammo > 99)
						gui.maptext_x = -15
					else
						gui.maptext_x = -10
					gui.maptext = "<div align='center' valign='middle' style='position:relative'><font color='[display_color]'>[bgun.get_ammo()]/[bgun.magazine.max_ammo]</font></div>"
			else
				gui.invisibility = INVISIBILITY_ABSTRACT
				gui.maptext = null

var/obj/screen/ammo_counter/Click(location, control, params)
	. = ..()


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
