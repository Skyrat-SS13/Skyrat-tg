// No, I am not making this a subtype of card_slot. TG modular computer code is arcane to me, and I am *not* treading on it.
// Also, passports are somewhat different from IDs code wise.
/obj/item/computer_hardware/passport_slot
	name = "passport reader module" // \improper breaks the find_hardware_by_name proc
	desc = "A module allowing this computer to read or write data on passports. Necessary for some programs to run properly."
	power_usage = 10 //W
	icon_state = "card_mini"
	w_class = WEIGHT_CLASS_TINY
	device_type = MC_PASSPORT
	expansion_hw = TRUE

	var/obj/item/passport/stored_passport

///What happens when the ID card is removed (or deleted) from the module, through try_eject() or not.
/obj/item/computer_hardware/passport_slot/Exited(atom/movable/gone, direction)
	if(stored_passport == gone)
		stored_passport = null
		if(holder)
			if(holder.active_program)
				holder.active_program.event_idremoved(0)
			for(var/p in holder.idle_threads)
				var/datum/computer_file/program/computer_program = p
				computer_program.event_idremoved(1)

			holder.update_slot_icon()

			if(ishuman(holder.loc))
				var/mob/living/carbon/human/human_wearer = holder.loc
				if(human_wearer.wear_id == holder)
					human_wearer.sec_hud_set_ID()
	return ..()

/obj/item/computer_hardware/passport_slot/Destroy()
	if(stored_passport) //If you didn't expect this behavior for some dumb reason, do something different instead of directly destroying the slot
		QDEL_NULL(stored_passport)
	return ..()

/obj/item/computer_hardware/passport_slot/try_insert(obj/item/I, mob/living/user = null)
	if(!holder)
		return FALSE

	if(!ispassport(I))
		return FALSE

	if(stored_passport)
		return FALSE

	// item instead of player is checked so telekinesis will still work if the item itself is close
	if(!in_range(src, I))
		return FALSE

	if(user)
		if(!user.transferItemToLoc(I, src))
			return FALSE
	else
		I.forceMove(src)

	stored_passport = I
	to_chat(user, span_notice("You insert \the [I] into \the [expansion_hw ? "secondary":"primary"] [src]."))
	playsound(src, 'sound/machines/card_slide.ogg', 50, FALSE)
	holder.update_appearance()

	return TRUE


/obj/item/computer_hardware/passport_slot/try_eject(mob/living/user = null, forced = FALSE)
	if(!stored_passport)
		to_chat(user, span_warning("There are no cards in \the [src]."))
		return FALSE

	SpinAnimation()

	if(user && !issilicon(user) && in_range(src, user))
		user.put_in_hands(stored_passport)
	else
		stored_passport.forceMove(drop_location())

	to_chat(user, span_notice("You remove the card from \the [src]."))
	playsound(src, 'sound/machines/card_slide.ogg', 50, FALSE)
	holder.update_appearance()

	stored_passport = null

	return TRUE

/obj/item/computer_hardware/passport_slot/screwdriver_act(mob/living/user, obj/item/tool)
	if(stored_passport)
		to_chat(user, span_notice("You press down on the manual eject button with [tool]."))
		try_eject(user)
		return TOOL_ACT_TOOLTYPE_SUCCESS
	return ..()

/obj/item/computer_hardware/passport_slot/examine(mob/user)
	. = ..()
	. += "The connector is set to fit into a computer's expansion bay."
	if(stored_passport)
		. += "There appears to be something loaded in the passport slot. Use a screwdriver to remove it."

// Passport slot
/datum/design/passport_slot
	name = "Passport Slot"
	id = "passport_slot"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 600)
	build_path = /obj/item/computer_hardware/passport_slot
	category = list(
		RND_CATEGORY_MODULAR_COMPUTERS + RND_SUBCATEGORY_MODULAR_COMPUTERS_PARTS
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SERVICE
