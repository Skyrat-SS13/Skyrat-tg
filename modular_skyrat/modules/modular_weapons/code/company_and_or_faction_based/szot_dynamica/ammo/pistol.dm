// .27-54 Cesarzowa
// Small caliber pistol round meant to be fired out of something that shoots real quick like

/obj/item/ammo_casing/c27_54cesarzowa
	name = ".27-54 Cesarzowa piercing bullet casing"
	desc = "A purple-bodied caseless cartridge home to a small projectile with a fine point."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "27-54cesarzowa"

	caliber = CALIBER_CESARZOWA
	projectile_type = /obj/projectile/bullet/c27_54cesarzowa

/obj/item/ammo_casing/c27_54cesarzowa/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/caseless)

/obj/projectile/bullet/c27_54cesarzowa
	name = ".27-54 Cesarzowa piercing bullet"
	damage = 15
	armour_penetration = 30
	wound_bonus = -30
	bare_wound_bonus = -10

/obj/item/ammo_box/c27_54cesarzowa
	name = "ammo box (.27-54 Cesarzowa piercing)"
	desc = "A box of .27-54 Cesarzowa piercing pistol rounds, holds eighteen cartridges."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/szot_dynamica/ammo.dmi'
	icon_state = "27-54cesarzowa_box"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	w_class = WEIGHT_CLASS_NORMAL

	caliber = CALIBER_CESARZOWA
	ammo_type = /obj/item/ammo_casing/c27_54cesarzowa
	max_ammo = 18

// .27-54 Cesarzowa rubber
// Small caliber pistol round meant to be fired out of something that shoots real quick like, this one is less lethal

/obj/item/ammo_casing/c27_54cesarzowa/rubber
	name = ".27-54 Cesarzowa rubber bullet casing"
	desc = "A purple-bodied caseless cartridge home to a small projectile with a flat rubber tip."

	icon_state = "27-54cesarzowa_rubber"

	projectile_type = /obj/projectile/bullet/c27_54cesarzowa/rubber

/obj/projectile/bullet/c27_54cesarzowa/rubber
	name = ".27-54 Cesarzowa rubber bullet"
	stamina = 20
	damage = 10
	weak_against_armour = TRUE
	wound_bonus = -30
	bare_wound_bonus = -10

/obj/item/ammo_box/c27_54cesarzowa/rubber
	name = "ammo box (.27-54 Cesarzowa rubber)"
	desc = "A box of .27-54 Cesarzowa rubber pistol rounds, holds eighteen cartridges."

	icon_state = "27-54cesarzowa_box_rubber"

	ammo_type = /obj/item/ammo_casing/c27_54cesarzowa/rubber
