/obj/item/disk/nifsoft_uploader/dorms
	name = "Grimoire Purpura"
	loaded_nifsoft = /datum/nifsoft/summoner/dorms

/datum/nifsoft/summoner/dorms
	name = "Grimoire Purpura"
	program_desc = "Grimoire Purpura, a fork of the Grimoire Caeruleam code, allows users to conveniently access an extensive database of various adult toys. "
	holographic_filter = FALSE //No RGB toys
	name_tag = "purpura "
	lewd_nifsoft = TRUE
	ui_icon = "heart"

	//This uses a stripped down selection from the dorms vendor.
	summonable_items  = list(
					// Normal items
					/obj/item/clothing/sextoy/eggvib/signalvib,
					/obj/item/clothing/sextoy/eggvib,
					/obj/item/clothing/sextoy/buttplug,
					/obj/item/clothing/sextoy/nipple_clamps,
					/obj/item/clothing/sextoy/dildo/double_dildo,
					/obj/item/clothing/sextoy/vibroring,
					/obj/item/clothing/sextoy/dildo/custom_dildo,
					/obj/item/tickle_feather,
					/obj/item/clothing/sextoy/fleshlight,
					/obj/item/kinky_shocker,
					/obj/item/clothing/mask/leatherwhip,
					/obj/item/clothing/sextoy/magic_wand,
					/obj/item/bdsm_candle,
					/obj/item/spanking_pad,
					/obj/item/clothing/sextoy/vibrator,
					/obj/item/restraints/handcuffs/lewd,

					// Head / Mask /Neck Items
					/obj/item/clothing/mask/ballgag,
					/obj/item/clothing/mask/ballgag/choking,
					/obj/item/clothing/mask/muzzle/ring,
					/obj/item/clothing/head/deprivation_helmet,
					/obj/item/clothing/glasses/blindfold/kinky,
					/obj/item/clothing/ears/kinky_headphones,
					/obj/item/clothing/mask/gas/bdsm_mask,
					/obj/item/clothing/glasses/hypno,
					/obj/item/clothing/neck/kink_collar,


					//Torso / Belt Items
					/obj/item/clothing/under/misc/latex_catsuit,
					/obj/item/clothing/suit/straight_jacket/latex_straight_jacket,
					/obj/item/clothing/suit/straight_jacket/shackles,
					/obj/item/clothing/suit/straight_jacket/kinky_sleepbag,
					/obj/item/clothing/neck/mind_collar,
					/obj/item/clothing/strapon,
					/obj/item/storage/belt/erpbelt,

					//Hand Items
					/obj/item/clothing/gloves/ball_mittens,
					/obj/item/clothing/gloves/latex_gloves,

					//Feet items
					/obj/item/clothing/shoes/latex_socks,
					/obj/item/clothing/shoes/latex_heels,
	)
	purchase_price = 150

/obj/item/disk/nifsoft_uploader/dorms/contract
	name = "\improper Purpura Contract"
	loaded_nifsoft = /datum/nifsoft/hypno
	reusable = TRUE //This is set to true because of how this handles updating laws
	///What laws will be assigned when using the NIFSoft on someone?
	var/laws_to_assign = "Law 1: Be nice to others."

/obj/item/disk/nifsoft_uploader/dorms/contract/attempt_software_install(mob/living/carbon/human/target)
	var/datum/nifsoft/hypno/target_nifsoft = target.find_nifsoft(/datum/nifsoft/hypno)
	if(target_nifsoft)
		target_nifsoft.fake_laws = laws_to_assign
		return TRUE

	. = ..()
	if(. == FALSE)
		return FALSE

	target_nifsoft = target.find_nifsoft(/datum/nifsoft/hypno)
	if(!target_nifsoft)
		return FALSE

	target_nifsoft.fake_laws = laws_to_assign

/obj/item/disk/nifsoft_uploader/dorms/contract/attack_self(mob/user, list/modifiers)
	var/new_law = tgui_input_text(user, "Input a new law to add", src, laws_to_assign)
	if(!new_law)
		return FALSE

	laws_to_assign = new_law
	return TRUE

/datum/nifsoft/hypno
	name = "Purpura Contract"
	program_desc = "Once installed, the Purpura Contract compells the user to follow the rules stored in the data of the NIFSoft. \n OOC NOTE: This is strictly here for adult roleplay. None of the laws here actually need to be obeyed and you can uninstall this NIFSoft at any time."
	purchase_price = 0
	lewd_nifsoft = TRUE
	ui_icon = "file-contract"

	/// What "laws" does the person with this NIFSoft installed have?
	var/fake_laws = ""

/datum/nifsoft/hypno/activate()
	. = ..()
	if(!.)
		return FALSE

	to_chat(linked_mob, span_abductor(fake_laws))
