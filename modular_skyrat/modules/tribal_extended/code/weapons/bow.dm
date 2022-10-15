/obj/item/gun/ballistic/tribalbow
	name = "wooden bow"
	desc = "Some sort of primitive projectile weapon used to fire arrows."
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	lefthand_file = 'modular_skyrat/modules/tribal_extended/icons/bows_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/tribal_extended/icons/bows_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/tribal_extended/icons/back.dmi'
	inhand_icon_state = "bow"
	icon_state = "bow"
	worn_icon_state = "bow"
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY //need both hands to fire
	force = 8
	mag_type = /obj/item/ammo_box/magazine/internal/bow
	fire_sound = 'modular_skyrat/modules/tribal_extended/sound/sound_weapons_bowfire.ogg'
	slot_flags = ITEM_SLOT_BACK
	item_flags = NEEDS_PERMIT
	casing_ejector = FALSE
	internal_magazine = TRUE
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL //so ashwalkers can use it
	has_gun_safety = FALSE

/obj/item/gun/ballistic/tribalbow/shoot_with_empty_chamber()
	return

/obj/item/gun/ballistic/tribalbow/chamber_round(keep_bullet = FALSE, spin_cylinder, replace_new_round)
	chambered = magazine.get_round(1)

/obj/item/gun/ballistic/tribalbow/process_chamber()
	chambered = null
	magazine.get_round(0)
	update_icon()

/obj/item/gun/ballistic/tribalbow/attack_self(mob/living/user)
	if (chambered)
		var/obj/item/ammo_casing/AC = magazine.get_round(0)
		user.put_in_hands(AC)
		chambered = null
		to_chat(user, span_notice("You gently release the bowstring, removing the arrow."))
	else if (get_ammo())
		var/obj/item/I = user.get_active_held_item()
		if (do_mob(user,I,10))
			to_chat(user, span_notice("You draw back the bowstring."))
			playsound(src, 'modular_skyrat/modules/tribal_extended/sound/sound_weapons_bowdraw.ogg', 75, 0) //gets way too high pitched if the freq varies
			chamber_round()
	update_icon()

/obj/item/gun/ballistic/tribalbow/attackby(obj/item/I, mob/user, params)
	if (magazine.attackby(I, user, params, 1))
		to_chat(user, span_notice("You notch the arrow."))
		update_icon()

/obj/item/gun/ballistic/tribalbow/update_icon()
	. = ..()
	icon_state = "[initial(icon_state)]_[get_ammo() ? (chambered ? "firing" : "loaded") : "unloaded"]"

/obj/item/gun/ballistic/tribalbow/can_shoot()
	return chambered

/obj/item/gun/ballistic/tribalbow/ashen
	name = "bone bow"
	desc = "Some sort of primitive projectile weapon made of bone and wrapped sinew, oddly robust."
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	icon_state = "ashenbow"
	inhand_icon_state = "ashenbow"
	worn_icon_state = "ashenbow"
	force = 12

/obj/item/gun/ballistic/tribalbow/pipe
	name = "pipe bow"
	desc = "Portable and sleek, but you'd be better off hitting someone with a pool noodle."
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	icon_state = "pipebow"
	inhand_icon_state = "pipebow"
	worn_icon_state = "pipebow"
	force = 3
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
