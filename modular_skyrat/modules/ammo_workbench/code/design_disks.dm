/obj/item/disk/ammo_workbench
	name = "Armadyne Munitions Blueprint Datadisk"
	desc = "You shouldn't be seeing this!"
	var/list/loaded_ammo_types

/obj/item/disk/ammo_workbench/lethal
	name = "Lethal Munitions Datadisk"
	desc = "An Armadyne datadisk filled with lethal casing design blueprints for the Ammunitions Workbench."
	icon_state = "datadisk0"

/datum/design/disk/ammo_workbench_lethal
	name = "Ammo Workbench: Lethal Munitions Datadisk"
	id = "ammoworkbench_disk_lethal"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/disk/ammo_workbench/lethal
	category = list("intial", "Security", "Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
