// base class for any snortable drug item
/obj/item/snortable
	name = "powder"
	desc = "An indescribable powder."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "cocaine"
	/// The reagent contained in the item. Set blank for nothing.
	var/datum/reagent/powder_reagent
	/// How much of the reagent is in the item.
	var/reagent_amount = 0

/obj/item/snortable/Initialize(mapload)
	. = ..()
	create_reagents(reagent_amount)
	if(powder_reagent)
		reagents.add_reagent(powder_reagent, reagent_amount)

/obj/item/snortable/proc/snort(mob/living/user)
	if(!iscarbon(user))
		return
	var/covered = ""
	if(user.is_mouth_covered(ITEM_SLOT_HEAD))
		covered = "headgear"
	else if(user.is_mouth_covered(ITEM_SLOT_MASK))
		covered = "mask"
	if(covered)
		to_chat(user, span_warning("You have to remove your [covered] first!"))
		return
	user.visible_message(span_notice("'[user] starts snorting the [src]."))
	if(do_after(user, 30))
		to_chat(user, span_notice("You finish snorting the [src]."))
		if(reagents.total_volume)
			reagents.trans_to(user, reagents.total_volume, transfered_by = user, methods = INGEST)
		qdel(src)

/obj/item/snortable/attack(mob/target, mob/user)
	if(target == user)
		snort(user)

/obj/item/snortable/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(!in_range(user, src) || user.get_active_held_item())
		return

	snort(user)

	return
