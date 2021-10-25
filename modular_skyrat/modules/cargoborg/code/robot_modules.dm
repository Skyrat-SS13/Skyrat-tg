// --------------------- Cargo
/obj/item/robot_model/cargo
	name = "Cargo"
	basic_modules = list(
		/obj/item/stamp,
		/obj/item/stamp/denied,
		/obj/item/pen/cyborg,
		/obj/item/clipboard/cyborg,
		/obj/item/stack/package_wrap/cyborg,
		/obj/item/stack/wrapping_paper/xmas/cyborg,
		/obj/item/hand_labeler/cyborg,
		/obj/item/dest_tagger,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher,
	)
	radio_channels = list(RADIO_CHANNEL_SUPPLY)
	emag_modules = list(
		/obj/item/borg/paperplane_crossbow,
	)
	hat_offset = 0
	cyborg_base_icon = "cargo"
	model_select_icon = "cargo"
	cyborg_icon_override = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi'
	canDispose = TRUE
	borg_skins = list(
		"Technician" = list(SKIN_ICON = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi', SKIN_ICON_STATE = "cargoborg"),
		"Miss M" = list(SKIN_ICON = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi', SKIN_ICON_STATE = "missm_cargo"),
		"Zoomba" = list(SKIN_ICON = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi', SKIN_ICON_STATE = "zoomba_cargo", SKIN_TRAITS = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)),
		"Drake" = list(SKIN_ICON = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi', SKIN_ICON_STATE =  "drakecargo", SKIN_TRAITS = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Vale" = list(SKIN_ICON = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi', SKIN_ICON_STATE =  "valecargo", SKIN_TRAITS = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Hound" = list(SKIN_ICON = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi', SKIN_ICON_STATE =  "cargohound", SKIN_TRAITS = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Darkhound" = list(SKIN_ICON = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi', SKIN_ICON_STATE =  "cargohounddark", SKIN_TRAITS = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Borgi" = list(SKIN_ICON = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi', SKIN_ICON_STATE =  "borgi-cargo", SKIN_TRAITS = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL))
	)

