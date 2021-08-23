GLOBAL_VAR_INIT(floor_cluwnes, 0)
GLOBAL_LIST_EMPTY(cluwne_maze)

#define STAGE_HAUNT 1
#define STAGE_SPOOK 2
#define STAGE_TORMENT 3
#define STAGE_ATTACK 4
#define MANIFEST_DELAY 9

/mob/living/simple_animal/hostile/floor_cluwne
	name = "???"
	desc = "...."
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "clown"
	icon_living = "clown"
	icon_gib = "clown"
	maxHealth = 250
	health = 250
	speed = -1
	attack_sound = 'sound/items/bikehorn.ogg'
	del_on_death = TRUE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB | LETPASSTHROW | PASSGLASS | PASSBLOB | PASSDOORS | PASSSTRUCTURE | PASSMACHINE //it's practically a ghost when unmanifested (under the floor)
	wander = FALSE
	minimum_distance = 2
	move_to_delay = 1
	environment_smash = FALSE
	lose_patience_timeout = FALSE
	pixel_y = 8
	pressure_resistance = 200
	minbodytemp = 0
	maxbodytemp = 1500
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	var/mob/living/carbon/human/current_victim
	var/manifested = FALSE
	var/switch_stage = 40
	var/stage = STAGE_HAUNT
	var/interest = 0
	var/target_area
	var/invalid_area_typecache = list(/area/space, /area/lavaland, /area/centcom, /area/shuttle/syndicate)
	var/eating = FALSE
	var/obj/effect/dummy/floorcluwne_orbit/poi
	var/obj/effect/temp_visual/fcluwne_manifest/cluwnehole
	move_resist = INFINITY
	hud_type = /datum/hud/ghost
	hud_possible = list(ANTAG_HUD)

/mob/living/simple_animal/hostile/floor_cluwne/Initialize()
	. = ..()
	invalid_area_typecache = typecacheof(invalid_area_typecache)
	Manifest()
	if(!current_victim)
		Acquire_Victim()
	poi = new(src)

/mob/living/simple_animal/hostile/floor_cluwne/med_hud_set_health()
	return //we use a different hud

/mob/living/simple_animal/hostile/floor_cluwne/med_hud_set_status()
	return //we use a different hud

/mob/living/simple_animal/hostile/floor_cluwne/Destroy()
	if(poi)
		QDEL_NULL(poi)
	if(cluwnehole)
		QDEL_NULL(cluwnehole)
	if(current_victim)
		current_victim = null
	return ..()


/mob/living/simple_animal/hostile/floor_cluwne/attack_hand(mob/living/carbon/human/M)
	..()
	playsound(src.loc, 'sound/items/bikehorn.ogg', 50, 1)


/mob/living/simple_animal/hostile/floor_cluwne/CanPass(atom/A, turf/target)
	SHOULD_CALL_PARENT(FALSE)
	return TRUE


/mob/living/simple_animal/hostile/floor_cluwne/Life()
	do_jitter_animation(1000)
	pixel_y = 8
	var/area/check_area = get_area(loc) // Has to be separated from the below since is_type_in_typecache is also a funky macro
	if(is_type_in_typecache(check_area, invalid_area_typecache) || !is_station_level(z))
		var/area = pick(GLOB.teleportlocs)
		var/area/teleport_locs = GLOB.teleportlocs[area]
		forceMove(pick(get_area_turfs(teleport_locs.type)))

	if(!current_victim)
		Acquire_Victim()

	if(stage && !manifested)
		On_Stage()

	if(stage == STAGE_ATTACK)
		playsound(src, 'modular_skyrat/modules/demon_floor/sound/cluwne_breathing.ogg', 75, 1)

	if(eating)
		return

	var/turf/victim_turf = get_turf(current_victim)
	check_area = get_area(victim_turf) // Has to be separated from the below since is_type_in_typecache is also a funky macro
	if(prob(5))//checks roughly every 20 ticks
		if(current_victim.stat == DEAD || is_type_in_typecache(check_area, invalid_area_typecache) || !is_station_level(current_victim.z))
			if(!Found_You())
				Acquire_Victim()

	if(get_dist(src, current_victim) > 9 && !manifested &&  !is_type_in_typecache(check_area, invalid_area_typecache))//if cluwne gets stuck he just teleports
		do_teleport(src, victim_turf)

	interest++
	if(interest >= switch_stage * 4)
		stage = STAGE_ATTACK

	else if(interest >= switch_stage * 2)
		stage = STAGE_TORMENT

	else if(interest >= switch_stage)
		stage = STAGE_SPOOK

	else if(interest < switch_stage)
		stage = STAGE_HAUNT

	..()

/mob/living/simple_animal/hostile/floor_cluwne/Goto(target, delay, minimum_distance)
	var/area/check_area = get_area(current_victim.loc)
	if(!manifested && !is_type_in_typecache(check_area, invalid_area_typecache) && is_station_level(current_victim.z))
		walk_to(src, target, minimum_distance, delay)
	else
		walk_to(src,0)


/mob/living/simple_animal/hostile/floor_cluwne/FindTarget()
	return current_victim


/mob/living/simple_animal/hostile/floor_cluwne/CanAttack(atom/the_target)//you will not escape
	return TRUE


/mob/living/simple_animal/hostile/floor_cluwne/AttackingTarget()
	return


/mob/living/simple_animal/hostile/floor_cluwne/LoseTarget()
	return


/mob/living/simple_animal/hostile/floor_cluwne/electrocute_act(shock_damage, source, siemens_coeff = 1, flags = NONE)
	return FALSE

/mob/living/simple_animal/hostile/floor_cluwne/proc/Found_You()
	for(var/obj/structure/closet/hiding_spot in orange(7,src))
		if(current_victim.loc == hiding_spot)
			hiding_spot.bust_open()
			current_victim.Paralyze(40)
			to_chat(current_victim, span_warning("...edih t'nac uoY"))
			return TRUE
	return FALSE

/mob/living/simple_animal/hostile/floor_cluwne/proc/Acquire_Victim(specific)
	var/error_message = "Cannot find a valid target."
	var/mob/living/carbon/human/carbon_human
	var/area/check_area

	if(specific)
		carbon_human = specific
		check_area = get_area(carbon_human.loc)
		if(carbon_human.stat == DEAD)
			message_admins("Floor Cluwne is being deleted due to: The target is dead.")
			qdel(src)
			return
		if(is_type_in_typecache(check_area, invalid_area_typecache))
			message_admins("Floor Cluwne is being deleted due to: The target is in an invalid area.")
			qdel(src)
			return
		if(!is_station_level(carbon_human.z))
			message_admins("Floor Cluwne is being deleted due to: The target is not on the station z-level.")
			qdel(src)
			return
		current_victim = carbon_human
		interest = 0
		stage = STAGE_HAUNT
		return target = current_victim

	var/list/removable_list = GLOB.player_list

	for(var/player_loop in GLOB.player_list)//better than a potential recursive loop
		carbon_human = pick(removable_list)//so the check is fair
		check_area = get_area(carbon_human.loc)
		if(!carbon_human)
			error_message = "Cannot find a target in an empty list."
			break
		if(!ishuman(carbon_human))
			removable_list -= carbon_human
			continue
		if(carbon_human.stat == DEAD)
			removable_list -= carbon_human
			continue
		if(carbon_human == current_victim)
			removable_list -= carbon_human
			continue
		if(is_type_in_typecache(check_area, invalid_area_typecache))
			removable_list -= carbon_human
			continue
		if(!is_station_level(carbon_human.z))
			removable_list -= carbon_human
			continue
		current_victim = carbon_human
		interest = 0
		stage = STAGE_HAUNT
		return target = current_victim

	message_admins("Floor Cluwne is being deleted due to: [error_message]")
	qdel(src)


/mob/living/simple_animal/hostile/floor_cluwne/proc/Manifest()//handles disappearing and appearance anim
	if(manifested)
		mobility_flags &= ~MOBILITY_MOVE
		cluwnehole = new(src.loc)
		addtimer(CALLBACK(src, /mob/living/simple_animal/hostile/floor_cluwne/.proc/Appear), MANIFEST_DELAY)
	else
		layer = GAME_PLANE
		invisibility = INVISIBILITY_OBSERVER
		density = FALSE
		mobility_flags |= MOBILITY_MOVE
		if(cluwnehole)
			qdel(cluwnehole)


/mob/living/simple_animal/hostile/floor_cluwne/proc/Appear()//handled in a seperate proc so floor cluwne doesn't appear before the animation finishes
	layer = LYING_MOB_LAYER
	invisibility = FALSE
	density = TRUE

/mob/living/simple_animal/hostile/floor_cluwne/proc/Reset_View(screens, colour, mob/living/carbon/human/H)
	if(screens)
		for(var/whole_screen in screens)
			animate(whole_screen, transform = matrix(), time = 5, easing = QUAD_EASING)
	if(colour && H)
		H.client.color = colour

/mob/living/simple_animal/hostile/floor_cluwne/proc/single_throw(mob/living/carbon/human/human_target)
	var/obj/item/thrown_item = locate() in orange(human_target, 8)
	if(thrown_item?.anchored == FALSE)
		thrown_item.throw_at(human_target, 4, 3)
		to_chat(human_target, span_warning("What threw that?"))

/mob/living/simple_animal/hostile/floor_cluwne/proc/target_slip(mob/living/carbon/human/human_target)
	var/turf/target_turf = get_turf(human_target)
	target_turf.handle_slip(human_target, 20)
	to_chat(human_target, span_warning("The floor shifts beneath you!"))


/mob/living/simple_animal/hostile/floor_cluwne/proc/On_Stage()
	var/mob/living/carbon/human/human_victim = current_victim
	if(!human_victim)
		FindTarget()
		return
	switch(stage)
		if(STAGE_HAUNT)
			if(prob(5))
				human_victim.blur_eyes(1)

			if(prob(5))
				human_victim.playsound_local(src,'modular_skyrat/modules/demon_floor/sound/cluwnelaugh2.ogg', 2)

			if(prob(5))
				human_victim.playsound_local(src,'modular_skyrat/modules/demon_floor/sound/bikehorn_creepy.ogg', 5)

			if(prob(3))
				single_throw(human_victim)
		if(STAGE_SPOOK)
			if(prob(4))
				target_slip(human_victim)

			if(prob(5))
				human_victim.playsound_local(src,'modular_skyrat/modules/demon_floor/sound/cluwnelaugh2.ogg', 2)

			if(prob(5))
				human_victim.playsound_local(src,'modular_skyrat/modules/demon_floor/sound/bikehorn_creepy.ogg', 10)
				to_chat(human_victim, span_smallnoticeital("knoh<"))

			if(prob(5))
				single_throw(human_victim)

			if(prob(2))
				to_chat(human_victim, span_smallnoticeital("yalp ot tnaw I"))
				Appear()
				manifested = FALSE
				addtimer(CALLBACK(src, /mob/living/simple_animal/hostile/floor_cluwne/.proc/Manifest), 1)
				if(current_victim.hud_used)//yay skewium
					var/list/screens = list(current_victim.hud_used.plane_masters["[GAME_PLANE]"], current_victim.hud_used.plane_masters["[LIGHTING_PLANE]"])
					var/intensity = 8
					var/matrix/newmatrix = matrix(rand(-intensity,intensity), rand(-intensity,intensity))

					for(var/whole_screen in screens)
						animate(whole_screen, transform = newmatrix, time = 5, easing = QUAD_EASING, loop = -1)
						animate(transform = -newmatrix, time = 5, easing = QUAD_EASING)

					addtimer(CALLBACK(src, /mob/living/simple_animal/hostile/floor_cluwne/.proc/Reset_View, screens), 10)

		if(STAGE_TORMENT)
			if(prob(5))
				target_slip(human_victim)

			if(prob(3))
				playsound(src,pick('sound/spookoween/scary_horn.ogg', 'sound/spookoween/scary_horn2.ogg', 'sound/spookoween/scary_horn3.ogg'), 30, 1)

			if(prob(3))
				playsound(src,'modular_skyrat/modules/demon_floor/sound/cluwnelaugh1.ogg', 30, 1)

			if(prob(5))
				playsound(src,'modular_skyrat/modules/demon_floor/sound/bikehorn_creepy.ogg', 30, 1)

			if(prob(4))
				for(var/obj/item/thrown_item in orange(human_victim, 8))
					if(thrown_item && !thrown_item.anchored)
						thrown_item.throw_at(human_victim, 4, 3)
				to_chat(human_victim, span_warning("What the hell?!"))

			if(prob(2))
				to_chat(human_victim, span_warning("Something feels very wrong..."))
				human_victim.playsound_local(src,'sound/hallucinations/behind_you1.ogg', 25)
				human_victim.flash_act()

			if(prob(2))
				to_chat(human_victim, span_smallnoticeital("!?REHTOMKNOH eht esiarp uoy oD"))
				to_chat(human_victim, span_warning("Something grabs your foot!"))
				human_victim.playsound_local(src,'sound/hallucinations/i_see_you1.ogg', 25)
				human_victim.Stun(20)

			if(prob(3))
				to_chat(human_victim, span_smallnoticeital("KNOH ?od nottub siht seod tahW"))
				for(var/turf/open/slip_open in range(src, 6))
					slip_open.MakeSlippery(TURF_WET_WATER, 10)
					playsound(src, 'sound/effects/meteorimpact.ogg', 30, 1)

			if(prob(1))
				to_chat(human_victim, span_warning("WHAT THE FUCK IS THAT?!"))
				to_chat(human_victim, span_smallnoticeital(".KNOH !nuf hcum os si uoy htiw gniyalP .KNOH KNOH KNOH"))
				human_victim.playsound_local(src,'sound/hallucinations/im_here1.ogg', 25)
				human_victim.reagents.add_reagent(/datum/reagent/toxin/mindbreaker, 3)
				human_victim.reagents.add_reagent(/datum/reagent/consumable/laughter, 5)
				human_victim.reagents.add_reagent(/datum/reagent/mercury, 3)
				Appear()
				manifested = FALSE
				addtimer(CALLBACK(src, /mob/living/simple_animal/hostile/floor_cluwne/.proc/Manifest), 2)
				for(var/obj/machinery/light/flick_light in range(human_victim, 8))
					flick_light.flicker()

		if(STAGE_ATTACK)
			if(!eating)
				Found_You()
				for(var/check_loop in getline(src,human_victim))
					var/turf/check_turf = check_loop
					if(check_turf.density)
						forceMove(human_victim.loc)
					for(var/obj/structure/check_structure in check_turf)
						if(check_structure.density || istype(check_structure, /obj/machinery/door/airlock))
							forceMove(human_victim.loc)
				to_chat(human_victim, span_warning("You feel the floor closing in on your feet!"))
				human_victim.Paralyze(300)
				human_victim.emote("scream")
				human_victim.adjustBruteLoss(10)
				manifested = TRUE
				Manifest()
				if(!eating)
					empulse(src, 6, 6)
					addtimer(CALLBACK(src, /mob/living/simple_animal/hostile/floor_cluwne/.proc/Grab, human_victim), 50, TIMER_OVERRIDE|TIMER_UNIQUE)
					for(var/turf/open/slip_open in range(src, 6))
						slip_open.MakeSlippery(TURF_WET_LUBE, 30)
						playsound(src, 'sound/effects/meteorimpact.ogg', 30, 1)
				eating = TRUE


/mob/living/simple_animal/hostile/floor_cluwne/proc/Grab(mob/living/carbon/human/carbon_human)
	carbon_human.pull_force = INFINITY
	to_chat(carbon_human, span_warning("You feel a cold, gloved hand clamp down on your ankle!"))
	for(var/repeat_check in 1 to get_dist(src, carbon_human))
		if(do_after(src, 5, target = carbon_human))
			step_towards(carbon_human, src)
			playsound(carbon_human, pick('modular_skyrat/modules/demon_floor/sound/bodyscrape-01.ogg', 'modular_skyrat/modules/demon_floor/sound/bodyscrape-02.ogg'), 20, 1, -4)
			if(prob(40))
				carbon_human.emote("scream")
			else if(prob(25))
				carbon_human.say(pick("HELP ME!!","IT'S GOT ME!!","DON'T LET IT TAKE ME!!",";SOMETHING'S KILLING ME!!","HOLY FUCK!!"))
				playsound(src, pick('modular_skyrat/modules/demon_floor/sound/cluwnelaugh1.ogg', 'modular_skyrat/modules/demon_floor/sound/cluwnelaugh2.ogg', 'modular_skyrat/modules/demon_floor/sound/cluwnelaugh3.ogg'), 50, 1)

	if(get_dist(src,carbon_human) <= 1)
		visible_message(span_warning("[src] begins dragging [carbon_human] under the floor!"))
		if(do_after(src, 5 SECONDS, target = carbon_human) && eating)
			carbon_human.become_blind()
			carbon_human.layer = GAME_PLANE
			carbon_human.invisibility = INVISIBILITY_OBSERVER
			carbon_human.density = FALSE
			carbon_human.anchored = TRUE
			addtimer(CALLBACK(src, /mob/living/simple_animal/hostile/floor_cluwne/.proc/Kill, carbon_human), 100, TIMER_OVERRIDE|TIMER_UNIQUE)
			visible_message(span_warning("[src] pulls [carbon_human] under!"))
			to_chat(carbon_human, span_warning("[src] drags you underneath the floor!"))
		else
			eating = FALSE
	else
		eating = FALSE
	manifested = FALSE
	Manifest()


/mob/living/simple_animal/hostile/floor_cluwne/proc/Kill(mob/living/carbon/human/carbon_human)
	if(!istype(carbon_human) || !carbon_human.client)
		Acquire_Victim()
		return
	playsound(carbon_human, 'modular_skyrat/modules/demon_floor/sound/cluwne_feast.ogg', 100, 0, -4)
	var/old_color = carbon_human.client.color
	var/red_splash = list(1,0,0,0.8,0.2,0, 0.8,0,0.2,0.1,0,0)
	var/pure_red = list(0,0,0,0,0,0,0,0,0,1,0,0)
	carbon_human.client.color = pure_red
	animate(carbon_human.client,color = red_splash, time = 10, easing = SINE_EASING|EASE_OUT)
	for(var/turf/splatter_turf in orange(carbon_human, 4))
		carbon_human.add_splatter_floor(splatter_turf)
	if(do_after(src, 5 SECONDS, target = carbon_human))
		carbon_human.unequip_everything()//more runtime prevention
		carbon_human.cure_blind()
		carbon_human.fully_heal(TRUE)
		carbon_human.adjustBruteLoss(30)
		carbon_human.layer = initial(carbon_human.layer)
		carbon_human.invisibility = initial(carbon_human.invisibility)
		carbon_human.density = initial(carbon_human.density)
		carbon_human.anchored = initial(carbon_human.anchored)
		carbon_human.blur_eyes(10)
		carbon_human.equipOutfit(/datum/outfit/job/clown_free)
		carbon_human.pull_force = initial(carbon_human.pull_force)
		animate(carbon_human.client,color = old_color, time = 20)
		var/turf/move_turf = get_turf(pick(GLOB.cluwne_maze))
		carbon_human.forceMove(move_turf)
		to_chat(carbon_human, span_warning("You have entered the belly of the beast! Go to the ends and try to escape!"))

	eating = FALSE
	switch_stage = switch_stage * 0.75 //he gets faster after each feast
	for(var/mob/player_mob in GLOB.player_list)
		player_mob.playsound_local(get_turf(player_mob), 'modular_skyrat/modules/demon_floor/sound/honk_echo_distant.ogg', 50, 1, pressure_affected = FALSE)

	interest = 0
	stage = STAGE_HAUNT
	Acquire_Victim()

//manifestation animation
/obj/effect/temp_visual/fcluwne_manifest
	icon = 'modular_skyrat/modules/demon_floor/icon/demon.dmi'
	icon_state = "fcluwne_open"
	layer = TURF_LAYER
	duration = 600
	randomdir = FALSE

/obj/effect/temp_visual/fcluwne_manifest/Initialize()
	. = ..()
	playsound(src, 'modular_skyrat/modules/demon_floor/sound/floor_cluwne_emerge.ogg', 100, 1)
	flick("fcluwne_manifest",src)

/obj/effect/dummy/floorcluwne_orbit
	name = "floor cluwne"
	desc = "If you have this, tell a coder or admin!"

/obj/effect/dummy/floorcluwne_orbit/Initialize()
	. = ..()
	GLOB.floor_cluwnes++
	name += " ([GLOB.floor_cluwnes])"
	GLOB.poi_list += src

/obj/effect/dummy/floorcluwne_orbit/Destroy()
	. = ..()
	GLOB.poi_list -= src

/obj/effect/floorcluwne_maze
	name = "floor cluwne maze"


/obj/effect/floorcluwne_maze/Initialize()
	GLOB.cluwne_maze += src
	return ..()

/obj/effect/floorcluwne_maze/Destroy()
	GLOB.cluwne_maze -= src
	return ..()

/obj/effect/floorcluwne_maze/exit
	name = "exit"
	density = TRUE
	var/recent_exit = FALSE

/obj/effect/floorcluwne_maze/exit/proc/unrecent_exit()
	recent_exit = FALSE

/obj/effect/floorcluwne_maze/exit/Bumped(atom/movable/AM)
	if(prob(10) && !recent_exit)
		AM.forceMove(get_safe_random_station_turf())
		return
	if(recent_exit)
		return
	recent_exit = TRUE
	addtimer(CALLBACK(src, .proc/unrecent_exit), 5 SECONDS)
	var/obj/effect/floorcluwne_maze/exit/choose_exit = pick(GLOB.cluwne_maze)
	var/turf/move_turf = get_turf(choose_exit)
	AM.forceMove(move_turf)
	choose_exit.recent_exit = TRUE
	addtimer(CALLBACK(choose_exit, .proc/unrecent_exit), 5 SECONDS)
	return ..()

#undef STAGE_HAUNT
#undef STAGE_SPOOK
#undef STAGE_TORMENT
#undef STAGE_ATTACK
#undef MANIFEST_DELAY

/client/proc/spawn_floor_cluwne()
	set category = "Admin.Fun"
	set name = "Unleash Floor Cluwne"
	set desc = "Pick a specific target or just let it select randomly and spawn the floor cluwne mob on the station. Be warned: spawning more than one may cause issues!"
	var/target

	if(!check_rights(R_FUN))
		return

	var/turf/user_turf = get_turf(usr)
	target = input("Any specific target in mind? Please note only live, non cluwned, human targets are valid.", "Target", target) as null|anything in GLOB.player_list
	if(target && ishuman(target))
		var/mob/living/carbon/human/human_target = target
		var/mob/living/simple_animal/hostile/floor_cluwne/floor_cluwne = new /mob/living/simple_animal/hostile/floor_cluwne(user_turf)
		floor_cluwne.Acquire_Victim(human_target)
	else
		new /mob/living/simple_animal/hostile/floor_cluwne(user_turf)
	log_admin("[key_name(usr)] spawned floor cluwne.")
	message_admins("[key_name(usr)] spawned floor cluwne.")

/area/floorcluwne_maze
	name = "floor cluwne maze"
	dynamic_lighting = DYNAMIC_LIGHTING_DISABLED
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	area_flags = UNIQUE_AREA | NOTELEPORT | BLOCK_SUICIDE
