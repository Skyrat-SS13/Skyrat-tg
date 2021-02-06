/obj/item/gun/energy/laser/hitscan
	name = "Armadyne Allstar SC-05 Laser Focus Rifle"
	desc = "A high energy laser rifle that is capable of lightspeed projectiles which are guaranteed to burn flesh."
	icon_state = "blaster"
	inhand_icon_state = "blaster"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/energy/allstar.dmi'
	lefthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/aesthetics/guns/icons/guns_righthand.dmi'
	worn_icon_state = "blaster_worn"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/energy/allstar.dmi'
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron=4000)
	ammo_type = list(/obj/item/ammo_casing/energy/lasergun/hitscan)
	ammo_x_offset = 0
	shaded_charge = 1

/obj/item/ammo_casing/energy/lasergun/hitscan
	projectile_type = /obj/projectile/beam/laser/hitscan
	e_cost = 71
	select_name = "kill"

/obj/projectile/beam/laser/hitscan
	hitscan = TRUE
	muzzle_type = /obj/effect/projectile/muzzle/laser
	tracer_type = /obj/effect/projectile/tracer/laser
	impact_type = /obj/effect/projectile/impact/laser
	impact_effect_type = null
	hitscan_light_intensity = 3
	hitscan_light_range = 0.75
	hitscan_light_color_override = COLOR_BRIGHT_BLUE
	muzzle_flash_intensity = 6
	muzzle_flash_range = 2
	muzzle_flash_color_override = COLOR_BRIGHT_BLUE
	impact_light_intensity = 7
	impact_light_range = 2.5
	impact_light_color_override = COLOR_BRIGHT_BLUE

/obj/effect/projectile/muzzle/laser
	icon_state = "muzzle_omni"

/obj/effect/projectile/tracer/laser
	name = "laser"
	icon_state = "beam_omni"

/obj/effect/projectile/impact/laser
	name = "laser impact"
	icon_state = "impact_omni"

