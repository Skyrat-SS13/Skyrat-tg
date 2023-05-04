
//Uniform items are in command.dm

/obj/item/clothing/suit/armor/vest/nanotrasen_consultant
	name = "nanotrasen officers coat"
	desc = "A premium black coat with real fur round the neck, it seems to have some armor padding inside as well."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "bladerunner"
	inhand_icon_state = "armor"
	blood_overlay_type = "suit"
	dog_fashion = null
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = ARMOR_MIN_TEMP_PROTECT
	heat_protection = CHEST|ARMS|GROIN
	max_heat_protection_temperature = ARMOR_MAX_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/nanotrasen_consultant
	name = "nanotrasen consultant's hat"
	desc = "A cap made from durathread, it has an insignia on the front denoting the rank of \"Nanotrasen Consultant\"."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "nt_consultant_cap"
	inhand_icon_state = "that"
	flags_inv = 0
	armor_type = /datum/armor/head_nanotrasen_consultant
	strip_delay = 60
	dog_fashion = null
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/head_nanotrasen_consultant
	melee = 15
	bullet = 5
	laser = 15
	energy = 25
	bomb = 10
	fire = 30
	acid = 5
	wound = 4

/obj/item/clothing/head/nanotrasen_consultant/beret
	name = "nanotrasen consultant's beret"
	desc = "A beret made from durathread, it has an insignia on the front denoting the rank of \"Nanotrasen Consultant\"."
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#3F3C40#155326"
	icon_state = "beret_badge"

/obj/item/clothing/head/beret/centcom_formal/nt_consultant
	armor_type = /datum/armor/beret_centcom_formal_nt_consultant

/datum/armor/beret_centcom_formal_nt_consultant
	melee = 15
	bullet = 5
	laser = 15
	energy = 25
	bomb = 10
	fire = 30
	acid = 5
	wound = 4

/obj/item/clothing/suit/armor/centcom_formal/nt_consultant
	armor_type = /datum/armor/armor_centcom_formal_nt_consultant

/datum/armor/armor_centcom_formal_nt_consultant
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/hooded/wintercoat/centcom/nt_consultant
	armor_type = /datum/armor/centcom_nt_consultant

/datum/armor/centcom_nt_consultant
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/gloves/combat/naval/nanotrasen_consultant
	name = "\improper CentCom gloves"
	desc = "A high quality pair of thick gloves covered in gold stitching."
