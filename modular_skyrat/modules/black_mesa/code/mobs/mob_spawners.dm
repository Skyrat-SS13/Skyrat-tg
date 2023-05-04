/mob/living/simple_animal/hostile/blackmesa
	var/list/alert_sounds
	var/alert_cooldown = 3 SECONDS
	var/alert_cooldown_time

/mob/living/simple_animal/hostile/blackmesa/xen
	faction = list(FACTION_XEN)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500

/mob/living/simple_animal/hostile/blackmesa/Aggro()
	if(alert_sounds)
		if(!(world.time <= alert_cooldown_time))
			playsound(src, pick(alert_sounds), 70)
			alert_cooldown_time = world.time + alert_cooldown


#define MOB_PLACER_RANGE 16 // One more tile than the biggest viewrange we have.

/obj/effect/random_mob_placer
	name = "mob placer"
	icon = 'modular_skyrat/modules/black_mesa/icons/mapping_helpers.dmi'
	icon_state = "mobspawner"
	var/list/possible_mobs = list(/mob/living/simple_animal/hostile/blackmesa/xen/headcrab)

/obj/effect/random_mob_placer/Initialize(mapload)
	. = ..()
	for(var/turf/iterating_turf in range(MOB_PLACER_RANGE, src))
		RegisterSignal(iterating_turf, COMSIG_ATOM_ENTERED, PROC_REF(trigger))

/obj/effect/random_mob_placer/proc/trigger(datum/source, atom/movable/entered_atom)
	SIGNAL_HANDLER
	if(!isliving(entered_atom))
		return
	var/mob/living/entered_mob = entered_atom

	if(!entered_mob.client)
		return

	var/mob/picked_mob = pick(possible_mobs)
	new picked_mob(loc)
	qdel(src)

#undef MOB_PLACER_RANGE

/obj/effect/random_mob_placer/xen
	icon_state = "spawn_xen"
	possible_mobs = list(
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab,
		/mob/living/simple_animal/hostile/blackmesa/xen/houndeye,
		/mob/living/simple_animal/hostile/blackmesa/xen/bullsquid,
	)

/obj/effect/random_mob_placer/xen/zombie
	icon_state = "spawn_zombie"
	possible_mobs = list(
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/scientist,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/guard,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/hecu,
	)

/obj/effect/random_mob_placer/blackops
	icon_state = "spawn_blackops"
	possible_mobs = list(
		/mob/living/simple_animal/hostile/blackmesa/blackops,
		/mob/living/simple_animal/hostile/blackmesa/blackops/ranged,
	)

/obj/effect/random_mob_placer/hev_zombie
	icon_state = "spawn_hev"
	possible_mobs = list(/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/hev)

/obj/effect/random_mob_placer/scientist_zombie
	icon_state = "spawn_zombiescientist"
	possible_mobs = list(/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/scientist)

/obj/effect/random_mob_placer/scientist_zombie
	icon_state = "spawn_zombiesec"
	possible_mobs = list(/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/guard)

/obj/effect/random_mob_placer/security_guard
	icon_state = "spawn_guard"
	possible_mobs = list(/mob/living/simple_animal/hostile/blackmesa/sec, /mob/living/simple_animal/hostile/blackmesa/sec/ranged)

/obj/effect/random_mob_placer/vortigaunt_hostile
	icon_state = "spawn_vortigaunt_slave"
	possible_mobs = list(/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt/slave)

/obj/effect/random_mob_placer/vortigaunt
	icon_state = "spawn_vortigaunt"
	possible_mobs = list(/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt)

/obj/effect/mob_spawn/corpse/human/hecu_zombie
	name = "HECU"
	outfit = /datum/outfit/hecucorpse
	icon_state = "corpsebartender" /// It 'vaguely' looks like HECU
	brute_damage = 1000

/datum/outfit/hecucorpse
	name = "BMRF HECU Corpse"
	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	head = /obj/item/clothing/head/helmet
	suit = /obj/item/clothing/suit/armor/vest
	mask = /obj/item/clothing/mask/gas/hecu2
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/military/assault/hecu
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/storage/belt/bowie_sheath
	r_pocket = /obj/item/flashlight/flare

/obj/effect/mob_spawn/corpse/human/scientist_zombie
	name = "Science Team"
	outfit = /datum/outfit/sciteamcorpse
	icon_state = "corpsescientist"
	brute_damage = 1000

/datum/outfit/sciteamcorpse
	name = "BMRF Science Team Corpse"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/hlscience
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	gloves = /obj/item/clothing/gloves/latex

/obj/effect/mob_spawn/corpse/human/guard_zombie
	name = "Security Guard"
	outfit = /datum/outfit/barneycorpse
	icon_state = "corpsedoctor" /// It 'vaguely' looks like the guard
	brute_damage = 1000

/datum/outfit/barneycorpse
	name = "BMRF Security Guard Corpse"
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt
	head = /obj/item/clothing/head/helmet/blueshirt
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	gloves = /obj/item/clothing/gloves/color/black
	belt = /obj/item/storage/belt/security
