
/obj/item/mod/control/pre_equipped/contractor
	worn_icon = 'modular_skyrat/modules/contractor/icons/worn_modsuit.dmi'
	icon = 'modular_skyrat/modules/contractor/icons/modsuit.dmi'
	theme = /datum/mod_theme/contractor
	applied_cell = /obj/item/stock_parts/cell/hyper
	initial_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/emp_shield,
	)

/obj/item/mod/control/pre_equipped/contractor/upgraded
	applied_cell = /obj/item/stock_parts/cell/bluespace
	initial_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/baton_holster/preloaded,
		/obj/item/mod/module/emp_shield,
	)

/obj/item/mod/control/pre_equipped/contractor/upgraded/adminbus
	initial_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/springlock/contractor/no_complexity,
		/obj/item/mod/module/baton_holster/preloaded,
		/obj/item/mod/module/scorpion_hook,
		/obj/item/mod/module/emp_shield,
	)

// For the prefs menu
/obj/item/mod/control/pre_equipped/syndicate_empty/contractor
	theme = /datum/mod_theme/contractor
