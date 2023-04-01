/obj/item/gun/ballistic
	/// Does this gun have mag and nomag on mob variance?
	var/alt_icons = FALSE
	/// What the icon state is for the on-back guns
	var/alt_icon_state
	/// How long it takes to reload a magazine.
	var/reload_time = 2 SECONDS


/obj/item/gun/ballistic/Initialize(mapload)
	. = ..()

	if(alt_icons)
		AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/gun/ballistic/update_overlays()
	. = ..()
	if(alt_icons)
		if(!magazine)
			if(alt_icon_state)
				inhand_icon_state = "[alt_icon_state]_nomag"
				worn_icon_state = "[alt_icon_state]_nomag"
			else
				inhand_icon_state = "[initial(icon_state)]_nomag"
				worn_icon_state = "[initial(icon_state)]_nomag"
		else
			if(alt_icon_state)
				inhand_icon_state = "[alt_icon_state]"
				worn_icon_state = "[alt_icon_state]"
			else
				inhand_icon_state = "[initial(icon_state)]"
				worn_icon_state = "[initial(icon_state)]"

/obj/item/gun/ballistic/attackby(obj/item/A, mob/user, params)
	. = ..()
	if (.)
		return
	if (!internal_magazine && istype(A, /obj/item/ammo_box/magazine))
		handle_magazine(user, A)
		return
	if (istype(A, /obj/item/ammo_casing) || istype(A, /obj/item/ammo_box))
		if (bolt_type == BOLT_TYPE_NO_BOLT || internal_magazine)
			if (chambered && !chambered.loaded_projectile)
				chambered.forceMove(drop_location())
				chambered = null
			var/num_loaded = magazine?.attackby(A, user, params, TRUE)
			if (num_loaded)
				to_chat(user, span_notice("You load [num_loaded] [cartridge_wording]\s into [src]."))
				playsound(src, load_sound, load_sound_volume, load_sound_vary)
				if (chambered == null && bolt_type == BOLT_TYPE_NO_BOLT)
					chamber_round()
				A.update_appearance()
				update_appearance()
			return
	if(istype(A, /obj/item/suppressor))
		var/obj/item/suppressor/S = A
		if(!can_suppress)
			to_chat(user, span_warning("You can't seem to figure out how to fit [S] on [src]!"))
			return
		if(!user.is_holding(src))
			to_chat(user, span_warning("You need be holding [src] to fit [S] to it!"))
			return
		if(suppressed)
			to_chat(user, span_warning("[src] already has a suppressor!"))
			return
		if(user.transferItemToLoc(A, src))
			to_chat(user, span_notice("You screw [S] onto [src]."))
			install_suppressor(A)
			return
	if (can_be_sawn_off)
		if (sawoff(user, A))
			return

	if(can_misfire && istype(A, /obj/item/stack/sheet/cloth))
		if(guncleaning(user, A))
			return

	return FALSE

/obj/item/gun/ballistic/proc/handle_magazine(mob/user, obj/item/ammo_box/magazine/inserting_magazine)
	if(magazine) // If we already have a magazine inserted, we're going to begin tactically reloading it.
		if(reload_time && !HAS_TRAIT(user, TRAIT_INSTANT_RELOAD)) // Check if we have a reload time to tactical reloading, or if we have the instant reload trait.
			to_chat(user, span_notice("You start to insert the magazine into [src]!"))
			if(!do_after(user, reload_time, src, IGNORE_USER_LOC_CHANGE)) // We are allowed to move while reloading.
				to_chat(user, span_danger("You fail to insert the magazine into [src]!"))
				return
		eject_magazine(user, FALSE, inserting_magazine) // We eject the magazine then insert the new one, while putting the old one in hands.
	else
		insert_magazine(user, inserting_magazine) // Otherwise, just insert it.

//CRATES

//all that shit
/obj/structure/closet/crate/secure/weapon/ww2
	name = "ww2 weapons crate"
	desc = "A secure weapons crate. Looks like it's from the old-era world war 2."
	icon_state = "weaponcrate"

/obj/structure/closet/crate/secure/weapon/ww2/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/fg42(src)
	new /obj/item/ammo_box/magazine/fg42(src)
	new /obj/item/gun/ballistic/automatic/akm(src)
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/gun/ballistic/automatic/m16(src)
	new /obj/item/ammo_box/magazine/m16/vintage(src)
	new /obj/item/gun/ballistic/automatic/mg34(src)
	new /obj/item/ammo_box/magazine/mg34(src)
	new /obj/item/gun/ballistic/automatic/mp40(src)
	new /obj/item/ammo_box/magazine/mp40(src)
	new /obj/item/gun/ballistic/automatic/stg(src)
	new /obj/item/ammo_box/magazine/stg(src)
	new /obj/item/gun/ballistic/automatic/ppsh(src)
	new /obj/item/ammo_box/magazine/ppsh(src)
	new /obj/item/gun/ballistic/automatic/pps(src)
	new /obj/item/ammo_box/magazine/pps(src)
	new /obj/item/gun/ballistic/automatic/mg34/mg42(src)
	new /obj/item/ammo_box/magazine/mg42(src)
	new /obj/item/gun/ballistic/automatic/pistol/luger(src)
	new /obj/item/ammo_box/magazine/m9mm(src)

/obj/effect/temp_visual/dir_setting/firing_effect
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_FIRE
