/datum/species/jelly
	species_traits = list(MUTCOLORS,EYECOLOR,NOBLOOD,HAIR,FACEHAIR)
	default_mutant_bodyparts = list("tail" = "None", "snout" = "None", "ears" = "None", "taur" = "None", "wings" = "None", "legs" = "Normal Legs", "horns" = "None",  "spines" = "None", "frills" = "None")
	mutant_bodyparts = list()
	hair_color = "mutcolor"
	hair_alpha = 160 //a notch brighter so it blends better.
	learnable_languages = list(/datum/language/common, /datum/language/slime)
	payday_modifier = 0.75

/datum/species/jelly/get_species_description()
	return placeholder_description

/datum/species/jelly/get_species_lore()
	return list(placeholder_lore)

/datum/species/jelly/roundstartslime
	name = "Xenobiological Slime Hybrid"
	id = SPECIES_SLIMESTART
	examine_limb_id = SPECIES_SLIMEPERSON
	say_mod = "says"
	coldmod = 3
	heatmod = 1
	burnmod = 1
	specific_alpha = 155
	markings_alpha = 130 //This is set lower than the other so that the alpha values don't stack on top of each other so much

	bodypart_overrides = list( //Overriding jelly bodyparts
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/roundstartslime,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/roundstartslime,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/roundstartslime,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/roundstartslime,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/roundstartslime,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/roundstartslime,
	)

/datum/action/innate/slime_change
	name = "Alter Form"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "alter_form"
	icon_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"
	var/slime_restricted = TRUE

/datum/action/innate/slime_change/admin
	slime_restricted = FALSE

/datum/action/innate/slime_change/Activate()
	var/mob/living/carbon/human/H = owner
	if(slime_restricted && !isjellyperson(H))
		return
	if(slime_restricted)
		H.visible_message(span_notice("[owner] gains a look of \
		concentration while standing perfectly still.\
		 Their body seems to shift and starts getting more goo-like."),
		span_notice("You focus intently on altering your body while \
		standing perfectly still..."))
	change_form()

/datum/action/innate/slime_change/proc/change_form()
	var/mob/living/carbon/human/H = owner
	var/select_alteration = input(H, "Select what part of your form to alter", "Form Alteration", "cancel") in list("Body Colors","Hair Style", "Facial Hair Style", "Markings", "Cancel")
	if(!select_alteration || select_alteration == "Cancel" || QDELETED(H))
		return
	var/datum/dna/DNA = H.dna
	switch(select_alteration)
		if("Body Colors")
			var/color_choice = input(H, "What color would you like to change?", "Form Alteration", "cancel") in list("Primary", "Secondary", "Tertiary", "All", "Cancel")
			if(!color_choice || color_choice == "Cancel" || QDELETED(H))
				return
			var/color_target
			switch(color_choice)
				if("Primary", "All")
					color_target = "mcolor"
				if("Secondary")
					color_target = "mcolor2"
				if("Tertiary")
					color_target = "mcolor3"
			var/new_mutantcolor = input(H, "Choose your character's new [lowertext(color_choice)] color:", "Form Alteration",DNA.features[color_target]) as color|null
			if(!new_mutantcolor)
				return
			var/marking_reset = tgui_alert(H, "Would you like to reset your markings to match your new colors?", "", list("Yes", "No"))
			var/mutantpart_reset = tgui_alert(H, "Would you like to reset your mutant body parts(not limbs) to match your new colors?", "", list("Yes", "No"))
			if(color_choice == "All")
				DNA.features["mcolor"] = sanitize_hexcolor(new_mutantcolor)
				DNA.features["mcolor2"] = sanitize_hexcolor(new_mutantcolor)
				DNA.features["mcolor3"] = sanitize_hexcolor(new_mutantcolor)
				DNA.update_uf_block(DNA_MUTANT_COLOR_BLOCK)
				DNA.update_uf_block(DNA_MUTANT_COLOR_2_BLOCK)
				DNA.update_uf_block(DNA_MUTANT_COLOR_3_BLOCK)
			else
				DNA.features[color_target] = sanitize_hexcolor(new_mutantcolor)
				switch(color_target)
					if("mcolor")
						DNA.update_uf_block(DNA_MUTANT_COLOR_BLOCK)
					if("mcolor2")
						DNA.update_uf_block(DNA_MUTANT_COLOR_2_BLOCK)
					if("mcolor3")
						DNA.update_uf_block(DNA_MUTANT_COLOR_3_BLOCK)
			if(marking_reset && marking_reset == "Yes")
				for(var/zone in DNA.species.body_markings)
					for(var/key in DNA.species.body_markings[zone])
						var/datum/body_marking/BD = GLOB.body_markings[key]
						if(BD.always_color_customizable)
							continue
						DNA.species.body_markings[zone][key] = BD.get_default_color(DNA.features, DNA.species)
			if(mutantpart_reset && mutantpart_reset == "Yes")
				H.mutant_renderkey = "" //Just in case
				for(var/mutant_key in DNA.species.mutant_bodyparts)
					var/mutant_list = DNA.species.mutant_bodyparts[mutant_key]
					var/datum/sprite_accessory/SP = GLOB.sprite_accessories[mutant_key][mutant_list[MUTANT_INDEX_NAME]]
					mutant_list[MUTANT_INDEX_COLOR_LIST] = SP.get_default_color(DNA.features, DNA.species)

			H.update_body()
			H.update_hair()
		if("Hair Style")
			var/new_style = input(owner, "Select a hair style", "Hair Alterations")  as null|anything in GLOB.hairstyles_list
			if(new_style)
				H.hairstyle = new_style
				H.update_hair()
		if("Facial Hair Style")
			var/new_style = input(H, "Select a facial hair style", "Hair Alterations")  as null|anything in GLOB.facial_hairstyles_list
			if(new_style)
				H.facial_hairstyle = new_style
				H.update_hair()
		if("Mutant Body Parts")
			var/list/key_list = DNA.mutant_bodyparts
			var/chosen_key = input(H, "Select the part you want to alter", "Body Part Alterations")  as null|anything in key_list + "Cancel"
			if(!chosen_key || chosen_key == "Cancel")
				return
			var/choice_list = GLOB.sprite_accessories[chosen_key]
			var/chosen_name_key = input(H, "What do you want the part to become?", "Body Part Alterations")  as null|anything in choice_list + "Cancel"
			if(!chosen_name_key || chosen_name_key == "Cancel")
				return
			var/datum/sprite_accessory/SA = GLOB.sprite_accessories[chosen_key][chosen_name_key]
			H.mutant_renderkey = "" //Just in case
			if(!SA.factual)
				if(SA.organ_type)
					var/obj/item/organ/path = SA.organ_type
					var/slot = initial(path.slot)
					var/obj/item/organ/got_organ = H.getorganslot(slot)
					if(got_organ)
						got_organ.Remove(H)
						qdel(got_organ)
				else
					DNA.species.mutant_bodyparts -= chosen_key
			else
				if(SA.organ_type)
					var/obj/item/organ/path = SA.organ_type
					var/slot = initial(path.slot)
					var/obj/item/organ/got_organ = H.getorganslot(slot)
					if(got_organ)
						got_organ.Remove(H)
						qdel(got_organ)
					path = new SA.organ_type
					var/list/new_acc_list = list()
					new_acc_list[MUTANT_INDEX_NAME] = SA.name
					new_acc_list[MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(DNA.features, DNA.species)
					DNA.mutant_bodyparts[chosen_key] = new_acc_list.Copy()
					if(ROBOTIC_DNA_ORGANS in DNA.species.species_traits)
						path.status = ORGAN_ROBOTIC
						path.organ_flags |= ORGAN_SYNTHETIC
					path.build_from_dna(DNA, chosen_key)
					path.Insert(H, 0, FALSE)

				else
					var/list/new_acc_list = list()
					new_acc_list[MUTANT_INDEX_NAME] = SA.name
					new_acc_list[MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(DNA.features, DNA.species)
					DNA.species.mutant_bodyparts[chosen_key] = new_acc_list
					DNA.mutant_bodyparts[chosen_key] = new_acc_list.Copy()
				DNA.update_uf_block(GLOB.dna_mutant_bodypart_blocks[chosen_key])
			H.update_mutant_bodyparts()
		if("Markings")
			var/list/candidates = GLOB.body_marking_sets
			var/chosen_name = input(H, "Select which set of markings would you like to change into", "Marking Alterations")  as null|anything in candidates + "Cancel"
			if(!chosen_name || chosen_name == "Cancel")
				return
			var/datum/body_marking_set/BMS = GLOB.body_marking_sets[chosen_name]
			DNA.species.body_markings = assemble_body_markings_from_set(BMS, DNA.features, DNA.species)
			H.update_body()
		if("DNA Specifics")
			var/dna_alteration = input(H, "Select what part of your DNA you'd like to alter", "DNA Alteration", "cancel") in list("Penis Size","Penis Girth", "Penis Sheath", "Penis Taur Mode", "Balls Size", "Breasts Size", "Breasts Lactation", "Body Size", "Cancel")
			if(!dna_alteration || dna_alteration == "Cancel")
				return
			switch(dna_alteration)
				if("Breasts Size")
					var/new_size = input(H, "Choose your character's breasts size:", "DNA Alteration") as null|anything in GLOB.preference_breast_sizes
					if(new_size)
						DNA.features["breasts_size"] = breasts_cup_to_size(new_size)
						var/obj/item/organ/genital/breasts/melons = H.getorganslot(ORGAN_SLOT_BREASTS)
						if(melons)
							melons.set_size(DNA.features["breasts_size"])
				if("Breasts Lactation")
					DNA.features["breasts_lactation"] = !DNA.features["breasts_lactation"]
					var/obj/item/organ/genital/breasts/melons = H.getorganslot(ORGAN_SLOT_BREASTS)
					if(melons)
						melons.lactates = DNA.features["breasts_lactation"]
					to_chat(H, span_notice("Your breasts [DNA.features["breasts_lactation"] ? "will now lactate" : "will not lactate anymore"]."))
				if("Penis Taur Mode")
					DNA.features["penis_taur_mode"] = !DNA.features["penis_taur_mode"]
					to_chat(H, span_notice("Your penis [DNA.features["penis_taur_mode"] ? "will be at your taur part" : "will not be at your taur part anymore"]."))
				if("Penis Size")
					var/new_length = input(H, "Choose your penis length:\n([PENIS_MIN_LENGTH]-[PENIS_MAX_LENGTH] in inches)", "DNA Alteration") as num|null
					if(new_length)
						DNA.features["penis_size"] = clamp(round(new_length, 1), PENIS_MIN_LENGTH, PENIS_MAX_LENGTH)
						var/obj/item/organ/genital/penis/PP = H.getorganslot(ORGAN_SLOT_PENIS)
						if(DNA.features["penis_girth"] >= new_length)
							DNA.features["penis_girth"] = new_length - 1
							if(PP)
								PP.girth = DNA.features["penis_girth"]
						if(PP)
							PP.set_size(DNA.features["penis_size"])
				if("Penis Sheath")
					var/new_sheath = input(H, "Choose your penis sheath", "DNA Alteration") as null|anything in SHEATH_MODES
					if(new_sheath)
						DNA.features["penis_sheath"] = new_sheath
						var/obj/item/organ/genital/penis/PP = H.getorganslot(ORGAN_SLOT_PENIS)
						if(PP)
							PP.sheath = new_sheath
				if("Penis Girth")
					var/max_girth = PENIS_MAX_GIRTH
					if(DNA.features["penis_size"] >= max_girth)
						max_girth = DNA.features["penis_size"]
					var/new_girth = input(H, "Choose your penis girth:\n(1-[max_girth] (based on length) in inches)", "Character Preference") as num|null
					if(new_girth)
						DNA.features["penis_girth"] = clamp(round(new_girth, 1), 1, max_girth)
						var/obj/item/organ/genital/penis/PP = H.getorganslot(ORGAN_SLOT_PENIS)
						if(PP)
							PP.girth = DNA.features["penis_girth"]
				if("Balls Size")
					var/new_size = input(H, "Choose your character's balls size:", "Character Preference") as null|anything in GLOB.preference_balls_sizes
					if(new_size)
						DNA.features["balls_size"] = balls_description_to_size(new_size)
						var/obj/item/organ/genital/testicles/avocados = H.getorganslot(ORGAN_SLOT_TESTICLES)
						if(avocados)
							avocados.set_size(DNA.features["balls_size"])
				if("Body Size")
					var/new_body_size = input(H, "Choose your desired sprite size:\n([BODY_SIZE_MIN*100]%-[BODY_SIZE_MAX*100]%), Warning: May make your character look distorted", "Character Preference", DNA.features["body_size"]*100) as num|null
					if(new_body_size)
						new_body_size = clamp(new_body_size * 0.01, BODY_SIZE_MIN, BODY_SIZE_MAX)
						DNA.features["body_size"] = new_body_size
						DNA.update_body_size()
			H.mutant_renderkey = "" //Just in case
			H.update_mutant_bodyparts()
