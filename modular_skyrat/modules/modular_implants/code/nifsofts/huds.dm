/datum/nifsoft/hud
	name = "Blank HUD"
	program_desc = "Provides the overlay of a hud on compatible eyewear."
	compatible_nifs = list(/obj/item/organ/internal/cyberimp/brain/nif/standard)
	active_mode = TRUE
	active_cost = 0.5
	ui_icon = "eye"
	/// Do we need to check if the user is wearing compatible eyewear?
	var/eyewear_check = TRUE
	/// What kind of HUD are we adding when the NIFSoft is activated?
	var/hud_type
	/// What is the HUD trait we are adding when the NIFSoft is activated?
	var/hud_trait
	/// A list of traits that we want to add while the NIFSoft is active. This is here to emulate things like sci-goggles
	var/list/added_eyewear_traits = list()

/datum/nifsoft/hud/activate()
	. = ..()
	if(!.)
		return FALSE

	if(!active)
		if(hud_type)
			var/datum/atom_hud/hud = GLOB.huds[hud_type]
			hud.hide_from(linked_mob)
		if(hud_trait)
			REMOVE_TRAIT(linked_mob, hud_trait, NIFSOFT_TRAIT)

		for(var/trait as anything in added_eyewear_traits)
			REMOVE_TRAIT(linked_mob, trait, NIFSOFT_TRAIT)

		return TRUE

	if(eyewear_check)
		var/obj/item/clothing/glasses/nif_hud/hud_glasses = linked_mob.get_item_by_slot(ITEM_SLOT_EYES)
		if(!istype(hud_glasses))
			linked_mob.balloon_alert(linked_mob, "You need to wear a piece of compatible eyewear for this to work.")
			return FALSE

	if(hud_type)
		var/datum/atom_hud/our_hud = GLOB.huds[hud_type]
		our_hud.show_to(linked_mob)
	if(hud_trait)
		ADD_TRAIT(linked_mob, hud_trait, GLASSES_TRAIT)

	for(var/trait as anything in added_eyewear_traits)
		ADD_TRAIT(linked_mob, trait, NIFSOFT_TRAIT)

	return TRUE

/datum/nifsoft/hud/job
	mutually_exclusive_programs = list(/datum/nifsoft/hud/job) //We don't want people stacking job HUDs

//
// JOB NIFSOFT HUDS
//

/datum/nifsoft/hud/job/medical
	name = "Medical HUD"
	program_desc = "Allows the user to view a medical HUD when wearing compatible eyewear."
	ui_icon = "staff-snake"
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	hud_trait = TRAIT_MEDICAL_HUD

/datum/nifsoft/hud/job/diagnostic
	name = "Diagnostic HUD"
	program_desc = "Allows the user to view a diagnostic HUD when wearing compatible eyewear."
	ui_icon = "robot"
	hud_type = DATA_HUD_DIAGNOSTIC_BASIC
	hud_trait = TRAIT_DIAGNOSTIC_HUD

/datum/nifsoft/hud/job/security
	name = "Security HUD"
	program_desc = "Allows the user to view a security HUD when wearing compatible eyewear."
	ui_icon = "shield"
	hud_type = DATA_HUD_SECURITY_ADVANCED
	hud_trait = TRAIT_SECURITY_HUD

/datum/nifsoft/hud/job/cargo_tech
	name = "Permit HUD"
	program_desc = "Allows the user to view a permit HUD when wearing compatible eyewear."
	ui_icon = "gun"
	hud_type = DATA_HUD_PERMIT

/datum/nifsoft/hud/job/science
	name = "Science HUD"
	program_desc = "Allows the user to view a science HUD when wearing compatible eyewear."
	ui_icon = "flask"
	added_eyewear_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

//
// UPLOADER DISKS
//

/obj/item/disk/nifsoft_uploader/med_hud
	name = "Medical HUD"
	loaded_nifsoft = /datum/nifsoft/hud/job/medical

/obj/item/disk/nifsoft_uploader/diag_hud
	name = "Diagnostic HUD"
	loaded_nifsoft = /datum/nifsoft/hud/job/diagnostic

/obj/item/disk/nifsoft_uploader/security
	name = "Security HUD"
	loaded_nifsoft = /datum/nifsoft/hud/job/security

/obj/item/disk/nifsoft_uploader/cargo_tech
	name = "Permit HUD"
	loaded_nifsoft = /datum/nifsoft/hud/job/cargo_tech

/obj/item/disk/nifsoft_uploader/science
	name = "Science HUD"
	loaded_nifsoft = /datum/nifsoft/hud/job/science


//
// NIFSOFT HUD GLASSES
//

/obj/item/clothing/glasses/nif_hud
	name = "NIF HUD glasses"
	desc = "Glasses that interface with a NIF"

/obj/item/clothing/glasses/nif_hud/dropped(mob/living/carbon/human/user)
	. = ..()
	if(!istype(user))
		return FALSE

	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = user.get_organ_by_type(/obj/item/organ/internal/cyberimp/brain/nif)
	if(!target_nif)
		return FALSE

	for(var/datum/nifsoft/hud/hud_nifsoft in target_nif.loaded_nifsofts)
		if(!hud_nifsoft.eyewear_check || !hud_nifsoft.active)
			continue

		hud_nifsoft.activate()

/obj/item/clothing/glasses/nif_hud/fake_blindfold
	name = "modernized fake blindfold"
	desc = "A restored version of the obsolete fake blindfold, retrofitted with the proper electronics to work as a NIF HUD."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "obsoletefold"
	base_icon_state = "obsoletefold"
	can_switch_eye = TRUE
