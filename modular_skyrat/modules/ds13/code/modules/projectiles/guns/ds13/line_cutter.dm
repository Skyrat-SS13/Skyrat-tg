/*
	Force Gun

	Fires a shortrange blast of gravity that repulses things. Light damage, but stuns and knocks down

	Secondary fire is a focused beam with a similar effect and marginally better damage
*/
#define FORCE_FOCUS_WINDUP_TIME	15

/obj/item/weapon/gun/projectile/linecutter
	name = "IM-822 Handheld Ore Cutter Line Gun"
	desc = "A basic energy-based gun."
	icon = 'icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "linecutter"
	item_state = "linecutter"

	ammo_type = /obj/item/ammo_casing/linerack
	slot_flags = SLOT_BACK
	mag_insert_sound = 'sound/weapons/guns/interaction/line_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/line_magout.ogg'
	firemodes = list(
		list(mode_name = "line cutter", fire_sound = 'sound/weapons/guns/fire/line_fire.ogg', fire_delay = 1.75 SECONDS),
		list(mode_name = "plasma mine", projectile_type = /obj/item/projectile/deploy/plasma, fire_sound = 'sound/weapons/guns/fire/line_altfire.ogg', fire_delay = 1.75 SECONDS))

	icon_state = "linecutter"
	item_state = "linecutter"
	wielded_item_state = ""
	w_class = ITEM_SIZE_HUGE
	handle_casings = CLEAR_CASINGS
	load_method = SINGLE_CASING|SPEEDLOADER
	caliber = "linerack"
	slot_flags = SLOT_BACK
	ammo_type = /obj/item/ammo_casing/linerack
	one_hand_penalty = 6	//Don't try to fire this with one hand
	max_shells = 5

	aiming_modes = list(/datum/extension/aim_mode/heavy)

	//The linegun opens when you enter ironsights mode
	require_aiming = TRUE

	has_safety = FALSE	//Safety switches are for military/police weapons, not for tools

/*
	Ironsight Handling
*/
/obj/item/weapon/gun/projectile/linecutter/enable_aiming_mode()
	.=..()
	if (.)
		playsound(src, 'sound/weapons/guns/interaction/line_open.ogg', VOLUME_MID, TRUE)
		update_icon()

/obj/item/weapon/gun/projectile/linecutter/disable_aiming_mode()
	.=..()
	if (.)
		playsound(src, 'sound/weapons/guns/interaction/line_close.ogg', VOLUME_MID, TRUE)
		update_icon()

/obj/item/weapon/gun/projectile/linecutter/update_icon()
	if (active_aiming_mode)
		icon_state = "linecutter_open"
		item_state = "linecutter_open"
	else
		icon_state = "linecutter"
		item_state = "linecutter"

	update_wear_icon()

/obj/item/weapon/gun/projectile/linecutter/empty
	ammo_type = null



/obj/item/weapon/gun/projectile/linecutter/can_fire()
	.=..()
	if (.)
		if (!is_held_twohanded(loc))
			return FALSE

/*
	Firemodes
*/
/*--------------------------
	Cutting Wave
--------------------------*/
/obj/item/projectile/wave/linecutter
	damage = 32
	accuracy = 130
	penetrating = TRUE
	edge = TRUE
	icon = 'icons/obj/weapons/ds13_projectiles_large.dmi'
	icon_state = "linecutter_48"
	step_delay = 3
	kill_count = 9	//Short ranged
	height = 0.1	//10cm thick wave

	var/dig_power = 1800

/obj/item/projectile/wave/linecutter/update_icon()
	if (backstop)
		return

	switch(side)
		if (LEFT)
			icon_state = "linecutter_left"
		if (RIGHT)
			icon_state = "linecutter_right"

//get_limbs_at_height(var/altitude, var/height = 0.01)

/obj/item/projectile/wave/linecutter/attack_mob(var/mob/living/target_mob, var/distance, var/miss_modifier=0)
	//We'll only do our special effect if we haven't already hit this mob
	var/do_hit = TRUE
	if (PW && (target_mob in PW.damaged_atoms))
		do_hit = FALSE
	.=..()

	if (do_hit && ishuman(target_mob))
		var/mob/living/carbon/human/H = target_mob
		//List of the tags of bodyparts we've already hit, so we don't hit them twice
		var/already_hit = list(def_zone)

		//Linecutter projectiles hit all limbs at the same height
		for (var/obj/item/organ/external/E as anything in H.get_limbs_at_height(altitude, height))
			if ((E.organ_tag in already_hit))
				continue

			already_hit += E.organ_tag
			H.bullet_act(src, E.organ_tag)



/obj/item/projectile/wave/linecutter/Bump(var/atom/A)
	if(istype(A, /turf/simulated/mineral))
		var/turf/simulated/mineral/M = A
		if (dig_power)
			var/dig_amount = min(dig_power, (M.health+M.resistance))
			dig_power -= dig_amount
			M.dig(dig_amount)
	. = ..()
/*--------------------------
	Plasma Mine
--------------------------*/


/obj/item/projectile/deploy/plasma
	deploy_type = /obj/effect/mine/plasma
	icon_state = "plasma_mine"

//The deployed mine, explodes after some time
/obj/effect/mine/plasma
	name = "Plasma Mine"
	icon = 'icons/obj/weapons/ds13_deployables.dmi'
	icon_state = "plasma_mine_base"
	var/obj/effect/plasma_light/p_light
	fuse_timer = 6 SECONDS


/obj/effect/mine/plasma/Initialize()
	p_light = new (loc)
	playsound(src, 'sound/weapons/guns/misc/plasma_mine.ogg', VOLUME_MAX, FALSE)//Max volume, no variation. This terrifying sound is an important warning
	.=..()

/obj/effect/mine/plasma/Destroy()
	QDEL_NULL(p_light)
	.=..()

/obj/effect/mine/plasma/explode(obj)
	explosion(3, 5)
	spawn(0)
		qdel(src)

//Small light effect that rises into the air over time
/obj/effect/plasma_light
	icon = 'icons/obj/weapons/ds13_deployables.dmi'
	icon_state = "plasma_mine_light"

/obj/effect/plasma_light/New(var/atom/location, var/duration = 5 SECONDS)
	.=..()
	animate(src, pixel_y = pixel_y+13, time = duration)



/obj/effect/plasma_light/Initialize()
	.=..()
	flicker()

/obj/effect/plasma_light/proc/flicker()
	set waitfor = FALSE
	while (!QDELETED(src))
		set_light(1, 1, 3, 2, "#CCCC11")
		sleep(2)
		if (QDELETED(src))
			return
		set_light(0)
		sleep(2)
/*--------------------------
	Ammo
---------------------------*/

/obj/item/ammo_magazine/lineracks
	name = "line racks"
	desc = "A pack of line racks for use in the IM-822 Handheld Ore Cutter Line Gun"
	icon_state = "line_racks"
	caliber = "linerack"
	ammo_type = /obj/item/ammo_casing/linerack
	matter = list(MATERIAL_STEEL = 1260)
	max_ammo = 5
	multiple_sprites = 0
	mag_type = SPEEDLOADER
	delete_when_empty = TRUE


/obj/item/ammo_casing/linerack
	name = "line rack"
	desc = "An assemblage of metal and wires with a built in power supply"
	icon_state = "line_rack"
	spent_icon = "line_rack"
	caliber = "linerack"
	projectile_type  = /obj/item/projectile/wavespawner/linecutter


/obj/item/projectile/wavespawner/linecutter
	wave_type = /obj/item/projectile/wave/linecutter
	width = 3



/*
	Acquisition
*/
/decl/hierarchy/supply_pack/mining/line_racks
	name = "Line Racks"
	contains = list(/obj/item/ammo_magazine/lineracks = 4)
	cost = 90
	containertype = /obj/structure/closet/crate
	containername = "\improper line rack crate"


/decl/hierarchy/supply_pack/mining/line_cutter
	name = "Mining Tool - Line Cutter"
	contains = list(/obj/item/ammo_magazine/lineracks = 2,
	/obj/item/weapon/gun/projectile/linecutter/empty = 1)
	cost = 90
	containertype = /obj/structure/closet/crate
	containername = "\improper Line Cutter crate"