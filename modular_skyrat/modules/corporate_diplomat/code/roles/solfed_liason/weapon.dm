#define LOWISH_POWER_THRESHOLD 70
#define LOW_POWER_THRESHOLD 30

/obj/item/gun/ballistic/revolver/rebellion
	name = "\improper Rebellion-5 revolver"
	desc = "A rare prototype model of a no longer produced revolver, it uses a power cell to drive 12mm rounds at high speed."
	icon = 'modular_skyrat/modules/corporate_diplomat/icons/solfed_liaison/rebellion.dmi'
	righthand_file = 'modular_skyrat/modules/corporate_diplomat/icons/solfed_liaison/rebellion_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/corporate_diplomat/icons/solfed_liaison/rebellion_lefthand.dmi'
	icon_state = "rebellion"
	inhand_icon_state = "rebellion"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rebellion
	fire_sound = 'modular_skyrat/modules/corporate_diplomat/sound/revolver_shot.ogg'
	fire_delay = 2.25
	company_flag = COMPANY_REMOVED //:sus:
	/// Ref to the cell that this gun uses (wooo this takes power AND ammo)
	var/obj/item/stock_parts/cell/charge_cell
	/// How much power/shot the gun uses
	var/charge_per_shot = 500
	/// Ref to the mutable appearance of the power cell
	var/mutable_appearance/cell_icon


/obj/item/gun/ballistic/revolver/rebellion/Destroy()
	if(charge_cell)
		QDEL_NULL(charge_cell)

	return ..()


/obj/item/gun/ballistic/revolver/rebellion/examine(mob/user)
	. = ..()

	if(charge_cell)
		. += "[span_info("The cell is currently at: ")][span_boldnotice("[charge_cell.percent()]")][span_info("% power remaining.")]"
		. += span_notice("You can remove the cell with <b>Right Click</b>.")

	else
		. += span_notice("There is a slot for a <b>power cell</b> near the barrel of the gun.")


/obj/item/gun/ballistic/revolver/rebellion/attack_hand_secondary(mob/user, list/modifiers)
	if(charge_cell)
		user.playsound_local(get_turf(src), 'sound/weapons/magout.ogg', 40, TRUE)
		user.put_in_hands(charge_cell)
		charge_cell.update_appearance(UPDATE_ICON)
		charge_cell = null
		balloon_alert(user, "removed cell")
		update_appearance(UPDATE_ICON)

	else
		balloon_alert(user, "no cell to remove")

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN


/obj/item/gun/ballistic/revolver/rebellion/attack_self_secondary(mob/user, modifiers)
	if(charge_cell)
		user.playsound_local(get_turf(src), 'sound/weapons/magout.ogg', 40, TRUE)
		user.put_in_hands(charge_cell)
		charge_cell.update_appearance(UPDATE_ICON)
		charge_cell = null
		balloon_alert(user, "removed cell")
		update_appearance(UPDATE_ICON)

	else
		balloon_alert(user, "no cell to remove")

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN


/obj/item/gun/ballistic/revolver/rebellion/can_trigger_gun(mob/living/user)
	. = ..()
	if(!.)
		return FALSE

	if(!charge_cell)
		balloon_alert(user, "no cell!")
		return FALSE

	if(charge_cell.charge < charge_per_shot)
		balloon_alert(user, "not enough power!")
		return FALSE


/obj/item/gun/ballistic/revolver/rebellion/fire_gun(atom/target, mob/living/user, flag, params)
	. = ..()
	charge_cell.use(charge_per_shot)
	update_appearance(UPDATE_ICON)


/obj/item/gun/ballistic/revolver/rebellion/update_overlays()
	. = ..()

	if(!charge_cell)
		cell_icon = null
		return .

	. += mutable_appearance('modular_skyrat/modules/corporate_diplomat/icons/solfed_liaison/rebellion.dmi', "rebellion_cell")

	var/power_overlay = "cell_max"

	switch(charge_cell.percent())
		if(0)
			power_overlay = "cell_empty"

		if(1 to LOW_POWER_THRESHOLD)
			power_overlay = "cell_low"

		if(LOW_POWER_THRESHOLD + 1 to LOWISH_POWER_THRESHOLD)
			power_overlay = "cell_lowish"

	. += mutable_appearance('modular_skyrat/modules/corporate_diplomat/icons/solfed_liaison/rebellion.dmi', power_overlay)

	return .


/obj/item/gun/ballistic/revolver/rebellion/attackby(obj/item/cell_maybe, mob/user, params)
	if(istype(cell_maybe, /obj/item/stock_parts/cell))
		if(charge_cell)
			balloon_alert(user, "cell already inserted")
			return ..()

		cell_maybe.forceMove(src)
		charge_cell = cell_maybe
		balloon_alert(user, "inserted cell")
		user.playsound_local(get_turf(cell_maybe), 'sound/weapons/magin.ogg', 40, TRUE)
		update_appearance(UPDATE_ICON)

	return ..()


/obj/item/ammo_box/magazine/internal/cylinder/rebellion
	name = "\improper Rebellion-5 cylinder"
	desc = "If you see this, you should call a Bluespace Technician. Unless you're that Bluespace Technician."
	ammo_type = /obj/item/ammo_casing/c12mm
	caliber = CALIBER_12MM
	max_ammo = 5


/obj/item/ammo_box/revolver/rebellion
	name = "\improper Rebellion-5 speedloader"
	desc = "A speedloader for the Rebellion-5 revolver, chambered in 12mm Magnum."
	icon_state = "speedloader"
	ammo_type = /obj/item/ammo_casing/c12mm
	max_ammo = 5
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	caliber = CALIBER_12MM
	start_empty = FALSE

/obj/item/storage/box/gunset/rebellion
	name = "\"Rebellion-5\" supply box"
	desc = "Ideally contains a prototype revolver chambered in 12mm."
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gunset/rebellion/PopulateContents()
	new /obj/item/gun/ballistic/revolver/rebellion(src)
	new /obj/item/ammo_box/revolver/rebellion(src)
	new /obj/item/ammo_box/revolver/rebellion(src)
	new /obj/item/ammo_box/revolver/rebellion(src)
	new /obj/item/stock_parts/cell/upgraded(src) // 5 shots with the base cell

#undef LOWISH_POWER_THRESHOLD
#undef LOW_POWER_THRESHOLD
