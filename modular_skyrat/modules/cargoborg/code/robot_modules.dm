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
		/obj/item/hand_labeler,
		/obj/item/dest_tagger,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher,
	)
	radio_channels = list(RADIO_CHANNEL_SUPPLY)
	emag_modules = list(

	)
	hat_offset = 0
	cyborg_base_icon = "cargo"
	model_select_icon = "cargo"
	cyborg_icon_override = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi'
	canDispose = TRUE

/obj/item/robot_model/cargo/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/cargo_icons
	if(!cargo_icons)
		cargo_icons = list(
		"Technician" = image(icon = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi', icon_state = "cargoborg"),
		"Miss M" = image(icon = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi', icon_state = "missm_cargo"),
		"Zoomba" = image(icon = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi', icon_state = "zoomba_cargo")
		)
		var/list/L = list("Drake" = "drakecargo", "Vale" = "valecargo", "Hound" = "cargohound", "Darkhound" = "cargohounddark", "Borgi" = "borgi-cargo")
		for(var/a in L)
			var/image/wide = image(icon = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi', icon_state = L[a])
			wide.pixel_x = -16
			cargo_icons[a] = wide
		cargo_icons = sortList(cargo_icons)
	var/cargo_borg_icon = show_radial_menu(cyborg, cyborg , cargo_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	cyborg_icon_override = 'modular_skyrat/modules/cargoborg/icons/mob/robots_cargo.dmi' // Putting it here because it's already everywhere else, change this if it's not the case anymore.
	switch(cargo_borg_icon)
		if("Technician")
			cyborg_base_icon = "cargoborg"
		if("Miss M")
			cyborg_base_icon = "missm_cargo"
		if("Zoomba")
			cyborg_base_icon = "zoomba_cargo"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		//Dogborgs
		if("Vale")
			cyborg_base_icon = "valecargo"
			cyborg_icon_override = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi'
			sleeper_overlay = "valecargosleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Drake")
			cyborg_base_icon = "drakecargo"
			cyborg_icon_override = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi'
			sleeper_overlay = "drakecargosleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Hound")
			cyborg_base_icon = "cargohound"
			cyborg_icon_override = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi'
			sleeper_overlay = "cargohound-sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Darkhound")
			cyborg_base_icon = "cargohounddark"
			cyborg_icon_override = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi'
			sleeper_overlay = "cargohounddark-sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Borgi")
			cyborg_base_icon = "borgi-cargo"
			cyborg_icon_override = 'modular_skyrat/modules/cargoborg/icons/mob/widerobot_cargo.dmi'
			sleeper_overlay = "borgi-cargo-sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
		else
			return FALSE
	return TRUE
