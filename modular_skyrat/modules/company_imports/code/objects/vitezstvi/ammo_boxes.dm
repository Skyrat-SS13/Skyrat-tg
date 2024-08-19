/obj/item/ammo_box
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/ammo_box/magazine
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/strilka310
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/a357
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/c38
	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/c9mm/ap
	name = "ammo box (9mm AP)"
	ammo_type = /obj/item/ammo_casing/c9mm/ap

/obj/item/ammo_box/c9mm/hp
	name = "ammo box (9mm HP)"
	ammo_type = /obj/item/ammo_casing/c9mm/hp

/obj/item/ammo_box/c9mm/fire
	name = "ammo box (9mm incendiary)"
	ammo_type = /obj/item/ammo_casing/c9mm/fire

/obj/item/ammo_box/c10mm/ap
	name = "ammo box (10mm AP)"
	ammo_type = /obj/item/ammo_casing/c10mm/ap
	max_ammo = 20

/obj/item/ammo_box/c10mm/hp
	name = "ammo box (10mm HP)"
	ammo_type = /obj/item/ammo_casing/c10mm/hp
	max_ammo = 20

/obj/item/ammo_box/c10mm/fire
	name = "ammo box (10mm incendiary)"
	ammo_type = /obj/item/ammo_casing/c10mm/fire
	max_ammo = 20

/obj/item/ammo_box/c46x30mm
	name = "ammo box (4.6x30mm)"
	icon = 'modular_skyrat/modules/company_imports/icons/ammo.dmi'
	icon_state = "ammo_46"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	max_ammo = 20

/obj/item/ammo_box/c46x30mm/ap
	name = "ammo box (4.6x30mm AP)"
	ammo_type = /obj/item/ammo_casing/c46x30mm/ap

/obj/item/ammo_box/c46x30mm/rubber
	name = "ammo box (4.6x30mm rubber)"
	ammo_type = /obj/item/ammo_casing/c46x30mm/rubber

/obj/item/ammo_box/c34
	name = "ammo box (.34)"
	icon = 'modular_skyrat/modules/company_imports/icons/ammo.dmi'
	icon_state = "ammo_34"
	ammo_type = /obj/item/ammo_casing/c34
	max_ammo = 20

/obj/item/ammo_box/c34/ap
	name = "ammo box (.34 AP)"
	ammo_type = /obj/item/ammo_casing/c34/ap

/obj/item/ammo_box/c34/rubber
	name = "ammo box (.34 rubber)"
	ammo_type = /obj/item/ammo_casing/c34/rubber

/obj/item/ammo_box/c34/fire
	name = "ammo box (.34 incendiary)"
	ammo_type = /obj/item/ammo_casing/c34_incendiary

/obj/item/storage/box/ammo_box/microfusion/bluespace
	name = "bluespace microfusion cell container"
	desc = "A box filled with microfusion cells."

/obj/item/storage/box/ammo_box/microfusion/bluespace/PopulateContents()
	new /obj/item/storage/pouch/ammo(src)
	new /obj/item/stock_parts/power_store/cell/microfusion/bluespace(src)
	new /obj/item/stock_parts/power_store/cell/microfusion/bluespace(src)
	new /obj/item/stock_parts/power_store/cell/microfusion/bluespace(src)


/obj/item/storage/box/ammo_box/microfusion/bluespace/bagless/PopulateContents()
	new /obj/item/stock_parts/power_store/cell/microfusion/bluespace(src)
	new /obj/item/stock_parts/power_store/cell/microfusion/bluespace(src)
	new /obj/item/stock_parts/power_store/cell/microfusion/bluespace(src)

