/*
*	ARMBANDS
*/

/datum/loadout_item/accessory/armband_medblue
	name = "Blue-White Armband"
	item_path = /obj/item/clothing/accessory/armband/medblue/nonsec

/datum/loadout_item/accessory/armband_med
	name = "White Armband"
	item_path = /obj/item/clothing/accessory/armband/med/nonsec

/datum/loadout_item/accessory/armband_cargo
	name = "Brown Armband"
	item_path = /obj/item/clothing/accessory/armband/cargo/nonsec

/datum/loadout_item/accessory/armband_engineering
	name = "Orange Armband"
	item_path = /obj/item/clothing/accessory/armband/engine/nonsec

/datum/loadout_item/accessory/armband_security_nonsec
	name = "Blue Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy/lopland/nonsec

/datum/loadout_item/accessory/armband_security
	name = "Security Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy/lopland
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/accessory/armband_security_deputy
	name = "Security Deputy Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/accessory/armband_science
	name = "Purple Armband"
	item_path = /obj/item/clothing/accessory/armband/science/nonsec

/*
*	ARMOURLESS
*/

/datum/loadout_item/accessory/bone_charm
	name = "Heirloom Bone Talisman"
	item_path = /obj/item/clothing/accessory/talisman/armourless
	additional_displayed_text = list(TOOLTIP_NO_ARMOR)

/datum/loadout_item/accessory/bone_codpiece
	name = "Heirloom Skull Codpiece"
	item_path = /obj/item/clothing/accessory/skullcodpiece/armourless
	additional_displayed_text = list(TOOLTIP_NO_ARMOR)

/datum/loadout_item/accessory/sinew_kilt
	name = "Heirloom Sinew Skirt"
	item_path = /obj/item/clothing/accessory/skilt/armourless
	additional_displayed_text = list(TOOLTIP_NO_ARMOR)

/datum/loadout_item/accessory/wallet
	name = "Wallet"
	item_path = /obj/item/storage/wallet
