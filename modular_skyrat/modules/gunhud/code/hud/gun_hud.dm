/obj/item/gun/afterattack(atom/target, mob/living/user, flag, params)
	user.handle_ammo_counter(TRUE, src)
	..()

/obj/item/gun/pickup(mob/user)
	. = ..()
	visible_message("<span class='warning'>[user] picks up the [src]!</span>")
	user.handle_ammo_counter(TRUE, src)

/obj/item/gun/dropped(mob/user)
	. = ..()
	user.handle_ammo_counter(FALSE, src)


/mob/proc/handle_ammo_counter(toggle, var/obj/item/gun/pew)
	if(!istype(pew, /obj/item/gun))
		return

	if(mind && hud_used && hud_used.ammo_counter)
		if(istype(pew, /obj/item/gun/energy))
			var/obj/item/gun/energy/egun = pew
			if(toggle)
				hud_used.ammo_counter.invisibility = 0
				var/charges = CEILING(clamp(egun.cell.charge / egun.cell.maxcharge, 0, 1) * 4, 1)
				hud_used.ammo_counter.icon_state = "ecounter_[charges]"
			else
				hud_used.ammo_counter.invisibility = INVISIBILITY_ABSTRACT

		else if(istype(pew, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/bgun = pew
			if(toggle)
				hud_used.ammo_counter.invisibility = 0
				hud_used.ammo_counter.maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:8px'><font color='#f5f7b3'>[bgun.get_ammo()]</font></div>"
			else
				hud_used.ammo_counter.invisibility = INVISIBILITY_ABSTRACT
