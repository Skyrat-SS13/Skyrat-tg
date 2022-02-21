/obj/item/reagent_containers/syringe/dart
	name = "medical smartdart"
	desc = "allows the user to safely inject chemicals at a range without harming the patient"
	volume = 10

/obj/item/reagent_containers/syringe/dart/afterattack(atom/target, mob/user, proximity)
	to_chat(user, span_warning("You cannot directly inject from a smartdart"))
	return
//A majority of this code is from the original syringes.dm file.
/obj/item/reagent_containers/syringe/dart/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	if(!try_syringe(target, user, proximity_flag))
		return SECONDARY_ATTACK_CONTINUE_CHAIN
	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("[src] is full."))
		return SECONDARY_ATTACK_CONTINUE_CHAIN
	if(isliving(target))
		to_chat(user, span_warning("You are unable to take blood with a smartdart"))
		return SECONDARY_ATTACK_CONTINUE_CHAIN
	else
		if(!target.reagents.total_volume)
			to_chat(user, span_warning("[target] is empty!"))
			return SECONDARY_ATTACK_CONTINUE_CHAIN
		if(!target.is_drawable(user))
			to_chat(user, span_warning("You cannot directly remove reagents from [target]!"))
			return SECONDARY_ATTACK_CONTINUE_CHAIN
		var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user) // transfer from, transfer to - who cares?
		to_chat(user, span_notice("You fill [src] with [trans] units of the solution. It now contains [reagents.total_volume] units."))

	return SECONDARY_ATTACK_CONTINUE_CHAIN

