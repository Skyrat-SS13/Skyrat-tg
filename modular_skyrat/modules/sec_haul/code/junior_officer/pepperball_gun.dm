/obj/item/gun/ballistic/automatic/pistol/pepperball
	name = "\improper Armadyne Pepperball AHG"
	desc = "A fantastically shit weapon used for self defence and created for the soul purpose of underfunded security forces, meet the Pepperball AHG."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pepperball.dmi'
	icon_state = "peppergun"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/pepperball
	can_suppress = FALSE
	fire_sound = 'sound/effects/pop_expl.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	can_flashlight = TRUE
	dirt_modifier = 3
	emp_damageable = TRUE
	armadyne = TRUE
	fire_sound_volume = 50

/obj/item/ammo_box/magazine/pepperball
	name = "pistol magazine (pepperball)"
	desc = "A gun magazine filled with balls."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pepperball.dmi'
	icon_state = "pepperball"
	ammo_type = /obj/item/ammo_casing/pepperball
	caliber = CALIBER_PEPPERBALL
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_casing/pepperball
	name = "pepperball"
	desc = "A pepperball casing."
	caliber = CALIBER_PEPPERBALL
	projectile_type = /obj/projectile/bullet/pepperball

/obj/projectile/bullet/pepperball
	name = "pepperball orb"
	damage = 0
	nodamage = TRUE
	shrapnel_type = null
	sharpness = NONE
	embedding = null
	impact_effect_type = /obj/effect/temp_visual/impact_effect
	var/contained_reagent = /datum/reagent/consumable/condensedcapsaicin
	var/reagent_volume = 50

/obj/projectile/bullet/pepperball/on_hit(atom/target, blocked, pierce_hit)
	if(isliving(target))
		var/mob/living/M = target
		if(M.can_inject())
			var/datum/reagent/R = new(contained_reagent)
			R.volume = reagent_volume
			R.expose_mob(M, VAPOR)
	. = ..()
