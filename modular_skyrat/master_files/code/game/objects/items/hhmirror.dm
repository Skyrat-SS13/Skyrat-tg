/obj/item/hhmirror
	name = "handheld mirror"
	desc = "A handheld mirror."
	icon = 'modular_skyrat/master_files/icons/obj/hhmirror.dmi'
	icon_state = "hhmirror"

/obj/item/hhmirror/attack_self(mob/user)
	. = ..()
	if(.)
		return

/obj/item/hhmirror/fullmagic
	name = "full handheld magic mirror"
	desc = "A handheld mirror that allows you to change your... self?" // Later, maybe add a charge to the description.
	icon = 'modular_skyrat/master_files/icons/obj/hhmirror.dmi'
	icon_state = "hhmirrormagic"
	var/list/races_blacklist = list(SPECIES_SKELETON, "agent", "angel", SPECIES_ZOMBIE, "clockwork golem servant", SPECIES_MUSHROOM, "memezombie")
	var/list/choosable_races = list()

/obj/item/hhmirror/fullmagic/New()
	if(!choosable_races.len)
		for(var/speciestype in subtypesof(/datum/species))
			var/datum/species/iterated_species = new speciestype()
			if(!(iterated_species.id in races_blacklist))
				choosable_races += iterated_species.id
	..()

/obj/item/hhmirror/fullmagic/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/human_user = user

	var/choice = input(user, "Something to change?", "Magical Grooming") as null|anything in list("name", "race", "gender", "hair", "eyes")

	switch(choice)
		if("name")
			var/newname = reject_bad_name(stripped_input(human_user, "Who are we again?", "Name change", human_user.name, MAX_NAME_LEN))

			if(!newname)
				return
			if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
				return
			human_user.real_name = newname
			human_user.name = newname
			if(human_user.dna)
				human_user.dna.real_name = newname
			if(human_user.mind)
				human_user.mind.name = newname

		if("race")
			var/newrace
			var/racechoice = input(human_user, "What are we again?", "Race change") as null|anything in choosable_races
			newrace = GLOB.species_list[racechoice]

			if(!newrace)
				return
			if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
				return
			human_user.set_species(newrace, icon_update = 0)

			if(HAS_TRAIT(human_user, TRAIT_USES_SKINTONES))
				var/new_s_tone = input(user, "Choose your skin tone:", "Race change")  as null|anything in GLOB.skin_tones

				if(new_s_tone)
					human_user.skin_tone = new_s_tone
					human_user.dna.update_ui_block(DNA_SKIN_TONE_BLOCK)

			#define MIN_MCOLOR_VALUE 50

			if(HAS_TRAIT(human_user, TRAIT_MUTANT_COLORS) && !HAS_TRAIT(human_user, TRAIT_FIXED_MUTANT_COLORS))
				var/new_mutantcolor = input(user, "Choose your skin color:", "Race change", human_user.dna.features["mcolor"]) as color|null
				if(new_mutantcolor)
					var/mutantcolor_hsv = rgb2hsv(new_mutantcolor)

					if(mutantcolor_hsv[3] >= MIN_MCOLOR_VALUE) // mutantcolors must be bright
						human_user.dna.features["mcolor"] = sanitize_hexcolor(new_mutantcolor)

					else
						to_chat(human_user, span_notice("Invalid color. Your color is not bright enough."))
						
			#undef MIN_MCOLOR_VALUE

			human_user.update_body()
			human_user.update_mutations_overlay() // no hulk lizard

		if("gender")
			if(!(human_user.gender in list("male", "female"))) // blame the patriarchy
				return
			if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
				return
			if(human_user.gender == "male")
				if(alert(human_user, "Become a Witch?", "Confirmation", "Yes", "No") == "Yes")
					human_user.gender = "female"
					to_chat(human_user, span_notice("Man, you feel like a woman!"))
				else
					return

			else
				if(alert(human_user, "Become a Warlock?", "Confirmation", "Yes", "No") == "Yes")
					human_user.gender = "male"
					to_chat(human_user, span_notice("Whoa man, you feel like a man!"))
				else
					return
			human_user.dna.update_ui_block(DNA_GENDER_BLOCK)
			human_user.update_body()
			human_user.update_mutations_overlay() // (hulk male/female)

		if("hair")
			var/hairchoice = tgui_alert(human_user, "Hair style or hair color?", "Change Hair", list("Style", "Color"))
			if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
				return
			if(hairchoice == "Style") // So you just want to use a mirror then?
				..()
			else
				var/new_hair_color = input(human_user, "Choose your hair color", "Hair Color", human_user.hair_color) as color|null
				if(new_hair_color)
					human_user.hair_color = sanitize_hexcolor(new_hair_color)
					human_user.dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
				if(human_user.gender == "male")
					var/new_face_color = input(human_user, "Choose your facial hair color", "Hair Color", human_user.facial_hair_color) as color|null
					if(new_face_color)
						human_user.facial_hair_color = sanitize_hexcolor(new_face_color)
						human_user.dna.update_ui_block(DNA_FACIAL_HAIR_COLOR_BLOCK)
				human_user.update_body_parts()

		if(BODY_ZONE_PRECISE_EYES)
			var/new_eye_color = input(human_user, "Choose your eye color", "Eye Color", human_user.eye_color_left) as color|null
			if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
				return TRUE
			if(new_eye_color)
				human_user.eye_color_left = sanitize_hexcolor(new_eye_color)
				human_user.eye_color_right = sanitize_hexcolor(new_eye_color)
				human_user.dna.update_ui_block(DNA_EYE_COLOR_LEFT_BLOCK)
				human_user.dna.update_ui_block(DNA_EYE_COLOR_RIGHT_BLOCK)
				human_user.update_body()

/obj/item/hhmirror/wracemagic
	name = "raceless handheld magic mirror"
	desc = "A handheld mirror that allows you to change your... self?" // Later, maybe add a charge to the description.
	icon = 'modular_skyrat/master_files/icons/obj/hhmirror.dmi'
	icon_state = "hhmirrormagic"
	var/charges = 4

/obj/item/hhmirror/wracemagic/attack_self(mob/user)
	. = ..()
	if(.)
		return
	if(!ishuman(user))
		return
	if(!charges == 0) // Later, should also have a lock
		var/mob/living/carbon/human/human_user = user

		var/choice = input(user, "Something to change?", "Magical Grooming") as null|anything in list("name", "gender", "hair", "eyes")

		switch(choice)
			if("name")
				var/newname = reject_bad_name(stripped_input(human_user, "Who are we again?", "Name change", human_user.name, MAX_NAME_LEN))

				if(!newname)
					return
				if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
					return
				human_user.real_name = newname
				human_user.name = newname
				if(human_user.dna)
					human_user.dna.real_name = newname
				if(human_user.mind)
					human_user.mind.name = newname

			if("gender")
				if(!(human_user.gender in list("male", "female"))) // blame the patriarchy
					return
				if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
					return
				if(human_user.gender == "male")
					if(alert(human_user, "Become a Witch?", "Confirmation", "Yes", "No") == "Yes")
						human_user.gender = "female"
						to_chat(human_user, span_notice("Man, you feel like a woman!"))
					else
						return

				else
					if(alert(human_user, "Become a Warlock?", "Confirmation", "Yes", "No") == "Yes")
						human_user.gender = "male"
						to_chat(human_user, span_notice("Whoa man, you feel like a man!"))
					else
						return
				human_user.dna.update_ui_block(DNA_GENDER_BLOCK)
				human_user.update_body()
				human_user.update_mutations_overlay() // (hulk male/female)

			if("hair")
				var/hairchoice = tgui_alert(human_user, "Hair style or hair color?", "Change Hair", list("Style", "Color"))
				if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
					return
				if(hairchoice == "Style") // So you just want to use a mirror then?
					..()
				else
					var/new_hair_color = input(human_user, "Choose your hair color", "Hair Color", human_user.hair_color) as color|null
					if(new_hair_color)
						human_user.hair_color = sanitize_hexcolor(new_hair_color)
						human_user.dna.update_ui_block(DNA_HAIR_COLOR_BLOCK)
					if(human_user.gender == "male")
						var/new_face_color = input(human_user, "Choose your facial hair color", "Hair Color", human_user.facial_hair_color) as color|null
						if(new_face_color)
							human_user.facial_hair_color = sanitize_hexcolor(new_face_color)
							human_user.dna.update_ui_block(DNA_FACIAL_HAIR_COLOR_BLOCK)
					human_user.update_body_parts()

			if(BODY_ZONE_PRECISE_EYES)
				var/new_eye_color = input(human_user, "Choose your eye color", "Eye Color", human_user.eye_color_left) as color|null
				if(!user.can_perform_action(src, FORBID_TELEKINESIS_REACH))
					return TRUE
				if(new_eye_color)
					human_user.eye_color_left = sanitize_hexcolor(new_eye_color)
					human_user.eye_color_right = sanitize_hexcolor(new_eye_color)
					human_user.dna.update_ui_block(DNA_EYE_COLOR_LEFT_BLOCK)
					human_user.dna.update_ui_block(DNA_EYE_COLOR_RIGHT_BLOCK)
					human_user.update_body()
		charges--
	if(charges == 0)
		qdel(src)
		to_chat(user, "The mirror crumbles to dust within your hands.")
