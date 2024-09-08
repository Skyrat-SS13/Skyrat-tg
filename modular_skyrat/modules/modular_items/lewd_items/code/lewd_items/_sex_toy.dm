/obj/item/clothing/sextoy
	name = "sextoy"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	equip_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg'
	drop_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	/// This is used to decide what lewd slot a toy should be able to be inserted into.
	/// The currently accepted defines are all prefixes with LEWD_SLOT_, and there is one for each lewd organ.
	/// See code/__DEFINES/~skyrat_defines/inventory.dm for the full list.
	var/lewd_slot_flags = NONE
	/// This is to keep track of where we are stored, because sometimes we might want to know that
	var/current_equipped_slot

/**
 * Called after an item is placed in a lewd slot via the interaction menu. This gets called after equipped() does.
 *
 * Use this instead of equipped() when dealing with lewd slots. We really should hook this better into the upstream
 * equip chain but for now this will have to do.
 *
 * Arguments:
 * * user is mob that equipped it
 * * slot(s) that item is equipped to
 * * initial is used to indicate whether or not this is the initial equipment (job datums etc) or just a player doing it
 */
/obj/item/clothing/sextoy/proc/lewd_equipped(mob/living/carbon/human/user, slot, initial)
	SHOULD_CALL_PARENT(TRUE)

	current_equipped_slot = slot

	// Give out actions our item has to people who equip it.
	for(var/datum/action/action as anything in actions)
		give_item_action(action, user)

/obj/item/clothing/sextoy/dropped(mob/user)
	..()

	update_appearance()
	if(!ishuman(loc))
		return

	var/mob/living/carbon/human/holder = loc
	holder.update_inv_lewd()
	holder.fan_hud_set_fandom()

// Try to force evacuate it.
/obj/item/clothing/sextoy/moveToNullspace()
	if(!ishuman(loc) || !current_equipped_slot)
		return ..()

	var/mob/living/carbon/human/current_holder = loc

	current_holder.dropItemToGround(src, force = TRUE) // Force is true, cause nodrop shouldn't affect lewd items.
	current_holder.vars[current_equipped_slot] = null
	current_holder.update_inv_lewd()

	return ..()

/// A check to confirm if you can open the toy's color/design radial menu
/obj/item/clothing/sextoy/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

/// Returns if the item is inside a lewd slot.
/obj/item/clothing/sextoy/proc/is_inside_lewd_slot(mob/living/carbon/human/target)
	return (src == target.penis || src == target.vagina || src == target.anus || src == target.nipples)
