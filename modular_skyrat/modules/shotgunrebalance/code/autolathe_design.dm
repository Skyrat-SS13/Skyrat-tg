//12 Gauge
/datum/design/shotgun_slug
	name = "Shotgun Slug"
	id = "shotgun_slug"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 3000)
	build_path = /obj/item/ammo_casing/shotgun
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/shotgun_slug/sec
	id = "sec_shotgun_slug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500)
	category = list(RND_CATEGORY_AMMO)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/buckshot_shell
	name = "Buckshot Shell"
	id = "buckshot_shell"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/buckshot_shell/sec
	id = "sec_buckshot_shell"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000)
	category = list(RND_CATEGORY_AMMO)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY
	autolathe_exportable = FALSE

//Existing Designs Discounting

/datum/design/rubbershot
	materials = list(/datum/material/iron = 2000)

/datum/design/rubbershot/sec
	materials = list(/datum/material/iron = 1000)

/datum/design/beanbag_slug
	materials = list(/datum/material/iron = 3000)

/datum/design/beanbag_slug/sec
	materials = list(/datum/material/iron = 1500)

/datum/design/shotgun_dart
	materials = list(/datum/material/iron = 3000)

/datum/design/shotgun_dart/sec
	materials = list(/datum/material/iron = 1500)

/datum/design/incendiary_slug
	materials = list(/datum/material/iron = 3000)

/datum/design/incendiary_slug/sec
	materials = list(/datum/material/iron = 1500)
