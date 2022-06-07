/obj/item/clothing/glasses/hud/eyepatch
	name = "eyepatch HUD"
	desc = "A simple HUD designed to interface with optical nerves of a lost eye. This one seems busted."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "hudpatch"
	inhand_icon_state = "eyepatch"
	uses_advanced_reskins = TRUE
	can_switch_eye = TRUE	//See modular_skyrat\modules\customization\modules\clothing\glasses\glasses.dm

/obj/item/clothing/glasses/hud/eyepatch/sec
	name = "security eyepatch HUD"
	desc = "Lost your eye beating an innocent clown? Thankfully your corporate overlords have made something to make up for this. May not do well against flashes."
	icon_state = "hudpatch"
	hud_type = DATA_HUD_SECURITY_ADVANCED
	hud_trait = TRAIT_SECURITY_HUD
	glass_colour_type = /datum/client_colour/glass_colour/blue

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "hudpatch",
			RESKIN_WORN_ICON_STATE = "hudpatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "secfold",
			RESKIN_WORN_ICON_STATE = "secfold"
		)
	)
/obj/item/clothing/glasses/hud/eyepatch/med
	name = "medical eyepatch HUD"
	desc = "Do no harm, maybe harm has befell to you, or your poor eyeball, thankfully there's a way to continue your oath, thankfully it didn't mention sleepdarts or monkey men."
	icon_state = "medpatch"
	hud_type = DATA_HUD_MEDICAL_ADVANCED
	hud_trait = TRAIT_MEDICAL_HUD
	glass_colour_type = /datum/client_colour/glass_colour/lightblue

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "medpatch",
			RESKIN_WORN_ICON_STATE = "medpatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "medfold",
			RESKIN_WORN_ICON_STATE = "medfold"
		)
	)

/obj/item/clothing/glasses/hud/eyepatch/meson
	name = "mesons eyepatch HUD"
	desc = "For those that only want to go half insane when staring at the supermatter."
	icon_state = "mesonpatch"
	clothing_traits = list(TRAIT_MADNESS_IMMUNE)
	darkness_view = 2
	vision_flags = SEE_TURFS
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_VISIBLE
	glass_colour_type = /datum/client_colour/glass_colour/lightgreen

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "mesonpatch",
			RESKIN_WORN_ICON_STATE = "mesonpatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "mesonfold",
			RESKIN_WORN_ICON_STATE = "mesonfold"
		)
	)

/obj/item/clothing/glasses/hud/eyepatch/diagnostic
	name = "diagnostic eyepatch HUD"
	desc = "Lost your eyeball to a rogue borg? Dare to tell a Dogborg to do it's job? Got bored? Whatever the reason, this bit of tech will help you still repair borgs, they'll never need it since they usually do it themselves, but its the thought that counts."
	icon_state = "robopatch"
	hud_type = DATA_HUD_DIAGNOSTIC_BASIC
	hud_trait = TRAIT_DIAGNOSTIC_HUD
	glass_colour_type = /datum/client_colour/glass_colour/lightorange

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "robopatch",
			RESKIN_WORN_ICON_STATE = "robopatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "robofold",
			RESKIN_WORN_ICON_STATE = "robofold"
		)
	)

/obj/item/clothing/glasses/hud/eyepatch/sci
	name = "science eyepatch HUD"
	desc = "Every few years, the aspiring mad scientist says to themselves 'I've got the castle, the evil laugh and equipment, but what I need is a look', thankfully, Dr. Galox has already covered that for you dear friend - while it doesn't do much beyond scan chemicals, what it lacks in use it makes up for in style."
	icon_state = "scipatch"
	clothing_traits = list(TRAIT_REAGENT_SCANNER, TRAIT_RESEARCH_SCANNER)

	unique_reskin = list(
		"Eyepatch" = list(
			RESKIN_ICON_STATE = "scipatch",
			RESKIN_WORN_ICON_STATE = "scipatch"
		),
		"Fake Blindfold" = list(
			RESKIN_ICON_STATE = "scifold",
			RESKIN_WORN_ICON_STATE = "scifold"
		)
	)


/// BLINDFOLD HUDS ///
/obj/item/clothing/glasses/trickblindfold/obsolete
	name = "obsolete fake blindfold"
	desc = "An ornate fake blindfold, devoid of any electronics. It's belived to be originally worn by members of bygone military force that sought to protect humanity."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon_state = "obsoletefold"
	can_switch_eye = TRUE

/obj/item/clothing/glasses/hud/eyepatch/sec/blindfold
	name = "sec blindfold HUD"
	desc = "a fake blindfold with a security HUD inside, helps you look like blind justice. This won't provide the same protection that you'd get from sunglasses."
	icon_state =  "secfold"

/obj/item/clothing/glasses/hud/eyepatch/med/blindfold
	name = "medical blindfold HUD"
	desc = "a fake blindfold with a medical HUD inside, great for helping keep a poker face when dealing with patients."
	icon_state =  "medfold"

/obj/item/clothing/glasses/hud/eyepatch/meson/blindfold
	name = "meson blindfold HUD"
	desc = "a fake blindfold with meson lenses inside. Doesn't shield against welding."
	icon_state =  "mesonfold"

/obj/item/clothing/glasses/hud/eyepatch/diagnostic/blindfold
	name = "diagnostic blindfold HUD"
	desc = "a fake blindfold with a diagnostic HUD inside, excellent for working on androids."
	icon_state =  "robofold"

/obj/item/clothing/glasses/hud/eyepatch/sci/blindfold
	name = "science blindfold HUD"
	desc = "a fake blindfold with a science HUD inside, provides a way to get used to blindfolds before you eventually end up needing the real thing."
	icon_state =  "scifold"
