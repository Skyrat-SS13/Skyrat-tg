//Blueshield

//Uniform items are in command.dm

/obj/item/clothing/gloves/tackler/combat/insulated/blueshield
	name = "combat gloves"
	desc = "These tactical gloves appear to be unique, made out of double woven durathread fibers which make it fireproof as well as acid resistant"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	icon_state = "combat"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	resistance_flags = FIRE_PROOF |  ACID_PROOF
	armor_type = /datum/armor/insulated_blueshield

/datum/armor/insulated_blueshield
	fire = 100
	acid = 100

/obj/item/radio/headset/headset_bs
	name = "\proper the blueshield's headset"
	icon = 'modular_skyrat/modules/blueshield/icons/radio.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/ears.dmi'
	icon_state = "bshield_headset"
	worn_icon_state = "bshield_headset"
	keyslot = /obj/item/encryptionkey/heads/blueshield
	keyslot2 = /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/headset_bs/alt
	icon_state = "bshield_headset_alt"
	worn_icon_state = "bshield_headset_alt"

/obj/item/radio/headset/headset_bs/alt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))


/obj/item/clothing/head/helmet/space/plasmaman/blueshield
	name = "blueshield envirosuit helmet"
	desc = "A plasmaman containment helmet designed for certified blueshields, who's job guarding heads should not include self-combustion... most of the time."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/plasmaman_hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/plasmaman_head.dmi'
	icon_state = "bs_envirohelm"
	armor_type = /datum/armor/head_helmet/plasmaman/blueshield

/datum/armor/head_helmet/plasmaman/blueshield
	acid = 90

/obj/item/clothing/under/plasmaman/blueshield
	name = "blueshield envirosuit"
	desc = "A plasmaman containment suit designed for certified blueshields, offering a limited amount of extra protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/plasmaman.dmi'
	icon_state = "bs_envirosuit"
	armor_type = /datum/armor/clothing_under/under_plasmaman_blueshield
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/datum/armor/clothing_under/under_plasmaman_blueshield
	melee = 10
	laser = 10
	bomb = 5
	bio = 100
	fire = 95
	acid = 95

/obj/item/clothing/head/beret/blueshield
	name = "blueshield's beret"
	desc = "A blue beret made of durathread with a genuine golden badge, denoting its owner as a Blueshield Lieuteneant. It seems to be padded with nano-kevlar, making it tougher than standard reinforced berets."
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#3A4E7D#DEB63D"
	//alternate_worn_icon_digi = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	icon_state = "beret_badge_police"
	armor_type = /datum/armor/head_helmet/blueshield
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/datum/armor/head_helmet/blueshield
	fire = 75
	acid = 75

/obj/item/clothing/head/beret/blueshield/navy
	name = "navy blueshield's beret"
	desc = "A navy-blue beret made of durathread with a silver badge, denoting its owner as a Blueshield Lieuteneant. It seems to be padded with nano-kevlar, making it tougher than standard reinforced berets."
	greyscale_colors = "#3C485A#BBBBBB"

/obj/item/storage/backpack/blueshield
	name = "blueshield backpack"
	desc = "A robust backpack issued to Nanotrasen's finest."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "backpack_blueshield"
	inhand_icon_state = "backpack_blueshield"

/obj/item/storage/backpack/satchel/blueshield
	name = "blueshield satchel"
	desc = "A robust satchel issued to Nanotrasen's finest."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "satchel_blueshield"
	inhand_icon_state = "satchel_blueshield"

/obj/item/storage/backpack/duffelbag/blueshield
	name = "blueshield duffelbag"
	desc = "A robust duffelbag issued to Nanotrasen's finest."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/clothing/backpack_righthand.dmi'
	icon_state = "duffel_blueshield"
	inhand_icon_state = "duffel_blueshield"

//blueshield armor
/obj/item/clothing/suit/armor/vest/blueshield
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	name = "blueshield's armor"
	desc = "A tight-fitting kevlar-lined vest with a blue badge on the chest of it."
	icon_state = "blueshieldarmor"
	body_parts_covered = CHEST
	armor_type = /datum/armor/suit_armor/blueshield
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Slim" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "blueshieldarmor",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "blueshieldarmor",
		),
		"Marine" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "bs_marine",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "bs_marine",
		),
		"Bulky" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi',
			RESKIN_ICON_STATE = "vest_black",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi',
			RESKIN_WORN_ICON_STATE = "vest_black",
		),
	)

/datum/armor/suit_armor/blueshield
	bomb = 30
	fire = 75
	acid = 75

/obj/item/clothing/suit/armor/vest/blueshield/jacket
	name = "blueshield's jacket"
	desc = "An expensive kevlar-lined jacket with a golden badge on the chest and \"NT\" emblazoned on the back. It weighs surprisingly little, despite how heavy it looks."
	icon_state = "blueshield"
	body_parts_covered = CHEST|ARMS
	unique_reskin = null

/obj/item/clothing/suit/armor/vest/blueshield/jacket/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/hooded/wintercoat/skyrat/blueshield
	name = "blueshield's winter coat"
	icon_state = "coatblueshield"
	desc = "A comfy kevlar-lined coat with blue highlights, fit to keep the blueshield armored and warm."
	hoodtype = /obj/item/clothing/head/hooded/winterhood/skyrat/blueshield
	allowed = list(/obj/item/melee/baton/security/loaded)
	armor_type = /datum/armor/suit_armor/blueshield

/obj/item/clothing/suit/hooded/wintercoat/skyrat/blueshield/Initialize(mapload)
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/head/hooded/winterhood/skyrat/blueshield
	icon_state = "hood_blueshield"
	desc = "A comfy kevlar-lined hood to go with the comfy kevlar-lined coat."
	armor_type = /datum/armor/suit_armor/blueshield
