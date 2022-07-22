/obj/item/storage/backpack/duffelbag/syndie/nri
	name = "imperial assault pack"
	desc = "A large green backpack for holding extra tactical supplies. It appears to be made from lighter yet sturdier materials."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "russian_green_backpack"
	worn_icon_state = "russian_green_backpack"
	inhand_icon_state = "securitypack"
	resistance_flags = FIRE_PROOF
	special_desc_requirement = null
	special_desc = null

/obj/item/storage/backpack/duffelbag/syndie/nri/captain
	desc = "A large black backpack for holding extra tactical supplies. It appears to be made from lighter yet sturdier materials."
	icon_state = "russian_black_backpack"
	worn_icon_state = "russian_black_backpack"

/obj/item/storage/backpack/duffelbag/syndie/nri/medic
	desc = "A large white backpack for holding extra tactical supplies. It appears to be made from lighter yet sturdier materials."
	icon_state = "russian_white_backpack"
	worn_icon_state = "russian_white_backpack"

/obj/item/storage/backpack/duffelbag/syndie/nri/engineer
	desc = "A large brown backpack for holding extra tactical supplies. It appears to be made from lighter yet sturdier materials."
	icon_state = "russian_brown_backpack"
	worn_icon_state = "russian_brown_backpack"

/obj/item/storage/backpack/nri //LARPing gear
	name = "imperial assault pack"
	desc = "A large green backpack for holding extra tactical supplies. You really doubt its authenticity."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "russian_green_backpack"
	worn_icon_state = "russian_green_backpack"
	inhand_icon_state = "securitypack"

/obj/item/storage/backpack/nri/larp/PopulateContents()
	generate_items_inside(list(
		/obj/item/clothing/head/helmet/rus_helmet = 1,
		/obj/item/clothing/suit/armor/vest/russian = 1,
		/obj/item/storage/belt/military/nri = 1,
		/obj/item/clothing/gloves/tackler/combat = 1,
		/obj/item/clothing/under/costume/nri = 1,
		/obj/item/clothing/mask/gas/hecu2 = 1,
		/obj/item/clothing/shoes/combat = 1
	),src)
