/obj/item/mod/control/pre_equipped/expedition
	//theme = /datum/mod_theme/mining
	applied_core = /obj/item/mod/core/standard

/obj/item/mod/control/pre_equipped/expedition/expedition_commander
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/jetpack,
	)

/obj/item/mod/control/pre_equipped/expedition/expedition_sci
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/circuit,
		/obj/item/mod/module/t_ray,
	)

/obj/item/mod/control/pre_equipped/expedition/expedition_med
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/health_analyzer,
		/obj/item/mod/module/quick_carry,
	)

/obj/item/mod/control/pre_equipped/expedition/expedition_sec
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/pepper_shoulders,
	)

/obj/item/mod/control/pre_equipped/expedition/expedition_eng
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
	)

/obj/machinery/suit_storage_unit/expedition_commander
	name = "expedition commander suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/expedition_commander
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/machinery/suit_storage_unit/expedition_sci
	name = "expedition scientist's suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/expedition_sci
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/machinery/suit_storage_unit/expedition_med
	name = "expedition medic's suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/expedition_med
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/machinery/suit_storage_unit/expedition_sec
	name = "expedition security guard's suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/expedition_sec
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/machinery/suit_storage_unit/expedition_eng
	name = "expedition engineer's suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/expedition_eng
	mask_type = /obj/item/clothing/mask/gas/explorer
