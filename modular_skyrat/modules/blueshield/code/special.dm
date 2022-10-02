/obj/item/gun/energy/e_gun/revolver //The virgin gun.
	name = "energy revolver"
	desc = "An advanced energy revolver with the capacity to shoot both electrodes and lasers."
	force = 7
	ammo_type = list(/obj/item/ammo_casing/energy/electrode, /obj/item/ammo_casing/energy/laser)
	ammo_x_offset = 1
	charge_sections = 4
	fire_delay = 4
	icon = 'modular_skyrat/modules/blueshield/icons/energy.dmi'
	icon_state = "bsgun"
	inhand_icon_state = "minidisable"
	lefthand_file = 'modular_skyrat/modules/blueshield/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/blueshield/icons/guns_righthand.dmi'
	obj_flags = UNIQUE_RENAME
	cell_type = /obj/item/stock_parts/cell/blueshield
	pin = /obj/item/firing_pin/implant/mindshield
	selfcharge = TRUE

/obj/item/stock_parts/cell/blueshield
	name = "internal revolver power cell"
	maxcharge = 1500
	chargerate = 300

/obj/item/gun/energy/e_gun/revolver/pdw9 //The chad gun.
	name = "PDW-9 taser pistol"
	desc = "A military grade energy sidearm, used by many militia forces throughout the local sector. It comes with an internally recharging battery which is slow to recharge."
	ammo_x_offset = 2
	icon_state = "pdw9pistol"
	inhand_icon_state = null
	cell_type = /obj/item/stock_parts/cell/pdw9

/obj/item/stock_parts/cell/pdw9
	name = "internal pistol power cell"
	maxcharge = 1000
	chargerate = 300
	var/obj/item/gun/energy/e_gun/revolver/pdw9/parent

/obj/item/stock_parts/cell/pdw9/Initialize(mapload)
	. = ..()
	parent = loc

/obj/item/stock_parts/cell/pdw9/process()
	. = ..()
	parent.update_icon()
