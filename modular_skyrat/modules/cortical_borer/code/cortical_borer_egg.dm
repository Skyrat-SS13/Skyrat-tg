/obj/effect/mob_spawn/ghost_role/borer_egg
	name = "borer egg"
	desc = "An egg of a creature that is known to crawl inside of you, be careful."
	icon = 'modular_skyrat/modules/cortical_borer/icons/animal.dmi'
	icon_state = "brainegg"
	layer = BELOW_MOB_LAYER
	density = FALSE
	mob_name = "cortical borer"
	///Type of mob that will be spawned
	mob_type = /mob/living/basic/cortical_borer
	role_ban = ROLE_ALIEN
	show_flavor = FALSE
	prompt_name = "cortical borer"
	you_are_text = "You are a Cortical Borer."
	flavour_text = "You are a cortical borer! You can fear someone to make them stop moving, but make sure to inhabit them! \
					You only grow/heal/talk when inside a host!"
	important_text = "As a borer, you have the option to be friendly or not. \
					Note that how you act will determine how a host responds. \
					Do not wordlessly resort to mechanics within a host. \
					You can talk to other borers using ; and your host by just speaking normally. \
					You are unable to speak outside of a host, but are able to emote."
	///what the generation of the borer egg is
	var/generation = 1
	///the egg that is attached to this mob spawn
	var/obj/item/borer_egg/host_egg = /obj/item/borer_egg

/obj/effect/mob_spawn/ghost_role/borer_egg/Destroy()
	host_egg = null
	return ..()

/obj/effect/mob_spawn/ghost_role/borer_egg/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	spawned_mob.mind.add_antag_datum(/datum/antagonist/cortical_borer)
	spawned_mob.name = "cortical borer ([generation]-[rand(100,999)])"
	QDEL_NULL(host_egg)

/obj/effect/mob_spawn/ghost_role/borer_egg/Initialize(mapload, datum/team/cortical_borers/borer_team)
	. = ..()
	host_egg = new host_egg(get_turf(src))
	host_egg.host_spawner = src
	forceMove(host_egg)
	var/area/src_area = get_area(src)
	if(src_area)
		notify_ghosts("A cortical borer egg has been laid in \the [src_area.name].", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE, ignore_key = POLL_IGNORE_DRONE, notify_suiciders = FALSE)

/obj/item/borer_egg
	name = "borer egg"
	desc = "An egg of a creature that is known to crawl inside of you, be careful."
	icon = 'modular_skyrat/modules/cortical_borer/icons/animal.dmi'
	icon_state = "brainegg"
	layer = BELOW_MOB_LAYER
	///the spawner that is attached to this item
	var/obj/effect/mob_spawn/ghost_role/borer_egg/host_spawner

/obj/item/borer_egg/attack_ghost(mob/user)
	if(host_spawner)
		host_spawner.attack_ghost(user)
	return ..()

/obj/item/borer_egg/attack_self(mob/user, modifiers)
	to_chat(user, span_notice("You crush [src] within your grasp."))
	new /obj/effect/decal/cleanable/food/egg_smudge(get_turf(user))
	if(host_spawner)
		QDEL_NULL(host_spawner)
	qdel(src)

/obj/item/borer_egg/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if (..()) // was it caught by a mob?
		return

	var/turf/hit_turf = get_turf(hit_atom)
	new /obj/effect/decal/cleanable/food/egg_smudge(hit_turf)
	QDEL_NULL(host_spawner)
	qdel(src)

/obj/item/borer_egg/empowered
	name = "empowered borer egg"
	icon_state = "empowered_brainegg"

/datum/uplink_item/dangerous/cortical_borer
	name = "Cortical Borer Egg"
	desc = "The egg of a cortical borer. The cortical borer is a parasite that can produce chemicals upon command, as well as \
			learn new chemicals through the blood if old enough. Be careful as there is no way to get the borer to pledge allegiance \
			to yourself. The egg is extremely fragile, do not crush it in your hand nor throw it. \
			The egg is required to sit out in the open in order to hatch. (Cannot be hidden in closets, etc.)"
	progression_minimum = 20 MINUTES
	item = /obj/effect/mob_spawn/ghost_role/borer_egg/traitor
	cost = 20

/obj/effect/mob_spawn/ghost_role/borer_egg/traitor
	prompt_name = "cortical borer (traitor spawned)"

/obj/effect/mob_spawn/ghost_role/borer_egg/opfor
	prompt_name = "cortical borer (OPFOR spawned)"

/obj/effect/mob_spawn/ghost_role/borer_egg/empowered
	name = "empowered borer egg"
	desc = "An egg of a creature that came crawling out of someone instead of into them."
	mob_type = /mob/living/basic/cortical_borer/empowered
	host_egg = /obj/item/borer_egg/empowered
