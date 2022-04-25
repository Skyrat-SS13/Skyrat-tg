// --- Loadout item datums for accessories ---

/// Accessory Items (Moves overrided items to backpack)
GLOBAL_LIST_INIT(loadout_accessory, generate_loadout_items(/datum/loadout_item/accessory))

/datum/loadout_item/accessory
	category = LOADOUT_ITEM_ACCESSORY

/datum/loadout_item/accessory/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.accessory)
			LAZYADD(outfit.backpack_contents, outfit.accessory)
		outfit.accessory = item_path
	else
		outfit.accessory = item_path

/datum/loadout_item/accessory/maid_apron
	name = "Maid Apron"
	item_path = /obj/item/clothing/accessory/maidapron

/datum/loadout_item/accessory/waistcoat
	name = "Waistcoat"
	item_path = /obj/item/clothing/accessory/waistcoat

/datum/loadout_item/accessory/pocket_protector
	name = "Pocket Protector"
	item_path = /obj/item/clothing/accessory/pocketprotector

/datum/loadout_item/accessory/full_pocket_protector
	name = "Pocket Protector (Filled)"
	item_path = /obj/item/clothing/accessory/pocketprotector/full
	additional_tooltip_contents = list("CONTAINS PENS - This item contains multiple pens on spawn.")

/datum/loadout_item/accessory/ribbon
	name = "Ribbon"
	item_path = /obj/item/clothing/accessory/medal/ribbon

/datum/loadout_item/accessory/pride
	name = "Pride Pin"
	item_path = /obj/item/clothing/accessory/pride


/datum/loadout_item/accessory/armband_medblue
	name = "Medical Armband (blue stripe)"
	item_path = /obj/item/clothing/accessory/armband/medblue
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_VIROLOGIST, JOB_ORDERLY)

/datum/loadout_item/accessory/armband_med
	name = "Medical Armband (white)"
	item_path = /obj/item/clothing/accessory/armband/med
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_VIROLOGIST, JOB_ORDERLY)

/datum/loadout_item/accessory/armband_cargo
	name = "Cargo Armband"
	item_path = /obj/item/clothing/accessory/armband/cargo
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT)

/datum/loadout_item/accessory/armband_engineering
	name = "Engineering Armband"
	item_path = /obj/item/clothing/accessory/armband/engine
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/accessory/armband_security
	name = "Security Armband"
	item_path = /obj/item/clothing/accessory/armband
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_MEDIC)

/datum/loadout_item/accessory/armband_security_deputy
	name = "Security Deputy Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy
	restricted_roles = list(JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/accessory/armband_science
	name = "Science Armband"
	item_path = /obj/item/clothing/accessory/armband/science
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_VANGUARD_OPERATIVE, JOB_SCIENCE_GUARD)

/* to do later
/datum/loadout_item/accessory/dogtags
	name = "Name-Inscribed Dogtags"
	item_path = /obj/item/clothing/accessory/cosmetic_dogtag
	additional_tooltip_contents = list("MATCHES NAME - The name inscribed on this item matches your character's name on spawn.")

/datum/loadout_item/accessory/bone_charm
	name = "Heirloom Bone Talismin"
	item_path = /obj/item/clothing/accessory/armorless_talisman
	additional_tooltip_contents = list(TOOLTIP_NO_ARMOR)

/datum/loadout_item/accessory/bone_codpiece
	name = "Heirloom Skull Codpiece"
	item_path = /obj/item/clothing/accessory/armorless_skullcodpiece
	additional_tooltip_contents = list(TOOLTIP_NO_ARMOR)
*/
