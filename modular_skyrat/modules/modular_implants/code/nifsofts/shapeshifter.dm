/obj/item/disk/nifsoft_uploader/shapeshifter
	name = "Polymorph"
	loaded_nifsoft = /datum/nifsoft/action_granter/shapeshifter

/datum/nifsoft/action_granter/shapeshifter
	name = "Polymorph"
	program_desc = "This program is a large-scale refitting of the nanomachine channels running over the skin of a NIF user. This allows the nanites to reach under the skin and even into the very bone structure of the host; including incorporation of mimetic materials and femto-level manipulation devices all for the purpose of allowing the user to, essentially, shapeshift on a low level. However, despite the incredible complexity behind these processes, there are still limits on the range of 'forms' a user can take. Mass can neither be created nor destroyed, after all, and you can only distribute and rearrange it in so many ways across a functioning humanoid body; meaning, the user cannot adopt forms too far out of their 'true' one."
	compatible_nifs = list(/obj/item/organ/internal/cyberimp/brain/nif/standard)
	purchase_price = 350
	buying_category = NIFSOFT_CATEGORY_COSMETIC
	ui_icon = "paintbrush"
	action_to_grant = /datum/action/innate/alter_form/nif


/// The NIF version of alter form. This lacks the ability to change body color.
/datum/action/innate/alter_form/nif
	name = "Polymorph"
	slime_restricted =  FALSE
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "slime"
	shapeshift_text = "closes their eyes to focus, their body subtly shifting and contorting."

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

