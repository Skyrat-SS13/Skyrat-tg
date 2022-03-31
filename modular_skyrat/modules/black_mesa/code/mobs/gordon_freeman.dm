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

/obj/structure/xen_pylon/freeman
	shield_range = 20

/obj/structure/xen_pylon/freeman/register_mob(mob/living/simple_animal/hostile/blackmesa/xen/mob_to_register)
	if(!istype(mob_to_register, /mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman))
		return
	shielded_mobs += mob_to_register
	mob_to_register.shielded = TRUE
	mob_to_register.shield_count++
	mob_to_register.update_appearance()
	var/datum/beam/created_beam = Beam(mob_to_register, icon_state = "red_lightning", time = 10 MINUTES, maxdistance = shield_range)
	shielded_mobs[mob_to_register] = created_beam
	RegisterSignal(created_beam, COMSIG_PARENT_QDELETING, .proc/beam_died)
	RegisterSignal(mob_to_register, COMSIG_PARENT_QDELETING, .proc/mob_died)

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
