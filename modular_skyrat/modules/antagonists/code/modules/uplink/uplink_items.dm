/datum/uplink_item/device_tools/ammo_pouch
	name = "Ammo Pouch"
	desc = "A small yet large enough pouch that can fit in your pocket, and has room for three magazines."
	item = /obj/item/storage/bag/ammo
	cost = 1

/datum/uplink_item/role_restricted/cosmonauts_revolver
	name = "Cosmonauts Revolver"
	desc = "A highly complex Soviet Space Gun, this incredible weapon fired a longer round than its competition, but featured an ingenious (If overly complicated) per-chamber hammer \
			system, and a recoiless design to boot. However, the complexity of this gun was also its undoing, as the Soviet Space agency could not afford to arm every Cosmonaut with such an \
			expensive weapon. This one is museum-grade, and in perfect running condition"
	item = /obj/item/gun/ballistic/revolver/cosmonaut
	cost = 15
	restricted_roles = list("Curator")
	limited_stock = 1

/datum/uplink_item/role_restricted/cosmonauts_revolver/ammo
	name = "Cosmonauts Reloader"
	desc = "Extra-special ammo for your extra-special gun"
	item = /obj/item/ammo_box/cosmonaut
	cost = 5
	restricted_roles = list("Curator")
