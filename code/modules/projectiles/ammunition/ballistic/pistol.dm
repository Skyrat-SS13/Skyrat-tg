// 10mm

/obj/item/ammo_casing/c10mm
	name = "10mm bullet casing"
	desc = "A 10mm bullet casing."
	caliber = CALIBER_10MM
	projectile_type = /obj/projectile/bullet/c10mm

/obj/item/ammo_casing/c10mm/ap
	name = "10mm armor-piercing bullet casing"
	desc = "A 10mm armor-piercing bullet casing."
	projectile_type = /obj/projectile/bullet/c10mm/ap

/obj/item/ammo_casing/c10mm/hp
	name = "10mm hollow-point bullet casing"
	desc = "A 10mm hollow-point bullet casing."
	projectile_type = /obj/projectile/bullet/c10mm/hp

/obj/item/ammo_casing/c10mm/fire
	name = "10mm incendiary bullet casing"
	desc = "A 10mm incendiary bullet casing."
	projectile_type = /obj/projectile/bullet/incendiary/c10mm

// 9mm (Makarov, Stechkin APS, PP-95)

/obj/item/ammo_casing/c9mm
//	name = "9mm bullet casing"		// SKYRAT EDIT: Original
//	desc = "A 9mm bullet casing."	// SKYRAT EDIT: Original
	name = "9x25mm Mk.12 bullet casing"	// SKYRAT EDIT
	desc = "A modern 9x25mm Mk.12 bullet casing."	// SKYRAT EDIT
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/c9mm

/obj/item/ammo_casing/c9mm/ap
//	name = "9mm armor-piercing bullet casing"		// SKYRAT EDIT: Original
//	desc = "A 9mm armor-piercing bullet casing."	// SKYRAT EDIT: Original
	name = "9x25mm Mk.12 armor-piercing bullet casing"	// SKYRAT EDIT
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires an armor-piercing projectile."	// SKYRAT EDIT
	projectile_type = /obj/projectile/bullet/c9mm/ap

/obj/item/ammo_casing/c9mm/hp
//	name = "9mm hollow-point bullet casing"			// SKYRAT EDIT: Original
//	desc = "A 10mm hollow-point bullet casing."		// SKYRAT EDIT: Original
	name = "9x25mm Mk.12 hollow-point bullet casing"	// SKYRAT EDIT
	desc = "A modern 9x25mm Mk.12 bullet casing. This one fires a hollow-point projectile. Very lethal to unarmored opponents."	// SKYRAT EDIT
	projectile_type = /obj/projectile/bullet/c9mm/hp

/obj/item/ammo_casing/c9mm/fire
//	name = "9mm incendiary bullet casing"			// SKYRAT EDIT: Original
//	desc = "A 9mm incendiary bullet casing."		// SKYRAT EDIT: Original
	name = "9x25mm Mk.12 incendiary bullet casing"	// SKYRAT EDIT
	desc = "A modern 9x25mm Mk.12 bullet casing. This incendiary round leaves a trail of fire and ignites its target."	// SKYRAT EDIT
	projectile_type = /obj/projectile/bullet/incendiary/c9mm


// .50AE (Desert Eagle)

/obj/item/ammo_casing/a50ae
	name = ".50AE bullet casing"
	desc = "A .50AE bullet casing."
	caliber = CALIBER_50AE
	projectile_type = /obj/projectile/bullet/a50ae
