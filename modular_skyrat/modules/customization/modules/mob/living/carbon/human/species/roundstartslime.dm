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

/**
 * Alter Form is the ability of slimes to edit many of their character attributes at will
 * This covers most thing about their character, from body size or colour, to adding new wings, tails, ears, etc, to changing the presence of their genitalia
 * There are some balance concerns with some of these (looking at you, body size), but nobody has abused it Yet:tm:, and it would be exceedingly obvious if they did
 */
/datum/action/innate/alter_form
	name = "Alter Form"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "alter_form"
	icon_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"
	/// Do you need to be a slime-person to use this ability?
	var/slime_restricted = TRUE
	///Is the person using this ability oversized?
	var/oversized_user = FALSE

/datum/action/innate/alter_form/unrestricted
	slime_restricted = FALSE

/datum/action/innate/alter_form/Activate()
	var/mob/living/carbon/human/alterer = owner
	if(slime_restricted && !isjellyperson(alterer))
		return
	alterer.visible_message(
		span_notice("[owner] gains a look of concentration while standing perfectly still. Their body seems to shift and starts getting more goo-like."),
		span_notice("You focus intently on altering your body while standing perfectly still...")
	)
	change_form(alterer)

/**
 * Change form is the initial proc when using the alter form action
 * It brings up a radial menu to allow you to pick what about your character it is that you want to edit
 * Each of these radial menus should be kept from being too long where possible, really
 */
/datum/action/innate/alter_form/proc/change_form(mob/living/carbon/human/alterer)
	var/selected_alteration = show_radial_menu(
		alterer,
		alterer,
		list(
			"Body Colours" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_rainbow"),
			"DNA" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "dna"),
			"Hair" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "scissors"),
			"Markings" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "rainbow_spraycan"),
		),
		tooltips = TRUE,
	)
	if(!selected_alteration)
		return
	switch(selected_alteration)
		if("Body Colours")
			alter_colours(alterer)
		if("DNA")
			alter_dna(alterer)
		if("Hair")
			alter_hair(alterer)
		if("Markings")
			alter_markings(alterer)

/**
 * Alter colours handles the changing of mutant colours
 * This affects skin tone primarily, though has the option to change hair, markings, and mutant body parts to match
 */
/datum/action/innate/alter_form/proc/alter_colours(mob/living/carbon/human/alterer)
	var/color_choice = show_radial_menu(
		alterer,
		alterer,
		list(
			"Primary" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_red"),
			"Secondary" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_green"),
			"Tertiary" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_blue"),
			"All" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "slime_rainbow"),
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
		alterer.dna.features[color_target]
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
	var/hair_reset = tgui_alert(
		alterer,
		"Would you like to reset your hair to match your new colors?",
		"Reset hair",
		list("Hair", "Facial Hair", "Both", "None"),
	)

	if(color_choice == "All")
		alterer.dna.features["mcolor"] = sanitize_hexcolor(new_mutant_colour)
		alterer.dna.features["mcolor2"] = sanitize_hexcolor(new_mutant_colour)
		alterer.dna.features["mcolor3"] = sanitize_hexcolor(new_mutant_colour)
		alterer.dna.update_uf_block(DNA_MUTANT_COLOR_BLOCK)
		alterer.dna.update_uf_block(DNA_MUTANT_COLOR_2_BLOCK)
		alterer.dna.update_uf_block(DNA_MUTANT_COLOR_3_BLOCK)
	else
		alterer.dna.features[color_target] = sanitize_hexcolor(new_mutant_colour)
		switch(color_target)
			if("mcolor")
				alterer.dna.update_uf_block(DNA_MUTANT_COLOR_BLOCK)
			if("mcolor2")
				alterer.dna.update_uf_block(DNA_MUTANT_COLOR_2_BLOCK)
			if("mcolor3")
				alterer.dna.update_uf_block(DNA_MUTANT_COLOR_3_BLOCK)

	if(marking_reset == "Yes")
		for(var/zone in alterer.dna.species.body_markings)
			for(var/key in alterer.dna.species.body_markings[zone])
				var/datum/body_marking/iterated_marking = GLOB.body_markings[key]
				if(iterated_marking.always_color_customizable)
					continue
				alterer.dna.species.body_markings[zone][key] = iterated_marking.get_default_color(alterer.dna.features, alterer.dna.species)

	if(mutant_part_reset == "Yes")
		alterer.mutant_renderkey = "" //Just in case
		for(var/mutant_key in alterer.dna.species.mutant_bodyparts)
			var/mutant_list = alterer.dna.species.mutant_bodyparts[mutant_key]
			var/datum/sprite_accessory/changed_accessory = GLOB.sprite_accessories[mutant_key][mutant_list[MUTANT_INDEX_NAME]]
			mutant_list[MUTANT_INDEX_COLOR_LIST] = changed_accessory.get_default_color(alterer.dna.features, alterer.dna.species)

	if(hair_reset)
		switch(hair_reset)
			if("Hair")
				alterer.hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.update_body_parts()
			if("Facial Hair")
				alterer.facial_hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.update_body_parts()
			if("Both")
				alterer.hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.facial_hair_color = sanitize_hexcolor(new_mutant_colour)
				alterer.update_body_parts()

	alterer.update_body(is_creating = TRUE)

/**
 * Alter hair lets you adjust both the hair on your head as well as your facial hair
 * You can adjust the style of either
 */
/datum/action/innate/alter_form/proc/alter_hair(mob/living/carbon/human/alterer)
	var/target_hair = show_radial_menu(
		alterer,
		alterer,
		list(
			"Hair" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "scissors"),
			"Facial Hair" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "straight_razor"),
			"Hair Color" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "rainbow_spraycan")
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
				alterer.update_body_parts()
		if("Facial Hair")
			var/new_style = tgui_input_list(alterer, "Select a facial hair style", "Hair Alterations", GLOB.facial_hairstyles_list)
			if(new_style)
				alterer.facial_hairstyle = new_style
				alterer.update_body_parts()
		if("Hair Color")
			var/hair_area = tgui_alert(alterer, "Select which color you would like to change", "Hair Color Alterations", list("Hairstyle", "Facial Hair", "Both"))
			if(!hair_area)
				return
			var/new_hair_color = input(alterer, "Select your new hair color", "Hair Color Alterations", alterer.dna.features["mcolor"]) as color|null
			if(!new_hair_color)
				return

			switch(hair_area)

				if("Hairstyle")
					alterer.hair_color = new_hair_color
					alterer.update_body_parts()
				if("Facial Hair")
					alterer.facial_hair_color = new_hair_color
					alterer.update_body_parts()
				if("Both")
					alterer.hair_color = new_hair_color
					alterer.facial_hair_color = new_hair_color
					alterer.update_body_parts()

/**
 * Alter DNA is an intermediary proc for the most part
 * It lets you pick between a few options for DNA specifics
 */
/datum/action/innate/alter_form/proc/alter_dna(mob/living/carbon/human/alterer)
	var/list/key_list = list("Body Size", "Genitals", "Mutant Parts")
	if(CONFIG_GET(flag/disable_erp_preferences))
		key_list.Remove("Genitals")
	var/dna_alteration = tgui_input_list(
		alterer,
		"Select what part of your DNA you'd like to alter",
		"DNA Alteration",
		key_list,
	)
	if(!dna_alteration)
		return
	switch(dna_alteration)
		if("Body Size")
			if(oversized_user && !HAS_TRAIT(alterer, TRAIT_OVERSIZED))
				var/reset_size = tgui_alert(alterer, "Do you wish to return to being oversized?", "Size Change", list("Yes", "No"))
				if(reset_size == "Yes")
					alterer.add_quirk(/datum/quirk/oversized)
					return

			var/new_body_size = tgui_input_number(
				alterer,
				"Choose your desired sprite size: ([BODY_SIZE_MIN * 100]% to [BODY_SIZE_MAX * 100]%). Warning: May make your character look distorted",
				"Size Change",
				default = min(alterer.dna.features["body_size"] * 100, BODY_SIZE_MAX * 100),
				max_value = BODY_SIZE_MAX * 100,
				min_value = BODY_SIZE_MIN * 100,
			)
			if(!new_body_size)
				return

			if(HAS_TRAIT(alterer, TRAIT_OVERSIZED))
				oversized_user = TRUE
				alterer.remove_quirk(/datum/quirk/oversized)

			new_body_size = new_body_size * 0.01
			alterer.dna.features["body_size"] = new_body_size
			alterer.dna.update_body_size()

		if("Genitals")
			alter_genitals(alterer)
		if("Mutant Parts")
			alter_parts(alterer)

	alterer.mutant_renderkey = "" //Just in case
	alterer.update_mutant_bodyparts()

/**
 * Alter parts lets you adjust mutant bodyparts
 * This can be adding (or removing) things like ears, tails, wings, et cetera.
 */
/datum/action/innate/alter_form/proc/alter_parts(mob/living/carbon/human/alterer)
	var/list/key_list = alterer.dna.mutant_bodyparts
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
			alterer.dna.species.mutant_bodyparts -= chosen_key
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
			new_acc_list[MUTANT_INDEX_COLOR_LIST] = selected_sprite_accessory.get_default_color(alterer.dna.features, alterer.dna.species)
			alterer.dna.mutant_bodyparts[chosen_key] = new_acc_list.Copy()
			if(ROBOTIC_DNA_ORGANS in alterer.dna.species.species_traits)
				organ_path.status = ORGAN_ROBOTIC
				organ_path.organ_flags |= ORGAN_SYNTHETIC
			organ_path.build_from_dna(alterer.dna, chosen_key)
			organ_path.Insert(alterer, 0, FALSE)

		else
			var/list/new_acc_list = list()
			new_acc_list[MUTANT_INDEX_NAME] = selected_sprite_accessory.name
			new_acc_list[MUTANT_INDEX_COLOR_LIST] = selected_sprite_accessory.get_default_color(alterer.dna.features, alterer.dna.species)
			alterer.dna.species.mutant_bodyparts[chosen_key] = new_acc_list
			alterer.dna.mutant_bodyparts[chosen_key] = new_acc_list.Copy()
		alterer.dna.update_uf_block(GLOB.dna_mutant_bodypart_blocks[chosen_key])
	alterer.update_mutant_bodyparts()

/**
 * Alter markings lets you add a particular body marking
 */
/datum/action/innate/alter_form/proc/alter_markings(mob/living/carbon/human/alterer)
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
	alterer.dna.species.body_markings = assemble_body_markings_from_set(marking_set, alterer.dna.features, alterer.dna.species)
	alterer.update_body(is_creating = TRUE)

/**
 * Alter genitals lets you adjust the size or functionality of genitalia
 * If you don't own the genital you try to adjust, it'll ask you if you want to add it first
 */
/datum/action/innate/alter_form/proc/alter_genitals(mob/living/carbon/human/alterer)
	var/list/genital_list
	if(alterer.getorganslot(ORGAN_SLOT_BREASTS))
		genital_list += list("Breasts Lactation", "Breasts Size")
	if(alterer.getorganslot(ORGAN_SLOT_PENIS))
		genital_list += list("Penis Girth", "Penis Length", "Penis Sheath", "Penis Taur Mode")
	if(alterer.getorganslot(ORGAN_SLOT_TESTICLES))
		genital_list += list("Testicles Size")
	if(!length(genital_list))
		alterer.balloon_alert(alterer, "no genitals!")

	var/dna_alteration = tgui_input_list(
		alterer,
		"Select what bodypart you'd like to alter",
		"Genital Alteration",
		genital_list
	)
	if(!dna_alteration)
		return
	switch(dna_alteration)
		if("Breasts Lactation")
			var/obj/item/organ/external/genital/breasts/melons = alterer.getorganslot(ORGAN_SLOT_BREASTS)
			alterer.dna.features["breasts_lactation"] = !alterer.dna.features["breasts_lactation"]
			melons.lactates = alterer.dna.features["breasts_lactation"]
			alterer.balloon_alert(alterer, "[alterer.dna.features["breasts_lactation"] ? "lactating" : "not lactating"]")

		if("Breasts Size")
			var/obj/item/organ/external/genital/breasts/melons = alterer.getorganslot(ORGAN_SLOT_BREASTS)
			var/new_size = tgui_input_list(
				alterer,
				"Choose your character's breasts size:",
				"DNA Alteration",
				GLOB.preference_breast_sizes,
			)
			if(!new_size)
				return
			alterer.dna.features["breasts_size"] = melons.breasts_cup_to_size(new_size)
			melons.set_size(alterer.dna.features["breasts_size"])

		if("Penis Girth")
			var/obj/item/organ/external/genital/penis/sausage = alterer.getorganslot(ORGAN_SLOT_PENIS)
			var/max_girth = PENIS_MAX_GIRTH
			if(alterer.dna.features["penis_size"] >= max_girth)
				max_girth = alterer.dna.features["penis_size"]
			var/new_girth = tgui_input_number(
				alterer,
				"Choose your penis girth:\n(1-[max_girth] (based on length) in inches)",
				"Character Preference",
				max_value = max_girth,
				min_value = 1
			)
			if(new_girth)
				alterer.dna.features["penis_girth"] = new_girth
				sausage.girth = alterer.dna.features["penis_girth"]

		if("Penis Length")
			var/obj/item/organ/external/genital/penis/wang = alterer.getorganslot(ORGAN_SLOT_PENIS)
			var/new_length = tgui_input_number(
				alterer,
				"Choose your penis length:\n([PENIS_MIN_LENGTH]-[PENIS_MAX_LENGTH] inches)",
				"DNA Alteration",
				max_value = PENIS_MAX_LENGTH,
				min_value = PENIS_MIN_LENGTH,
			)
			if(!new_length)
				return
			alterer.dna.features["penis_size"] = new_length
			if(alterer.dna.features["penis_girth"] >= new_length)
				alterer.dna.features["penis_girth"] = new_length - 1
				wang.girth = alterer.dna.features["penis_girth"]
			wang.set_size(alterer.dna.features["penis_size"])

		if("Penis Sheath")
			var/obj/item/organ/external/genital/penis/schlong = alterer.getorganslot(ORGAN_SLOT_PENIS)
			var/new_sheath = tgui_input_list(
				alterer,
				"Choose your penis sheath",
				"DNA Alteration",
				SHEATH_MODES,
			)
			if(new_sheath)
				alterer.dna.features["penis_sheath"] = new_sheath
				schlong.sheath = new_sheath

		if("Penis Taur Mode")
			alterer.dna.features["penis_taur_mode"] = !alterer.dna.features["penis_taur_mode"]
			alterer.balloon_alert(alterer, "[alterer.dna.features["penis_taur_mode"] ? "using taur penis" : "not using taur penis"]")

		if("Testicles Size")
			var/obj/item/organ/external/genital/testicles/avocados = alterer.getorganslot(ORGAN_SLOT_TESTICLES)
			var/new_size = tgui_input_list(
				alterer,
				"Choose your character's testicles size:",
				"Character Preference",
				GLOB.preference_balls_sizes,
			)
			if(new_size)
				alterer.dna.features["balls_size"] = avocados.balls_description_to_size(new_size)
				avocados.set_size(alterer.dna.features["balls_size"])
