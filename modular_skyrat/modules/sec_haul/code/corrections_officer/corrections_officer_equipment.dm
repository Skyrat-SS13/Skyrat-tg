/obj/item/clothing/under/rank/security/corrections_officer
	desc = "A white satin shirt with some bronze rank pins at the neck."
	name = "corrections officer's suit"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "corrections_officer"
	armor = list("melee" = 10, "bullet" = 5, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)
	can_adjust = FALSE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/corrections_officer/skirt
	desc = "A white satin shirt with some bronze rank pins at the neck."
	name = "corrections officer's skirt"
	icon_state = "corrections_officerw"

/obj/item/clothing/under/rank/security/corrections_officer/sweater
	desc = "A black combat sweater thrown over the standard issue shirt, perfect for wake up calls."
	name = "corrections officer's sweater"
	icon_state = "corrections_officer_sweat"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/security/corrections_officer/sweater/skirt
	icon_state = "corrections_officer_sweatw"

/obj/item/radio/headset/corrections_officer
	name = "\proper corrections officer's headset"
	icon_state = "sec_headset"
	keyslot = new /obj/item/encryptionkey/headset_sec

/obj/item/clothing/head/corrections_officer
	name = "corrections officer's cap"
	desc = "A black visor cap with a round Nanotrasen logo made out of silver in the center, the most it'll do is protect you from some light rain...Or a prisoner slopping out."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "corrections_officer"
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON

/obj/item/clothing/suit/toggle/jacket/corrections_officer
	name = "corrections officer's suit jacket"
	desc = "A pressed and ironed suit jacket, it has light armor against stabbings. There's some rank badges on the right breast."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "co_coat"
	body_parts_covered = CHEST|ARMS
	armor = list("melee" = 10, "bullet" = 10, "laser" = 0,"energy" = 0, "bomb" = 0, "bio" = 0, "fire" = 0, "acid" = 0)


// LOCKER
/obj/structure/closet/secure_closet/corrections_officer
	name = "corrections officer riot gear"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_state = "riot"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/secure_closet/corrections_officer/PopulateContents()
	..()
	new /obj/item/clothing/suit/armor/riot(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/shoes/jackboots/peacekeeper(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/shield/riot(src)
	new /obj/item/clothing/under/rank/security/corrections_officer(src)
