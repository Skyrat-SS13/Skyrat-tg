////////////
///CONDOM///
////////////

//Packaged condom

/obj/item/condom_pack
	name = "condom pack"
	desc = "Don't worry, I have protection."
	icon_state = "condom_pack_pink"
	base_icon_state = "condom_pack"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY
	/// The current color of the condom, can be changed and affects sprite
	var/current_color = "pink"

/obj/item/condom_pack/Initialize(mapload)
	. = ..()
	//color chosen randomly when item spawned
	current_color = "pink"
	if(prob(50))
		current_color = "teal"
	update_icon_state()
	update_icon()

/obj/item/condom_pack/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]"

/obj/item/condom_pack/attack_self(mob/user)
	to_chat(user, span_notice("You start to open the condom pack..."))
	if(!do_after(user, 1.5 SECONDS, target = user))
		return
	conditional_pref_sound(src.loc, 'sound/items/poster_ripped.ogg', 50, TRUE)
	var/obj/item/clothing/sextoy/condom/removed_condom = new /obj/item/clothing/sextoy/condom

	user.put_in_hands(removed_condom)
	switch(current_color)
		if("pink")
			removed_condom.current_color = "pink"
		if("teal")
			removed_condom.current_color = "teal"
	removed_condom.update_icon_state()
	removed_condom.update_icon()
	qdel(src)

//Opened condom

/obj/item/clothing/sextoy/condom
	name = "condom"
	desc = "I wonder if I can put this over my head..."
	icon_state = "condom_pink_unused"
	base_icon_state = "condom"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/current_color = "pink"
	var/condom_state = "unused"
	lewd_slot_flags = LEWD_SLOT_PENIS

/obj/item/clothing/sextoy/condom/Initialize(mapload)
	. = ..()

	if(current_color != "pink" || condom_state != "unused")
		update_icon_state()
		update_icon()

/obj/item/clothing/sextoy/condom/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[current_color]_[condom_state]"

/// Updates the condom's sprite, called after use
/obj/item/clothing/sextoy/condom/proc/condom_use()
	switch(condom_state)
		if("used")
			name = "used condom"
			condom_state = "dirty"
			if(prob(10)) //chance of condom to break on first time.
				name = "broken condom"
				condom_state = TRAIT_CONDOM_BROKEN
			update_icon_state()
			update_icon()

		if("dirty")
			name = "broken condom"
			condom_state = TRAIT_CONDOM_BROKEN
			update_icon_state()
			update_icon()

//When condom equipped we doing stuff
/obj/item/clothing/sextoy/condom/lewd_equipped(mob/user, slot, initial)
	. = ..()
	if((slot == LEWD_SLOT_PENIS) && condom_state == "unused")
		condom_state = "used"
		update_icon_state()
		update_icon()
