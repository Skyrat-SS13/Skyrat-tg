/obj/item/clothing/suit/armor/vest/hecu
	name = "combat vest"
	desc = "Vest designed to take heavy beating and probably keep the user alive in the process."
	armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 40, BIO = 0, FIRE = 80, ACID = 100, WOUND = 30)
	icon_state = "ceramic_vest" ///I am not paid enough (I am not paid at all) to change these.
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

/obj/item/clothing/head/helmet/hecu
	name = "combat helmet"
	desc = "Helmet designed to take heavy beating and probably keep the user alive in the process."
	armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 40, BIO = 0, FIRE = 80, ACID = 100, WOUND = 30)
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
