/**
 * Gordon Freeman - Xen boss
 *
 * This boss uses crystal pylons to supply a shield that is not penetrable until these pylons are destroyed.
 *
 * Once destroyed, the shield falls, and the mob can be killed.
 */


/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman
	name = "\improper Gordon Freeman"
	desc = "Gordon Freeman in the flesh."
	icon_state = "gordon_freeman"
	speed = -2
	environment_smash = ENVIRONMENT_SMASH_RWALLS
	health = 1000
	maxHealth = 1000
	melee_damage_lower = 45
	melee_damage_upper = 45
	wander = FALSE
	attack_sound = 'modular_skyrat/master_files/sound/weapons/crowbar2.ogg'
	loot = list(/obj/item/crowbar/freeman/ultimate, /obj/item/keycard/freeman_boss_exit)
	/// If we have support pylons, this is true.
	var/shielded = FALSE
	/// How many shields we have protecting us
	var/shield_count = 0

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman/update_overlays()
	. = ..()
	if(shielded)
		. += mutable_appearance('icons/effects/effects.dmi', "shield-yellow", MOB_SHIELD_LAYER)

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman/proc/lose_shield()
	shield_count--
	if(shield_count <= 0)
		shielded = FALSE
		update_appearance()

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman/apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, attack_direction)
	if(shielded)
		balloon_alert_to_viewers("ineffective!")
		return FALSE
	return ..()

/obj/structure/xen_pylon
	name = "shield pylon"
	desc = "It seems to be some kind of force field generator."
	icon = 'modular_skyrat/modules/black_mesa/icons/plants.dmi'
	icon_state = "crystal_pylon"
	max_integrity = 350
	density = TRUE
	/// The range at which we provide shield support to a mob.
	var/shield_range = 50
	/// The mob we are currently shielding.
	var/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman/freeman
	var/datum/beam/current_beam = null


/obj/structure/xen_pylon/Initialize(mapload)
	. = ..()
	for(var/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman/iterating_freeman in circle_range(src, shield_range))
		if(freeman)
			break
		freeman = iterating_freeman
		freeman.shielded = TRUE
		freeman.shield_count++
		freeman.update_appearance()
		current_beam = Beam(freeman, icon_state="red_lightning", time = 10 MINUTES, maxdistance = shield_range)
		RegisterSignal(current_beam, COMSIG_PARENT_QDELETING, .proc/beam_died)
		RegisterSignal(freeman, COMSIG_PARENT_QDELETING, .proc/gordon_died)


/obj/structure/xen_pylon/proc/gordon_died()
	SIGNAL_HANDLER
	freeman = null

/obj/structure/xen_pylon/proc/beam_died()
	SIGNAL_HANDLER
	current_beam = null
	if(freeman)
		freeman.lose_shield()
		freeman = null

/obj/structure/xen_pylon/Destroy()
	if(freeman)
		freeman.lose_shield()
		freeman = null
	QDEL_NULL(current_beam)
	playsound(src, 'sound/magic/lightningbolt.ogg', 100, TRUE)
	return ..()


/obj/machinery/door/keycard/xen/freeman_boss_entry
	name = "entry door"
	desc = "Complete the puzzle to open this door."
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_door.dmi'
	icon_state = "resin"
	puzzle_id = "freeman_entry"

/obj/item/keycard/freeman_boss_entry
	name = "entry keycard"
	color = "#1100ff"
	puzzle_id = "freeman_entry"

/obj/machinery/door/keycard/xen/freeman_boss_exit
	name = "exit door"
	desc = "You must defeat him."
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_door.dmi'
	icon_state = "resin"
	puzzle_id = "freeman_exit"

/obj/item/keycard/freeman_boss_exit
	name = "\improper Freeman's ID card"
	desc = "How could you do it? HOW?!!"
	color = "#fffb00"
	puzzle_id = "freeman_exit"

/obj/effect/sliding_puzzle/freeman
	reward_type = /obj/item/keycard/freeman_boss_entry



/obj/effect/freeman_blocker
	name = "freeman blocker"

/obj/effect/freeman_blocker/CanPass(atom/blocker, movement_dir, blocker_opinion)
	. = ..()
	if(istype(blocker, /mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman))
		return FALSE
	return TRUE
