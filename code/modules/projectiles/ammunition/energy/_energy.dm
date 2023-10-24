/obj/item/ammo_casing/energy
	name = "energy weapon lens"
	desc = "The part of the gun that makes the laser go pew."
	caliber = ENERGY
	projectile_type = /obj/projectile/energy
	slot_flags = null
	var/e_cost = LASER_SHOTS(10, STANDARD_CELL_CHARGE) //The amount of energy a cell needs to expend to create this shot.
	var/select_name = CALIBER_ENERGY
	fire_sound = 'sound/weapons/laser.ogg'
<<<<<<< HEAD
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy
	var/select_color = FALSE //SKYRAT EDIT ADDITION - This is the color that shows up when selecting an ammo type. Disabled by default
=======
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/red
>>>>>>> 28559aa7fc2 (New Muzzle Flash + Temperature gun Baking beam change (#79212))
