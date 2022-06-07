//The SmartDarts themselves
/obj/item/reagent_containers/syringe/smartdart
	name = "SmartDart"
	desc = "Allows the user to safely inject chemicals at a range without harming the patient."
	volume = 10
	icon = 'modular_skyrat/modules/medical/icons/obj/smartdarts.dmi'
	icon_state = "dart_0"
	possible_transfer_amounts = list(1, 2, 5, 10)
	base_icon_state = "dart"

//Code that handles the base interactions involving smartdarts
/obj/item/reagent_containers/syringe/smartdart/afterattack(atom/target, mob/user, proximity)
	if(isliving(target))
		to_chat(user, span_warning("The [src] is unable to manually inject chemicals."))
	return
//A majority of this code is from the original syringes.dm file.
/obj/item/reagent_containers/syringe/smartdart/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	if(!try_syringe(target, user, proximity_flag))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	if(reagents.total_volume >= reagents.maximum_volume)
		to_chat(user, span_notice("[src] is full."))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	if(isliving(target))
		to_chat(user, span_warning("The [src] is unable to take blood."))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	if(!target.reagents.total_volume)
		to_chat(user, span_warning("[target] is empty!"))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	if(!target.is_drawable(user))
		to_chat(user, span_warning("You cannot directly remove reagents from [target]!"))
		return SECONDARY_ATTACK_CONTINUE_CHAIN

	var/trans = target.reagents.trans_to(src, amount_per_transfer_from_this, transfered_by = user) // transfer from, transfer to - who cares?
	to_chat(user, span_notice("You fill [src] with [trans] units of the solution. It now contains [reagents.total_volume] units."))

	return SECONDARY_ATTACK_CONTINUE_CHAIN

//The base smartdartgun
/obj/item/gun/syringe/smartdart
	name = "medical SmartDart gun"
	desc = "An adjusted version of the medical syringe gun that only allows SmartDarts to be chambered."
	w_class = WEIGHT_CLASS_NORMAL //I might need to look into changing this later depending on feedback
	icon = 'modular_skyrat/modules/medical/icons/obj/dartguns.dmi'
	icon_state = "smartdartgun"
	has_gun_safety = TRUE
	item_flags = null

/obj/item/gun/syringe/smartdart/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/syringegun/dart(src)

/obj/item/gun/syringe/smartdart/attackby(obj/item/container, mob/user, params, show_msg = TRUE)
	if(istype(container, /obj/item/reagent_containers/syringe/smartdart))
		..()
	else
		to_chat(user, span_notice("The [container] is unable to fit inside of the [src]! Try using a <b>SmartDart</b> instead."))
		return FALSE

/obj/item/gun/syringe/smartdart/examine(mob/user)
	. = ..()

	for(var/obj/item/reagent_containers/syringe/dart as anything in syringes)
		. += "There is a [dart] loaded."

//Smartdart projectiles
/obj/item/ammo_casing/syringegun/dart
	harmful = FALSE
	projectile_type = /obj/projectile/bullet/dart/syringe/dart

/obj/projectile/bullet/dart/syringe/dart
	name = "SmartDart"
	damage = 0
	//A list used to store to store the allergns of the target, so that it can be compared with later.
	var/list/allergy_list = list()
	///Is allergy prevention used?
	var/prevention_used = FALSE
	///List containing chemicals that Smartdarts can Inject.
	var/list/allowed_medicine = list(
		/datum/reagent/medicine,
		/datum/reagent/vaccine
	)
        ///Blacklist that contains medicines that SmartDarts are unable to inject.
	var/list/disallowed_medicine = list(
		/datum/reagent/inverse/,
		/datum/reagent/medicine/morphine,
	)

/obj/projectile/bullet/dart/syringe/dart/on_hit(atom/target, blocked = FALSE)
	if(!iscarbon(target))
		..(target, blocked)
		reagents.flags &= ~(NO_REACT)
		reagents.handle_reactions()
		return BULLET_ACT_HIT

	var/mob/living/carbon/injectee = target
	if(!injectee.can_inject(target_zone = def_zone, injection_flags = inject_flags)) // if the syringe is blocked
		blocked = 100
	if(blocked == 100)
		target.visible_message(span_danger("\The [src] is deflected!"),
							span_userdanger("You are protected against \the [src]!"))
		return

	//Checks for allergies, and saves allergies to a list if they are present
	for(var/datum/quirk/quirky as anything in injectee.quirks)
		if(!istype(quirky, /datum/quirk/item_quirk/allergic))
			continue
		var/datum/quirk/item_quirk/allergic/allergies_quirk = quirky
		allergy_list = allergies_quirk.allergies

	//Variable that handles storage of chemical temperature
	var/chemical_temp = reagents.chem_temp

	//The code that handles the actual injections
	for(var/datum/reagent/meds in reagents.reagent_list)
		//Variable to store OD threshold (If present)
		var/overdose_amount
		//Amount of chemicals to inject, Changes if OD is present
		var/inject_amount = meds.volume

		if(meds.overdose_threshold > 0)
			overdose_amount = meds.overdose_threshold

			//This is mostly here for chemicals that have a low enough OD that an entire dart could trigger it
			if(inject_amount >= overdose_amount)
				inject_amount = overdose_amount

			for(var/datum/reagent/injectee_chemical in injectee.reagents.reagent_list)
				if(istype(injectee_chemical, meds))
					inject_amount = overdose_amount - injectee_chemical.volume

			inject_amount = inject_amount - 2 //This is here to give a bit of a buffer. If this is not here, the overdose prevention will fail to work.

			if(inject_amount <= 0)
				continue

		if(!is_type_in_list(meds, allowed_medicine))
			continue
		if(is_type_in_list(meds, disallowed_medicine))
			continue
		if(is_type_in_list(meds, allergy_list))
			prevention_used = TRUE
		else
			injectee.reagents.add_reagent(meds.type, inject_amount, null, chemical_temp, meds.purity)

	injectee.visible_message(span_notice("[src] embeds itself into [injectee]"), span_notice("You feel a small prick as [src] embeds itself into you."))
	if(prevention_used) //Used to signal that allergens were not injected into the target mob.
		injectee.visible_message(span_notice("[src] lets out a short beep."), span_notice("You hear a short beep from [src]."))
		playsound(loc, 'sound/machines/ping.ogg', 50, 1, -1)
	return BULLET_ACT_HIT

