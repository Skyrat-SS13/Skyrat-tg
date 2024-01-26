/obj/item/gun/ballistic/automatic/laser/marksman // Cheap replacement for a gauss rifle.
	name = "designated marksman rifle"
	desc = "A special laser beam sniper rifle designed by a certain now defunct research facility."
	icon_state = "ctfmarksman"
	inhand_icon_state = "ctfmarksman"
	accepted_magazine_type = /obj/item/ammo_box/magazine/recharge/marksman
	force = 15
	weapon_weight = WEAPON_HEAVY
	fire_delay = 4 SECONDS
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_fire.ogg'

/obj/item/gun/ballistic/automatic/laser/marksman/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/ammo_box/magazine/recharge/marksman
	ammo_type = /obj/item/ammo_casing/laser/marksman
	max_ammo = 5

/obj/item/ammo_casing/laser/marksman
	projectile_type = /obj/projectile/beam/marksman

/obj/item/ammo_casing/laser/marksman/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/delete_on_drop)

/obj/projectile/beam/marksman
	name = "laser beam"
	damage = 70
	armour_penetration = 30
	hitscan = TRUE
	icon_state = "gaussstrong"
	tracer_type = /obj/effect/projectile/tracer/solar
	muzzle_type = /obj/effect/projectile/muzzle/solar
	impact_type = /obj/effect/projectile/impact/solar
