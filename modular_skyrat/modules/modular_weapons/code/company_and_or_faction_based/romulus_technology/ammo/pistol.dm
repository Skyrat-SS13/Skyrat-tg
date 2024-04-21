/obj/item/ammo_casing/c460rowland
	name = ".460 Rowland Rose bullet casing"
	desc = "A Romulus Tech standard lethal pistol round."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "sl-casing"

	caliber = CALIBER_460ROWLAND
	projectile_type = /obj/projectile/bullet/c460rowland

/obj/projectile/bullet/c460rowland
	name = ".460 Rowland Rose"
	damage = 30

	wound_bonus = 30
	bare_wound_bonus = 20
	weak_against_armour = TRUE

/obj/item/ammo_casing/c460rowland/dart
	name = ".460 Rowland Armour Piercing bullet casing"

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/romulus_technology/ammo.dmi'
	icon_state = "sr-casing"

	caliber = CALIBER_460ROWLAND
	projectile_type = /obj/projectile/bullet/c460rowland/dart

/obj/projectile/bullet/c460rowland/dart
	name = ".460 Rowland Armour Piercing"
	damage = 25

	wound_bonus = -10
	bare_wound_bonus = -10
	weak_against_armour = FALSE
	armour_penetration = 40
