/obj/item/clothing/suit/armor/vest/hecu //This shouldn't be a Vest subtype considering it covers the legs (sprite-wise) :/
	name = "plate carrier system"
	desc = "A modular armor vest with inserted plates and armor elements that provide decent protection against most types of damage. Despite its modularity, however, you can't remove any of its pieces."
	icon_state = "combat_vest"
	inhand_icon_state = "armoralt"
	blood_overlay_type = "armor"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_digi.dmi'
	uses_advanced_reskins = TRUE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	unique_reskin = list(
		"Basic" = list(
			RESKIN_ICON_STATE = "combat_vest",
			RESKIN_WORN_ICON_STATE = "combat_vest"
		),
		"Corpsman" = list(
			RESKIN_ICON_STATE = "combat_vest_medic",
			RESKIN_WORN_ICON_STATE = "combat_vest_medic"
		),
		"Basic Black" = list(
			RESKIN_ICON_STATE = "combat_vest_black",
			RESKIN_WORN_ICON_STATE = "combat_vest_black"
		),
		"Corpsman Black" = list(
			RESKIN_ICON_STATE = "combat_vest_medic_black",
			RESKIN_WORN_ICON_STATE = "combat_vest_medic_black"
		),
	)

/obj/item/clothing/head/helmet/hecu
	name = "combat helmet"
	desc = "A (previously) common helmet design meant to protect its user's head from impacts."
	icon_state = "combat_helmet"
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecucloth.dmi'
	worn_icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob.dmi'
	worn_icon_digi = 'modular_skyrat/modules/awaymissions_skyrat/icons/hecumob_muzzled.dmi'
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Basic" = list(
			RESKIN_ICON_STATE = "combat_helmet",
			RESKIN_WORN_ICON_STATE = "combat_helmet"
		),
		"Corpsman" = list(
			RESKIN_ICON_STATE = "combat_helmet_medic",
			RESKIN_WORN_ICON_STATE = "combat_helmet_medic"
		),
		"Basic Black" = list(
			RESKIN_ICON_STATE = "combat_helmet_black",
			RESKIN_WORN_ICON_STATE = "combat_helmet_black"
		),
		"Corpsman Black" = list(
			RESKIN_ICON_STATE = "combat_helmet_medic_black",
			RESKIN_WORN_ICON_STATE = "combat_helmet_medic_black"
		),
	)

/obj/item/clothing/suit/armor/bulletproof/hecu
	name = "ceramic vest"
	desc = "Vest made from some brittle and highly conductive, yet incredibly impact- and shock-resistant material. Might be of best use against bullets and explosives."
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

/obj/item/clothing/head/helmet/alt/hecu
	name = "ceramic helmet"
	desc = "Helmet made from some brittle and highly conductive, yet incredibly impact- and shock-resistant material. Might be of best use against bullets and explosives."
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
