//Yoinked away from modular_weapons

/datum/design/shotgun_slug
	name = "Shotgun Slug"
	id = "shotgun_slug"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 4000)
	build_path = /obj/item/ammo_casing/shotgun
	category = list("hacked", "Security")

/datum/design/buckshot_shell
	name = "Buckshot Shell"
	id = "buckshot_shell"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list("hacked", "Security")

/datum/design/buckshot_shell_proto
	name = "Buckshot Shell"
	id = "buckshot_shell_proto"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 200)
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
