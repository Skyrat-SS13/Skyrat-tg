/*
	Force Gun

	Fires a shortrange blast of gravity that repulses things. Light damage, but stuns and knocks down

	Secondary fire is a focused beam with a similar effect and marginally better damage
*/
#define EMPTY	0
#define CHARGING	1
#define CHARGE_READY	2


/obj/item/weapon/gun/energy/contact
	name = "C99 Supercollider Contact Beam"
	desc = "A heavy-duty energy pulse device, the Contact Beam is used for commercial destruction where a powerful but focused explosive force is needed. The alt-fire delivers a ground clearing-blast around the user."
	icon = 'icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "contact"
	item_state = "contact"
	wielded_item_state = "contact-wielded"
	w_class = ITEM_SIZE_HUGE

	charge_cost = 1000 //Five shots per battery
	cell_type = /obj/item/weapon/cell/contact
	projectile_type = null
	slot_flags = SLOT_BACK
	charge_meter = FALSE	//if set, the icon state will be chosen based on the current charge
	mag_insert_sound = 'sound/weapons/guns/interaction/contact_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/contact_magout.ogg'
	removeable_cell = TRUE


	firemodes = list(
		list(mode_name = "charge beam", mode_type = /datum/firemode/contact_beam, fire_delay = 2 SECONDS),
		list(mode_name = "repulse", mode_type = /datum/firemode/contact_repulse, windup_time = 0.5 SECONDS, 	fire_delay = 2 SECONDS)
		)


	aiming_modes = list(/datum/extension/aim_mode/rifle)

	var/charge_status = EMPTY	//We're either doing nothing, charging a shot, or holding a charged shot and ready to fire it
	var/fire_when_charged	=	TRUE	//When we finish charging, do we fire immediately? If false, hold it
	var/fire_params
	var/fire_target
	var/mob/living/fire_user
	var/datum/click_handler/contact/CHC
	var/charge_projectile_type = /obj/item/projectile/beam/contact
	var/obj/flick_overlay/charge_fx

	var/datum/sound_token/charge_sound_token

	shot_volume = VOLUME_MAX

	//This is a precision weapon, not to be hipfired
	require_aiming = TRUE

/obj/item/weapon/gun/energy/contact/empty
	cell_type = null

/*--------------------------------
	Charge Handling
--------------------------------*/
//Called to fire a charged beam
/obj/item/weapon/gun/energy/contact/proc/fire_charged(atom/_target, _clickparams)
	fire_when_charged = TRUE

	if (charge_status == EMPTY)
		return	//Save some processing, we don't care

	update_aiming_handler()

	//Again, it might have changed
	if (charge_status == EMPTY)
		return	//Save some processing, we don't care

	else if (charge_status == CHARGING)
		cancel_charged()
		return	//Aborted

	//We are firing
	QDEL_NULL(charge_sound_token)
	QDEL_NULL(charge_fx)

	//Cache these in case they're needed
	if (_clickparams)
		fire_params = _clickparams
	if (_target)
		fire_target = _target

	var/datum/firemode/contact_beam/CB = current_firemode


	//Its ready to fire!
	if (istype(CB) && charge_status == CHARGE_READY)

		//To actually fire, we briefly disable fire overriding, set a projectile type, then call Fire as normal
		CB.override_fire = FALSE
		projectile_type = charge_projectile_type

		//Pew pew
		Fire(fire_target, fire_user, fire_params)

		//Now set those vars back to default
		CB.override_fire = TRUE
		projectile_type = null

		//We have fired, charge is gone
		charge_status = EMPTY

//Aborts a charged beam and returns us to normal state
/obj/item/weapon/gun/energy/contact/proc/cancel_charged()
	charge_status = EMPTY
	fire_params = null
	fire_target = null
	fire_user = null
	QDEL_NULL(charge_sound_token)
	QDEL_NULL(charge_fx)
	update_icon()

//Starts the charging of a beam, disables autofire
/obj/item/weapon/gun/energy/contact/proc/start_charging(atom/_target, _clickparams, var/mob/living/user)
	if (!can_fire(_target, user, _clickparams))
		return FALSE

	fire_when_charged	=	FALSE
	if (charge_status != EMPTY)
		return


	var/datum/firemode/contact_beam/CB = current_firemode

	if (!istype(CB) || !istype(user))
		cancel_charged()
		return

	//Cache these in case they're needed
	if (_clickparams)
		fire_params = _clickparams
	if (_target)
		fire_target = _target


	charge_status = CHARGING
	update_icon()

	//Charge sound
	charge_sound_token = GLOB.sound_player.PlayStoppableSound(source = src, sound = 'sound/weapons/guns/misc/contact_charge.ogg', sound_id = "contact_charge", volume = VOLUME_LOW, duration = CB.charge_time)

	//Charge visual fx
	//Passing in a null duration makes it stay forever
	charge_fx = flick_overlay_icon(null, icon(icon = src.icon, icon_state = "contact_charge"))

	var/shake_strength = 4
	shake_camera(user, duration = 3, strength = shake_strength)
	var/shaketime = 3
	spawn()
		var/timeleft = CB.charge_time
		//Alright lets run a loop here to charge things

		while (timeleft > 0  && charge_status == CHARGING)	//If the status changes, we cancelled
			timeleft -= 1	//We'll decrement 1 decisecond at a time
			shaketime -= 1
			if (shaketime <= 0)
				shaketime = 3
				shake_strength *= 0.65
				shake_camera(user, duration = 2, strength = shake_strength, flags = 0)
			sleep(1)

		//Once the charge time is done, lets redo safety checks
		user = loc
		if (!istype(CB) || !istype(user) || charge_status != CHARGING)
			cancel_charged()
			return

		//Set the status
		charge_status = CHARGE_READY


		//If the flag is set, fire immediately
		if (fire_when_charged)
			fire_charged()
		else
			//Play a sound to indicate that its ready
			playsound(src, 'sound/weapons/guns/misc/contact_charge_ready.ogg', VOLUME_MID, TRUE)

			//And start looping an additional sound for as long as its held
			//We dont need to worry about stopping the previous token, it has an auto duration cutoff
			charge_sound_token = GLOB.sound_player.PlayLoopingSound(source = src, sound = 'sound/weapons/guns/misc/contact_charge_hold.ogg', sound_id = "contact_charge_hold", volume = VOLUME_QUIET)



/obj/item/weapon/gun/energy/contact/disable_aiming_mode()
	.=..()
	cancel_charged()	//On exiting aiming mode, we dismiss the charged shot


/obj/item/weapon/gun/energy/contact/create_click_handlers()
	.=..()
	var/datum/firemode/contact_beam/CB = current_firemode
	var/mob/living/user = loc
	if (!istype(CB) || !istype(user))
		cancel_charged()
		if (CHC)
			QDEL_NULL(CHC)
		return
	fire_user = user

	if (!CHC)
		CHC = fire_user.PushClickHandler(/datum/click_handler/contact)
		CHC.gun = src

/obj/item/weapon/gun/energy/contact/remove_click_handlers()
	.=..()
	if (CHC)
		QDEL_NULL(CHC)
/*
	Firemodes
*/
/*
	Contact beam charges up a shot which can be held at fully charged state
*/
/datum/firemode/contact_beam
	var/charge_time = 1.3 SECOND
	override_fire = TRUE



/*
	Contact Beam Click Handler
*/
/datum/click_handler/contact
	var/obj/item/weapon/gun/energy/contact/gun	//What gun are they aiming

/datum/click_handler/contact/MouseDown(object,location,control,params)
	var/list/modifiers = params2list(params)
	if(modifiers["left"])
		var/target = get_turf_at_mouse(params, user.client)
		gun.start_charging(target, params, user)
		return FALSE
	return TRUE

/datum/click_handler/contact/MouseUp(object,location,control,params)
	var/list/modifiers = params2list(params)
	if(modifiers["left"])
		var/target = get_turf_at_mouse(params, user.client)
		gun.fire_charged(target, params)
		return FALSE
	return TRUE



/*--------------------------
	Ammo
---------------------------*/

/obj/item/weapon/cell/contact
	name = "contact energy"
	desc = "A heavy power pack designed for use with the C99 Supercollider Contact Beam."
	origin_tech = list(TECH_POWER = 6)
	icon = 'icons/obj/ammo.dmi'
	icon_state = "contact_energy"
	w_class = ITEM_SIZE_LARGE
	maxcharge = 4000
	matter = list(MATERIAL_STEEL = 700, MATERIAL_SILVER = 80)

/obj/item/weapon/cell/contact/update_icon()
	return


/*
	Projectile
*/
/obj/item/projectile/beam/contact
	damage = 92
	armor_penetration = 15
	accuracy	=	100
	fire_sound = list('sound/weapons/guns/fire/contact_fire_1.ogg', 'sound/weapons/guns/fire/contact_fire_2.ogg')


/*
	Repulse drops an area effect pushback
*/
/datum/firemode/contact_repulse

/datum/firemode/contact_repulse/on_fire(atom/target, mob/living/user, clickparams, pointblank=0, reflex=0, var/fired = TRUE)
	new /obj/effect/effect/repulse(get_turf(user), user = user)

/obj/effect/effect/repulse
	icon_state = null

//Rather than a single effect, the focus mode uses a little spawner which creates multiple staggered effects
/obj/effect/effect/repulse/New(var/atom/location, var/_lifespan = 2 SECOND, var/matrix/rotation, var/mob/living/user)


	playsound(src, pick(list('sound/weapons/guns/blast/contact_blast_1.ogg',
	'sound/weapons/guns/blast/contact_blast_2.ogg',
	'sound/weapons/guns/blast/contact_blast_3.ogg',
	'sound/weapons/guns/blast/contact_blast_4.ogg',
	'sound/weapons/guns/blast/contact_blast_5.ogg',
	'sound/weapons/guns/blast/contact_blast_6.ogg')), VOLUME_HIGH, TRUE)

	spawn(5)


		for (var/atom/movable/AM in view(2, location))
			if (AM == user)
				continue

			if (isliving(AM))
				var/mob/living/L = AM
				L.adjustFireLoss(50)
			AM.apply_push_impulse_from(location, 250, 0.3)

		for (var/i in 1 to 4)
			new /obj/effect/effect/expanding_circle(location, 0.25, 1. SECONDS)
			sleep(rand_between(2,4))
		qdel(src)
