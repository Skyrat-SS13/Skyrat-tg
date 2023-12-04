/// Yes. This is a lot of code frankensteining. I am not proud of my work but damned am i proud it works... Atleast if you're seeing this it works.

/obj/item/gun/energy/recharge/kinetic_accelerator/resonant_system
	name = "Advanced Resonance Control System"
	desc = "The \"Advanced Resonance Control System\" or \"A.R.C.S\" is an advanced, ranged version of a mining resonator."
	icon_state = "kineticgun"
	base_icon_state = "kineticgun"
	inhand_icon_state = "kineticgun"
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic)
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	can_bayonet = TRUE
	knife_x_offset = 20
	knife_y_offset = 12
	var/mob/holder
	var/max_mod_capacity = 100
	var/list/modkits = list()
	gun_flags = NOT_A_REAL_GUN

/obj/projectile/resonant_bolt
	name = "resonating pulse"
	icon_state = "pulse1"
	damage = 0 //Damage will be done via delayed blast
	damage_type = BRUTE
	armor_flag = BOMB //Shockwave as opposed to physical mass
	range = 6
	log_override = TRUE
	var/firing_gun


/obj/projectile/resonant_bolt/Destroy()
	hammer_synced = null
	return ..()

/obj/projectile/resonant_bolt/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/L = target
		var/had_effect = (L.has_status_effect(/datum/status_effect/resonant_link)) //used as a boolean
		var/datum/status_effect/resonant_link/CM = L.apply_status_effect(/datum/status_effect/resonant_link, hammer_synced)
		if(hammer_synced)
			for(var/t in hammer_synced.trophies)
				var/obj/item/crusher_trophy/T = t
				T.on_mark_application(target, CM, had_effect)
	var/target_turf = get_turf(target)
	if(ismineralturf(target_turf))
		var/turf/closed/mineral/M = target_turf
		new /obj/effect/temp_visual/kinetic_blast(M)
		M.gets_drilled(firer)
	..()

/datum/status_effect/resonant_link
	id = "resonant_link"
	duration = 300 //Resonance can only stay for so long, if it doesn't break from activation
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null //Visual cue + general context is enough
	var/mutable_appearance/marked_underlay
	var/firing_gun


/datum/status_effect/resonant_link/on_creation(mob/living/new_owner, obj/item/kinetic_crusher/new_hammer_synced)
	. = ..()
	if(.)
		hammer_synced = new_hammer_synced

/datum/status_effect/resonant_link/on_apply()
	if(owner.mob_size >= MOB_SIZE_LARGE)
		marked_underlay = mutable_appearance('icons/effects/effects.dmi', "shield2")
		marked_underlay.pixel_x = -owner.pixel_x
		marked_underlay.pixel_y = -owner.pixel_y
		owner.underlays += marked_underlay
		return TRUE
	return FALSE

/datum/status_effect/resonant_link/Destroy()
	hammer_synced = null
	if(owner)
		owner.underlays -= marked_underlay
	QDEL_NULL(marked_underlay)
	return ..()

/datum/status_effect/resonant_link/be_replaced()
	owner.underlays -= marked_underlay //if this is being called, we should have an owner at this point
	..()
