//USP pistol - Universal Self Protection pistol
/obj/item/gun/ballistic/automatic/pistol/uspm
	name = "USP 9mm"
	desc = "USP - Universal Self Protection. A standard-issue low cost handgun, chambered in 9x19mm and fitted with a smart lock for LTL rounds. You hear the relieved sighs of an entire Security department in the back of your head, each time you pick it up."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/usp/projectile.dmi'
	icon_state = "usp-m"
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/usp/uspshot.ogg'
	mag_type = /obj/item/ammo_box/magazine/usp
	can_suppress = FALSE
	unique_reskin = list("USP Match" = "usp-m",
						"Stealth" = "stealth",
						"P9" = "p9",
						"M92FS" = "beretta")
	obj_flags = UNIQUE_RENAME
	req_access = list(ACCESS_HOS)

/obj/item/gun/ballistic/automatic/pistol/uspm/update_icon()
	..()
	if(current_skin)
		icon_state = "[unique_reskin[current_skin]][chambered ? "" : "-e"]"
	else
		icon_state = "[initial(icon_state)][chambered ? "" : "-e"]"

/obj/item/gun/ballistic/automatic/pistol/uspm/emag_act(mob/user)
	if(magazine)
		var/obj/item/ammo_box/magazine/M = magazine
		M.emag_act(user)

/obj/item/gun/ballistic/automatic/pistol/uspm/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(check_access(A))
		if(magazine)
			magazine.attackby(A, user)

//piss baby usp mag
//i haven't been able to test this shit at ALL so uh
/obj/item/ammo_box/magazine/usp
	name = "USP magazine (9mm rubber)"
	desc = "A magazine for the security USP Match. Security systems lock it to be only able to load rubber 9mm rounds."
	icon = 'modular_skyrat/modules/gunsgalore/icons/ammo/ammo copy.dmi'
	icon_state = "uspm-15"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	caliber = "9mm"
	var/locked = TRUE
	var/can_lock = TRUE
	var/list/accepted_casings = list(/obj/item/ammo_casing/c9mm/rubber)
	max_ammo = 15
	req_access = list(ACCESS_HOS)

/obj/item/ammo_box/magazine/usp/give_round(obj/item/ammo_casing/R, replace_spent)
	. = ..()
	if(locked && !(R.type in accepted_casings))
		return FALSE

/obj/item/ammo_box/magazine/usp/update_icon()
	..()
	icon_state = icon_state = "uspm-[ammo_count() ? "15" : "0"]"

/obj/item/ammo_box/magazine/usp/emag_act(mob/user)
	. = ..()
	if(.)
		to_chat(user, "<span class='notice'>The [src]'s security lock gets fried.</span>")
		ammo_type = /obj/item/ammo_casing/c9mm
		locked = FALSE
		can_lock = FALSE

/obj/item/ammo_box/magazine/usp/attackby(obj/item/A, mob/user, params, silent, replace_spent)
	. = ..()
	if(check_access(A))
		toggle_lock(user)
	else if(istype(A, /obj/item/card))
		to_chat(user, "<span class='warning'>Access denied.</span>")

/obj/item/ammo_box/magazine/usp/proc/toggle_lock(var/mob/living/user)
	if(!can_lock)
		to_chat(user, "<span class='warning'>The [src]'s security lock is fried!</span>")
		return FALSE
	locked = !locked
	if(user)
		if(locked)
			to_chat(user, "<span class='notice'>The [src] is now unable to accept lethal rounds.</span>")
		else
			to_chat(user, "<span class='notice'>The [src] can now accept lethal 9mm rounds.</span>")
	return TRUE

/obj/item/ammo_box/magazine/usp/examine(mob/user)
	. = ..()
	. += "<br><span class='notice'>It is currently <b>[locked ? "locked" : "not locked"]</b> to rubber rounds."
