
/obj/item/mod/control/pre_equipped/contractor
	worn_icon = 'modular_skyrat/modules/contractor/icons/worn_modsuit.dmi'
	icon = 'modular_skyrat/modules/contractor/icons/modsuit.dmi'
	icon_state = "contractor-control"
	theme = /datum/mod_theme/contractor
	starting_frequency = MODLINK_FREQ_SYNDICATE
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/tether,
	)
	default_pins = list(
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/tether,
	)

/obj/item/mod/control/pre_equipped/contractor/upgraded
	applied_cell = /obj/item/stock_parts/power_store/cell/bluespace
	applied_modules = list(
		/obj/item/mod/module/baton_holster/preloaded,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/storage/syndicate,
	)
	default_pins = list(
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/baton_holster,
	)

/obj/item/mod/control/pre_equipped/contractor/upgraded/adminbus
	applied_modules = list(
		/obj/item/mod/module/baton_holster/preloaded/upgraded,
		/obj/item/mod/module/emp_shield,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/scorpion_hook,
		/obj/item/mod/module/springlock/contractor/no_complexity,
		/obj/item/mod/module/storage/syndicate,
	)
	default_pins = list(
		/obj/item/mod/module/armor_booster,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/baton_holster/preloaded,
		/obj/item/mod/module/scorpion_hook,
	)

// For the prefs menu
/obj/item/mod/control/pre_equipped/empty/contractor
	theme = /datum/mod_theme/contractor
