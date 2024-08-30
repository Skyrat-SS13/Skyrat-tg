/obj/item/organ/external/genital
	color = "#fcccb3"
	organ_flags = ORGAN_ORGANIC | ORGAN_UNREMOVABLE
	///Size value of the genital, needs to be translated to proper lengths/diameters/cups
	var/genital_size = 1
	///Sprite name of the genital, it's what shows up on character creation
	var/genital_name = "Human"
	///Type of the genital. For penises tapered/horse/human etc. for breasts quadruple/sixtuple etc...
	var/genital_type = SPECIES_HUMAN
	///Used for determining what sprite is being used, derrives from size and type
	var/sprite_suffix
	///Used for input from the user whether to show a genital through clothing or not, always or never etc.
	var/visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	///Whether the organ is aroused, matters for sprites, use AROUSAL_CANT, AROUSAL_NONE, AROUSAL_PARTIAL or AROUSAL_FULL
	var/aroused = AROUSAL_NONE
	///Whether the organ is supposed to use a skintoned variant of the sprite
	var/uses_skintones = FALSE
	///Whether the organ is supposed to use the color of the holder's skin tone.
	var/uses_skin_color = FALSE
	/// Where the genital is actually located, for clothing checks.
	var/genital_location = GROIN

//This translates the float size into a sprite string
/obj/item/organ/external/genital/proc/get_sprite_size_string()
	return 0

//This translates the float size into a sprite string
/obj/item/organ/external/genital/proc/update_sprite_suffix()
	sprite_suffix = "[get_sprite_size_string()]"

	var/datum/bodypart_overlay/mutant/genital/our_overlay = bodypart_overlay

	our_overlay.sprite_suffix = sprite_suffix


/obj/item/organ/external/genital/proc/get_description_string(datum/sprite_accessory/genital/gas)
	return "You see genitals"

/obj/item/organ/external/genital/proc/update_genital_icon_state()
	return

/obj/item/organ/external/genital/proc/set_size(size)
	genital_size = size
	update_sprite_suffix()

/obj/item/organ/external/genital/Initialize(mapload)
	. = ..()
	update_sprite_suffix()
	if(CONFIG_GET(flag/disable_lewd_items))
		return INITIALIZE_HINT_QDEL

//Removes ERP organs depending on config
/obj/item/organ/external/genital/Insert(mob/living/carbon/M, special, movement_flags)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return
	. = ..()

/obj/item/organ/external/genital/Remove(mob/living/carbon/M, special = FALSE, moving)
	. = ..()
	update_genital_icon_state()

/obj/item/organ/external/genital/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	var/datum/sprite_accessory/genital/accessory = SSaccessories.sprite_accessories[associated_key][DNA.mutant_bodyparts[associated_key][MUTANT_INDEX_NAME]]
	genital_name = accessory.name
	genital_type = accessory.icon_state
	build_from_accessory(accessory, DNA)
	update_sprite_suffix()

	var/datum/bodypart_overlay/mutant/genital/our_overlay = bodypart_overlay

	our_overlay.color_source = uses_skin_color ? ORGAN_COLOR_INHERIT : ORGAN_COLOR_OVERRIDE

/// for specific build_from_dna behavior that also checks the genital accessory.
/obj/item/organ/external/genital/proc/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	return

/obj/item/organ/external/genital/proc/is_exposed()
	if(!owner)
		return TRUE

	if(!ishuman(owner))
		return TRUE

	var/mob/living/carbon/human/human = owner

	switch(visibility_preference)
		if(GENITAL_ALWAYS_SHOW)
			return TRUE
		if(GENITAL_HIDDEN_BY_CLOTHES)
			if((human.w_uniform && human.w_uniform.body_parts_covered & genital_location) || (human.wear_suit && human.wear_suit.body_parts_covered & genital_location))
				return FALSE
			else
				return TRUE
		else
			return FALSE


/datum/bodypart_overlay/mutant/genital
	layers = EXTERNAL_FRONT
	color_source = ORGAN_COLOR_OVERRIDE
	/// The suffix appended to the feature_key for the overlays.
	var/sprite_suffix

/datum/bodypart_overlay/mutant/genital/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/genital/get_base_icon_state()
	return sprite_suffix


/datum/bodypart_overlay/mutant/genital/get_color_layer_names(icon_state_to_lookup)
	if(length(sprite_datum.color_layer_names))
		return sprite_datum.color_layer_names

	sprite_datum.color_layer_names = list()
	if (!SSaccessories.cached_mutant_icon_files[sprite_datum.icon])
		SSaccessories.cached_mutant_icon_files[sprite_datum.icon] = icon_states(new /icon(sprite_datum.icon))

	var/list/cached_mutant_icon_states = SSaccessories.cached_mutant_icon_files[sprite_datum.icon]

	for (var/layer in all_layers)
		if(!(layer & layers))
			continue

		var/layertext = mutant_bodyparts_layertext(bitflag_to_layer(layer))
		if ("m_[feature_key]_[get_base_icon_state()]_[layertext]_primary" in cached_mutant_icon_states)
			sprite_datum.color_layer_names["1"] = "primary"
		if ("m_[feature_key]_[get_base_icon_state()]_[layertext]_secondary" in cached_mutant_icon_states)
			sprite_datum.color_layer_names["2"] = "secondary"
		if ("m_[feature_key]_[get_base_icon_state()]_[layertext]_tertiary" in cached_mutant_icon_states)
			sprite_datum.color_layer_names["3"] = "tertiary"

	return sprite_datum.color_layer_names


/obj/item/organ/external/genital/penis
	name = "penis"
	desc = "A male reproductive organ."
	icon_state = "penis"
	icon = 'modular_skyrat/master_files/icons/obj/genitals/penis.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_PENIS
	mutantpart_key = ORGAN_SLOT_PENIS
	mutantpart_info = list(MUTANT_INDEX_NAME = "Human", MUTANT_INDEX_COLOR_LIST = list("#FFEEBB"))
	drop_when_organ_spilling = FALSE
	var/girth = 9
	var/sheath = SHEATH_NONE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/penis

/datum/bodypart_overlay/mutant/genital/penis
	feature_key = ORGAN_SLOT_PENIS
	layers = EXTERNAL_FRONT | EXTERNAL_BEHIND


/obj/item/organ/external/genital/penis/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = ""
	var/pname = lowertext(genital_name) == "nondescript" ? "" : lowertext(genital_name) + " "
	if(sheath != SHEATH_NONE && aroused != AROUSAL_FULL) //Hidden in sheath
		switch(sheath)
			if(SHEATH_NORMAL)
				returned_string = "You see a sheath."
			if(SHEATH_SLIT)
				returned_string = "You see a slit." ///Typo fix.
		if(aroused == AROUSAL_PARTIAL)
			returned_string += " There's a [pname]penis poking out of it."
	else
		returned_string = "You see a [pname]penis. You estimate it's [genital_size] inches long, and [girth] inches in circumference."
		switch(aroused)
			if(AROUSAL_NONE)
				returned_string += " It seems flaccid."
			if(AROUSAL_PARTIAL)
				returned_string += " It's partically erect."
			if(AROUSAL_FULL)
				returned_string += " It's fully erect."
	return returned_string

/obj/item/organ/external/genital/penis/update_genital_icon_state()
	var/size_affix
	var/measured_size = FLOOR(genital_size,1)
	if(measured_size < 1)
		measured_size = 1
	switch(measured_size)
		if(1 to 8)
			size_affix = "1"
		if(9 to 15)
			size_affix = "2"
		if(16 to 24)
			size_affix = "3"
		else
			size_affix = "4"
	var/passed_string = "penis_[genital_type]_[size_affix]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/external/genital/penis/get_sprite_size_string()
	if(aroused != AROUSAL_FULL && sheath != SHEATH_NONE) //Sheath time!
		var/poking_out = 0
		if(aroused == AROUSAL_PARTIAL)
			poking_out = 1
		return "[lowertext(sheath)]_[poking_out]"

	var/size_affix
	var/measured_size = FLOOR(genital_size,1)
	var/is_erect = 0
	if(aroused == AROUSAL_FULL)
		is_erect = 1
	if(measured_size < 1)
		measured_size = 1
	switch(measured_size)
		if(1 to 8)
			size_affix = "1"
		if(9 to 15)
			size_affix = "2"
		if(16 to 24)
			size_affix = "3"
		else
			size_affix = "4"
	var/passed_string = "[genital_type]_[size_affix]_[is_erect]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/obj/item/organ/external/genital/penis/build_from_dna(datum/dna/DNA, associated_key)
	girth = DNA.features["penis_girth"]
	uses_skin_color = DNA.features["penis_uses_skincolor"]
	set_size(DNA.features["penis_size"])

	return ..()

/obj/item/organ/external/genital/penis/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	var/datum/sprite_accessory/genital/penis/snake = accessory
	if(snake.can_have_sheath)
		sheath = DNA.features["penis_sheath"]
	if(DNA.features["penis_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading

/datum/bodypart_overlay/mutant/genital/penis/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_PENIS]


/obj/item/organ/external/genital/testicles
	name = "testicles"
	desc = "A male reproductive organ."
	icon_state = "testicles"
	icon = 'modular_skyrat/master_files/icons/obj/genitals/testicles.dmi'
	mutantpart_key = ORGAN_SLOT_TESTICLES
	mutantpart_info = list(MUTANT_INDEX_NAME = "Pair", MUTANT_INDEX_COLOR_LIST = list("#FFEEBB"))
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES
	aroused = AROUSAL_CANT
	genital_location = GROIN
	drop_when_organ_spilling = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/testicles

/datum/bodypart_overlay/mutant/genital/testicles
	feature_key = ORGAN_SLOT_TESTICLES
	layers = EXTERNAL_ADJACENT | EXTERNAL_BEHIND

/obj/item/organ/external/genital/testicles/update_genital_icon_state()
	var/measured_size = clamp(genital_size, 1, TESTICLES_MAX_SIZE)
	var/passed_string = "testicles_[genital_type]_[measured_size]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/external/genital/testicles/get_description_string(datum/sprite_accessory/genital/gas)
	if(genital_name == "Internal") //Checks if Testicles are of Internal Variety
		visibility_preference = GENITAL_SKIP_VISIBILITY //Removes visibility if yes.
	else
		return "You see a pair of testicles, they look [lowertext(balls_size_to_description(genital_size))]."

/obj/item/organ/external/genital/testicles/build_from_dna(datum/dna/DNA, associated_key)
	uses_skin_color = DNA.features["testicles_uses_skincolor"]
	set_size(DNA.features["balls_size"])

	return ..()

/obj/item/organ/external/genital/testicles/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["testicles_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading

/obj/item/organ/external/genital/testicles/get_sprite_size_string()
	var/measured_size = FLOOR(genital_size,1)
	measured_size = clamp(measured_size, 0, TESTICLES_MAX_SIZE)
	var/passed_string = "[genital_type]_[measured_size]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/datum/bodypart_overlay/mutant/genital/testicles/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_TESTICLES]


/obj/item/organ/external/genital/testicles/proc/balls_size_to_description(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.balls_size_translation["[number]"]
	if(!returned)
		returned = BREAST_SIZE_BEYOND_MEASUREMENT
	return returned

/obj/item/organ/external/genital/testicles/proc/balls_description_to_size(cup)
	for(var/key in GLOB.balls_size_translation)
		if(GLOB.balls_size_translation[key] == cup)
			return text2num(key)
	return 0


/obj/item/organ/external/genital/vagina
	name = "vagina"
	icon = 'modular_skyrat/master_files/icons/obj/genitals/vagina.dmi'
	icon_state = "vagina"
	mutantpart_key = ORGAN_SLOT_VAGINA
	mutantpart_info = list(MUTANT_INDEX_NAME = "Human", MUTANT_INDEX_COLOR_LIST = list("#FFEEBB"))
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA
	genital_location = GROIN
	drop_when_organ_spilling = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/vagina

/datum/bodypart_overlay/mutant/genital/vagina
	feature_key = ORGAN_SLOT_VAGINA
	layers = EXTERNAL_FRONT

/obj/item/organ/external/genital/vagina/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see a [lowertext(genital_name)] vagina."
	if(lowertext(genital_name) == "cloaca")
		returned_string = "You see a cloaca." //i deserve a pipebomb for this
	switch(aroused)
		if(AROUSAL_NONE)
			returned_string += " It seems dry."
		if(AROUSAL_PARTIAL)
			returned_string += " It's glistening with arousal."
		if(AROUSAL_FULL)
			returned_string += " It's bright and dripping with arousal."
	return returned_string

/obj/item/organ/external/genital/vagina/get_sprite_size_string()
	var/is_dripping = 0
	if(aroused == AROUSAL_FULL)
		is_dripping = 1
	return "[genital_type]_[is_dripping]"

/obj/item/organ/external/genital/vagina/build_from_dna(datum/dna/DNA, associated_key)
	uses_skin_color = DNA.features["vagina_uses_skincolor"]

	return ..() // will update the sprite suffix

/obj/item/organ/external/genital/vagina/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["vagina_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading

/datum/bodypart_overlay/mutant/genital/vagina/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_VAGINA]


/obj/item/organ/external/genital/womb
	name = "womb"
	desc = "A female reproductive organ."
	icon = 'modular_skyrat/master_files/icons/obj/genitals/vagina.dmi'
	icon_state = "womb"
	mutantpart_key = ORGAN_SLOT_WOMB
	mutantpart_info = list(MUTANT_INDEX_NAME = "Normal", MUTANT_INDEX_COLOR_LIST = list("FFEEBB"))
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_WOMB
	visibility_preference = GENITAL_SKIP_VISIBILITY
	aroused = AROUSAL_CANT
	genital_location = GROIN
	drop_when_organ_spilling = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/womb

/datum/bodypart_overlay/mutant/genital/womb
	feature_key = ORGAN_SLOT_WOMB
	layers = NONE

/datum/bodypart_overlay/mutant/genital/womb/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_WOMB]


/obj/item/organ/external/genital/anus
	name = "anus"
	desc = "What do you want me to tell you?"
	icon = 'modular_skyrat/master_files/icons/obj/genitals/anus.dmi'
	icon_state = "anus"
	mutantpart_key = ORGAN_SLOT_ANUS
	mutantpart_info = list(MUTANT_INDEX_NAME = "Normal", MUTANT_INDEX_COLOR_LIST = list("FEB"))
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_ANUS
	genital_location = GROIN
	drop_when_organ_spilling = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/anus

/datum/bodypart_overlay/mutant/genital/anus
	feature_key = ORGAN_SLOT_ANUS
	layers = NONE

/obj/item/organ/external/genital/anus/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see an [lowertext(genital_name)]."
	if(aroused == AROUSAL_PARTIAL)
		returned_string += " It looks tight."
	if(aroused == AROUSAL_FULL)
		returned_string += " It looks very tight."
	return returned_string

/datum/bodypart_overlay/mutant/genital/anus/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_ANUS]


/obj/item/organ/external/genital/breasts
	name = "breasts"
	desc = "Female milk producing organs."
	icon_state = "breasts"
	icon = 'modular_skyrat/master_files/icons/obj/genitals/breasts.dmi'
	genital_type = "pair"
	mutantpart_key = ORGAN_SLOT_BREASTS
	mutantpart_info = list(MUTANT_INDEX_NAME = "Pair", MUTANT_INDEX_COLOR_LIST = list("#FFEEBB"))
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BREASTS
	genital_location = CHEST
	drop_when_organ_spilling = FALSE
	var/lactates = FALSE
	bodypart_overlay = /datum/bodypart_overlay/mutant/genital/breasts

/datum/bodypart_overlay/mutant/genital/breasts
	feature_key = ORGAN_SLOT_BREASTS
	layers = EXTERNAL_FRONT | EXTERNAL_BEHIND

/obj/item/organ/external/genital/breasts/get_description_string(datum/sprite_accessory/genital/gas)
	var/returned_string = "You see a [lowertext(genital_name)] of breasts."
	var/size_description
	var/translation = breasts_size_to_cup(genital_size)
	switch(translation)
		if(BREAST_SIZE_FLATCHESTED)
			size_description = " They are small and flat, however."
		if(BREAST_SIZE_BEYOND_MEASUREMENT)
			size_description = " Their size is enormous, you estimate they're around [genital_size] inches in diameter."
		else
			size_description = " You estimate they are [translation]-cups."
	returned_string += size_description
	if(aroused == AROUSAL_FULL)
		if(lactates)
			returned_string += " The nipples seem hard, perky and are leaking milk."
		else
			returned_string += " Their nipples look hard and perky."
	return returned_string

/obj/item/organ/external/genital/breasts/update_genital_icon_state()
	var/max_size = 5
	var/current_size = FLOOR(genital_size, 1)
	if(current_size < 0)
		current_size = 0
	else if (current_size > max_size)
		current_size = max_size
	var/passed_string = "breasts_pair_[current_size]"
	if(uses_skintones)
		passed_string += "_s"
	icon_state = passed_string

/obj/item/organ/external/genital/breasts/get_sprite_size_string()
	var/max_size = 5
	if(genital_type == "pair")
		max_size = 16
	var/current_size = FLOOR(genital_size, 1)
	if(current_size < 0)
		current_size = 0
	else if (current_size > max_size)
		current_size = max_size
	var/passed_string = "[genital_type]_[current_size]"
	if(uses_skintones)
		passed_string += "_s"
	return passed_string

/obj/item/organ/external/genital/breasts/build_from_dna(datum/dna/DNA, associated_key)
	lactates = DNA.features["breasts_lactation"]
	uses_skin_color = DNA.features["breasts_uses_skincolor"]
	set_size(DNA.features["breasts_size"])

	return ..()

/obj/item/organ/external/genital/breasts/build_from_accessory(datum/sprite_accessory/genital/accessory, datum/dna/DNA)
	if(DNA.features["breasts_uses_skintones"])
		uses_skintones = accessory.has_skintone_shading

/datum/bodypart_overlay/mutant/genital/breasts/get_global_feature_list()
	return SSaccessories.sprite_accessories[ORGAN_SLOT_BREASTS]

/obj/item/organ/external/genital/breasts/proc/breasts_size_to_cup(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.breast_size_translation["[number]"]
	if(!returned)
		returned = BREAST_SIZE_BEYOND_MEASUREMENT
	return returned

/obj/item/organ/external/genital/breasts/proc/breasts_cup_to_size(cup)
	for(var/key in GLOB.breast_size_translation)
		if(GLOB.breast_size_translation[key] == cup)
			return text2num(key)
	return 0


/mob/living/carbon/human/verb/toggle_genitals()
	set category = "IC"
	set name = "Expose/Hide genitals"
	set desc = "Allows you to toggle which genitals should show through clothes or not."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle genitals visibility right now..."))
		return

	var/list/genital_list = list()
	for(var/obj/item/organ/external/genital/genital in organs)
		if(!genital.visibility_preference == GENITAL_SKIP_VISIBILITY)
			genital_list += genital
	if(!genital_list.len) //There is nothing to expose
		return
	//Full list of exposable genitals created
	var/obj/item/organ/external/genital/picked_organ
	picked_organ = input(src, "Choose which genitalia to expose/hide", "Expose/Hide genitals") as null|anything in genital_list
	if(picked_organ && (picked_organ in organs))
		var/list/gen_vis_trans = list("Never show" = GENITAL_NEVER_SHOW,
												"Hidden by clothes" = GENITAL_HIDDEN_BY_CLOTHES,
												"Always show" = GENITAL_ALWAYS_SHOW
												)
		var/picked_visibility = input(src, "Choose visibility setting", "Expose/Hide genitals") as null|anything in gen_vis_trans
		if(picked_visibility && picked_organ && (picked_organ in organs))
			picked_organ.visibility_preference = gen_vis_trans[picked_visibility]
			update_body()
	return

//Removing ERP IC verb depending on config
/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	if(CONFIG_GET(flag/disable_erp_preferences))
		verbs -= /mob/living/carbon/human/verb/toggle_genitals
		verbs -= /mob/living/carbon/human/verb/toggle_arousal

/mob/living/carbon/human/verb/toggle_arousal()
	set category = "IC"
	set name = "Toggle Arousal"
	set desc = "Allows you to toggle how aroused your private parts are."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle arousal right now..."))
		return

	var/list/genital_list = list()
	for(var/obj/item/organ/external/genital/genital in organs)
		if(!genital.aroused == AROUSAL_CANT)
			genital_list += genital
	if(!genital_list.len) //There is nothing to expose
		return
	//Full list of exposable genitals created
	var/obj/item/organ/external/genital/picked_organ
	picked_organ = input(src, "Choose which genitalia to change arousal", "Expose/Hide genitals") as null|anything in genital_list
	if(picked_organ && (picked_organ in organs))
		var/list/gen_arous_trans = list(
			"Not aroused" = AROUSAL_NONE,
			"Partly aroused" = AROUSAL_PARTIAL,
			"Very aroused" = AROUSAL_FULL,
		)
		var/picked_arousal = input(src, "Choose arousal", "Toggle Arousal") as null|anything in gen_arous_trans
		if(picked_arousal && picked_organ && (picked_organ in organs))
			picked_organ.aroused = gen_arous_trans[picked_arousal]
			picked_organ.update_sprite_suffix()
			update_body()
	return
