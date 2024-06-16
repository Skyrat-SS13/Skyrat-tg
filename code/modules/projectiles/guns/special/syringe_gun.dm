/obj/item/gun/syringe
	name = "medical syringe gun"
	desc = "A spring loaded gun designed to fit syringes, used to incapacitate unruly patients from a distance."
	icon = 'icons/obj/weapons/guns/syringegun.dmi'
	icon_state = "medicalsyringegun"
	lefthand_file = 'icons/mob/inhands/weapons/64x_guns_left.dmi'
	righthand_file = 'icons/mob/inhands/weapons/64x_guns_right.dmi'
	inhand_icon_state = "medicalsyringegun"
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	worn_icon_state = null
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throw_speed = 3
	throw_range = 7
	force = 6
	base_pixel_x = -4
	pixel_x = -4
	custom_materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT)
	clumsy_check = FALSE
	fire_sound = 'sound/items/syringeproj.ogg'
	var/load_sound = 'sound/weapons/gun/shotgun/insert_shell.ogg'
	var/list/syringes = list()
	var/max_syringes = 1 ///The number of syringes it can store.
	var/has_syringe_overlay = TRUE ///If it has an overlay for inserted syringes. If true, the overlay is determined by the number of syringes inserted into it.
	gun_flags = NOT_A_REAL_GUN

/obj/item/gun/syringe/Initialize(mapload)
	. = ..()
	chambered = new /obj/item/ammo_casing/syringegun(src)
	recharge_newshot()

/obj/item/gun/syringe/apply_fantasy_bonuses(bonus)
	. = ..()
	max_syringes = modify_fantasy_variable("max_syringes", max_syringes, bonus, minimum = 1)

/obj/item/gun/syringe/remove_fantasy_bonuses(bonus)
	max_syringes = reset_fantasy_variable("max_syringes", max_syringes)
	return ..()

/obj/item/gun/syringe/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone in syringes)
		syringes -= gone

/obj/item/gun/syringe/recharge_newshot()
	if(!syringes.len)
		return
	//SKYRAT EDIT SMARTDARTS
	if(istype(syringes[length(syringes)], /obj/item/reagent_containers/syringe/smartdart))
		chambered.newshot(/obj/projectile/bullet/dart/syringe/dart)
	else
		chambered.newshot()
	//SKYRAT EDIT SMARTDARTS END

/obj/item/gun/syringe/can_shoot()
	return syringes.len

/obj/item/gun/syringe/handle_chamber()
	if(chambered && !chambered.loaded_projectile) //we just fired
		recharge_newshot()
	update_appearance()

/obj/item/gun/syringe/examine(mob/user)
	. = ..()
	. += "Can hold [max_syringes] syringe\s. Has [syringes.len] syringe\s remaining."

/obj/item/gun/syringe/attack_self(mob/living/user)
	if(!syringes.len)
		balloon_alert(user, "it's empty!")
		return FALSE

	var/obj/item/reagent_containers/syringe/S = syringes[syringes.len]

	if(!S)
		return FALSE
	user.put_in_hands(S)

	syringes.Remove(S)
	balloon_alert(user, "[S.name] unloaded")
	update_appearance()

	return TRUE

/obj/item/gun/syringe/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/reagent_containers/syringe/bluespace))
		balloon_alert(user, "[tool.name] is too big!")
		return ITEM_INTERACT_BLOCKING
	if(istype(tool, /obj/item/reagent_containers/syringe))
		if(syringes.len < max_syringes)
			if(!user.transferItemToLoc(tool, src))
				return ITEM_INTERACT_BLOCKING
			balloon_alert(user, "[tool.name] loaded")
			syringes += tool
			recharge_newshot()
			update_appearance()
			playsound(src, load_sound, 40)
			return ITEM_INTERACT_SUCCESS
		balloon_alert(user, "it's full!")
		return ITEM_INTERACT_BLOCKING
	return NONE

/obj/item/gun/syringe/update_overlays()
	. = ..()
	if(!has_syringe_overlay)
		return
	var/syringe_count = syringes.len
	. += "[initial(icon_state)]_[syringe_count ? clamp(syringe_count, 1, initial(max_syringes)) : "empty"]"

/obj/item/gun/syringe/rapidsyringe
	name = "compact rapid syringe gun"
	desc = "A modification of the syringe gun design to be more compact and use a rotating cylinder to store up to six syringes."
	icon_state = "rapidsyringegun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "syringegun"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	worn_icon_state = "gun"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	base_pixel_x = 0
	pixel_x = 0
	max_syringes = 6
	force = 4

/obj/item/gun/syringe/syndicate
	name = "dart pistol"
	desc = "A small spring-loaded sidearm that functions identically to a syringe gun."
	icon_state = "dartsyringegun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "gun" //Smaller inhand
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	worn_icon_state = "gun"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_BELT
	base_pixel_x = 0
	pixel_x = 0
	force = 2 //Also very weak because it's smaller
	suppressed = TRUE //Softer fire sound
	can_unsuppress = FALSE //Permanently silenced
	syringes = list(new /obj/item/reagent_containers/syringe())

/obj/item/gun/syringe/dna
	name = "modified compact syringe gun"
	desc = "A syringe gun that has been modified to be compact and fit DNA injectors instead of normal syringes."
	icon_state = "dnasyringegun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "syringegun"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	worn_icon_state = "gun"
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	base_pixel_x = 0
	pixel_x = 0
	force = 4

/obj/item/gun/syringe/dna/Initialize(mapload)
	. = ..()
	chambered = new /obj/item/ammo_casing/dnainjector(src)

/obj/item/gun/syringe/dna/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/dnainjector))
		var/obj/item/dnainjector/D = tool
		if(D.used)
			balloon_alert(user, "[D.name] is used up!")
			return ITEM_INTERACT_BLOCKING
		if(syringes.len < max_syringes)
			if(!user.transferItemToLoc(D, src))
				return ITEM_INTERACT_BLOCKING
			balloon_alert(user, "[D.name] loaded")
			syringes += D
			recharge_newshot()
			update_appearance()
			playsound(loc, load_sound, 40)
			return ITEM_INTERACT_SUCCESS
		balloon_alert(user, "it's already full!")
		return ITEM_INTERACT_BLOCKING
	return NONE

/obj/item/gun/syringe/blowgun
	name = "blowgun"
	desc = "Fire syringes at a short distance."
	icon = 'icons/obj/weapons/guns/ballistic.dmi'
	icon_state = "blowgun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	inhand_icon_state = "blowgun"
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	worn_icon_state = "gun"
	has_syringe_overlay = FALSE
	fire_sound = 'sound/items/syringeproj.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT
	base_pixel_x = 0
	pixel_x = 0
	force = 4
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/gun/syringe/blowgun/process_fire(atom/target, mob/living/user, message = TRUE, params = null, zone_override = "", bonus_spread = 0)
	visible_message(span_danger("[user] shoots the blowgun!"))

	user.adjustStaminaLoss(20, updating_stamina = FALSE)
	user.adjustOxyLoss(20)
	return ..()
