// --- Loadout item datums for glasses ---

/// Glasses Slot Items (Moves overrided items to backpack)
GLOBAL_LIST_INIT(loadout_glasses, generate_loadout_items(/datum/loadout_item/glasses))

/datum/loadout_item/glasses
	category = LOADOUT_ITEM_GLASSES

/datum/loadout_item/glasses/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.glasses)
			LAZYADD(outfit.backpack_contents, outfit.glasses)
		outfit.glasses = item_path
	else
		outfit.glasses = item_path

/datum/loadout_item/glasses/post_equip_item(datum/preferences/preference_source, mob/living/carbon/human/equipper)
	var/obj/item/clothing/glasses/equipped_glasses = locate(item_path) in equipper.get_equipped_items()
	if (!equipped_glasses)
		return
	if(equipped_glasses.glass_colour_type)
		equipper.update_glasses_color(equipped_glasses, TRUE)
	if(equipped_glasses.tint)
		equipper.update_tint()
	if(equipped_glasses.vision_correction)
		equipper.clear_fullscreen("nearsighted")
	if(equipped_glasses.vision_flags \
		|| equipped_glasses.darkness_view \
		|| equipped_glasses.invis_override \
		|| equipped_glasses.invis_view \
		|| !isnull(equipped_glasses.lighting_alpha))
		equipper.update_sight()

/datum/loadout_item/glasses/prescription_glasses
	name = "Glasses"
	item_path = /obj/item/clothing/glasses/regular
	additional_tooltip_contents = list("PRESCRIPTION - This item functions with the 'nearsighted' quirk.")

/datum/loadout_item/glasses/prescription_glasses/circle_glasses
	name = "Circle Glasses"
	item_path = /obj/item/clothing/glasses/regular/circle

/datum/loadout_item/glasses/prescription_glasses/hipster_glasses
	name = "Hipster Glasses"
	item_path = /obj/item/clothing/glasses/regular/hipster

/datum/loadout_item/glasses/prescription_glasses/jamjar_glasses
	name = "Jamjar Glasses"
	item_path = /obj/item/clothing/glasses/regular/jamjar

/datum/loadout_item/glasses/cold_glasses
	name = "Cold Glasses"
	item_path = /obj/item/clothing/glasses/cold

/datum/loadout_item/glasses/heat_glasses
	name = "Heat Glasses"
	item_path = /obj/item/clothing/glasses/heat

/datum/loadout_item/glasses/geist_glasses
	name = "Geist Gazers"
	item_path = /obj/item/clothing/glasses/geist_gazers

/datum/loadout_item/glasses/orange_glasses
	name = "Orange Glasses"
	item_path = /obj/item/clothing/glasses/orange

/datum/loadout_item/glasses/psych_glasses
	name = "Psych Glasses"
	item_path = /obj/item/clothing/glasses/psych

/datum/loadout_item/glasses/red_glasses
	name = "Red Glasses"
	item_path = /obj/item/clothing/glasses/red

/datum/loadout_item/glasses/eyepatch
	name = "Eyepatch"
	item_path = /obj/item/clothing/glasses/eyepatch

/datum/loadout_item/glasses/fakeblindfold
	name = "Fake Blindfold"
	item_path = /obj/item/clothing/glasses/trickblindfold

/datum/loadout_item/glasses/monocle
	name = "Monocle"
	item_path = /obj/item/clothing/glasses/monocle

/datum/loadout_item/glasses/thin
	name = "Thin Glasses"
	item_path = /obj/item/clothing/glasses/thin

/datum/loadout_item/glasses/better
	name = "Modern Glasses"
	item_path = /obj/item/clothing/glasses/betterunshit

/datum/loadout_item/glasses/eyewrap
	name = "Eyepatch Wrap"
	item_path = /obj/item/clothing/glasses/eyepatch/wrap

/datum/loadout_item/glasses/whiteeyepatch
	name = "White Eyepatch"
	item_path = /obj/item/clothing/glasses/eyepatch/white

/datum/loadout_item/glasses/biker
	name = "Biker Goggles"
	item_path = /obj/item/clothing/glasses/biker

/datum/loadout_item/glasses/medicpatch
	name = "Medical Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/med
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Paramedic")

/datum/loadout_item/glasses/robopatch
	name = "Diagnostic Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/diagnostic
	restricted_roles = list("Scientist", "Roboticist", "Geneticist", "Research Director", "Vanguard Operative")
/datum/loadout_item/glasses/scipatch
	name = "Science Eyepatch"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sci
	restricted_roles = list("Scientist", "Roboticist", "Geneticist", "Research Director", "Chemist", "Vanguard Operative")

/datum/loadout_item/glasses/sechud
	name = "Security Hud"
	item_path = /obj/item/clothing/glasses/hud/security
	restricted_roles = list("Security Officer", "Security Sergeant", "Warden", "Head of Security", "Civil Disputes Officer")

/datum/loadout_item/glasses/secpatch
	name = "Security Eyepatch Hud"
	item_path = /obj/item/clothing/glasses/hud/eyepatch/sec
	restricted_roles = list("Security Officer", "Security Sergeant", "Warden", "Head of Security", "Civil Disputes Officer")

/datum/loadout_item/glasses/sechud_glasses
	name = "Prescription Security Hud"
	item_path = /obj/item/clothing/glasses/hud/security/prescription
	restricted_roles = list("Security Officer", "Warden", "Head of Security")

/datum/loadout_item/glasses/medhud_glasses
	name = "Prescription Medical Hud"
	item_path = /obj/item/clothing/glasses/hud/health/prescription
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist", "Paramedic")

/datum/loadout_item/glasses/diaghud_glasses
	name = "Prescription Diagnostic Hud"
	item_path = /obj/item/clothing/glasses/hud/diagnostic/prescription
	restricted_roles = list("Research Director","Scientist", "Roboticist")

//Families Gear
/datum/loadout_item/glasses/osi
	name = "OSI Glasses"
	item_path = /obj/item/clothing/glasses/osi
/datum/loadout_item/glasses/phantom
	name = "Phantom Glasses"
	item_path = /obj/item/clothing/glasses/phantom
