/obj/item/ammo_casing/c460rowland
	name = ".460 Rowland Rose bullet casing"
	desc = "A Romulus Tech standard lethal pistol round."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "sl-casing"

	caliber = CALIBER_460ROWLAND
	projectile_type = /obj/projectile/bullet/c460rowland

/obj/projectile/bullet/c460rowland
	name = ".460 Rowland Rose"
	damage = 35
	stamina = 10 //knock the winds outta ya

	wound_bonus = 15
	bare_wound_bonus = -40
	weak_against_armour = TRUE
	stamina_falloff_tile = 0.3

/obj/item/ammo_casing/c460rowland/dart
	name = ".460 Rowland Armour Piercing bullet casing"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "sr-casing"

	caliber = CALIBER_460ROWLAND
	projectile_type = /obj/projectile/bullet/c460rowland/dart

/obj/projectile/bullet/c460rowland/dart
	name = ".460 Rowland Armour Piercing"
	damage = 25

	wound_bonus = -30
	bare_wound_bonus = -10
	weak_against_armour = FALSE
	armour_penetration = 40
	damage_falloff_tile = 0
	stamina_falloff_tile = 0

//457

/obj/item/ammo_casing/c457govt
	name = ".457 Government bullet casing"
	desc = "A Romulus Tech standard lethal pistol round."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "sl-casing"

	caliber = CALIBER_457GOVT
	projectile_type = /obj/projectile/bullet/c457govt

/obj/projectile/bullet/c457govt
	name = ".457 Government"
	damage = 35
	wound_bonus = -20
	bare_wound_bonus = -15

/obj/item/ammo_casing/c457govt/dart
	name = ".457 Government Accelerating"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "sr-casing"

	caliber = CALIBER_457GOVT
	projectile_type = /obj/projectile/bullet/c457govt/dart

/obj/projectile/bullet/c457govt/dart
	name = ".457 Government Accelerating"
	damage = 15

	wound_bonus = -10
	bare_wound_bonus = -10
	armour_penetration = 45
	speed = 0.5
	range = 14
