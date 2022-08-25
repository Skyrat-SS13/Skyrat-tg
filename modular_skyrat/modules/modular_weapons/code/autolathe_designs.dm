/*
*	AMMO
*/

// .32 - 15 damage pistol round.

/datum/design/c32
	name = ".32 Bullet"
	id = "c32"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c32
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/c32/rubber
	name = ".32 Rubber Bullet"
	id = "c32/rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c32/rubber
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SECURITY)

/datum/design/a762
	name = "7.62 Bullet"
	id = "a762"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/a762
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/a762_rubber
	name = "7.62 Rubber Bullet"
	id = "a762_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/a762/rubber
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

// 4.6x30mm - SMG round, used in the WT550 and in numerous modular guns as a weaker alternative to 9mm.

/datum/design/c46x30mm
	name = "4.6x30mm Bullet"
	id = "c46x30mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c46x30mm
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/c46x30mm_rubber
	name = "4.6x30mm Rubber Bullet"
	id = "c46x30mm_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c46x30mm/rubber
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SECURITY)

// .45

/datum/design/c45_lethal
	name = ".45 Bullet"
	id = "c45_lethal"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c45
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/c45_rubber
	name = ".45 Bouncy Rubber Ball"
	id = "c45_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c45/rubber
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SECURITY)

// .460 Rowland magnum, for the M45A5

/datum/design/b460
	name = ".460 Rowland magnum"
	id = "b460"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1500)
	build_path = /obj/item/ammo_casing/b460
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

// 10mm Magnum
/datum/design/c10mm_lethal
	name = "10mm Magnum bullet"
	id = "c10mm_lethal"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c10mm
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/c10mm_rubber
	name = "10mm Magnum rubber bullet"
	id = "c10mm_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c10mm/rubber
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_SECURITY)

// Peacekeeper Rounds
/datum/design/b9mm
	name = "Ammo Box (9x19mm Peacekeeper FMJ)"
	id = "b9mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/advanced/b9mm
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/b9mm_rubber
	name = "9x19mm Peacekeeper rubber bullet"
	id = "b9mm_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/b9mm/rubber
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/b10mm
	name = "Ammo Box (10mm Auto)"
	id = "b10mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 30000)
	build_path = /obj/item/ammo_box/advanced/b10mm
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)

/datum/design/b10mm_rubber
	name = "10mm Auto rubber bullet"
	id = "b10mm_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/b10mm/rubber
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_SECURITY)
