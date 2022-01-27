/mob/living/simple_animal/pet/poppy
	name = "Poppy the Safety Inspector"
	desc = "Safety first!"
	icon = 'modular_skyrat/master_files/icons/mob/pets.dmi'
	icon_state = "poppypossum"
	icon_living = "poppypossum"
	icon_dead = "poppypossum_dead"
	gender = FEMALE
	unique_pet = TRUE
	maxHealth = 30
	health = 30
	speak = list("Hiss!", "HISS!", "Hissss?")
	speak_emote = list("hisses")
	emote_hear = list("hisses.")
	emote_see = list("runs in a circle.", "shakes.")
	speak_chance = 2
	turns_per_move = 3
	var/safety_inspection = TRUE // The inspection fails if she gets dusted
	var/near_engine = FALSE // She is actually really scared of the engine
	animal_species = /mob/living/simple_animal/pet/poppy
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "stamps on"
	response_harm_simple = "stamp"
	density = FALSE
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	gold_core_spawnable = FRIENDLY_SPAWN
	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_color = LIGHT_COLOR_YELLOW
	light_range = 2
	light_power = 0.8
	light_on = TRUE

/mob/living/simple_animal/pet/poppy/Initialize(mapload, safety_inspection)
	. = ..()
	add_verb(src, /mob/living/proc/toggle_resting)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	qdel(GetComponent(/datum/component/butchering))

	var/datum/component/overlay_lighting/lighting_object = src.GetComponent(/datum/component/overlay_lighting)
	var/image/cone = lighting_object.cone
	cone.transform = cone.transform.Translate(0, -12) //adjust the little headlamp

/mob/living/simple_animal/pet/poppy/death()
	set_light_on(FALSE)

	if(safety_inspection)
		var/list/sm_chamber = get_area_turfs(/area/engineering/supermatter)
		if(src.loc in sm_chamber)
			safety_inspection = FALSE
			priority_announce("This is a generated message due to an automated signal regarding the safety standards of the engineering department onboard [station_name()]. Due to the station-engineers failing to meet the standard set by CentCom, each will be forcibly enrolled in a re-evaluation program at later notice... ", "Concerning the results of a safety inspection", type = "Priority")
			// It's just flavor, no tangible punishment
	..()

/mob/living/simple_animal/pet/poppy/revive(full_heal = FALSE, admin_revive = FALSE)
	. = ..()
	set_light_on(TRUE)

/mob/living/simple_animal/pet/poppy/update_resting()
	. = ..()
	if(stat == DEAD)
		return
	if(resting)
		icon_state = "[icon_living]_rest"
		set_light_on(FALSE)
	else
		icon_state = "[icon_living]"
		set_light_on(TRUE)
	regenerate_icons()

/mob/living/simple_animal/pet/poppy/Life(delta_time = SSMOBS_DT, times_fired)
	if(buckled || client)
		return

	if(pulledby)
		set_resting(FALSE)

	if(!near_engine)
		for(var/obj/machinery/power/supermatter_crystal/sm_crystal in view(8, src))
			near_engine = TRUE
			icon_state = "poppypossum_aaa"

			do_jitter_animation(30)
			manual_emote("[src.p_their()] fur begins to stand up, trembling at the sight of [sm_crystal]...")
			emote("sweatdrop")

			cooldowns.Add(addtimer(CALLBACK(src, .proc/calm_down), 60 SECONDS, TIMER_STOPPABLE))
			break

	if(!DT_PROB(0.5, delta_time))
		return
	if(resting)
		manual_emote(pick("lets out a hiss before resting.", "catches a break.", "gives a simmering hiss before lounging.", "exams her surroundings before relaxing."))
		set_resting(TRUE)
		return
	else
		manual_emote(pick("stretches her claws, rising...", "diligently gets up, ready to inspect!", "stops her resting."))
		set_resting(FALSE)

	return ..()

/mob/living/simple_animal/pet/poppy/proc/calm_down()
	near_engine = FALSE
	icon_state = initial(icon_state)
