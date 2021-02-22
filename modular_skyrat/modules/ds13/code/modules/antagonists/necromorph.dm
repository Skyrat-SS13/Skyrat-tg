/datum/team/necromorph
	name = "Necromorphs"

//Simply lists them.
/datum/team/necromorph/roundend_report()
	var/list/parts = list()
	parts += "<span class='header'>The [name] were:</span>"
	parts += printplayerlist(members)
	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/antagonist/necromorph
	name = "Necromorph"
	job_rank = ROLE_NECROMORPH
	show_in_antagpanel = FALSE
	prevent_roundtype_conversion = FALSE
	show_to_ghosts = TRUE
	var/datum/team/necromorph/necromorph_team

/datum/antagonist/necromorph/create_team(datum/team/necromorph/new_team)
	if(!new_team)
		for(var/datum/antagonist/necromorph/X in GLOB.antagonists)
			if(!X.owner || !X.necromorph_team)
				continue
			necromorph_team = X.necromorph_team
			return
		necromorph_team = new
	else
		if(!istype(new_team))
			CRASH("Wrong necromorph team type provided to create_team")
		necromorph_team = new_team

/datum/antagonist/necromorph/get_team()
	return necromorph_team

//necromorph
/mob/living/carbon/alien/mind_initialize()
	..()
	if(!mind.has_antag_datum(/datum/antagonist/necromorph))
		mind.add_antag_datum(/datum/antagonist/necromorph)
/*-----------------

/mob/living/simple_animal/hostile/true_changeling/emote(act, m_type=1, message = null, intentional = TRUE)
	if(stat)
		return
	if(act == "scream" && !spam_flag)
		message = "<B>[src]</B> makes a loud, bone-chilling roar!"
		act = "me"
		var/frequency = get_rand_frequency() //so sound frequency is consistent
		for(var/mob/M in range(35, src)) //You can hear the scream 7 screens away
			// Double check for client
			if(M && M.client)
				var/turf/M_turf = get_turf(M)
				if(M_turf && M_turf.z == src.z)
					var/dist = get_dist(M_turf, src)
					if(dist <= 7) //source of sound very close
						M.playsound_local(src, 'modular_skyrat/modules/horrorform/sound/effects/horror_scream.ogg', 80, 1, frequency)
					else
						var/vol = clamp(100-((dist-7)*5), 10, 100) //Every tile decreases sound volume by 5
						M.playsound_local(src, 'modular_skyrat/modules/horrorform/sound/effects/horror_scream_reverb.ogg', vol, 1, frequency)
				if(M.stat == DEAD && (M.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(get_turf(src),null)))
					M.show_message(message)
		audible_message(message)
		spam_flag = 1
		spawn(50)
			spam_flag = 0
		return

	..(act, m_type, message)




/mob/living/simple_animal/hostile/alien/Initialize()
	. = ..()
	AddComponent(/datum/component/footstep, FOOTSTEP_MOB_CLAW)
as
/mob/living/simple_animal/hostile/alien/drone
	name = "alien drone"
	icon_state = "aliend"
	icon_living = "aliend"
	icon_dead = "aliend_dead"
	melee_damage_lower = 15
	melee_damage_upper = 15
	var/plant_cooldown = 30
	var/plants_off = 0

/mob/living/simple_animal/hostile/alien/drone/handle_automated_action()
	if(!..()) //AIStatus is off
		return
	plant_cooldown--
	if(AIStatus == AI_IDLE)
		if(!plants_off && prob(10) && plant_cooldown<=0)
			plant_cooldown = initial(plant_cooldown)
			SpreadPlants()

/mob/living/simple_animal/hostile/alien/sentinel
	name = "alien sentinel"
	icon_state = "aliens"
	icon_living = "aliens"
	icon_dead = "aliens_dead"
	health = 150
	maxHealth = 150
	melee_damage_lower = 15
	melee_damage_upper = 15
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	projectiletype = /obj/projectile/neurotox
	projectilesound = 'sound/weapons/pierce.ogg'


/mob/living/simple_animal/hostile/alien/queen
	name = "alien queen"
	icon_state = "alienq"
	icon_living = "alienq"
	icon_dead = "alienq_dead"
	health = 250
	maxHealth = 250
	melee_damage_lower = 15
	melee_damage_upper = 15
	ranged = 1
	retreat_distance = 5
	minimum_distance = 5
	move_to_delay = 4
	butcher_results = list(/obj/item/food/meat/slab/xeno = 4,
							/obj/item/stack/sheet/animalhide/xeno = 1)
	projectiletype = /obj/projectile/neurotox
	projectilesound = 'sound/weapons/pierce.ogg'
	status_flags = 0
	unique_name = 0
	var/sterile = 1
	var/plants_off = 0
	var/egg_cooldown = 30
	var/plant_cooldown = 30

/mob/living/simple_animal/hostile/alien/queen/handle_automated_action()
	if(!..()) //AIStatus is off
		return
	egg_cooldown--
	plant_cooldown--
	if(AIStatus == AI_IDLE)
		if(!plants_off && prob(10) && plant_cooldown<=0)
			plant_cooldown = initial(plant_cooldown)
			SpreadPlants()
		if(!sterile && prob(10) && egg_cooldown<=0)
			egg_cooldown = initial(egg_cooldown)
			LayEggs()

/mob/living/simple_animal/hostile/alien/proc/SpreadPlants()
	if(!isturf(loc) || isspaceturf(loc))
		return
	if(locate(/obj/structure/alien/weeds/node) in get_turf(src))
		return
	visible_message("<span class='alertalien'>[src] plants some alien weeds!</span>")
	new /obj/structure/alien/weeds/node(loc)

/mob/living/simple_animal/hostile/alien/proc/LayEggs()
	if(!isturf(loc) || isspaceturf(loc))
		return
	if(locate(/obj/structure/alien/egg) in get_turf(src))
		return
	visible_message("<span class='alertalien'>[src] lays an egg!</span>")
	new /obj/structure/alien/egg(loc)

/mob/living/simple_animal/hostile/alien/queen/large
	name = "alien empress"
	icon = 'icons/mob/alienqueen.dmi'
	icon_state = "alienq"
	icon_living = "alienq"
	icon_dead = "alienq_dead"
	health_doll_icon = "alienq"
	bubble_icon = "alienroyal"
	move_to_delay = 4
	maxHealth = 400
	health = 400
	butcher_results = list(/obj/item/food/meat/slab/xeno = 10,
							/obj/item/stack/sheet/animalhide/xeno = 2)
	mob_size = MOB_SIZE_LARGE
	gold_core_spawnable = NO_SPAWN

/obj/projectile/neurotox
	name = "neurotoxin"
	damage = 30
	icon_state = "toxin"

/mob/living/simple_animal/hostile/alien/handle_temperature_damage()
	if(bodytemperature < minbodytemp)
		adjustBruteLoss(2)
		throw_alert("temp", /atom/movable/screen/alert/cold, 1)
	else if(bodytemperature > maxbodytemp)
		adjustBruteLoss(20)
		throw_alert("temp", /atom/movable/screen/alert/hot, 3)
	else
		clear_alert("temp")

/mob/living/simple_animal/hostile/alien/maid
	name = "lusty xenomorph maid"
	melee_damage_lower = 0
	melee_damage_upper = 0
	a_intent = INTENT_HELP
	friendly_verb_continuous = "caresses"
	friendly_verb_simple = "caress"
	obj_damage = 0
	environment_smash = ENVIRONMENT_SMASH_NONE
	gold_core_spawnable = HOSTILE_SPAWN
	icon_state = "maid"
	icon_living = "maid"
	icon_dead = "maid_dead"

/mob/living/simple_animal/hostile/alien/maid/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/cleaning)

/mob/living/simple_animal/hostile/alien/maid/AttackingTarget()
	if(ismovable(target))
		target.wash(CLEAN_SCRUB)
		if(istype(target, /obj/effect/decal/cleanable))
			visible_message("<span class='notice'>[src] cleans up \the [target].</span>")
		else
			visible_message("<span class='notice'>[src] polishes \the [target].</span>")
		return TRUE
*/
