//NEW CARTRAGES
/obj/item/ammo_casing/realistic
	icon = 'modular_skyrat/modules/gunsgalore/icons/ammo/ammo.dmi'

//GERMAN
//7.92x33mm Kurz german
/obj/item/ammo_casing/realistic/a792x33
	name = "7.92x33 bullet casing"
	desc = "A 7.92x33mm Kurz bullet casing."
	icon_state = "792x33-casing"
	caliber = "a792x33"
	projectile_type = /obj/projectile/bullet/a792x33

/obj/projectile/bullet/a792x33
	name = "7.92x33 bullet"
	damage = 40
	wound_bonus = 10
	wound_falloff_tile = 0
//

//7.92x57mm Mauser
/obj/item/ammo_casing/realistic/a792x57
	name = "7.92x57 bullet casing"
	desc = "A 7.92x57mm Mauser bullet casing."
	icon_state = "792x57-casing"
	caliber = "a792x57"
	projectile_type = /obj/projectile/bullet/a792x57

/obj/projectile/bullet/a792x57
	name = "7.92x57 bullet"
	damage = 45
	armour_penetration = 5
	wound_bonus = 15
	wound_falloff_tile = 0
//

//RUSSIAN
//7.62x25 tokarev
/obj/item/ammo_casing/realistic/a762x25
	name = "7.62x25 bullet casing"
	desc = "A 7.62x25 Tokarev bullet casing."
	icon_state = "762x25-casing"
	caliber = "a762x25"
	projectile_type = /obj/projectile/bullet/a762x25

/obj/projectile/bullet/a762x25
	name = "7.62x25 bullet"
	damage = 22
	wound_bonus = 30
	armour_penetration = 8
	wound_falloff_tile = 0
//

//FICTIONAL NRI 5.45 AMMO
/obj/item/ammo_casing/realistic/a545x39
	name = "5.45x39 bullet casing"
	desc = "A 5.45x39mm tungsten-tipped 7N30-B polymer casing."
	icon_state = "545x39-casing"
	caliber = "a545x39"
	projectile_type = /obj/projectile/bullet/a545x39

/obj/projectile/bullet/a545x39
	name = "5.45x39mm bullet"
	damage = 38
	wound_bonus = 35
	armour_penetration = 40
	wound_falloff_tile = 0
