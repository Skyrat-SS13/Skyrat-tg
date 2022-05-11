/obj/item/mod/control/pre_equipped/expedition
	//theme = /datum/mod_theme/mining
	applied_core = /obj/item/mod/core/standard

/obj/item/mod/control/pre_equipped/expedition/commander
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/jetpack,
	)

/obj/item/mod/control/pre_equipped/expedition/sci
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

/obj/item/mod/control/pre_equipped/expedition/med
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/health_analyzer,
		/obj/item/mod/module/quick_carry,
	)

/obj/item/mod/control/pre_equipped/expedition/sec
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/magnetic_harness,
		/obj/item/mod/module/pepper_shoulders,
	)

/obj/item/mod/control/pre_equipped/expedition/eng
	initial_modules = list(
		/obj/item/mod/module/storage,
		/obj/item/mod/module/gps,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/magboot,
	)

/obj/machinery/suit_storage_unit/expedition/commander
	name = "expedition commander suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/commander
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/machinery/suit_storage_unit/expedition/sci
	name = "expedition scientist's suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/sci
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/machinery/suit_storage_unit/expedition/med
	name = "expedition medic's suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/med
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/machinery/suit_storage_unit/expedition/sec
	name = "expedition security guard's suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/sec
	mask_type = /obj/item/clothing/mask/gas/explorer

/obj/machinery/suit_storage_unit/expedition/eng
	name = "expedition engineer's suit storage"
	mod_type = /obj/item/mod/control/pre_equipped/expedition/eng
	mask_type = /obj/item/clothing/mask/gas/explorer
