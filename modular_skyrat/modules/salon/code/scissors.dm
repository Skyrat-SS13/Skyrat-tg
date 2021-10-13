/obj/item/scissors
	name = "barbers scissors"
	desc = "Some say a barbers best tool is his electric razor, that is not the case. These are used to cut hair in a professional way!"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "scissors"
	w_class = WEIGHT_CLASS_TINY
	sharpness = SHARP_EDGED

/obj/item/scissors/attack(mob/living/attacked_mob, mob/living/user, params)
	if(!ishuman(attacked_mob))
		return

	var/mob/living/carbon/human/target_human = attacked_mob

	if(target_human.hairstyle == "Bald" && target_human.facial_hairstyle == "Shaved")
		balloon_alert(user, "What hair? They have none!")
		return

	if(user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	var/selected_part = tgui_alert(user, "Please select which part of [target_human] you would like to sculpt!", "It's sculpting time!", list("Hair", "Facial Hair", "Cancel"))

	if(!selected_part || selected_part == "Cancel")
		return

	if(selected_part == "Hair")
		if(!target_human.hairstyle == "Bald" && target_human.head)
			balloon_alert(user, "They have no hair to cut!")
			return

		var/hair_id = tgui_input_list(user, "Please select what hairstyle you'd like to sculpt!", "Select masterpiece", GLOB.hairstyles_list)

		if(hair_id == "Bald")
			to_chat(target_human, span_danger("[user] seems to be cutting all your hair off!"))

		to_chat(user, span_notice("You begin to masterfully sculpt [target_human]'s hair!"))

		playsound(target_human, 'modular_skyrat/modules/salon/sound/haircut.ogg', 100)

		if(do_after(user, 1 MINUTES, target_human))
			target_human.hairstyle = hair_id
			target_human.update_hair()
			balloon_alert_to_viewers("[user] successfully cuts [target_human]'s hair!")
			new /obj/effect/decal/cleanable/hair(get_turf(src))
	else
		if(!target_human.facial_hairstyle == "Shaved" && target_human.wear_mask)
			balloon_alert(user, "They have no facial hair to cut!")
			return

		var/facial_hair_id = tgui_input_list(user, "Please select what facial hairstyle you'd like to sculpt!", "Select masterpiece", GLOB.facial_hairstyles_list)

		if(facial_hair_id == "Shaved")
			to_chat(target_human, span_danger("[user] seems to be cutting all your facial hair off!"))

		to_chat(user, "You begin to masterfully sculpt [target_human]'s facial hair!")

		playsound(target_human, 'modular_skyrat/modules/salon/sound/haircut.ogg', 100)

		if(do_after(user, 20 SECONDS, target_human))
			target_human.facial_hairstyle = facial_hair_id
			target_human.update_hair()
			balloon_alert_to_viewers("[user] successfully cuts [target_human]'s facial hair!")
			new /obj/effect/decal/cleanable/hair(get_turf(src))
