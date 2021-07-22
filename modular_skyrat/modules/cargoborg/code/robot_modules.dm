// --------------------- Cargo
/obj/item/robot_model/cargo
	name = "Cargo"
	basic_modules = list(
		/obj/item/stamp,
		/obj/item/stamp/denied,
		/obj/item/pen,
		/obj/item/stack/package_wrap,
		/obj/item/stack/wrapping_paper,
		/obj/item/hand_labeler,
		/obj/item/dest_tagger,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher,
	)
	radio_channels = list(RADIO_CHANNEL_SUPPLY)
	emag_modules = list(

	)
	cyborg_base_icon = "cargo"
	model_select_icon = "cargo"
	cyborg_icon_override = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi'
	canDispose = TRUE
	hat_offset = 3


