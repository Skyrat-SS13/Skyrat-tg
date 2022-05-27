//Blueshield
/obj/item/clothing/under/rank/security/blueshield
	desc = "An expensive designer shirt with snazzy suit pants, complete with a blue tie."
	name = "blueshield's suit"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "blueshield"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 5,"energy" = 10, "bomb" =10, "bio" = 0, "fire" = 50, "acid" = 50)
	can_adjust = FALSE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/blueshield/turtleneck
	name = "blueshield's skivvy"
	desc = "A cozier alternative to the normal blueshield's suit. It's made out of an expensive, all-natural wool."
	icon_state = "bs_turtleneck"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/rank/security/blueshield/turtleneck/skirt
	name = "blueshield's skirtleneck"
	desc = "An alternative to the normal turtleneck with the pants replaced with a high-cut skirt. It's still made out of an expensive, all-natural wool."
	icon_state = "bs_skirtleneck"

/obj/item/clothing/under/rank/security/blueshield/skirt
	desc = "A \"tactical\" skirt seemingly outfitted in Nanotrasen's standard corporate-chic."
	name = "blueshield's skirt"
	icon_state = "blueshieldskirt"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/gloves/tackler/combat/insulated/blueshield
    name = "combat gloves"
    desc = "These tactical gloves appear to be unique, made out of double woven durathread fibers which make it fireproof as well as acid resistant"
    icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
    icon_state = "combat"
    worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
    resistance_flags = FIRE_PROOF |  ACID_PROOF
    armor = list("melee" = 0, "bullet" = 0, "laser" = 0, "energy" = 0, "bomb" = 0, "bio" = 0, "fire" = 100, "acid" = 100)

/obj/item/radio/headset/headset_bs
	name = "\proper the blueshield's headset"
	icon = 'modular_skyrat/modules/blueshield/icons/radio.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/ears.dmi'
	icon_state = "bshield_headset"
	keyslot = new /obj/item/encryptionkey/heads/blueshield
	keyslot2 = new /obj/item/encryptionkey/headset_cent

/obj/item/radio/headset/headset_bs/alt
	icon_state = "bshield_headset_alt"

/obj/item/radio/headset/headset_bs/alt/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/wearertargeting/earprotection, list(ITEM_SLOT_EARS))


/obj/item/clothing/head/helmet/space/plasmaman/blueshield
	name = "blueshield envirosuit helmet"
	desc = "A plasmaman containment helmet designed for certified blueshields, who's job guarding heads should not include self-combustion... most of the time."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/plasmaman_hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/plasmaman_head.dmi'
	icon_state = "bs_envirohelm"
	armor = list("melee" = 30, "bullet" = 20, "laser" = 20,"energy" = 20, "bomb" = 25, "bio" = 100, "fire" = 100, "acid" = 90)

/obj/item/clothing/under/plasmaman/blueshield
	name = "blueshield envirosuit"
	desc = "A plasmaman containment suit designed for certified blueshields, offering a limited amount of extra protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/plasmaman.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/plasmaman.dmi'
	icon_state = "bs_envirosuit"
	armor = list("melee" = 10, "bullet" = 0, "laser" = 10,"energy" = 0, "bomb" = 5, "bio" = 100, "fire" = 95, "acid" = 95)
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/head/beret/blueshield
	name = "blueshield's beret"
	desc = "A blue beret made of durathread with a genuine golden badge, denoting its owner as a Blueshield Lieuteneant. It seems to be padded with nano-kevlar, making it tougher than standard reinforced berets."
	greyscale_config = /datum/greyscale_config/beret_badge
	greyscale_config_worn = /datum/greyscale_config/beret_badge/worn
	greyscale_colors = "#3A4E7D#DEB63D"
	//alternate_worn_icon_digi = 'modular_skyrat/icons/mob/head_muzzled.dmi'
	icon_state = "beret_badge_police"
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25,"energy" = 15, "bomb" = 25, "bio" = 0, "fire" = 75, "acid" = 75)

/obj/item/clothing/head/beret/blueshield/navy
	name = "navy blueshield's beret"
	desc = "A navy-blue beret made of durathread with a silver badge, denoting its owner as a Blueshield Lieuteneant. It seems to be padded with nano-kevlar, making it tougher than standard reinforced berets."
	greyscale_colors = "#3C485A#BBBBBB"

/obj/item/storage/backpack/blueshield
	name = "blueshield backpack"
	desc = "A robust backpack issued to Nanotrasen's finest."
	icon = 'modular_skyrat/modules/blueshield/icons/blueshieldpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "blueshieldpack"
	inhand_icon_state = "securitypack"

/obj/item/storage/backpack/satchel/blueshield
	name = "blueshield satchel"
	desc = "A robust satchel issued to Nanotrasen's finest."
	icon = 'modular_skyrat/modules/blueshield/icons/blueshieldpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "satchel-blueshield"
	inhand_icon_state = "satchel-sec"

/obj/item/storage/backpack/duffelbag/blueshield
	name = "blueshield duffelbag"
	desc = "A robust duffelbag issued to Nanotrasen's finest."
	icon = 'modular_skyrat/modules/blueshield/icons/blueshieldpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "duffel-blueshield"
	inhand_icon_state = "duffel-sec"

//blueshield armor
/obj/item/clothing/suit/armor/vest/blueshield
	name = "blueshield's jacket"
	desc = "An expensive kevlar-lined jacket with a golden badge on the chest and \"NT\" emblazoned on the back. It weighs surprisingly little, despite how heavy it looks. There's a tight-fitting vest tucked in underneath."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	//alternate_worn_icon_digi = 'modular_skyrat/icons/mob/suit_digi.dmi'
	icon_state = "blueshield"
	body_parts_covered = CHEST|ARMS
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25,"energy" = 25, "bomb" = 30, "bio" = 0, "fire" = 75, "acid" = 75)

/obj/item/clothing/suit/armor/vest/blueshieldarmor
	name = "blueshield's armor"
	desc = "A tight-fitting kevlar-lined vest with a golden badge on the chest and \"NT\" emblazoned on the back. It weighs surprisingly little, despite how heavy it looks."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "blueshieldarmor"
	body_parts_covered = CHEST
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25,"energy" = 25, "bomb" = 30, "bio" = 0, "fire" = 75, "acid" = 75)

/obj/item/clothing/suit/hooded/wintercoat/blueshield
	name = "blueshield's winter coat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "coatblueshield"
	inhand_icon_state = "coatblueshield"
	desc = "A comfy kevlar-lined coat with \"NT\" emblazoned on the back."
	hoodtype = /obj/item/clothing/head/hooded/winterhood/blueshield
	allowed = list(/obj/item/melee/baton/security/loaded)
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25,"energy" = 25, "bomb" = 30, "bio" = 0, "fire" = 75, "acid" = 75)

/obj/item/clothing/suit/hooded/wintercoat/blueshield/Initialize()
	. = ..()
	allowed += GLOB.security_vest_allowed

/obj/item/clothing/head/hooded/winterhood/blueshield
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "winterhood_blueshield"
	desc = "A comfy kevlar-lined hood to go with the comfy kevlar-lined coat."
	armor = list("melee" = 35, "bullet" = 25, "laser" = 25,"energy" = 15, "bomb" = 25, "bio" = 0, "fire" = 75, "acid" = 75)
