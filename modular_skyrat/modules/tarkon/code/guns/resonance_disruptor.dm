/// Yes. This is a lot of code frankensteining. I am not proud of my work but damned am i proud it works... Atleast if you're seeing this it works.

/obj/item/gun/energy/recharge/resonant_system
	name = "A.R.C.S Resonator"
	desc = "The \"Advanced Resonance Control System\" or \"A.R.C.S\" is an advanced, ranged version of a mining resonator. While its main case looks nothing more fancy than a modified proto-kinetic accelerator... One could guess thats not far off the truth. The lugs for a bayonette are missing, but atleast you can play with the new adjustment dial on the side."
	icon = 'modular_skyrat/modules/tarkon/icons/misc/ARCS.dmi'
	righthand_file = 'modular_skyrat/modules/tarkon/icons/mob/guns/ARCS/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/tarkon/icons/mob/guns/ARCS/lefthand.dmi'
	icon_state = "arcs"
	base_icon_state = "arcs"
	inhand_icon_state = "arcs"
	ammo_type = list(/obj/item/ammo_casing/energy/resonance)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	gun_flags = NOT_A_REAL_GUN
	/// the mode of the resonator; has three modes: auto (1), manual (2), and matrix (3)
	var/mode = RESONATOR_MODE_AUTO
	/// How devestating it is in manual mode. Yes, this is all copied from the resonator item
	var/quick_burst_mod = 1.3
	/// the number of fields the resonator is allowed to have at once
	var/fieldlimit = 5
	/// the list of currently active fields from this resonator
	var/list/fields = list()
	/// the number that is added to the failure_prob, which is the probability of whether it will spread or not
	var/adding_failure = 30

/obj/item/gun/energy/recharge/resonant_system/attack_self(mob/user)
	if(mode == RESONATOR_MODE_AUTO)
		to_chat(user, span_info("You set the resonator's fields to detonate only after you hit one with it."))
		mode = RESONATOR_MODE_MANUAL
	else
		to_chat(user, span_info("You set the resonator's fields to automatically detonate after 2 seconds."))
		mode = RESONATOR_MODE_AUTO

/obj/item/gun/energy/recharge/resonant_system/proc/modify_projectile(obj/projectile/resonant_bolt/bolt)
	bolt.firing_gun = src //do something special on-hit, easy!

/obj/item/ammo_casing/energy/resonance
	projectile_type = /obj/projectile/resonant_bolt
	select_name = "kinetic"
	e_cost = LASER_SHOTS(1, STANDARD_CELL_CHARGE * 0.5)
	fire_sound = 'sound/weapons/kinetic_accel.ogg'

/obj/item/ammo_casing/energy/resonance/ready_proj(atom/target, mob/living/user, quiet, zone_override = "")
	..()
	if(loc && istype(loc, /obj/item/gun/energy/recharge/resonant_system))
		var/obj/item/gun/energy/recharge/resonant_system/firer = loc
		firer.modify_projectile(loaded_projectile)

/obj/projectile/resonant_bolt
	name = "resonating pulse"
	icon_state = "pulse1"
	damage = 0 //Damage will be done via delayed blast
	damage_type = BRUTE
	armor_flag = BOMB //Shockwave as opposed to physical mass
	range = 6
	log_override = TRUE
	var/obj/item/gun/energy/recharge/resonant_system/firing_gun = null

/obj/projectile/resonant_bolt/on_hit(atom/target, blocked = 0, pierce_hit)
	var/hit_target = FALSE
	if(isliving(target))
		var/mob/living/idiot = target
		if(idiot.has_status_effect(/datum/status_effect/resonant_link))
			var/datum/status_effect/resonant_link/blaster = idiot.has_status_effect(/datum/status_effect/resonant_link)
			blaster.detonate()
			blaster.Destroy()
		else
			var/datum/status_effect/resonant_link/connection = idiot.apply_status_effect(/datum/status_effect/resonant_link, firing_gun)
			if(firing_gun)
				connection.mode = firing_gun.mode
				connection.quick_burst_mod = firing_gun.quick_burst_mod
				connection.creator = firer
				if(firing_gun.mode == RESONATOR_MODE_AUTO)
					connection.duration = world.time + 20
					connection.autodet = TRUE
		hit_target = TRUE
	var/target_turf = get_turf(target)
	var/obj/effect/temp_visual/resonance/resonance_field = locate(/obj/effect/temp_visual/resonance) in target_turf
	if(resonance_field)
		if(!hit_target)
			resonance_field.damage_multiplier = firing_gun.quick_burst_mod
			resonance_field.burst()
			hit_target = TRUE
			return
	if(LAZYLEN(firing_gun.fields) < firing_gun.fieldlimit)
		if(!hit_target)
			new /obj/effect/temp_visual/resonance(target_turf, firer, firing_gun, firing_gun.mode, firing_gun.adding_failure)
	..()

/datum/status_effect/resonant_link
	id = "resonant_link"
	duration = 300 //Resonance can only stay for so long, if it doesn't break from activation
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null //Visual cue + general context is enough
	processing_speed = STATUS_EFFECT_NORMAL_PROCESS
	var/mutable_appearance/marked_underlay
	var/obj/item/gun/energy/recharge/resonant_system/firing_gun = null
	var/damage_name = "resonant_force"
	var/mode = null
	var/quick_burst_mod = null
	var/resonance_damage = 15
	var/damage_multiplier = 1
	var/mob/creator
	var/autodet = FALSE

/datum/status_effect/resonant_link/on_creation(mob/living/new_owner, obj/item/gun/energy/recharge/resonant_system/new_firing_gun)
	. = ..()
	if(.)
		firing_gun = new_firing_gun

/datum/status_effect/resonant_link/on_apply()
	if(owner.mob_size >= MOB_SIZE_SMALL) // needs a minimal mass to resonate with.
		if(autodet)
			marked_underlay = mutable_appearance('icons/effects/effects.dmi', "shield2")
		else
			marked_underlay = mutable_appearance('icons/effects/effects.dmi', "shield1")
		marked_underlay.pixel_x = -owner.pixel_x
		marked_underlay.pixel_y = -owner.pixel_y
		owner.underlays += marked_underlay
		return TRUE
	return FALSE

/datum/status_effect/resonant_link/on_remove()
	. = ..()
	if(autodet)
		detonate()

/datum/status_effect/resonant_link/proc/check_pressure(turf/proj_turf)
	if(!proj_turf)
		proj_turf = get_turf(owner.loc)
	resonance_damage = initial(resonance_damage)
	if(lavaland_equipment_pressure_check(proj_turf))
		damage_name = "strong [initial(damage_name)]"
		resonance_damage *= 3
	else
		damage_name = initial(damage_name)
	resonance_damage *= damage_multiplier

/datum/status_effect/resonant_link/proc/detonate()
	SIGNAL_HANDLER
	var/turf/src_turf = get_turf(src)
	playsound(src_turf, 'sound/weapons/resonator_blast.ogg', 50, TRUE)
	check_pressure(src_turf)
	if(creator)
		log_combat(creator, owner, "used a resonator field on", "resonator")
		SEND_SIGNAL(creator, COMSIG_LIVING_RESONATOR_BURST, creator, owner)
	to_chat(owner, span_userdanger("[src] detonated with you in it!"))
	owner.apply_damage(resonance_damage, BRUTE)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/resonance)
	addtimer(CALLBACK(owner, TYPE_PROC_REF(/mob, remove_movespeed_modifier), /datum/movespeed_modifier/resonance), 10 SECONDS, TIMER_UNIQUE | TIMER_OVERRIDE)

/datum/status_effect/resonant_link/Destroy()
	firing_gun = null
	if(owner)
		owner.underlays -= marked_underlay
	QDEL_NULL(marked_underlay)
	return ..()

/datum/status_effect/resonant_link/be_replaced()
	owner.underlays -= marked_underlay //if this is being called, we should have an owner at this point
	..()
