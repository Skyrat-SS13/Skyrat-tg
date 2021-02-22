/*
	Force Gun

	Fires a shortrange blast of gravity that repulses things. Light damage, but stuns and knocks down

	Secondary fire is a focused beam with a similar effect and marginally better damage
*/
#define FORCE_FOCUS_WINDUP_TIME	15

/obj/item/weapon/gun/energy/forcegun
	name = "Handheld Graviton Accelerator"
	desc = "A basic energy-based gun."
	icon = 'icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "forcegun"
	item_state = "forcegun"

	charge_cost = 1000 //Five shots per battery
	cell_type = /obj/item/weapon/cell/force
	projectile_type = null
	slot_flags = SLOT_BACK
	charge_meter = FALSE	//if set, the icon state will be chosen based on the current charge
	mag_insert_sound = 'sound/weapons/guns/interaction/force_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/force_magout.ogg'
	removeable_cell = TRUE
	firemodes = list(
		list(mode_name = "blast", mode_type = /datum/firemode/forcegun/blast, fire_sound = 'sound/weapons/guns/fire/force_shot.ogg', fire_delay = 1.5 SECONDS),
		list(mode_name = "focus", mode_type = /datum/firemode/forcegun/focus, windup_time = 1.5 SECONDS, windup_sound = 'sound/weapons/guns/fire/force_windup.ogg', fire_sound = 'sound/weapons/guns/fire/force_focus.ogg',fire_delay = 1.5 SECONDS)
		)
	has_safety = FALSE	//Safety switches are for military/police weapons, not for tools

	aiming_modes = list(/datum/extension/aim_mode/heavy)


/obj/item/weapon/gun/energy/forcegun/empty
	cell_type = null

/*
	Firemodes
*/
/*
	Blast is a close range shotgun attack.
*/
/datum/firemode/forcegun
	var/firing_cone = 80
	var/firing_range = 4
	var/damage = 59
	var/force	=	350
	var/falloff_factor = 0.9
	var/effect_type = /obj/effect/effect/forceblast
	var/windup_time = 0

/datum/firemode/forcegun/blast
	firing_cone = 80
	firing_range = 4
	damage = 50	//Bear in mind that damage values are heavily affected by falloff. Even at pointblank range, they will never be as high as this number
	force	=	350
	falloff_factor = 0.7

/*
	Focus is a much longer ranged tight beam which hits harder, but has a windup time
*/
/datum/firemode/forcegun/focus
	firing_cone = 15
	firing_range = 8
	damage = 80
	force	=	500
	falloff_factor = 0.35
	effect_type = /obj/effect/effect/forceblast_focus_spawner
	windup_time = 1.5 SECONDS

/datum/firemode/forcegun/on_fire(atom/target, mob/living/user, clickparams, pointblank=0, reflex=0, var/fired = TRUE)
	if (!fired)
		return

	var/held_twohanded = gun.is_held_twohanded(user)

	var/turf/origin = get_turf(user)

	var/vector2/fire_direction = Vector2.DirectionBetween(origin, target)
	var/list/affected_turfs = get_cone(origin, fire_direction, firing_range, firing_cone)

	//Spawn the effect, and also rotate it
	new effect_type(origin, 0.6 SECONDS, fire_direction.Rotation())

	for (var/turf/T as anything in affected_turfs)
		//debug_mark_turf(T)
		if (T == origin)
			continue	//Don't hit yourself!
		var/distance = get_dist_euclidian(origin, T)	//Calculate distance and damage for things in this turf
		var/turf_damage = force_falloff(damage, distance, falloff_factor)
		T.apply_push_impulse_from(origin, force, falloff_factor)
		for (var/atom/movable/AM in T)
			if (!(AM.atom_flags & ATOM_FLAG_INTANGIBLE))
				AM.apply_push_impulse_from(origin, force, falloff_factor)	//Push the thing. This will shove objects, stagger/knockdown mobs
				if (isliving(AM))
					var/mob/living/L = AM
					L.take_overall_damage(turf_damage, 0, gun)	//Mobs additionally take damage



	//TODO: Make the weapon be launched out of your hands if not held twohanded
	if (!held_twohanded)
		user.unEquip(gun)
		gun.throw_at(pick(trange(8, user)), 8, 1, null)
		user.visible_message(SPAN_DANGER("The [gun] goes flying out of [user]'s weak grip!"),SPAN_DANGER("The [gun] goes flying out of your weak grip!"))






/*
	Firing Effects
*/

/obj/effect/effect/forceblast
	alpha = 255
	var/lifespan
	var/expansion_rate
	icon_state = "cone_80"
	icon = 'icons/effects/effects_256.dmi'
	pixel_x = -112
	pixel_y = -112
	var/max_length = 4
	var/target_scale_minus_one = 1
	var/target_scale = 1
	var/scale_growth
	var/fadeout_time = 0.2 SECONDS

/obj/effect/effect/forceblast/New(var/atom/location, var/_lifespan = 2 SECOND, var/matrix/rotation)
	lifespan = _lifespan
	if (rotation)
		transform = rotation
	//Since this is a 256 icon, it is 8 tiles long at 1 scale. But that means it has a radius of 4 tiles
	target_scale = max_length / 4
	target_scale_minus_one = (max_length - 1) / 4


	//How fast is the scale growing? We'll use this to calculate something
	scale_growth = lifespan / max_length

	..()

/obj/effect/effect/forceblast/Initialize()
	.=..()
	var/matrix/baseline = new (transform)
	transform = transform.Scale(0.01)//Start off tiny
	var/matrix/step1 = new (baseline)
	animate(src, transform = step1.Scale(target_scale_minus_one), alpha = 255, time = lifespan-scale_growth)	//It grows to the max size -1
	animate(transform = baseline.Scale(target_scale), alpha = 0, time = scale_growth) //Then rapidly fades out over the final tile
	QDEL_IN(src, lifespan)

/obj/effect/effect/forceblast/focus
	max_length = 8
	icon_state = "cone_15"


/obj/effect/effect/forceblast_focus_spawner
	icon_state = null

//Rather than a single effect, the focus mode uses a little spawner which creates multiple staggered effects
/obj/effect/effect/forceblast_focus_spawner/New(var/atom/location, var/_lifespan = 2 SECOND, var/matrix/rotation)
	spawn()
		for (var/i in 1 to 7)
			new /obj/effect/effect/forceblast/focus(location, _lifespan, rotation)
			sleep(rand_between(1,3))
		qdel(src)


/*--------------------------
	Ammo
---------------------------*/

/obj/item/weapon/cell/force
	name = "force energy"
	desc = "A heavy power pack designed for use with the handheld graviton accelerator"
	origin_tech = list(TECH_POWER = 6)
	icon = 'icons/obj/ammo.dmi'
	icon_state = "forcebattery"
	w_class = ITEM_SIZE_LARGE
	maxcharge = 5000
	matter = list(MATERIAL_STEEL = 700, MATERIAL_SILVER = 80)

/obj/item/weapon/cell/force/update_icon()
	overlays.Cut()
	var/overlay_state
	var/percentage = percent()
	if (percentage >= 20)
		overlay_state = "fb-[round(percentage, 20)]"
	if(overlay_state)
		overlays += image('icons/obj/ammo.dmi', overlay_state)





/*
	Acquisition
*/
/decl/hierarchy/supply_pack/mining/force_energy
	name = "Power - Force Energy"
	contains = list(/obj/item/weapon/cell/force = 4)
	cost = 80
	containertype = /obj/structure/closet/crate
	containername = "\improper force energy crate"


/decl/hierarchy/supply_pack/mining/force_gun
	name = "Mining Tool - Graviton Accelerator"
	contains = list(/obj/item/weapon/cell/force = 2,
	/obj/item/weapon/gun/energy/forcegun/empty = 1)
	cost = 80
	containertype = /obj/structure/closet/crate
	containername = "\improper Graviton Accelerator crate"