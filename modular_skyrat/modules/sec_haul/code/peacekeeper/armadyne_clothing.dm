/obj/item/clothing/under/rank/security/peacekeeper/armadyne
	name = "armadyne corporate uniform"
	desc = "A sleek uniform worn by Armadyne corporate. Its metallic red belt buckle is made in the shape of the Armadyne logo."
	icon_state = "armadyne_shirt"
	worn_icon_state = "armadyne_shirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/centcom.dmi'	//This can probably be moved to centcom.dm when the suits are sorted
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/centcom.dmi'

/obj/item/clothing/under/rank/security/peacekeeper/armadyne/tactical
	name = "armadyne tactical uniform"
	desc = "A robust tactical uniform worn by Armadyne corporate."
	icon_state = "armadyne_tac"
	worn_icon_state = "armadyne_tac"

/obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	name = "armadyne corporate beret"
	desc = "A comfy yet robust beret worn by Armadyne corporate."
	greyscale_config = /datum/greyscale_config/beret_badge_fancy
	greyscale_config_worn = /datum/greyscale_config/beret_badge_fancy/worn
	greyscale_colors = "#3F3C40#5B2423#491716"
	icon_state = "beret_badge_fancy_diagonal"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/hos/trenchcoat/armadyne
	name = "armadyne trenchcoat"
	desc = "A large and warm Armadyne-red trenchcoat worn by the wealthy higher-ups. A good half of its warmth - and bulk - actually comes from the polymer armor plating beneath it."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "armadyne_trench"
	current_skin = "armadyne_trench" //prevents reskinning

/obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	name = "armadyne jacket"
	desc = "An Armadyne branded track jacket, with a thin nanocarbon lining inside for protective purposes. Worn by Armadyne corporate, or wealthy supporters."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "armadyne_jacket"
	worn_icon_state = "armadyne_jacket"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "zipper")

/obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor
	name = "armadyne armor vest"
	desc = "A nanocarbon and high-grade polymer vest, with the worn-red Armadyne logo printed on the back. Used by Armadyne corporate when they need emergency armor."
	icon_state = "armadyne_armor"
	worn_icon_state = "armadyne_armor"

/obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	name = "armadyne hud glasses"
	icon_state = "armadyne_glasses"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	uses_advanced_reskins = FALSE

/obj/item/clothing/gloves/combat/peacekeeper/armadyne
	name = "armadyne combat gloves"
	desc = "Tactical and sleek. Worn by Armadyne representatives."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "armadyne_gloves"
	worn_icon_state = "armadyne_gloves"
	cut_type = null

/obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	name = "armadyne combat boots"
	desc = "Tactical and sleek. Worn by Armadyne representatives."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "armadyne_boots"
	inhand_icon_state = "jackboots"
	worn_icon_state = "armadyne_boots"


/obj/item/storage/belt/security/webbing/peacekeeper/armadyne
	name = "armadyne webbing"
	desc = "Unique and versatile chest rig, can hold security gear."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "armadyne_webbing"
	worn_icon_state = "armadyne_webbing"

/obj/item/storage/belt/security/peacekeeper/armadyne
	name = "armadyne belt"
	desc = "Can hold security gear like handcuffs and flashes. Has a holster for a gun."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	icon_state = "armadyne_belt"
	worn_icon_state = "armadyne_belt"

/datum/outfit/armadyne_rep
	name = "Armadyne Corporate Representative"

	suit_store = /obj/item/modular_computer/pda/security
	ears = /obj/item/radio/headset/headset_cent/commander
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/armadyne
	gloves = /obj/item/clothing/gloves/combat/peacekeeper/armadyne
	head =  /obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	neck = /obj/item/clothing/neck/tie/black
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne
	shoes = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	belt = /obj/item/storage/belt/security/peacekeeper/armadyne
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(
		/obj/item/melee/baton/telescopic,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
	)
	back = /obj/item/storage/backpack/satchel/leather
	box = /obj/item/storage/box/survival/security
	l_pocket = /obj/item/megaphone/command
	id = /obj/item/card/id/advanced/armadyne/agent


/datum/outfit/armadyne_security
	name = "Armadyne Corporate Security"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/armadyne/tactical
	gloves = /obj/item/clothing/gloves/combat/peacekeeper/armadyne
	head = /obj/item/clothing/head/helmet
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	mask = /obj/item/clothing/mask/gas/sechailer
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor
	suit_store = /obj/item/gun/ballistic/automatic/sol_smg
	shoes = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	backpack_contents = list(
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/wespe,
		/obj/item/storage/box/handcuffs,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo,
		/obj/item/modular_computer/pda/security,
	)
	back = /obj/item/storage/backpack/security
	box = /obj/item/storage/box/survival/security
	id = /obj/item/card/id/advanced/armadyne/security


/datum/outfit/armadyne_security/commander
	name = "Armadyne Corporate Security Commander"

	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/armadyne/tactical
	gloves = /obj/item/clothing/gloves/combat/peacekeeper/armadyne
	head =  /obj/item/clothing/head/beret/sec/peacekeeper/armadyne
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper/armadyne
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/armadyne/armor
	suit_store = /obj/item/gun/ballistic/automatic/sol_rifle
	shoes = /obj/item/clothing/shoes/jackboots/peacekeeper/armadyne
	belt = /obj/item/storage/belt/security/webbing/peacekeeper/armadyne
	backpack_contents = list(
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/wespe,
		/obj/item/storage/box/handcuffs,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard,
		/obj/item/modular_computer/pda/security,
	)
	back = /obj/item/storage/backpack/security
	box = /obj/item/storage/box/survival/security
	l_pocket = /obj/item/megaphone/command
	id = /obj/item/card/id/advanced/armadyne/security


/datum/outfit/armadyne_security/high_alert
	name = "Armadyne Corporate Security (High Alert)"
	belt = /obj/item/storage/belt/security/webbing/peacekeeper/armadyne
	suit_store = /obj/item/gun/ballistic/automatic/sol_rifle
	backpack_contents = list(
		/obj/item/melee/baton/telescopic,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/wespe,
		/obj/item/storage/box/handcuffs,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 2,
	)


/datum/outfit/armadyne_security/commander/high_alert
	name = "Armadyne Corporate Security Commander (High Alert)"
	suit_store = /obj/item/gun/ballistic/automatic/sol_rifle
	backpack_contents = list(
		/obj/item/melee/baton/telescopic,
		/obj/item/storage/toolbox/guncase/skyrat/pistol/trappiste_small_case/skild,
		/obj/item/storage/box/handcuffs,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 2,
	)

/obj/item/card/id/advanced/armadyne
	name = "\improper Armadyne ID"
	desc = "An Armadyne ID card."
	icon_state = "card_centcom"
	assigned_icon_state = "assigned_centcom"
	registered_age = null
	trim = /datum/id_trim/centcom/armadyne
	wildcard_slots = WILDCARD_LIMIT_CENTCOM

/datum/id_trim/centcom/armadyne
	assignment = "Armadyne Corporate"
	trim_state = "trim_ert_commander"

/datum/id_trim/centcom/armadyne/New()
	. = ..()
	access = SSid_access.get_region_access_list(list(REGION_GENERAL, REGION_CENTCOM)) // They're not with CC so they get fuck-all access on-station

/obj/item/card/id/advanced/armadyne/security
	registered_name = "Armadyne Corpo"
	trim = /datum/id_trim/centcom/armadyne/security

/datum/id_trim/centcom/armadyne/security
	assignment = "Armadyne Corporate Security Detail"
	trim_state = "trim_ert_commander"

/obj/item/card/id/advanced/armadyne/agent
	trim = /datum/id_trim/centcom/armadyne/agent

/datum/id_trim/centcom/armadyne/agent
	assignment = "Armadyne Corporate Directorate"
	trim_state = "trim_ert_commander"

/datum/outfit/armadyne_rep/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/W = H.wear_id
	if(W)
		W.registered_name = H.real_name
		W.update_label()
	..()

/obj/item/card/id/armadyne/corpo/security
	assignment = "Armadyne Corporate Security"


/datum/antagonist/ert/armadyne
	name = "Armadyne Corporate Security"
	outfit = /datum/outfit/armadyne_security
	role = "Security"

/datum/antagonist/ert/armadyne/high_alert
	name = "Armadyne Corporate Security (High Alert)"
	outfit = /datum/outfit/armadyne_security/high_alert
	role = "Security"

/datum/antagonist/ert/armadyne/leader
	name = "Armadyne Corporate Security Commander"
	outfit = /datum/outfit/armadyne_security/commander
	role = "Commander"

/datum/antagonist/ert/armadyne/leader/high_alert
	name = "Armadyne Corporate Security Commander (High Alert)"
	outfit = /datum/outfit/armadyne_security/commander/high_alert
	role = "Commander"


/datum/ert/armadyne
	roles = list(/datum/antagonist/ert/armadyne)
	leader_role = /datum/antagonist/ert/armadyne/leader
	rename_team = "Armadyne PMC"
	mission = "Assist any Armadyne corporate entities."
	polldesc = "an Armadyne PMC."
	teamsize = 3

/datum/ert/armadyne/high_alert
	roles = list(/datum/antagonist/ert/armadyne/high_alert)
	leader_role = /datum/antagonist/ert/armadyne/leader/high_alert
	rename_team = "Armadyne PMC (High Alert)"
