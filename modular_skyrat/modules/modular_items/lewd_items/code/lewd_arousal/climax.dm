

/datum/mood_event/orgasm
	description = span_purple("Woah... This pleasant tiredness... I love it.\n")
	timeout = 5 MINUTES

/datum/mood_event/climaxself
	description = span_purple("I just came in my own underwear. Messy.\n")
	timeout = 4 MINUTES

/datum/mood_event/overgasm
	description = span_warning("Uhh... I don't want to be horny anymore.\n") //Me too, buddy. Me too.
	timeout = 10 MINUTES

/mob/living/carbon/human/proc/climax(manual = TRUE)
	if (CONFIG_GET(flag/disable_erp_preferences))
		return

	if(!client?.prefs?.read_preference(/datum/preference/toggle/erp/autocum) && manual != TRUE)
		return

	var/obj/item/organ/external/genital/penis/penis = getorganslot(ORGAN_SLOT_PENIS)
	var/obj/item/organ/external/genital/testicles/testicles = getorganslot(ORGAN_SLOT_TESTICLES)
	var/obj/item/organ/external/genital/vagina/vagina = getorganslot(ORGAN_SLOT_VAGINA)

	if(!has_status_effect(/datum/status_effect/climax_cooldown) && client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		if(!HAS_TRAIT(src, TRAIT_NEVERBONER) && !has_status_effect(/datum/status_effect/climax_cooldown))
			switch(gender)
				if(MALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_m1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_m3.ogg'), 50, TRUE, ignore_walls = FALSE)
				if(FEMALE)
					playsound(get_turf(src), pick('modular_skyrat/modules/modular_items/lewd_items/sounds/final_f1.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f2.ogg',
												'modular_skyrat/modules/modular_items/lewd_items/sounds/final_f3.ogg'), 50, TRUE, ignore_walls = FALSE)
			if(penis)
				if(!testicles) //If we have no god damn balls, we can't cum anywhere... GET BALLS!
					visible_message(span_userlove("[src] orgasms, but nothing comes out of [p_their()] dick!"), \
						span_userlove("You orgasm, it feels great, but nothing comes out of your dick!"))
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					add_mood_event("orgasm", /datum/mood_event/climaxself)
					return TRUE

				if(!is_bottomless() && penis.visibility_preference != GENITAL_ALWAYS_SHOW)
					visible_message(span_userlove("[src] cums into their clothes!"), \
						span_userlove("You shoot your load, but you weren't naked, so you mess up your clothes!"))
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					add_mood_event("orgasm", /datum/mood_event/climaxself)
					return TRUE

				var/list/interactable_inrange_humans = list()

				for(var/mob/living/carbon/human/iterating_human in view(1, src))
					if(iterating_human == src)
						continue
					//if(iterating_human.client?.prefs?.read_preference(/datum/preference/toggle/erp))
					interactable_inrange_humans[iterating_human.name] = iterating_human

				var/list/buttons = list("On the floor")

				if(interactable_inrange_humans.len)
					buttons += "Inside/on someone"

				var/climax_choice = tgui_alert(src, "You are cumming, choose where to shoot your load.", "Load preference!", buttons)

				visible_message(span_purple("[src] is cumming!"), span_purple("You are cumming!"))

				var/create_cum_decal = FALSE

				if(!climax_choice || climax_choice == "On the floor")
					if(is_wearing_condom())
						var/obj/item/clothing/sextoy/condom/condom = get_item_by_slot(LEWD_SLOT_PENIS)
						if(condom.condom_state == "broken")
							create_cum_decal = TRUE
							visible_message(span_userlove("[src] shoots [p_their()] load into [condom], sending cum onto the floor!"), \
								span_userlove("You shoot string after string of cum, but it sprays out of [condom], hitting the floor!"))
						else
							condom.condom_use()
							visible_message(span_userlove("[src] shoots [p_their()] load into [condom], filling it up!"), \
								span_userlove("You shoot your thick load into [condom] and it catches it all!"))
					else
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] shoots their sticky load onto the floor!"), \
							span_userlove("You shoot string after string of hot cum, hitting the floor!"))
				else
					var/target_choice = tgui_input_list(src, "Choose a person to cum in or on~", "Choose target!", interactable_inrange_humans)
					if(!target_choice)
						create_cum_decal = TRUE
						visible_message(span_userlove("[src] shoots their sticky load onto the floor!"), \
							span_userlove("You shoot string after string of hot cum, hitting the floor!"))
					else
						var/mob/living/carbon/human/target_human = interactable_inrange_humans[target_choice]
						var/obj/item/organ/external/genital/vagina/target_vagina = target_human.getorganslot(ORGAN_SLOT_VAGINA)
						var/obj/item/organ/external/genital/anus/target_anus = target_human.getorganslot(ORGAN_SLOT_ANUS)
						var/obj/item/organ/external/genital/penis/target_penis = target_human.getorganslot(ORGAN_SLOT_PENIS)

						var/list/target_buttons = list()

						if(!target_human.wear_mask)
							target_buttons += "mouth"

						if(target_vagina && target_vagina?.is_exposed())
							target_buttons += ORGAN_SLOT_VAGINA

						if(target_anus && target_anus?.is_exposed())
							target_buttons += "asshole"

						if(target_penis && target_penis.is_exposed() && target_penis.sheath != "None")
							target_buttons += "sheath"

						target_buttons += "On them"

						var/climax_into_choice = tgui_input_list(src, "Where on or in [target_human] do you wish to cum?", "Final frontier!", target_buttons)

						if(!climax_into_choice)
							create_cum_decal = TRUE
							visible_message(span_userlove("[src] shoots their sticky load onto the floor!"), \
								span_userlove("You shoot string after string of hot cum, hitting the floor!"))
						else if(climax_into_choice == "On them")
							create_cum_decal = TRUE
							visible_message(span_userlove("[src] shoots their sticky load onto the [target_human]!"), \
								span_userlove("You shoot string after string of hot cum onto [target_human]!"))
						else
							visible_message(span_userlove("[src] hilts [p_their()] cock into [target_human]'s [climax_into_choice], shooting cum into it!"), \
								span_userlove("You hilt your cock into [target_human]'s [climax_into_choice], shooting cum into it!"))
							to_chat(target_human, span_userlove("Your [climax_into_choice] fills with warm cum as [src] shoots [p_their()] load into it."))
				try_lewd_autoemote("moan")
				testicles.reagents.remove_all(testicles.reagents.total_volume * 0.6)
				apply_status_effect(/datum/status_effect/climax)
				apply_status_effect(/datum/status_effect/climax_cooldown)
				if(create_cum_decal)
					add_cum_splatter_floor(get_turf(src))
				return TRUE
			if(vagina)
				if(is_bottomless() || vagina.visibility_preference == GENITAL_ALWAYS_SHOW)
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					visible_message(span_purple("[src] is cumming!"), span_purple("You are cumming!"))
					var/turf/our_turf = get_turf(src)
					add_cum_splatter_floor(our_turf, female = TRUE)
				else
					apply_status_effect(/datum/status_effect/climax)
					apply_status_effect(/datum/status_effect/climax_cooldown)
					visible_message(span_purple("[src] cums in their underwear!"), \
								span_purple("You cum in your underwear! Eww."))
					add_mood_event("orgasm", /datum/mood_event/climaxself)
				return TRUE
		else
			visible_message(span_purple("[src] twitches, trying to cum, but with no result."), \
				span_purple("You can't have an orgasm!"))
			return TRUE
