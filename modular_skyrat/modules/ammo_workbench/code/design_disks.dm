/obj/item/disk/ammo_workbench
	name = "Armadyne Munitions blueprint datadisk"
	desc = "You shouldn't be seeing this!"
	var/list/loaded_ammo_types

/obj/item/disk/ammo_workbench/lethal
	name = "lethal munitions datadisk"
	desc = "An Armadyne datadisk filled with lethal casing design blueprints for the ammunitions workbench."
	icon_state = "datadisk0"

/datum/design/disk/ammo_workbench_lethal
	name = "Ammo Workbench: Lethal Munitions Datadisk"
	id = "ammoworkbench_disk_lethal"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/disk/ammo_workbench/lethal
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
		)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
