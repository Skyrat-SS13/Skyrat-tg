//	This DMI holds our radial icons for the 'hide mutant parts' verb
#define HIDING_RADIAL_DMI 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/radial.dmi'

/mob/living/carbon/human/Topic(href, href_list)
	. = ..()

	if(href_list["lookup_info"])
		switch(href_list["lookup_info"])
			if("genitals")
				var/list/line = list()
				for(var/genital in GLOB.possible_genitals)
					if(!dna.species.mutant_bodyparts[genital])
						continue
					var/datum/sprite_accessory/genital/G = SSaccessories.sprite_accessories[genital][dna.species.mutant_bodyparts[genital][MUTANT_INDEX_NAME]]
					if(!G)
						continue
					if(G.is_hidden(src))
						continue
					var/obj/item/organ/external/genital/ORG = get_organ_slot(G.associated_organ_slot)
					if(!ORG)
						continue
					line += ORG.get_description_string(G)
				if(length(line))
					to_chat(usr, span_notice("[jointext(line, "\n")]"))
			if("open_examine_panel")
				tgui.holder = src
				tgui.ui_interact(usr) //datum has a tgui component, here we open the window

/mob/living/carbon/human/species/vox
	race = /datum/species/vox

/mob/living/carbon/human/species/vox_primalis
	race = /datum/species/vox_primalis

/mob/living/carbon/human/species/synth
	race = /datum/species/synthetic

/mob/living/carbon/human/species/mammal
	race = /datum/species/mammal

/mob/living/carbon/human/species/vulpkanin
	race = /datum/species/vulpkanin

/mob/living/carbon/human/species/tajaran
	race = /datum/species/tajaran

/mob/living/carbon/human/species/unathi
	race = /datum/species/unathi

/mob/living/carbon/human/species/podweak
	race = /datum/species/pod/podweak

/mob/living/carbon/human/species/xeno
	race = /datum/species/xeno

/mob/living/carbon/human/species/dwarf
	race = /datum/species/dwarf

/mob/living/carbon/human/species/ghoul
	race = /datum/species/ghoul

/mob/living/carbon/human/species/roundstartslime
	race = /datum/species/jelly/roundstartslime

/mob/living/carbon/human/species/teshari
	race = /datum/species/teshari

/mob/living/carbon/human/species/akula
	race = /datum/species/akula

/mob/living/carbon/human/species/skrell
	race = /datum/species/skrell

/mob/living/carbon/human/verb/toggle_undies()
	set category = "IC"
	set name = "Toggle underwear visibility"
	set desc = "Allows you to toggle which underwear should show or be hidden. Underwear will obscure genitals."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't toggle underwear visibility right now..."))
		return

	var/underwear_button = underwear_visibility & UNDERWEAR_HIDE_UNDIES ? "Show underwear" : "Hide underwear"
	var/undershirt_button = underwear_visibility & UNDERWEAR_HIDE_SHIRT ? "Show shirt" : "Hide shirt"
	var/socks_button = underwear_visibility & UNDERWEAR_HIDE_SOCKS ? "Show socks" : "Hide socks"
	var/bra_button = underwear_visibility & UNDERWEAR_HIDE_BRA ? "Show bra" : "Hide bra"
	var/list/choice_list = list("[underwear_button]" = "underwear", "[bra_button]" = "bra", "[undershirt_button]" = "shirt", "[socks_button]" = "socks","show all" = "show", "Hide all" = "hide")
	var/picked_visibility = input(src, "Choose visibility setting", "Show/Hide underwear") as null|anything in choice_list
	if(picked_visibility)
		var/picked_choice = choice_list[picked_visibility]
		switch(picked_choice)
			if("underwear")
				underwear_visibility ^= UNDERWEAR_HIDE_UNDIES
			if("bra")
				underwear_visibility ^= UNDERWEAR_HIDE_BRA
			if("shirt")
				underwear_visibility ^= UNDERWEAR_HIDE_SHIRT
			if("socks")
				underwear_visibility ^= UNDERWEAR_HIDE_SOCKS
			if("show")
				underwear_visibility = NONE
			if("hide")
				underwear_visibility = UNDERWEAR_HIDE_UNDIES | UNDERWEAR_HIDE_SHIRT | UNDERWEAR_HIDE_SOCKS | UNDERWEAR_HIDE_BRA
		update_body()
	return

/mob/living/carbon/human/revive(full_heal_flags = NONE, excess_healing = 0, force_grab_ghost = FALSE)
	. = ..()
	if(.)
		if(dna && dna.species)
			dna.species.spec_revival(src)

/mob/living/carbon/human/verb/toggle_mutant_part_visibility()
	set category = "IC"
	set name = "Show/Hide Mutant Parts"
	set desc = "Allows you to choose to try and hide your mutant bodyparts under your clothes."

	mutant_part_visibility()

/mob/living/carbon/human/proc/mutant_part_visibility(quick_toggle, re_do)
	// The parts our particular user can choose
	var/list/available_selection
	// The total list of parts choosable
	var/static/list/total_selection = list(
		ORGAN_SLOT_EXTERNAL_HORNS = "horns",
		ORGAN_SLOT_EXTERNAL_EARS = "ears",
		ORGAN_SLOT_EXTERNAL_WINGS = "wings",
		ORGAN_SLOT_EXTERNAL_TAIL = "tail",
		ORGAN_SLOT_EXTERNAL_SYNTH_ANTENNA = "ipc_antenna",
		ORGAN_SLOT_EXTERNAL_ANTENNAE = "moth_antennae",
		ORGAN_SLOT_EXTERNAL_XENODORSAL = "xenodorsal",
		ORGAN_SLOT_EXTERNAL_SPINES = "spines",
	)

	// Stat check
	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't do this right now..."))
		return

	// Only show the 'reveal all' button if we are already hiding something
	if(try_hide_mutant_parts)
		LAZYOR(available_selection, "reveal all")
	// Lets build our parts list
	for(var/organ_slot in total_selection)
		if(get_organ_slot(organ_slot))
			LAZYOR(available_selection, total_selection[organ_slot])

	// If this proc is called with the 'quick_toggle' flag, we skip the rest
	if(quick_toggle)
		if("reveal all" in available_selection)
			LAZYNULL(try_hide_mutant_parts)
		else
			for(var/part in available_selection)
				LAZYOR(try_hide_mutant_parts, part)
		update_mutant_bodyparts()
		return

	// Dont open the radial automatically just for one button
	if(re_do && (length(available_selection) == 1))
		return
	// If 'reveal all' is our only option just do it
	if(!re_do && (("reveal all" in available_selection) && (length(available_selection) == 1)))
		LAZYNULL(try_hide_mutant_parts)
		update_mutant_bodyparts()
		return

	// Radial rendering
	var/list/choices = list()
	for(var/choice in available_selection)
		var/datum/radial_menu_choice/option = new
		var/image/part_image = image(icon = HIDING_RADIAL_DMI, icon_state = initial(choice))

		option.image = part_image
		if(choice in try_hide_mutant_parts)
			part_image.underlays += image(icon = HIDING_RADIAL_DMI, icon_state = "module_unable")
		choices[initial(choice)] = option
	// Radial choices
	sort_list(choices)
	var/pick = show_radial_menu(usr, src, choices, custom_check = FALSE, tooltips = TRUE)
	if(!pick)
		return

	// Choice to action
	if(pick == "reveal all")
		to_chat(usr, span_notice("You are no longer trying to hide your mutant parts."))
		LAZYNULL(try_hide_mutant_parts)
		update_mutant_bodyparts()
		return

	else if(pick in try_hide_mutant_parts)
		to_chat(usr, span_notice("You are no longer trying to hide your [pick]."))
		LAZYREMOVE(try_hide_mutant_parts, pick)
	else
		to_chat(usr, span_notice("You are now trying to hide your [pick]."))
		LAZYOR(try_hide_mutant_parts, pick)
	update_mutant_bodyparts()
	// automatically re-do the menu after making a selection
	mutant_part_visibility(re_do = TRUE)


// Feign impairment verb
#define DEFAULT_TIME 30
#define MAX_TIME 36000 // 10 hours

/mob/living/carbon/human/verb/acting()
	set category = "IC"
	set name = "Feign Impairment"
	set desc = "Pretend to be impaired for a defined duration."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't do this right now..."))
		return

	var/static/list/choices = list("drunkenness", "stuttering", "jittering")
	var/impairment = tgui_input_list(src, "Select an impairment to perform:", "Impairments", choices)
	if(!impairment)
		return

	var/duration = tgui_input_number(src, "How long would you like to feign [impairment] for?", "Duration in seconds", DEFAULT_TIME, MAX_TIME)
	switch(impairment)
		if("drunkenness")
			var/mob/living/living_user = usr
			if(istype(living_user))
				living_user.add_mood_event("drunk", /datum/mood_event/drunk)
			set_slurring_if_lower(duration SECONDS)
		if("stuttering")
			set_stutter_if_lower(duration SECONDS)
		if("jittering")
			set_jitter_if_lower(duration SECONDS)

	if(duration)
		addtimer(CALLBACK(src, PROC_REF(acting_expiry), impairment), duration SECONDS)
		to_chat(src, "You are now feigning [impairment].")

/mob/living/carbon/human/proc/acting_expiry(impairment)
	if(impairment)
		// Procs when fake impairment duration ends, useful for calling extra events to wrap up too
		if(impairment == "drunkenness")
			var/mob/living/living_user = usr
			if(istype(living_user))
				living_user.clear_mood_event("drunk")
		// Notify the user
		to_chat(src, "You are no longer feigning [impairment].")

#undef DEFAULT_TIME
#undef MAX_TIME
#undef HIDING_RADIAL_DMI
