/obj/item/hhmirror/syndie
	name = "handheld mirror"
	desc = "A handheld mirror that allows you to change your looks. Reminds you of old times for some reason..."
	icon = 'modular_skyrat/master_files/icons/obj/hhmirror.dmi'
	icon_state = "hhmirror"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "A mirror manufactured by the Syndicate containing barber-nanites that can alter your hair on the spot. Target your head and use it on yourself to activate the nanites."
	w_class = WEIGHT_CLASS_TINY
	// How long does it take to change someone's hairstyle?
	var/haircut_duration = 1 SECONDS
	// How long does it take to change someone's facial hair style?
	var/facial_haircut_duration = 1 SECONDS


/obj/item/hhmirror/syndie/attack(mob/living/attacked_mob, mob/living/user, params)
	if(!ishuman(attacked_mob))
		return

	var/mob/living/carbon/human/target_human = attacked_mob

	var/location = user.zone_selected
	if(!(location in list(BODY_ZONE_PRECISE_MOUTH, BODY_ZONE_HEAD)) && !user.combat_mode)
		balloon_alert(user, "only works on your head!")
		return

	if(user.zone_selected != BODY_ZONE_HEAD)
		return ..()

	var/selected_part = tgui_alert(user, "Please select which part of [target_human] you would like to sculpt!", "It's sculpting time!", list("Hair", "Facial Hair", "Cancel"))

	if(!selected_part || selected_part == "Cancel")
		return

	if(selected_part == "Hair")

		var/hair_id = tgui_input_list(user, "Please select what hairstyle you'd like to sculpt!", "Select masterpiece", GLOB.hairstyles_list)
		if(!hair_id)
			return

		if(hair_id == "Bald")
			to_chat(target_human, span_danger("Nanites seems to be disintegrating all your hair off!"))

		to_chat(user, span_notice("Nanites begin to reform [target_human]'s hair!"))


		if(do_after(user, haircut_duration, target_human))
			target_human.hairstyle = hair_id
			target_human.update_hair()
			user.visible_message(span_notice("[target_human]'s hair changes!"), span_notice("The nanites successfully alter [target_human]'s hair!"))
	else
		var/facial_hair_id = tgui_input_list(user, "Please select what facial hairstyle you'd like to sculpt!", "Select masterpiece", GLOB.facial_hairstyles_list)
		if(!facial_hair_id)
			return

		if(facial_hair_id == "Shaved")
			to_chat(target_human, span_danger("Nanites seems to be disintegrating all your facial hair off!"))

		to_chat(user, "Nanites begin to reform [target_human]'s facial hair!")

		if(do_after(user, facial_haircut_duration, target_human))
			target_human.facial_hairstyle = facial_hair_id
			target_human.update_hair()
			user.visible_message(span_notice("[target_human]'s facial hair changes!"), span_notice("The nanites successfully alter [target_human]'s facial hair!"))

/obj/item/storage/box/syndie_kit/chameleon/PopulateContents()
	. = ..()
	new /obj/item/hhmirror/syndie(src)
	new /obj/item/dyespray(src)

