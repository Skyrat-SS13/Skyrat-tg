/obj/item/gun/ballistic/automatic/laser/marksman
	name = "designated marksman rifle"
	desc = "A special laser beam sniper rifle designed by a certain now defunct research facility."
	icon_state = "ctfmarksman"
	inhand_icon_state = "ctfmarksman"
	mag_type = /obj/item/ammo_box/magazine/recharge/marksman
	force = 15
	weapon_weight = WEAPON_HEAVY
	zoomable = 1
	zoom_amt = 5
	fire_delay = 4 SECONDS
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_fire.ogg'

/obj/item/ammo_box/magazine/recharge/marksman
	ammo_type = /obj/item/ammo_casing/caseless/laser/marksman
	max_ammo = 5

/obj/item/ammo_casing/caseless/laser/marksman
	projectile_type = /obj/projectile/beam/marksman

/obj/item/ammo_casing/caseless/laser/marksman/Initialize(mapload)
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
