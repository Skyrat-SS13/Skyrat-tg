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
	var/obj/item/clothing/glasses/worn_glasses = linked_mob.get_item_by_slot(ITEM_SLOT_EYES)
	if(eyewear_check && !active)
		if(!istype(worn_glasses) || !HAS_TRAIT(worn_glasses, TRAIT_NIFSOFT_HUD_COMPATIBLE_EYEWEAR))
			to_chat(linked_mob, span_warning("You need to wear a piece of compatible eyewear for [program_name] to work."))
			return FALSE

	. = ..() // active = !active
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

		if(eyewear_check)
			if(!istype(worn_glasses)) // Really non-ideal situation, but it's better than a runtime.
				return FALSE

			UnregisterSignal(worn_glasses, COMSIG_ITEM_PRE_UNEQUIP)

		return TRUE

	if(hud_type)
		var/datum/atom_hud/our_hud = GLOB.huds[hud_type]
		our_hud.show_to(linked_mob)
	if(hud_trait)
		ADD_TRAIT(linked_mob, hud_trait, GLASSES_TRAIT)

	for(var/trait as anything in added_eyewear_traits)
		ADD_TRAIT(linked_mob, trait, NIFSOFT_TRAIT)

	if(eyewear_check)
		RegisterSignal(worn_glasses, COMSIG_ITEM_PRE_UNEQUIP, PROC_REF(activate))

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

/obj/item/disk/nifsoft_uploader/sec_hud
	name = "Security HUD"
	loaded_nifsoft = /datum/nifsoft/hud/job/security

/obj/item/disk/nifsoft_uploader/permit_hud
	name = "Permit HUD"
	loaded_nifsoft = /datum/nifsoft/hud/job/cargo_tech

/obj/item/disk/nifsoft_uploader/sci_hud
	name = "Science HUD"
	loaded_nifsoft = /datum/nifsoft/hud/job/science


//
// NIFSOFT HUD GLASSES
//

/obj/item/clothing/glasses/trickblindfold/obsolete
	name = "modernized fake blindfold"
	desc = "A restored version of the obsolete fake blindfold, retrofitted with the proper electronics to work as a NIF HUD."
	clothing_traits = TRAIT_NIFSOFT_HUD_COMPATIBLE_EYEWEAR
