/obj/item/straight_razor
	name = "straight razor"
	desc = "A very sharp blade, mostly used for shaving faces..."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "straight_razor"
	force = 12
	throw_speed = 3
	throw_range = 9
	w_class = WEIGHT_CLASS_TINY
	attack_verb_simple = list("cut", "stabbed", "chebbed")
	sharpness = SHARP_EDGED
	hitsound = 'sound/weapons/bladeslice.ogg'
	wound_bonus = 10
	bare_wound_bonus = 15
	tool_behaviour = TOOL_KNIFE
	// How long do we take to shave someone's facial hair?
	var/shaving_time = 10 SECONDS

/obj/item/straight_razor/proc/shave(mob/living/carbon/human/target_human)
	target_human.facial_hairstyle = "Shaved"
	target_human.update_body_parts()
	playsound(loc, 'sound/items/unsheath.ogg', 20, TRUE)

/obj/item/straight_razor/attack(mob/attacked_mob, mob/living/user)
	if(ishuman(attacked_mob))
		var/mob/living/carbon/human/target_human = attacked_mob
		var/location = user.zone_selected
		if(!(location in list(BODY_ZONE_PRECISE_MOUTH)) && !user.combat_mode)
			to_chat(user, span_warning("You stop, look down at what you're currently holding and ponder to yourself, \"This is probably to be used on their facial hair.\""))
			return
		if(location == BODY_ZONE_PRECISE_MOUTH && !target_human.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, span_warning("[target_human] doesn't have a head!"))
			return
		if(location == BODY_ZONE_PRECISE_MOUTH)
			if(!(FACEHAIR in target_human.dna.species.species_traits))
				to_chat(user, span_warning("There is no facial hair to shave!"))
				return
			if(!get_location_accessible(target_human, location))
				to_chat(user, span_warning("The mask is in the way!"))
				return
			if(target_human.facial_hairstyle == "Shaved")
				to_chat(user, span_warning("Already clean-shaven!"))
				return

			var/self_shaving = target_human == user // Shaving yourself?
			user.visible_message(span_notice("[user] starts to shave [self_shaving ? user.p_their() : "[target_human]'s"] facial hair with [src]."), \
				span_notice("You take a moment to shave [self_shaving ? "your" : "[target_human]'s" ] facial hair with [src]..."))
			if(do_after(user, shaving_time, target = target_human))
				user.visible_message(span_notice("[user] shaves [self_shaving ? user.p_their() : "[target_human]'s"] facial hair clean with [src]."), \
					span_notice("You finish shaving[self_shaving ? "" : " [target_human]'s facial hair"] with [src]. Fast and clean!"))
				shave(target_human)

		else
			..()
	else
		..()
