////////////
///CONDOM///
////////////

//Packaged condom

/obj/item/condom_pack
	name = "condom pack"
	desc = "Don't worry, I have protection."
	icon_state = "condom_pack"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/current_color = "pink"
	var/color_changed = FALSE

/obj/item/condom_pack/Initialize()
	. = ..()
	//color chosen randomly when item spawned
	if(prob(50))
		current_color = "teal"
	else
		current_color = "pink"
	update_icon_state()
	update_icon()

/obj/item/condom_pack/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/condom_pack/attack_self(mob/user)
	to_chat(user, span_notice("You start to open the condom pack..."))
	if(!do_after(user, 15, target = user))
		return
	playsound(src.loc, 'sound/items/poster_ripped.ogg', 50, TRUE)
	var/obj/item/clothing/sextoy/condom/C = new /obj/item/clothing/sextoy/condom

	user.put_in_hands(C)
	switch(current_color)
		if("pink")
			C.current_color = "pink"
		if("teal")
			C.current_color = "teal"
	C.update_icon_state()
	C.update_icon()
	qdel(src)

//Opened condom

/obj/item/clothing/sextoy/condom
	name = "condom"
	desc = "I wonder if I can put this over my head..."
	icon_state = "condom"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY
	var/current_color = "pink"
	var/condom_state = "unused"
	slot_flags = ITEM_SLOT_PENIS

/obj/item/clothing/sextoy/condom/Initialize()
	. = ..()
	update_icon_state()
	update_icon()

/obj/item/clothing/sextoy/condom/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]_[condom_state]"

//to update model properly after use
/obj/item/clothing/sextoy/condom/proc/condom_use()
	switch(condom_state)
		if("used")
			if(prob(10)) //chance of condom to break on first time.
				name = "broken condom"
				condom_state = "broken"
				update_icon_state()
				update_icon()
			else
				name = "used condom"
				condom_state = "dirty"
				update_icon_state()
				update_icon()

		if("dirty")
			name = "broken condom"
			condom_state = "broken"
			update_icon_state()
			update_icon()

//When condom equipped we doing stuff
/obj/item/clothing/sextoy/condom/equipped(mob/user, slot, initial)
	. = ..()
	if(slot == ITEM_SLOT_PENIS && condom_state == "unused")
		condom_state = "used"
		update_icon_state()
		update_icon()
