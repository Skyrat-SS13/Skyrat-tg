/obj/item/organ/genital
	color = "#fcccb3"
	organ_flags = ORGAN_EDIBLE | ORGAN_NO_DISMEMBERMENT
	///Size value of the genital, needs to be translated to proper lengths/diameters/cups
	var/genital_size = 1
	///Type of the genital. For penises tapered/horse/human etc. for breasts quadruple/sixtuple etc...
	var/genital_type = "human"
	///Used for determining what sprite is being used, derrives from size and type
	var/sprite_suffix 
	///Used for input from the user whether to show a genital through clothing or not, always or never etc.
	var/visibility_preference = GENITAL_HIDDEN_BY_CLOTHES
	///Whether the organ is aroused, matters for sprites, use a 0 or 1 for easy string append
	var/aroused = 0

//This translates the float size into a sprite string
/obj/item/organ/genital/proc/get_sprite_size_string()
	return 0

//This translates the float size into a sprite string
/obj/item/organ/genital/proc/update_sprite_suffix()
	sprite_suffix = "[get_sprite_size_string()]"

/obj/item/organ/genital/proc/get_description_string()
	return "genitals"

/obj/item/organ/genital/proc/set_type_and_size(type, size)
	genital_type = type
	genital_size = size
	update_sprite_suffix()

/obj/item/organ/genital/Initialize()
	. = ..()
	update_sprite_suffix()

/obj/item/organ/genital/penis
	name = "penis"
	desc = "A male reproductive organ."
	icon_state = "penis"
	icon = 'modular_skyrat/icons/obj/genitals/penis.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_PENIS
	var/girth = 9

/obj/item/organ/genital/penis/get_sprite_size_string()
	var/size_affix
	var/measured_size = FLOOR(genital_size,1)
	if(measured_size < 1)
		measured_size = 1
	switch(measured_size)
		if(1 to 8)
			size_affix = "1"
		if(9 to 15)
			size_affix = "2"
		if(16 to 25)
			size_affix = "3"
		else
			size_affix = "4"
	return "[size_affix]_[aroused]"

/obj/item/organ/genital/penis/build_from_dna(datum/dna/DNA, associated_key)
	..()
	var/type = lowertext(DNA.mutant_bodyparts[associated_key][MUTANT_INDEX_NAME])
	girth = DNA.features["penis_girth"]
	set_type_and_size(type, DNA.features["penis_size"])

/obj/item/organ/genital/testicles
	name = "testicles"
	desc = "A male reproductive organ."
	icon_state = "testicles"
	icon = 'modular_skyrat/icons/obj/genitals/testicles.dmi'
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TESTICLES

/obj/item/organ/genital/testicles/build_from_dna(datum/dna/DNA, associated_key)
	..()
	var/type = lowertext(DNA.mutant_bodyparts[associated_key][MUTANT_INDEX_NAME])
	set_type_and_size(type, DNA.features["balls_size"])

/obj/item/organ/genital/testicles/get_sprite_size_string()
	var/measured_size = FLOOR(genital_size,1)
	if(measured_size < 0)
		measured_size = 0
	else if (measured_size > 3)
		measured_size = 3
	return "[measured_size]"

/obj/item/organ/genital/vagina
	name = "vagina"
	icon = 'modular_skyrat/icons/obj/genitals/vagina.dmi'
	icon_state = "vagina"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA

/obj/item/organ/genital/womb
	name = "womb"
	desc = "A female reproductive organ."
	icon = 'modular_skyrat/icons/obj/genitals/vagina.dmi'
	icon_state = "womb"
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_WOMB
	visibility_preference = GENITAL_SKIP_VISIBILITY

/obj/item/organ/genital/breasts
	name = "breasts"
	desc = "Female milk producing organs."
	icon_state = "breasts"
	icon = 'modular_skyrat/icons/obj/genitals/breasts.dmi'
	genital_type = "pair"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_BREASTS
	var/lactates = FALSE

/obj/item/organ/genital/breasts/get_sprite_size_string()
	var/max_size = 5
	if(genital_type == "pair")
		max_size = 16
	var/current_size = FLOOR(genital_size, 1)
	if(current_size < 0)
		current_size = 0 
	else if (current_size > max_size)
		current_size = max_size
	return current_size

/obj/item/organ/genital/breasts/build_from_dna(datum/dna/DNA, associated_key)
	..()
	var/type = lowertext(DNA.mutant_bodyparts[associated_key][MUTANT_INDEX_NAME])
	lactates = DNA.features["breasts_lactation"]
	set_type_and_size(type, DNA.features["breasts_size"])

/proc/breasts_size_to_cup(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.breasts_size_translation["[number]"]
	if(!returned)
		returned = "beyond measurement"
	return returned

/proc/breasts_cup_to_size(cup)
	for(var/key in GLOB.breasts_size_translation)
		if(GLOB.breasts_size_translation[key] == cup)
			return text2num(key)
	return 0

/proc/balls_size_to_description(number)
	if(number < 0)
		number = 0
	var/returned = GLOB.balls_size_translation["[number]"]
	if(!returned)
		returned = "beyond measurement"
	return returned

/proc/balls_description_to_size(cup)
	for(var/key in GLOB.balls_size_translation)
		if(GLOB.balls_size_translation[key] == cup)
			return text2num(key)
	return 0

/mob/living/carbon/verb/toggle_genitals()
	set category = "IC"
	set name = "Expose/Hide genitals"
	set desc = "Allows you to toggle which genitals should show through clothes or not."

	if(stat != CONSCIOUS)
		to_chat(usr, "<span class='warning'>You can toggle genitals visibility right now...</span>")
		return

	var/list/genital_list = list()
	for(var/obj/item/organ/genital/G in internal_organs)
		if(!G.visibility_preference == GENITAL_SKIP_VISIBILITY)
			genital_list += G
	if(!genital_list.len) //There is nothing to expose
		return
	//Full list of exposable genitals created
	var/obj/item/organ/genital/picked_organ
	picked_organ = input(src, "Choose which genitalia to expose/hide", "Expose/Hide genitals") as null|anything in genital_list
	if(picked_organ && (picked_organ in internal_organs))
		var/static/list/gen_vis_trans = list("Never show" = GENITAL_NEVER_SHOW,
												"Hidden by clothes" = GENITAL_HIDDEN_BY_CLOTHES,
												"Always show" = GENITAL_ALWAYS_SHOW
												)
		var/picked_visibility = input(src, "Choose visibility setting", "Expose/Hide genitals") as null|anything in gen_vis_trans
		if(picked_visibility && picked_organ && (picked_organ in internal_organs))
			picked_organ.visibility_preference = gen_vis_trans[picked_visibility]
			update_body()
	return
