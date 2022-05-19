//Yoinked away from modular_weapons
/datum/techweb_node/s14gauge
	id = "s14gauge"
	starting_node = TRUE
	display_name = "14 Gauge Shotshells"
	description = "Standardized 14 Gauge Peacekeeper Ammo."
	design_ids = list(
		"sec_s14g_shell_rubber",
		"sec_s14g_shell_beanbag",
	)

/datum/techweb_node/shotgunnery
	id = "shotgunnery"
	display_name = "Basic Shotshells"
	description = "By applying material sciences, we can produce basic shotshells more efficiently."
	prereq_ids = list("weaponry")
	design_ids = list(
		"sec_buckshot_shell",
		"sec_shotgun_slug",
		"sec_s14g_shell_slug",
		"sec_s14g_shell_buckshot",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)

/datum/techweb_node/exotic_shotgunnery
	id = "shotgunnery"
	display_name = "Exotic Shotshells"
	description = "By optimizing and experimenting with our shotshell knowledge, we unlock alternative shotshells and how to manufacture them."
	prereq_ids = list("shotgunnery")
	design_ids = list(
		"shotgun_slug_hp",
		"buckshot_shell_magnum",
		"buckshot_shell_express",
		"sec_s14g_shell_stunslug",
		"sec_s14g_shell_hp",
		"sec_s14g_shell_magnum",
		"sec_s14g_shell_iceblox",
		"sec_s14g_shell_pyro",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

/datum/techweb_node/adv_shotgunnery
	id = "adv_shotgunnery"
	display_name = "Advanced Shotshells"
	description = "Utilizing our advanced weaponry and engineering knowledge, we can create experimental shotshells."
	prereq_ids = list("adv_weaponry")
	design_ids = list(
		"shotgun_slug_rip",
		"shotgun_slug_pt20",
		"sec_s14g_shell_beehive",
		"sec_s14g_shell_antitide",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)

//12 Gauge
/datum/design/shotgun_slug
	name = "Shotgun Slug"
	id = "shotgun_slug"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 3000)
	build_path = /obj/item/ammo_casing/shotgun
	category = list("hacked", "Security")

/datum/design/shotgun_slug/sec
	id = "sec_shotgun_slug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500)
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/buckshot_shell
	name = "Buckshot Shell"
	id = "buckshot_shell"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/shotgun/buckshot
	category = list("hacked", "Security")

/datum/design/buckshot_shell/sec
	id = "sec_buckshot_shell"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000)
	category = list("Ammo")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/shotgun_slug_hp
	name = "Hollow Point Shotgun Slug"
	id = "shotgun_slug_hp"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500)
	build_path = /obj/item/ammo_casing/shotgun/hp
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/shotgun_slug_pt20
	name = "PT-20 Armor Piercing Shotgun Slug"
	id = "shotgun_slug_pt20"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500, /datum/material/plasma = 1000, /datum/material/titanium = 1000)
	build_path = /obj/item/ammo_casing/shotgun/pt20
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/shotgun_slug_rip
	name = "RIP Shotgun Slug"
	id = "shotgun_slug_rip"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500)
	build_path = /obj/projectile/bullet/shotgun_slug/rip
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/buckshot_shell_magnum
	name = "Magnum Buckshot Shell"
	id = "buckshot_shell_magnum"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/shotgun/magnum
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/buckshot_shell_express
	name = "Express Buckshot Shell"
	id = "buckshot_shell_express"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500)
	build_path = /obj/item/ammo_casing/shotgun/express
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/buckshot_shell_flechette
	name = "Flechette Shell"
	id = "flechette_shell"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500, /datum/material/titanium = 1000)
	build_path = /obj/item/ammo_casing/shotgun/flechette
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

//14 Gauge
/datum/design/s14g_shell_slug
	name = "14 Gauge Shotgun Slug"
	id = "s14g_shell_slug"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/s14gauge
	category = list("hacked", "Security")

/datum/design/s14g_shell_slug/sec
	id = "sec_s14g_shell_slug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500)
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_buckshot
	name = "14 Gauge Buckshot Shell"
	id = "s14g_shell_buckshot"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1500)
	build_path = /obj/item/ammo_casing/s14gauge/buckshot
	category = list("hacked", "Security")

/datum/design/s14g_shell_buckshot/sec
	id = "sec_s14g_shell_buckshot"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000)
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_rubber
	name = "14 Gauge Rubbershot Shell"
	id = "s14g_shell_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1500)
	build_path = /obj/item/ammo_casing/s14gauge/rubbershot
	category = list("initial", "Security")

/datum/design/s14g_shell_rubber/sec
	id = "sec_s14g_shell_rubber"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1000)
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_beanbag
	name = "14 Gauge Beanbag Slug"
	id = "s14g_shell_beanbag"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/s14gauge/beanbag
	category = list("initial", "Security")

/datum/design/s14g_shell_beanbag/sec
	id = "sec_s14g_shell_beanbag"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 1500)
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_hp
	name = "14 Gauge Hollow Point Shotgun Slug"
	id = "sec_s14g_shell_hp"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/s14gauge/hp
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_magnum
	name = "14 Gauge Magnum Buckshot Shell"
	id = "sec_s14g_shell_magnum"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/s14gauge/magnum
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_stunslug
	name = "14 Gauge Shotgun Stunslug"
	id = "sec_s14g_shell_stunslug"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2000, /datum/material/gold = 1000)
	build_path = /obj/item/ammo_casing/s14gauge/stunslug
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_pyro
	name = "14 Gauge Pyrosium Slug"
	id = "sec_s14g_shell_pyro"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2000, /datum/material/plasma = 1000)
	build_path = /obj/item/ammo_casing/s14gauge/pyro
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_beehive
	name = "14 gauge B3-HVE 'Beehive' shell"
	id = "sec_s14g_shell_beehive"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2000, /datum/material/silver = 1000, /datum/material/plasma = 1000)
	build_path = /obj/item/ammo_casing/s14gauge/beehive
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_antitide
	name = "14 gauge 4NT1-TD3 'Suppressor' shell"
	id = "sec_s14g_shell_antitide"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2000, /datum/material/silver = 1000, /datum/material/plasma = 1000)
	build_path = /obj/item/ammo_casing/s14gauge/antitide
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
	autolathe_exportable = FALSE

/datum/design/s14g_shell_iceblox
	name = "14 gauge Iceshot shell"
	id = "sec_s14g_shell_iceblox"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 2000, /datum/material/plasma = 1000)
	build_path = /obj/item/ammo_casing/s14gauge/iceblox
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
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
