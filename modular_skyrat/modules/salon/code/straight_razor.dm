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

/obj/item/straight_razor/proc/shave(mob/living/carbon/human/H)
	H.facial_hairstyle = "Shaved"
	H.update_hair()
	playsound(loc, 'sound/items/unsheath.ogg', 20, TRUE)

/obj/item/straight_razor/attack(mob/M, mob/living/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		var/location = user.zone_selected
		if(location == BODY_ZONE_PRECISE_MOUTH && !H.get_bodypart(BODY_ZONE_HEAD))
			to_chat(user, span_warning("[H] doesn't have a head!"))
			return
		if(location == BODY_ZONE_PRECISE_MOUTH)
			if(!(FACEHAIR in H.dna.species.species_traits))
				to_chat(user, span_warning("There is no facial hair to shave!"))
				return
			if(!get_location_accessible(H, location))
				to_chat(user, span_warning("The mask is in the way!"))
				return
			if(H.facial_hairstyle == "Shaved")
				to_chat(user, span_warning("Already clean-shaven!"))
				return

			if(H == user) //shaving yourself
				user.visible_message(span_notice("[user] starts to shave [user.p_their()] facial hair with [src]."), \
					span_notice("You take a moment to shave your facial hair with [src]..."))
				if(do_after(user, 10 SECONDS, target = H))
					user.visible_message(span_notice("[user] shaves [user.p_their()] facial hair clean with [src]."), \
						span_notice("You finish shaving with [src]. Fast and clean!"))
					shave(H)
			else
				user.visible_message(span_warning("[user] tries to shave [H]'s facial hair with [src]."), \
					span_notice("You start shaving [H]'s facial hair..."))
				if(do_after(user, 10 SECONDS, target = H))
					user.visible_message(span_warning("[user] shaves off [H]'s facial hair with [src]."), \
						span_notice("You shave [H]'s facial hair clean off."))
					shave(H)
		else
			..()
	else
		..()
