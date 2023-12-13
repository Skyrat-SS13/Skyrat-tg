/obj/item/storage/belt/holster/pre_attack_secondary(atom/target, mob/living/user, params)
	// Right clicking your holster on a suit-slot piece of clothing will try to fit it for that individual item.
	// This will let you wear it in its suit slot. Foley workaround for mass Initialize() issues. Also, it's kinda cool.
	if (istype(target, /obj/item/clothing/suit))
		var/obj/item/clothing/suit/clothing_to_mod = target
		if (!(/obj/item/storage/belt/holster in clothing_to_mod.allowed))
			user.visible_message(span_notice("[user] begins adjusting [src] to fit properly upon [clothing_to_mod]..."), span_notice("You begin adjusting [src] to fit properly upon [clothing_to_mod]..."))
			if (do_after(user, 5 SECONDS))
				clothing_to_mod.allowed += list(/obj/item/storage/belt/holster)
				playsound(user.loc, 'sound/items/equip/toolbelt_equip.ogg', 50)
				balloon_alert(user, "adjusted to fit!")
			else
				balloon_alert(user, "interrupted!")
		else
			balloon_alert(user, "already adjusted to fit!")
	else
		balloon_alert(user, "can't be adjusted to fit this!")

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/storage/belt/holster/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>right click</b> on a piece of suit-slot clothing with the holster to try and adjust it to fit in its storage slot.")

/obj/item/storage/belt/holster
	// use a pen to rename your holster to something based (or cringe if that's your jam)
	obj_flags = UNIQUE_RENAME
