#define TRUE_CHANGELING_REFORM_THRESHOLD (5 MINUTES)
#define TRUE_CHANGELING_PASSIVE_HEAL 3 //Amount of brute damage restored per tick

//Changelings in their true form.
//Massive health and damage, but move slowly.

/mob/living/simple_animal/hostile/true_changeling
	name = "true changeling"
	real_name = "true changeling"
	desc = "Holy shit, what the fuck is that thing?!"
	speak_emote = list("says with one of its faces")
	emote_hear = list("says with one of its faces")
	icon = 'modular_skyrat/modules/horrorform/icons/animal.dmi'
	icon_state = "horror"
	icon_living = "horror"
	icon_dead = "horror_dead"
	mob_biotypes = MOB_ORGANIC
	speed = 0.5
	stop_automated_movement = FALSE
	status_flags = CANPUSH
	atmos_requirements = null
	minbodytemp = 0
	maxHealth = 750 //Very durable
	health = 500
	lighting_cutoff_red = 0
	lighting_cutoff_green = 35
	lighting_cutoff_blue = 20
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	melee_damage_lower = 40
	melee_damage_upper = 40
	wander = FALSE
	attack_verb_continuous = "rips into"
	attack_verb_simple = "rip into"
	attack_sound = 'sound/effects/blobattack.ogg'
	butcher_results = list(/obj/item/food/meat/slab/human = 15) //It's a pretty big dude. Actually killing one is a feat.
	gold_core_spawnable = FALSE //Should stay exclusive to changelings tbh, otherwise makes it much less significant to sight one
	var/datum/action/innate/turn_to_human
	var/transformed_time = 0
	var/playstyle_string = span_infoplain("<b><font size=3 color='red'>We have entered our true form!</font> We are unbelievably powerful, and regenerate life at a steady rate. However, most of \
	our abilities are useless in this form, and we must utilise the abilities that we have gained as a result of our transformation. Currently, we are incapable of returning to a human. \
	After several minutes, we will once again be able to revert into a human. Taking too much damage will cause us to reach equilibrium and our cells will combust into a shower of gore, watch out!</b>")
	var/mob/living/carbon/human/stored_changeling = null //The changeling that transformed
	var/devouring = FALSE //If the true changeling is currently devouring a human

/mob/living/simple_animal/hostile/true_changeling/New()
	. = ..()
	transformed_time = world.time
	emote("scream")

/mob/living/simple_animal/hostile/true_changeling/Initialize(mapload)
	. = ..()
	to_chat(src, playstyle_string)
	turn_to_human = new(src)
	turn_to_human.Grant(src)
	GRANT_ACTION(/datum/action/innate/devour)
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/simple_animal/hostile/true_changeling/Life()
	. = ..()
	adjustBruteLoss(-TRUE_CHANGELING_PASSIVE_HEAL)

/mob/living/simple_animal/hostile/true_changeling/AttackingTarget()
	..()
	if(prob(10))
		emote("scream")

/mob/living/simple_animal/hostile/true_changeling/emote(act, m_type=1, message = null, intentional = TRUE)
	if(stat)
		return
	if(act == "scream")
		message = span_emote("<B>[src]</B> makes a loud, bone-chilling roar!")
		act = "me"
		scream(message)
		return
	. = ..()

/mob/living/simple_animal/hostile/true_changeling/proc/scream(message)
	if(!message)
		message = span_emote("<B>[src]</B> makes a loud, bone-chilling roar!")
	var/frequency = get_rand_frequency() //so sound frequency is consistent
	for(var/mob/M in range(35, src)) //You can hear the scream 7 screens away
		// Double check for client
		if(M && M.client)
			var/turf/M_turf = get_turf(M)
			if(M_turf && M_turf.z == src.z)
				var/dist = get_dist(M_turf, src)
				if(dist <= 7) //source of sound very close
					M.playsound_local(src, 'modular_skyrat/modules/horrorform/sound/horror_scream.ogg', 80, 1, frequency)
				else
					var/vol = clamp(100-((dist-7)*5), 10, 100) //Every tile decreases sound volume by 5
					M.playsound_local(src, 'modular_skyrat/modules/horrorform/sound/horror_scream_reverb.ogg', vol, 1, frequency)
			if(M.stat == DEAD && (M.client.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(M in viewers(get_turf(src),null)))
				M.show_message(message)
	audible_message(message)

/mob/living/simple_animal/hostile/true_changeling/death()
	. = ..()
	scream()
	spawn_gibs()
	if(stored_changeling && mind)
		visible_message(span_warning("[src] lets out a furious scream as it reaches equilibrium, as it starts exploding into a shower of gore!"), \
						span_userdanger("We lack the power to maintain our mass, we have reached critic-..."))
		anchored = TRUE
		turn_to_human.Remove()
		AddComponent(/datum/component/pellet_cloud, projectile_type=/obj/projectile/bullet/pellet/bone_fragment, magnitude=8)
		addtimer(CALLBACK(src, PROC_REF(real_death)), rand(3 SECONDS, 6 SECONDS))
	else
		visible_message(span_warning("[src] lets out a waning scream as it falls, twitching, to the floor."))
		addtimer(CALLBACK(src, PROC_REF(revive_from_death)), 45 SECONDS)

/mob/living/simple_animal/hostile/true_changeling/proc/revive_from_death()
	if(!src)
		return
	visible_message(span_warning("[src] stumbles upright and begins to move!"))
	revive() //Changelings can self-revive, and true changelings are no exception
	scream()

/mob/living/simple_animal/hostile/true_changeling/proc/real_death()
	for(var/i in 1 to 4)
		spawn_gibs()
	scream()
	icon_state = "horror_dead"
	visible_message(span_warning("[src] has surpassed equilibrium and can no longer support itself, exploding in a shower of bone and gore!"), \
						span_userdanger("ARRRRRRGHHHH!!!"))
	stored_changeling.loc = get_turf(src)
	mind.transfer_to(stored_changeling)
	stored_changeling.Paralyze(10 SECONDS) //Make them helpless for 10 seconds
	stored_changeling.adjustBruteLoss(30, TRUE, TRUE)
	stored_changeling.status_flags &= ~GODMODE
	stored_changeling.emote("scream")
	stored_changeling.gib()
	stored_changeling = null
	SEND_SIGNAL(src, COMSIG_HORRORFORM_EXPLODE)
	explosion(src, 0, 0, 5, 5)
	qdel(src)

/obj/projectile/bullet/pellet/bone_fragment
	name = "bone fragment"
	icon = 'modular_skyrat/modules/horrorform/icons/bone_fragment.dmi'
	icon_state = "bone_fragment"
	damage = 8
	ricochets_max = 3
	ricochet_chance = 66
	ricochet_decay_chance = 1
	ricochet_decay_damage = 0.9
	ricochet_auto_aim_angle = 10
	ricochet_auto_aim_range = 2
	ricochet_incidence_leeway = 0
	embed_falloff_tile = -2
	shrapnel_type = /obj/item/shrapnel/bone_fragment
	embed_type = /datum/embed_data/tomahawk

/datum/embed_data/tomahawk
	embed_chance = 55
	fall_chance = 2
	jostle_chance = 7
	ignore_throwspeed_threshold = TRUE
	pain_stam_pct = 0.7
	pain_mult = 3
	jostle_pain_mult = 3
	rip_time = 15

/obj/item/shrapnel/bone_fragment
	name = "bone fragment"
	icon_state = "tiny"
	sharpness = NONE

/obj/item/grenade/stingbang/bonebang
	name = "bonebang"
	icon = 'modular_skyrat/modules/horrorform/icons/bone_fragment.dmi'
	icon_state = "grenade_bone"
	shrapnel_type = /obj/projectile/bullet/pellet/bone_fragment
	shrapnel_radius = 8

/obj/item/grenade/stingbang/bonebang/detonate(mob/living/lanced_by)
	new /obj/effect/gibspawner/generic/animal(loc)
	. = ..()

/datum/action/innate/turn_to_human
	name = "Re-Form Human Shell"
	desc = "We turn back into a human. This takes considerable effort and will stun us for some time afterwards."
	button_icon = 'modular_skyrat/modules/horrorform/icons/actions_changeling.dmi'
	button_icon = 'modular_skyrat/modules/horrorform/icons/actions_changeling.dmi'
	background_icon_state = "bg_changeling"
	button_icon_state = "change_to_human"

/datum/action/innate/turn_to_human/Trigger(trigger_flags)
	var/mob/living/simple_animal/hostile/true_changeling/horrorform = owner
	if(!horrorform.stored_changeling)
		horrorform.balloon_alert(horrorform, "our only form!")
		return FALSE
	if(horrorform.stored_changeling.stat == DEAD)
		horrorform.balloon_alert(horrorform, "body is dead!")
		return FALSE
	if(world.time - horrorform.transformed_time < TRUE_CHANGELING_REFORM_THRESHOLD)
		var/timeleft = (horrorform.transformed_time + TRUE_CHANGELING_REFORM_THRESHOLD) - world.time
		horrorform.balloon_alert(horrorform, "wait [round(timeleft/600)+1] minutes!")
		return FALSE
	horrorform.visible_message(span_warning("[horrorform] suddenly crunches and twists into a smaller form!"), \
						span_danger("We return to our lesser form."))
	horrorform.stored_changeling.loc = get_turf(horrorform)
	horrorform.mind.transfer_to(horrorform.stored_changeling)
	horrorform.stored_changeling.Stun(2 SECONDS)
	horrorform.stored_changeling.status_flags &= ~GODMODE
	qdel(horrorform)
	return TRUE

/datum/action/innate/devour
	name = "Devour"
	desc = "We tear into the innards of a human. After some time, they will be significantly damaged and our health partially restored."
	button_icon = 'modular_skyrat/modules/horrorform/icons/actions_changeling.dmi'
	background_icon_state = "bg_changeling"
	button_icon_state = "devour"

/datum/action/innate/devour/Trigger(trigger_flags)
	var/mob/living/simple_animal/hostile/true_changeling/horrorform = owner
	if(horrorform.devouring)
		horrorform.balloon_alert(horrorform, "already eating!")
		return FALSE
	var/list/potential_targets = list()
	for(var/mob/living/carbon/human/victim in range(1, usr))
		if(victim == horrorform.stored_changeling || (victim.mind && victim.mind.has_antag_datum(/datum/antagonist/changeling))) //You can't eat changelings in human form
			continue
		potential_targets.Add(victim)
	if(!length(potential_targets))
		horrorform.balloon_alert(horrorform, "no carbons!")
		return FALSE
	var/mob/living/carbon/human/lunch
	if(length(potential_targets) == 1)
		lunch = potential_targets[1]
	else
		lunch = tgui_input_list(horrorform, "Choose a human to devour.", "Lunch", potential_targets)
	if(!lunch && !ishuman(lunch))
		return FALSE
	if(lunch.getBruteLoss() + lunch.getFireLoss() >= 200) //Overall physical damage, basically
		horrorform.visible_message(span_warning("[lunch] provides no further nutrients for [horrorform]!"), \
						span_danger("[lunch] has no more useful flesh for us to consume!!"))
		return FALSE
	horrorform.devouring = TRUE
	horrorform.visible_message(span_warning("[horrorform] begins ripping apart and feasting on [lunch]!"), \
					span_danger("We begin to feast upon [lunch]..."))
	if(!do_after(usr, 5 SECONDS, lunch))
		horrorform.devouring = FALSE
		return FALSE
	horrorform.devouring = FALSE
	lunch.adjustBruteLoss(60)
	horrorform.visible_message(span_warning("[horrorform] tears a chunk from [lunch]'s flesh!"), \
					span_danger("We tear a chunk of flesh from [lunch] and devour it!"))
	to_chat(lunch, span_userdanger("[horrorform] takes a huge bite out of you!"))
	lunch.spawn_gibs()
	var/dismembered = FALSE
	for(var/obj/item/bodypart/guts in lunch.bodyparts)
		if(dismembered)
			break
		if(prob(60) || guts.body_part == CHEST || guts.body_part == HEAD)
			continue
		guts.dismember()
		dismembered = TRUE
	playsound(lunch, 'sound/effects/splat.ogg', 50, 1)
	playsound(lunch, 'modular_skyrat/modules/horrorform/sound/tear.ogg', 50, 1)
	lunch.emote("scream")
	if(lunch.nutrition >= NUTRITION_LEVEL_FAT)
		horrorform.adjustBruteLoss(-100) //Tasty leetle peegy
	else
		horrorform.adjustBruteLoss(-50)

#undef TRUE_CHANGELING_REFORM_THRESHOLD
#undef TRUE_CHANGELING_PASSIVE_HEAL
