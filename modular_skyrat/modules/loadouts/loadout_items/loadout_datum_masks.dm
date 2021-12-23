// --- Loadout item datums for masks ---

/// Mask Slot Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_masks, generate_loadout_items(/datum/loadout_item/mask))

/datum/loadout_item/mask
	category = LOADOUT_ITEM_MASK

/datum/loadout_item/mask/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(isplasmaman(equipper))
		if(!visuals_only)
			to_chat(equipper, "Your loadout mask was not equipped directly due to your envirosuit mask.")
			LAZYADD(outfit.backpack_contents, item_path)
	else if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.mask)
			LAZYADD(outfit.backpack_contents, outfit.mask)
		outfit.mask = item_path
	else
		outfit.mask = item_path


/datum/loadout_item/mask/balaclava
	name = "Balaclava"
	item_path = /obj/item/clothing/mask/balaclava

/datum/loadout_item/mask/gas_mask
	name = "Gas Mask"
	item_path = /obj/item/clothing/mask/gas

/datum/loadout_item/mask/black_bandana
	name = "Black Bandana"
	item_path = /obj/item/clothing/mask/bandana/black

/datum/loadout_item/mask/blue_bandana
	name = "Blue Bandana"
	item_path = /obj/item/clothing/mask/bandana/blue

/datum/loadout_item/mask/gold_bandana
	name = "Gold Bandana"
	item_path = /obj/item/clothing/mask/bandana/gold

/datum/loadout_item/mask/green_bandana
	name = "Green Bandana"
	item_path = /obj/item/clothing/mask/bandana/green

/datum/loadout_item/mask/red_bandana
	name = "Red Bandana"
	item_path = /obj/item/clothing/mask/bandana/red

/datum/loadout_item/mask/skull_bandana
	name = "Skull Bandana"
	item_path = /obj/item/clothing/mask/bandana/skull

/datum/loadout_item/mask/surgical_mask
	name = "Face Mask"
	item_path = /obj/item/clothing/mask/surgical

/datum/loadout_item/mask/fake_mustache
	name = "Fake Moustache"
	item_path = /obj/item/clothing/mask/fakemoustache

/datum/loadout_item/mask/pipe
	name = "Pipe"
	item_path = /obj/item/clothing/mask/cigarette/pipe

/datum/loadout_item/mask/corn_pipe
	name = "Corn Cob Pipe"
	item_path = /obj/item/clothing/mask/cigarette/pipe/cobpipe

/datum/loadout_item/mask/plague_doctor
	name = "Plague Doctor Mask"
	item_path = /obj/item/clothing/mask/gas/plaguedoctor

/datum/loadout_item/head/monky
	name = "Monkey Mask"
	item_path = /obj/item/clothing/mask/gas/monkeymask

/datum/loadout_item/head/owl
	name = "Owl Mask"
	item_path = /obj/item/clothing/mask/gas/owl_mask

/datum/loadout_item/mask/joy
	name = "Joy Mask"
	item_path = /obj/item/clothing/mask/joy

/datum/loadout_item/mask/lollipop
	name = "Lollipop"
	item_path = /obj/item/food/lollipop

/datum/loadout_item/mask/balaclava
	name = "Balaclava"
	item_path = /obj/item/clothing/mask/balaclava

/datum/loadout_item/mask/balaclavaadj
	name = "Adjustable Balaclava"
	item_path = /obj/item/clothing/mask/balaclavaadjust

/datum/loadout_item/mask/balaclavathree
	name = "Three Hole Balaclava"
	item_path = /obj/item/clothing/mask/balaclava/threehole

/datum/loadout_item/mask/balaclavagreen
	name = "Three Hole Green Balaclava"
	item_path = /obj/item/clothing/mask/balaclava/threehole/green

/datum/loadout_item/mask/moustache
	name = "Fake moustache"
	item_path = /obj/item/clothing/mask/fakemoustache

/datum/loadout_item/mask/bandana_redft
	name = "Skin Tight Red Bandana"
	item_path = /obj/item/clothing/mask/bandana/red/ft

/datum/loadout_item/mask/bandana_blueft
	name = "Skin Tight Blue Bandana"
	item_path = /obj/item/clothing/mask/bandana/blue/ft

/datum/loadout_item/mask/bandana_greenft
	name = "Skin Tight Green Bandana"
	item_path = /obj/item/clothing/mask/bandana/green/ft

/datum/loadout_item/mask/bandana_goldft
	name = "Skin Tight Gold Bandana"
	item_path = /obj/item/clothing/mask/bandana/gold/ft

/datum/loadout_item/mask/bandana_blackft
	name = "Skin Tight Black Bandana"
	item_path = /obj/item/clothing/mask/bandana/black/ft

/datum/loadout_item/mask/bandana_skullft
	name = "Skin Tight Skull Bandana"
	item_path = /obj/item/clothing/mask/bandana/skull/ft


/datum/loadout_item/mask/gas_glass
	name = "Glass Gas Mask"
	item_path = /obj/item/clothing/mask/gas/glass


/datum/loadout_item/mask/surgical
	name = "Sterile Mask"
	item_path = /obj/item/clothing/mask/surgical
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_VIROLOGIST, JOB_CHEMIST, JOB_GENETICIST, JOB_PARAMEDIC, JOB_PSYCHOLOGIST,JOB_SECURITY_MEDIC)

//Families Gear
/datum/loadout_item/mask/driscoll
	name = "Driscoll Mask"
	item_path = /obj/item/clothing/mask/gas/driscoll
