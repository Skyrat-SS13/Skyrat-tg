////////////////////////
//ID: MODULAR_WEAPONS //
////////////////////////

////////////////////////
//        AMMO        //
////////////////////////

// .32 - 15 damage pistol round.

/datum/design/c32
	name = "4.6x30mm Bullet"
	id = "c32"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c32
	category = list("hacked", "Security")

/datum/design/c32_rubber
	name = ".32 Rubber Bullet"
	id = "c32_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 1000)
	build_path = /obj/item/ammo_casing/c32_rubber
	category = list("initial", "Security")

/datum/design/c32_ap
	name = ".32 Armor-Piercing Bullet"
	id = "c32_ap"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/c32_ap
	category = list("hacked", "Security")

/datum/design/c32_incendiary
	name = ".32 Incendiary Bullet"
	id = "c32_incendiary"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/c32_incendiary
	category = list("hacked", "Security")

/datum/design/smg32acp
	name = "Empty .32 SMG Magazine"
	id = "smg32acp"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 3000)
	build_path = /obj/item/ammo_box/magazine/smg32/empty
	category = list("hacked", "Security")

// 4.6x30mm - SMG round, used in the WT550 and in numerous modular guns as a weaker alternative to 9mm.

/datum/design/c46x30mm
	name = "4.6x30mm Bullet"
	id = "c46x30mm"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/c46x30mm
	category = list("hacked", "Security")

/datum/design/c46x30mm_rubber
	name = "4.6x30mm Rubber Bullet"
	id = "c46x30mm_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/c46x30mm
	category = list("initial", "Security")

/datum/design/c46x30mm_ap
	name = "4.6x30mm Armor-Piercing Bullet"
	id = "c46x30mm_ap"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/c46x30mm/ap
	category = list("hacked", "Security")

/datum/design/c46x30mm_incendiary
	name = "4.6x30mm Incendiary Bullet"
	id = "c46x30mm_incendiary"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/c46x30mm/inc
	category = list("hacked", "Security")

// .45

/datum/design/c45
	name = ".45 Bullet"
	id = "c45"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/c45
	category = list("hacked", "Security")

/datum/design/c45_rubber
	name = ".45 Rubber Bullet"
	id = "c45_rubber"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 2000)
	build_path = /obj/item/ammo_casing/c45/rubber
	category = list("initial", "Security")
