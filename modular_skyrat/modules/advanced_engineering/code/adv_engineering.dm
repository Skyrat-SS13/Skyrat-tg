/obj/item/storage/belt/utility/full/powertools/ircd/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/electric(src)
	new /obj/item/construction/rcd/combat(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/wrench/bolter(src)
	new /obj/item/analyzer/ranged(src)

/obj/item/mod/control/pre_equipped/advanced/atmos
	theme = /datum/mod_theme/advanced/atmos
	applied_cell = /obj/item/stock_parts/power_store/cell/hyper
	applied_modules = list(
		/obj/item/mod/module/storage/large_capacity,
		/obj/item/mod/module/welding,
		/obj/item/mod/module/rad_protection,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/t_ray,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/visor/meson,
	)
	default_pins = list(
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/magboot/advanced,
	)

/datum/mod_theme/advanced/atmos	//Implement a unique skin for this eventually
	ui_theme = "neutral"

/obj/item/rcd_ammo/combat
	name = "industrial RCD matter cartridge"
	desc = "A cartridge with one complete refill for an industrial RCD."
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 60,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 40,
	)
	ammoamt = 440

/obj/item/storage/box/rcd_ammo
	name = "industrial RCD matter box"
	icon = 'modular_skyrat/modules/aesthetics/storage/storage.dmi'
	desc = "A durable box with refill cartridges for an industrial RCD."
	icon_state = "engibox"
	illustration = "rcd"
	custom_materials = list(
		/datum/material/plastic = HALF_SHEET_MATERIAL_AMOUNT,
	)

/obj/item/storage/box/rcd_ammo/PopulateContents()
	for(var/i in 1 to 4)
		new/obj/item/rcd_ammo/combat(src)
