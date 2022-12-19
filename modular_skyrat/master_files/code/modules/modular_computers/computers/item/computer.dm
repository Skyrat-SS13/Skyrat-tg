/obj/item/modular_computer
	/// The passport that is contained in the computer, if any.
	var/obj/item/passport/passport_slot

/**
 * Removes the passport from the computer, and puts it in loc's hand if it's a mob
 * Args:
 * * user - The mob trying to remove the passport, if there is one
 */
/obj/item/modular_computer/proc/remove_passport(mob/user)
	if(!passport_slot)
		return FALSE

	if(user)
		if(!issilicon(user) && in_range(src, user))
			user.put_in_hands(passport_slot)
		balloon_alert(user, "removed passport")
	else
		passport_slot.forceMove(drop_location())

	passport_slot = null
	playsound(src, 'sound/machines/card_slide.ogg', 50, FALSE)

	update_slot_icon()
	update_appearance()
	return TRUE

/**
 * insert_passport
 * Attempt to insert the passport in its slot.
 * Args:
 * * inserting_passport - the passport being inserted
 * * user - The person inserting the passport
 */
/obj/item/modular_computer/proc/insert_passport(obj/item/passport/inserting_passport, mob/user)
	//slot taken
	if(passport_slot)
		return FALSE

	passport_slot = inserting_passport
	if(user)
		if(!user.transferItemToLoc(inserting_passport, src))
			return FALSE
		balloon_alert(user, "inserted passport")
	else
		inserting_passport.forceMove(src)

	playsound(src, 'sound/machines/card_slide.ogg', 50, FALSE)

	update_appearance()
	update_slot_icon()
	return TRUE

/obj/item/modular_computer/attackby(obj/item/attacking_item, mob/user, params)
	if(ispassport(attacking_item) && insert_passport(attacking_item, user))
		return

	return ..()
