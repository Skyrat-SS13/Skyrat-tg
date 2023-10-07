/*
*	AMMO
*/

/datum/design/strilka310_rubber
	name = ".310 Rubber Bullet (Less Lethal)"
	id = "astrilka310_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/ammo_casing/strilka310/rubber
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO)

// 4.6x30mm - SMG round, used in the WT550 and in numerous modular guns as a weaker alternative to 9mm.

/datum/design/c46x30mm
	name = "4.6x30mm Bullet"
	id = "c46x30mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5)
	build_path = /obj/item/ammo_casing/c46x30mm
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO)

/datum/design/c46x30mm_rubber
	name = "4.6x30mm Rubber Bullet"
	id = "c46x30mm_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5)
	build_path = /obj/item/ammo_casing/c46x30mm/rubber
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO)

// .45

/datum/design/c45_lethal
	name = ".45 Bullet"
	id = "c45_lethal"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5)
	build_path = /obj/item/ammo_casing/c45
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO)

/datum/design/c45_rubber
	name = ".45 Bouncy Rubber Ball"
	id = "c45_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5)
	build_path = /obj/item/ammo_casing/c45/rubber
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO)

// 10mm
/datum/design/c10mm_lethal
	name = "10mm Bullet"
	id = "c10mm_lethal"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5)
	build_path = /obj/item/ammo_casing/c10mm
	category = list(RND_CATEGORY_HACKED, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO)

/datum/design/c10mm_rubber
	name = "10mm Rubber Bullet"
	id = "c10mm_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 7.5)
	build_path = /obj/item/ammo_casing/c10mm/rubber
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_AMMO)
