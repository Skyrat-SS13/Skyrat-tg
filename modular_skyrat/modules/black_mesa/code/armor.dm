/obj/item/clothing/suit/armor/vest/hecu
	name = "combat vest"
	desc = "Vest designed to take heavy beating and probably keep the user alive in the process."
	armor_type = /datum/armor/vest_hecu
	icon_state = "ceramic_vest"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_digi.dmi'
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Basic" = list(
			RESKIN_ICON_STATE = "ceramic_vest",
			RESKIN_WORN_ICON_STATE = "ceramic_vest"
		),
		"Corpsman" = list(
			RESKIN_ICON_STATE = "ceramic_vest_medic",
			RESKIN_WORN_ICON_STATE = "ceramic_vest_medic"
		),
		"Basic Black" = list(
			RESKIN_ICON_STATE = "ceramic_vest_black",
			RESKIN_WORN_ICON_STATE = "ceramic_vest_black"
		),
		"Corpsman Black" = list(
			RESKIN_ICON_STATE = "ceramic_vest_medic_black",
			RESKIN_WORN_ICON_STATE = "ceramic_vest_medic_black"
		),
	)

/datum/armor/vest_hecu
	melee = 40
	bullet = 40
	laser = 40
	energy = 40
	bomb = 40
	fire = 80
	acid = 100
	wound = 30

/obj/item/clothing/head/helmet/hecu
	name = "combat helmet"
	desc = "Helmet designed to take heavy beating and probably keep the user alive in the process."
	armor_type = /datum/armor/helmet_hecu
	icon_state = "ceramic_helmet"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_muzzled.dmi'
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Basic" = list(
			RESKIN_ICON_STATE = "ceramic_helmet",
			RESKIN_WORN_ICON_STATE = "ceramic_helmet"
		),
		"Corpsman" = list(
			RESKIN_ICON_STATE = "ceramic_helmet_medic",
			RESKIN_WORN_ICON_STATE = "ceramic_helmet_medic"
		),
		"Basic Black" = list(
			RESKIN_ICON_STATE = "ceramic_helmet_black",
			RESKIN_WORN_ICON_STATE = "ceramic_helmet_black"
		),
		"Corpsman Black" = list(
			RESKIN_ICON_STATE = "ceramic_helmet_medic_black",
			RESKIN_WORN_ICON_STATE = "ceramic_helmet_medic_black"
		),
	)

/datum/armor/helmet_hecu
	melee = 30
	bullet = 30
	laser = 30
	energy = 30
	bomb = 30
	fire = 80
	acid = 100
	wound = 30
