//The smartdarts themselves
/obj/item/reagent_containers/syringe/smartdart
	name = "medical smartdart"
	desc = "Allows the user to safely inject chemicals at a range without harming the patient."
	volume = 10

//Code that handles the base interactions involving smartdarts
/obj/item/reagent_containers/syringe/smartdart/afterattack(atom/target, mob/user, proximity)
	to_chat(user, span_warning("You cannot directly inject from a smartdart"))
	return
//A majority of this code is from the original syringes.dm file.
/obj/item/reagent_containers/syringe/smartdart/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
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

//The base smartdartgun
/obj/item/gun/syringe/smartdart
	name = "medical smartdart gun"
	desc = "An adjusted version of the medical syringe gun that only allows smartdarts to be chambered."
	w_class = WEIGHT_CLASS_NORMAL //I might need to look into changing this later depending on feedback

/obj/item/gun/syringe/smartdart/Initialize()
	. = ..()
	chambered = new /obj/item/ammo_casing/syringegun/dart(src)

/obj/item/gun/syringe/smartdart/attackby(obj/item/container, mob/user, params, show_msg = TRUE)
	if(istype(container, /obj/item/reagent_containers/syringe/smartdart))
		..()
	else
		to_chat(user, span_notice("[container] is unable to fit inside of the [src]! Try using a smartdart instead."))
		return FALSE

//Smartdart projectiles
/obj/item/ammo_casing/syringegun/dart
	harmful = FALSE
	projectile_type = /obj/projectile/bullet/dart/syringe/dart

/obj/projectile/bullet/dart/syringe/dart
	name = "smartdart"
	damage = 0
	var/is_allergic = FALSE
	var/list/allergyList = list()
	var/prevention_used = FALSE

/obj/projectile/bullet/dart/syringe/dart/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target))
		var/mob/living/carbon/mob = target
		if(blocked != 100) // not completely blocked
			if(mob.can_inject(target_zone = def_zone, injection_flags = inject_flags)) // Pass the hit zone to see if it can inject by whether it hit the head or the body.
				//Checks to see if the target has allergies
				for(var/datum/quirk/quirky as anything in mob.quirks)
					if(istype(quirky, /datum/quirk/item_quirk/allergic))
						var/datum/quirk/item_quirk/allergic/allergies_quirk = quirky
						allergyList = allergies_quirk.allergies
						is_allergic = TRUE
				//The code that handles the actual injections
				for(var/datum/reagent/medicine/meds in reagents.reagent_list)
					if(is_allergic)
						if(!is_type_in_list(meds, allergyList))
							mob.reagents.add_reagent(meds.type, meds.volume)
						else
							prevention_used = TRUE
					else
						mob.reagents.add_reagent(meds.type, meds.volume)
				mob.visible_message(span_notice("[src] embeds itself into [mob]"), span_notice("You feel a small prick as [src] embeds itself into you."))
				if(prevention_used) //Used to signal that allergens were not injected into the target mob.
					mob.visible_message(span_notice("[src] lets out a short beep."), span_notice("You hear a short beep from [src]."))
					playsound(loc, 'sound/machines/ping.ogg', 50, 1, -1)
				return BULLET_ACT_HIT
			else
				blocked = 100
				target.visible_message(span_danger("\The [src] is deflected!"), \
									   span_userdanger("You are protected against \the [src]!"))
	..(target, blocked)
	reagents.flags &= ~(NO_REACT)
	reagents.handle_reactions()
	return BULLET_ACT_HIT
