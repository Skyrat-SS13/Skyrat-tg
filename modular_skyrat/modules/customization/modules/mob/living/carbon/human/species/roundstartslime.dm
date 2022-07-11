/datum/species/jelly
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		NOBLOOD,
		HAIR,
		FACEHAIR,
	)
	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"taur" = "None",
		"wings" = "None",
		"legs" = "Normal Legs",
		"horns" = "None",
		"spines" = "None",
		"frills" = "None",
	)
	mutant_bodyparts = list()
	hair_color = "mutcolor"
	hair_alpha = 160 //a notch brighter so it blends better.
	learnable_languages = list(
		/datum/language/common,
		/datum/language/slime
	)

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
	/// Do you need to be a slime-person to use this ability?
	var/slime_restricted = TRUE

/datum/action/innate/slime_change/unrestricted
	slime_restricted = FALSE

/datum/action/innate/slime_change/Activate()
	var/mob/living/carbon/human/alterer = owner
	if(slime_restricted && !isjellyperson(alterer))
		return
	if(isjellyperson(alterer))
		alterer.visible_message(span_notice("[owner] gains a look of concentration while standing perfectly still. \
		Their body seems to shift and starts getting more goo-like."),
		span_notice("You focus intently on altering your body while standing perfectly still..."))
	change_form()

/datum/action/innate/slime_change/proc/change_form()
	var/mob/living/carbon/human/alterer = owner
	var/selected_alteration = show_radial_menu(
		alterer,
		alterer,
		list(
			"Body Colours" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "radial_colours"),
			"Hair" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "radial_hair"),
			"Mutant Parts" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "radial_mutant_parts"),
			"Markings" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "radial_markings"),
			"DNA" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "radial_dna"),
		),
		tooltips = TRUE,
	)
	if(!selected_alteration)
		return
	var/datum/dna/alterer_dna = alterer.dna
	switch(selected_alteration)
		if("Body Colours")
			var/color_choice = show_radial_menu(
				alterer,
				alterer,
				list(
					"Primary" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "primary_colour"),
					"Secondary" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "secondary_colour"),
					"Tertiary" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "tertiary_colour"),
					"All" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "all_colours"),
				),
				tooltips = TRUE,
			)
			if(!color_choice)
				return
			var/color_target
			switch(color_choice)
				if("Primary", "All")
					color_target = "mcolor"
				if("Secondary")
					color_target = "mcolor2"
				if("Tertiary")
					color_target = "mcolor3"
			var/new_mutant_colour = input(
				alterer,
				"Choose your character's new [color_choice = "All" ? "" : lowertext(color_choice)] color:",
				"Form Alteration",
				alterer_dna.features[color_target]
			) as color|null
			if(!new_mutant_colour)
				return
			var/marking_reset = tgui_alert(
				alterer,
				"Would you like to reset your markings to match your new colors?",
				"Reset markings",
				list("Yes", "No"),
			)
			var/mutant_part_reset = tgui_alert(
				alterer,
				"Would you like to reset your mutant body parts(not limbs) to match your new colors?",
				"Reset mutant parts",
				list("Yes", "No"),
			)
			if(color_choice == "All")
				alterer_dna.features["mcolor"] = sanitize_hexcolor(new_mutant_colour)
				alterer_dna.features["mcolor2"] = sanitize_hexcolor(new_mutant_colour)
				alterer_dna.features["mcolor3"] = sanitize_hexcolor(new_mutant_colour)
				alterer_dna.update_uf_block(DNA_MUTANT_COLOR_BLOCK)
				alterer_dna.update_uf_block(DNA_MUTANT_COLOR_2_BLOCK)
				alterer_dna.update_uf_block(DNA_MUTANT_COLOR_3_BLOCK)
			else
				alterer_dna.features[color_target] = sanitize_hexcolor(new_mutant_colour)
				switch(color_target)
					if("mcolor")
						alterer_dna.update_uf_block(DNA_MUTANT_COLOR_BLOCK)
					if("mcolor2")
						alterer_dna.update_uf_block(DNA_MUTANT_COLOR_2_BLOCK)
					if("mcolor3")
						alterer_dna.update_uf_block(DNA_MUTANT_COLOR_3_BLOCK)
			if(marking_reset && marking_reset == "Yes")
				for(var/zone in alterer_dna.species.body_markings)
					for(var/key in alterer_dna.species.body_markings[zone])
						var/datum/body_marking/iterated_marking = GLOB.body_markings[key]
						if(iterated_marking.always_color_customizable)
							continue
						alterer_dna.species.body_markings[zone][key] = iterated_marking.get_default_color(alterer_dna.features, alterer_dna.species)
			if(mutant_part_reset && mutant_part_reset == "Yes")
				alterer.mutant_renderkey = "" //Just in case
				for(var/mutant_key in alterer_dna.species.mutant_bodyparts)
					var/mutant_list = alterer_dna.species.mutant_bodyparts[mutant_key]
					var/datum/sprite_accessory/changed_accessory = GLOB.sprite_accessories[mutant_key][mutant_list[MUTANT_INDEX_NAME]]
					mutant_list[MUTANT_INDEX_COLOR_LIST] = changed_accessory.get_default_color(alterer_dna.features, alterer_dna.species)
			alterer.update_body(is_creating = TRUE)
			alterer.update_hair(is_creating = TRUE)

		if("Hair")
			var/target_hair = show_radial_menu(
				alterer,
				alterer,
				list(
					"Hair" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "radial_hair"),
					"Facial Hair" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "radial_beard"),
				),
				tooltips = TRUE,
			)
			if(!target_hair)
				return
			switch(target_hair)
				if("Hair")
					var/new_style = tgui_input_list(owner, "Select a hair style", "Hair Alterations", GLOB.hairstyles_list)
					if(new_style)
						alterer.hairstyle = new_style
						alterer.update_hair(is_creating = TRUE)
				if("Facial Hair")
					var/new_style = tgui_input_list(alterer, "Select a facial hair style", "Hair Alterations", GLOB.facial_hairstyles_list)
					if(new_style)
						alterer.facial_hairstyle = new_style
						alterer.update_hair(is_creating = TRUE)

		if("Mutant Parts")
			var/list/key_list = alterer_dna.mutant_bodyparts
			var/chosen_key = tgui_input_list(
				alterer,
				"Select the part you want to alter",
				"Body Part Alterations",
				key_list,
			)
			if(!chosen_key)
				return
			var/choice_list = GLOB.sprite_accessories[chosen_key]
			var/chosen_name_key = tgui_input_list(
				alterer,
				"What do you want the part to become?",
				"Body Part Alterations",
				choice_list,
			)
			if(!chosen_name_key)
				return
			var/datum/sprite_accessory/selected_sprite_accessory = GLOB.sprite_accessories[chosen_key][chosen_name_key]
			alterer.mutant_renderkey = "" //Just in case
			if(!selected_sprite_accessory.factual)
				if(selected_sprite_accessory.organ_type)
					var/obj/item/organ/organ_path = selected_sprite_accessory.organ_type
					var/slot = initial(organ_path.slot)
					var/obj/item/organ/got_organ = alterer.getorganslot(slot)
					if(got_organ)
						got_organ.Remove(alterer)
						qdel(got_organ)
				else
					alterer_dna.species.mutant_bodyparts -= chosen_key
			else
				if(selected_sprite_accessory.organ_type)
					var/obj/item/organ/organ_path = selected_sprite_accessory.organ_type
					var/slot = initial(organ_path.slot)
					var/obj/item/organ/got_organ = alterer.getorganslot(slot)
					if(got_organ)
						got_organ.Remove(alterer)
						qdel(got_organ)
					organ_path = new selected_sprite_accessory.organ_type
					var/list/new_acc_list = list()
					new_acc_list[MUTANT_INDEX_NAME] = selected_sprite_accessory.name
					new_acc_list[MUTANT_INDEX_COLOR_LIST] = selected_sprite_accessory.get_default_color(alterer_dna.features, alterer_dna.species)
					alterer_dna.mutant_bodyparts[chosen_key] = new_acc_list.Copy()
					if(ROBOTIC_DNA_ORGANS in alterer_dna.species.species_traits)
						organ_path.status = ORGAN_ROBOTIC
						organ_path.organ_flags |= ORGAN_SYNTHETIC
					organ_path.build_from_dna(alterer_dna, chosen_key)
					organ_path.Insert(alterer, 0, FALSE)

				else
					var/list/new_acc_list = list()
					new_acc_list[MUTANT_INDEX_NAME] = selected_sprite_accessory.name
					new_acc_list[MUTANT_INDEX_COLOR_LIST] = selected_sprite_accessory.get_default_color(alterer_dna.features, alterer_dna.species)
					alterer_dna.species.mutant_bodyparts[chosen_key] = new_acc_list
					alterer_dna.mutant_bodyparts[chosen_key] = new_acc_list.Copy()
				alterer_dna.update_uf_block(GLOB.dna_mutant_bodypart_blocks[chosen_key])
			alterer.update_mutant_bodyparts()

		if("Markings")
			var/list/candidates = GLOB.body_marking_sets
			var/chosen_name = tgui_input_list(
				alterer,
				"Select which set of markings would you like to change into",
				"Marking Alterations",
				candidates,
			)
			if(!chosen_name)
				return
			var/datum/body_marking_set/marking_set = GLOB.body_marking_sets[chosen_name]
			alterer_dna.species.body_markings = assemble_body_markings_from_set(marking_set, alterer_dna.features, alterer_dna.species)
			alterer.update_body(is_creating = TRUE)

		if("DNA")
			var/dna_alteration = tgui_input_list(
				alterer,
				"Select what part of your DNA you'd like to alter",
				"DNA Alteration",
				list(
					"Body Size",
					"Breasts Lactation",
					"Breasts Size",
					"Penis Girth",
					"Penis Sheath",
					"Penis Size",
					"Penis Taur Mode",
					"Testicles Size",
					),
			)
			if(!dna_alteration)
				return
			switch(dna_alteration)
				if("Breasts Size")
					var/obj/item/organ/external/genital/breasts/melons = alterer.getorganslot(ORGAN_SLOT_BREASTS)
					if(!melons)
						var/boob_job = tgui_alert(
							alterer,
							"You don't have any breasts! Would you like to add some?",
							"Add Breasts",
							list("Yes", "No"),
						)
						if(boob_job != "Yes")
							return
						alterer.dna.mutant_bodyparts["breasts"][MUTANT_INDEX_NAME] = "Pair"
						var/obj/item/organ/path = new /obj/item/organ/external/genital/breasts
						path.build_from_dna(alterer.dna, "breasts")
						path.Insert(
							alterer,
							special = FALSE,
							drop_if_replaced = FALSE,
						)
						alterer.update_body(is_creating = TRUE)
					var/new_size = tgui_input_list(
						alterer,
						"Choose your character's breasts size:",
						"DNA Alteration",
						GLOB.preference_breast_sizes,
					)
					if(!new_size)
						return
					alterer_dna.features["breasts_size"] = melons.breasts_cup_to_size(new_size)
					melons.set_size(alterer_dna.features["breasts_size"])

				if("Breasts Lactation")
					alterer_dna.features["breasts_lactation"] = !alterer_dna.features["breasts_lactation"]
					var/obj/item/organ/external/genital/breasts/melons = alterer.getorganslot(ORGAN_SLOT_BREASTS)
					if(!melons)
						return
					melons.lactates = alterer_dna.features["breasts_lactation"]
					alterer.balloon_alert(alterer, "[alterer_dna.features["breasts_lactation"] ? "lactating" : "not lactating"]")

				if("Penis Taur Mode")
					alterer_dna.features["penis_taur_mode"] = !alterer_dna.features["penis_taur_mode"]
					alterer.balloon_alert(alterer, "[alterer_dna.features["penis_taur_mode"] ? "using taur penis" : "not using taur penis"]")

				if("Penis Size")
					var/new_length = tgui_input_number(
						alterer,
						"Choose your penis length:\n([PENIS_MIN_LENGTH]-[PENIS_MAX_LENGTH] inches)",
						"DNA Alteration",
						max_value = PENIS_MAX_LENGTH,
						min_value = PENIS_MIN_LENGTH,
					)
					if(!new_length)
						return
					alterer_dna.features["penis_size"] = new_length
					var/obj/item/organ/external/genital/penis/altered_penis = alterer.getorganslot(ORGAN_SLOT_PENIS)
					if(alterer_dna.features["penis_girth"] >= new_length)
						alterer_dna.features["penis_girth"] = new_length - 1
						if(altered_penis)
							altered_penis.girth = alterer_dna.features["penis_girth"]
					if(altered_penis)
						altered_penis.set_size(alterer_dna.features["penis_size"])

				if("Penis Girth")
					var/max_girth = PENIS_MAX_GIRTH
					if(alterer_dna.features["penis_size"] >= max_girth)
						max_girth = alterer_dna.features["penis_size"]
					var/new_girth = tgui_input_number(
						alterer,
						"Choose your penis girth:\n(1-[max_girth] (based on length) in inches)",
						"Character Preference",
						max_value = max_girth,
						min_value = 1
					)
					if(new_girth)
						alterer_dna.features["penis_girth"] = new_girth
						var/obj/item/organ/external/genital/penis/sausage = alterer.getorganslot(ORGAN_SLOT_PENIS)
						if(sausage)
							sausage.girth = alterer_dna.features["penis_girth"]

				if("Penis Sheath")
					var/new_sheath = tgui_input_list(
						alterer,
						"Choose your penis sheath",
						"DNA Alteration",
						SHEATH_MODES,
					)
					if(new_sheath)
						alterer_dna.features["penis_sheath"] = new_sheath
						var/obj/item/organ/external/genital/penis/schlong = alterer.getorganslot(ORGAN_SLOT_PENIS)
						if(schlong)
							schlong.sheath = new_sheath

				if("Testicles Size")
					var/new_size = tgui_input_list(
						alterer,
						"Choose your character's testicles size:",
						"Character Preference",
						GLOB.preference_balls_sizes,
					)
					if(new_size)
						var/obj/item/organ/external/genital/testicles/avocados = alterer.getorganslot(ORGAN_SLOT_TESTICLES)
						if(avocados)
							alterer_dna.features["balls_size"] = avocados.balls_description_to_size(new_size)
							avocados.set_size(alterer_dna.features["balls_size"])

				if("Body Size")
					var/new_body_size = tgui_input_number(
						alterer,
						"Choose your desired sprite size: ([BODY_SIZE_MIN * 100]% to [BODY_SIZE_MAX * 100]%). Warning: May make your character look distorted",
						"Size Change",
						default = alterer_dna.features["body_size"] * 100,
						max_value = BODY_SIZE_MAX * 100,
						min_value = BODY_SIZE_MIN * 100,
					)
					if(!new_body_size)
						return
					new_body_size = new_body_size * 0.01
					alterer_dna.features["body_size"] = new_body_size
					alterer_dna.update_body_size()

			alterer.mutant_renderkey = "" //Just in case
			alterer.update_mutant_bodyparts()
