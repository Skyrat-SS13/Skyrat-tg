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
	health = 1000
	maxHealth = 1000
	melee_damage_lower = 45
	melee_damage_upper = 45
	attack_sound = 'modular_skyrat/master_files/sound/weapons/crowbar2.ogg'
	loot = list(/obj/item/crowbar/freeman/ultimate, /obj/machinery/door/keycard/xen/freeman_boss_exit)
	/// If we have support pylons, this is true.
	var/shielded = FALSE

/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman/update_overlays()
	. = ..()
	if(shielded)
		. += mutable_appearance('icons/effects/effects.dmi', "shield-yellow", MOB_SHIELD_LAYER)

/obj/structure/xen_pylon
	name = "shield pylon"
	desc = "It seems to be some kind of force field generator."
	icon = 'modular_skyrat/modules/black_mesa/icons/plants.dmi'
	icon_state = "crystal_pylon"
	max_integrity = 200
	density = TRUE
	/// The range at which we provide shield support to a mob.
	var/shield_range = 10
	/// The mob we are currently shielding.
	var/mob/living/linked_mob
	var/datum/beam/current_beam = null


/obj/structure/xen_pylon/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/xen_pylon/Destroy()
	linked_mob = null
	QDEL_NULL(current_beam)
	return ..()

/obj/structure/xen_pylon/process(delta_time)
	for(var/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman/freeman in circle_range(src, shield_range))
		linked_mob = freeman
		freeman.shielded = TRUE
		freeman.update_appearance()
		current_beam = Beam(freeman, icon_state="red_lightning", time = 10 MINUTES, maxdistance = shield_range)
		return
	linked_mob = null

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
