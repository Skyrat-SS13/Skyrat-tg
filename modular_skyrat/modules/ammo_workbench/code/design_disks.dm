/obj/item/disk/ammo_workbench
	name = "Armadyne Munitions blueprint datadisk"
	desc = "You shouldn't be seeing this!"

/// For doing things when installed/downloaded onto an ammo bench.
/// Really only used for setting variables, but if someone expands the system to have disks per ammo type, I guess this could be more useful.
/obj/item/disk/ammo_workbench/proc/on_bench_install(obj/machinery/ammo_workbench/ammobench)
	return

/obj/item/disk/ammo_workbench/advanced
	name = "advanced munitions datadisk"
	desc = "An Armadyne datadisk filled with advanced munition fabrication data for the ammunition workbench, including lethal ammotypes if not previously enabled. \
	Armadyne's munitions division does not take responsibility for any incidents that occur if safeties were circumvented beforehand."

/obj/item/disk/ammo_workbench/advanced/on_bench_install(obj/machinery/ammo_workbench/ammobench)
	ammobench.allowed_harmful = TRUE
	ammobench.allowed_advanced = TRUE

/datum/design/disk/ammo_workbench_lethal
	name = "Ammo Workbench Advanced Munitions Datadisk"
	id = "ammoworkbench_disk_lethal"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/disk/ammo_workbench/advanced
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_SECURITY,
		RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO
		)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
