/obj/item/disk/nifsoft_uploader/shapeshifter
	loaded_nifsoft = /datum/nifsoft/shapeshifter

/datum/nifsoft/shapeshifter
	name = "Shapeshifter"
	desc = "Allows the user to change the apperance of their body at will"

	cost = 500
	activation_cost = 10
	active_mode = TRUE
	active_cost = 5
	///What user is being modified?
	var/mob/living/carbon/human/modified_human
	var/datum/action/innate/alter_form/nif/shapeshifter

/datum/nifsoft/shapeshifter/New()
	. = ..()

	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif
	modified_human = installed_nif.linked_mob

/datum/nifsoft/shapeshifter/activate()
	. = ..()
	if(active)
		shapeshifter = new
		shapeshifter.Grant(modified_human)
		return

	if(shapeshifter)
		shapeshifter.Remove(modified_human)

/// The NIF version of alter form. This lacks the ability to change body color.
/datum/action/innate/alter_form/nif
	name = "Shapeshift"
	slime_restricted =  FALSE

/datum/action/innate/alter_form/nif/change_form(mob/living/carbon/human/alterer)
	var/selected_alteration = show_radial_menu(
		alterer,
		alterer,
		list(
			"DNA" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "dna"),
			"Hair" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "scissors"),
			"Markings" = image(icon = 'modular_skyrat/master_files/icons/mob/actions/actions_slime.dmi', icon_state = "rainbow_spraycan"),
		),
		tooltips = TRUE,
	)
	if(!selected_alteration)
		return
	switch(selected_alteration)
		if("DNA")
			alter_dna(alterer)
		if("Hair")
			alter_hair(alterer)
		if("Markings")
			alter_markings(alterer)

