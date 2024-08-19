// MODULAR ARMOUR

// WARDEN
/obj/item/clothing/suit/armor/vest/warden/syndicate
	name = "master at arms' vest"
	desc = "Stunning. Menacing. Perfect for the man who gets bullied for leaving the brig."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "warden_syndie"
	current_skin = "warden_syndie" //prevents reskinning
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

// HEAD OF PERSONNEL
/obj/item/clothing/suit/armor/vest/hop/hop_formal
	name = "head of personnel's parade jacket"
	desc = "A luxurious deep blue jacket for the Head of Personnel, woven with a red trim. It smells of bureaucracy."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "hopformal"

/obj/item/clothing/suit/armor/vest/hop/hop_formal/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

// CAPTAIN
/obj/item/clothing/suit/armor/vest/capcarapace/jacket
	name = "captain's jacket"
	desc = "A lightweight armored jacket in the Captain's colors. For when you want something sleeker."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "capjacket_casual"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/robe
	name = "captain's robe"
	desc = "A lightweight armored robe in the Captain's colors. For when you want something classy, but regal."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "solgov_robe"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/robe/overseer
	name = "captain's ordained robe"
	desc = "An armored robe in the Captain's colors. For when you want to lead a cult."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "solgov_overseer_robe"

/obj/item/clothing/suit/armor/vest/capcarapace/bathrobe
	name = "captain's bathrobe"
	desc = "Well that's just like, your opinion man."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "solgov_jacket"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/bathrobe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)

/obj/item/clothing/suit/armor/vest/capcarapace/suitjacket
	name = "captain's suit jacket"
	desc = "For the humble Captain."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "solgov_suit"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/gambison
	name = "captain's gambison"
	desc = "Unrelated to that other Bison fellow. Our lawyers say No! No!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "solgov_gambison"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/winterovercoat
	name = "captain's winter overcoat"
	desc = "Not as warm as it looks, especially since it was stol- err, borrowed from the Head of Security."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "solgov_coat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/capcarapace/overcoat
	name = "captain's overcoat"
	desc = "Bid our father the Sea King rise from the depths full foul in his fury!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "solgov_overcoat"
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/suit/armor/vest/bridge
	name = "bridge assistant coat"
	desc = "For those big enough to live on the bridge, but not so big they can reach the buttons."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "coat_solgov"

/obj/item/clothing/suit/armor/vest/bridge/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon)
