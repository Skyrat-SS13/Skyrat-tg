/mob/living/simple_animal/hostile/planet
	icon = 'icons/planet/planetary_mobs.dmi'
	response_help_continuous = "pets"
	response_help_simple = "pet"

	obj_damage = 40
	melee_damage_lower = 15
	melee_damage_upper = 15
	wound_bonus = 5
	bare_wound_bonus = 10
	sharpness = SHARP_EDGED
	attack_verb_continuous = "claws"
	attack_verb_simple = "claw"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_CLAW

	atmos_requirements = list(
		"min_oxy" = 0, "max_oxy" = 0,
		"min_tox" = 0, "max_tox" = 0,
		"min_co2" = 0, "max_co2" = 0,
		"min_n2" = 0, "max_n2" = 0,
	)
	minbodytemp = 0
	maxbodytemp = 1500
	weather_immunities = list("snow", "lava", "ash", "acid")

	faction = list("planet")

	footstep_type = FOOTSTEP_MOB_CLAW

	vision_range = 4
	aggro_vision_range = 8
	see_in_dark = 3

	butcher_results = list(
		/obj/item/food/meat/slab = 2,
		/obj/item/stack/sheet/bone = 2,
		/obj/item/stack/sheet/animalhide/generic = 1
	)

/mob/living/simple_animal/hostile/planet/samak
	name = "samak"
	desc = "A fast, armoured predator accustomed to hiding and ambushing in cold terrain."
	icon_state = "samak"
	icon_living = "samak"
	icon_dead = "samak_dead"
	maxHealth = 125
	health = 125
	speed = 2
	speak_chance = 5
	speak_emote = list("Hruuugh!","Hrunnph")
	emote_see = list("paws the ground","shakes its mane","stomps")
	emote_hear = list("snuffles")

/mob/living/simple_animal/hostile/planet/samak/alt
	desc = "A fast, armoured predator accustomed to hiding and ambushing."
	icon_state = "samak-alt"
	icon_living = "samak-alt"
	icon_dead = "samak-alt_dead"

/mob/living/simple_animal/hostile/planet/diyaab
	name = "diyaab"
	desc = "A small pack animal. Although omnivorous, it will hunt meat on occasion."
	icon_state = "diyaab"
	icon_living = "diyaab"
	icon_dead = "diyaab_dead"
	maxHealth = 25
	health = 25
	speed = 1
	speak_chance = 5
	speak = list("Awrr?","Aowrl!","Worrl")
	emote_see = list("sniffs the air cautiously","looks around")
	emote_hear = list("snuffles")
	mob_size = MOB_SIZE_SMALL

/mob/living/simple_animal/hostile/planet/shantak
	name = "shantak"
	desc = "A piglike creature with a bright iridiscent mane that sparkles as though lit by an inner light. Don't be fooled by its beauty though."
	icon_state = "shantak"
	icon_living = "shantak"
	icon_dead = "shantak_dead"
	maxHealth = 75
	health = 75
	speed = 1
	speak_chance = 2
	speak = list("Shuhn","Shrunnph?","Shunpf")
	emote_see = list("scratches the ground","shakes out its mane","tinkles gently")

/mob/living/simple_animal/hostile/planet/shantak/alt
	desc = "A piglike creature with a long and graceful mane. Don't be fooled by its beauty."
	icon_state = "shantak-alt"
	icon_living = "shantak-alt"
	icon_dead = "shantak-alt_dead"
	emote_see = list("scratches the ground","shakes out it's mane","rustles softly")

/mob/living/simple_animal/hostile/planet/shantak/lava
	desc = "A vaguely canine looking beast. It looks as though its fur is made of stone wool."
	icon_state = "lavadog"
	icon_living = "lavadog"
	icon_dead = "lavadog_dead"
	speak = list("Karuph","Karump")

/mob/living/simple_animal/hostile/planet/charbaby
	name = "charbaby"
	desc = "A huge grubby creature."
	icon_state = "char"
	icon_living = "char"
	icon_dead = "char_dead"
	mob_size = MOB_SIZE_LARGE
	health = 45
	maxHealth = 45
	speed = 2
	obj_damage = 10
	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_sound = 'sound/items/welder.ogg'
	melee_damage_type = BURN
	attack_verb_continuous = "signed"
	attack_verb_simple = "sign"
	status_flags = CANPUSH
	combat_mode = FALSE

/mob/living/simple_animal/hostile/planet/charbaby/AttackingTarget()
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		if(prob(10))
			L.fire_stacks += 1
		if(L.fire_stacks)
			L.IgniteMob()

/mob/living/simple_animal/yithian
	name = "yithian"
	desc = "A friendly creature vaguely resembling an oversized snail without a shell."
	icon = 'icons/planet/planetary_mobs.dmi'
	icon_state = "yithian"
	icon_living = "yithian"
	icon_dead = "yithian_dead"
	mob_size = MOB_SIZE_TINY
	pass_flags = PASSTABLE | PASSMOB
	atmos_requirements = list(
		"min_oxy" = 0, "max_oxy" = 0,
		"min_tox" = 0, "max_tox" = 0,
		"min_co2" = 0, "max_co2" = 0,
		"min_n2" = 0, "max_n2" = 0,
	)
	minbodytemp = 0
	maxbodytemp = 1500
	weather_immunities = list("snow", "lava", "ash", "acid")
	faction = list("planet")

/mob/living/simple_animal/tindalos
	name = "tindalos"
	desc = "It looks like a large, flightless grasshopper."
	icon = 'icons/planet/planetary_mobs.dmi'
	icon_state = "tindalos"
	icon_living = "tindalos"
	icon_dead = "tindalos_dead"
	mob_size = MOB_SIZE_TINY
	pass_flags = PASSTABLE | PASSMOB
	atmos_requirements = list(
		"min_oxy" = 0, "max_oxy" = 0,
		"min_tox" = 0, "max_tox" = 0,
		"min_co2" = 0, "max_co2" = 0,
		"min_n2" = 0, "max_n2" = 0,
	)
	minbodytemp = 0
	maxbodytemp = 1500
	weather_immunities = list("snow", "lava", "ash", "acid")
	faction = list("planet")

/mob/living/simple_animal/thinbug
	name = "taki"
	desc = "It looks like a bunch of legs."
	icon = 'icons/planet/planetary_mobs.dmi'
	icon_state = "thinbug"
	icon_living = "thinbug"
	icon_dead = "thinbug_dead"
	speak_chance = 1
	emote_hear = list("scratches the ground","chitters")
	mob_size = MOB_SIZE_TINY
	pass_flags = PASSTABLE | PASSMOB
	atmos_requirements = list(
		"min_oxy" = 0, "max_oxy" = 0,
		"min_tox" = 0, "max_tox" = 0,
		"min_co2" = 0, "max_co2" = 0,
		"min_n2" = 0, "max_n2" = 0,
	)
	minbodytemp = 0
	maxbodytemp = 1500
	weather_immunities = list("snow", "lava", "ash", "acid")
	faction = list("planet")

/mob/living/simple_animal/hostile/planet/antlion
	name = "antlion"
	desc = "A large insectoid creature."
	icon_state = "antlion"
	icon_living = "antlion"
	icon_dead = "antlion_dead"
	speak_emote = list("clicks")
	emote_hear = list("clicks its mandibles")
	emote_see = list("shakes the sand off itself")

	health = 65
	maxHealth = 65

	melee_damage_lower = 10
	melee_damage_upper = 10
	sharpness = SHARP_EDGED
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	attack_vis_effect = ATTACK_EFFECT_BITE

	//Their "ranged" ability is burrowing
	ranged = TRUE
	ranged_cooldown_time = 15 SECONDS

	/// Whether we are burrowed or not
	var/burrowed = FALSE
	/// How much health we regen per Life() when burrowed
	var/heal_amount = 10

/mob/living/simple_animal/hostile/planet/antlion/Life()
	. = ..()
	if(burrowed)
		health = min(maxHealth, health+heal_amount)

/mob/living/simple_animal/hostile/planet/antlion/OpenFire()
	if(!burrowed && prob(70))
		burrow()

/mob/living/simple_animal/hostile/planet/antlion/proc/burrow()
	ranged_cooldown = world.time + ranged_cooldown_time
	var/turf/my_turf = get_turf(src)
	playsound(my_turf, 'sound/effects/bamf.ogg', 50, 0)
	visible_message(SPAN_NOTICE("\The [src] burrows into \the [my_turf]!"))
	burrowed = TRUE
	invisibility = INVISIBILITY_MAXIMUM
	AIStatus = AI_OFF
	mob_size = MOB_SIZE_TINY
	new /obj/effect/temp_visual/burrow_sand_splash(my_turf)
	addtimer(CALLBACK(src, .proc/diggy), 4 SECONDS)

/mob/living/simple_animal/hostile/planet/antlion/proc/diggy()
	var/list/turf_targets = list()
	if(target)
		for(var/turf/T in range(1, get_turf(target)))
			if(!isopenturf(T))
				continue
			turf_targets += T
	else
		for(var/turf/T in view(5, src))
			if(!isopenturf(T))
				continue
			turf_targets += T
	if(length(turf_targets))
		forceMove(pick(turf_targets))

	addtimer(CALLBACK(src, .proc/emerge), 2 SECONDS)

/mob/living/simple_animal/hostile/planet/antlion/proc/emerge()
	var/turf/my_turf = get_turf(src)
	visible_message(SPAN_DANGER("\The [src] erupts from \the [my_turf]!"))
	invisibility = 0
	burrowed = FALSE
	AIStatus = AI_ON
	mob_size = initial(mob_size)
	playsound(my_turf, 'sound/effects/bamf.ogg', 50, 0)
	new /obj/effect/temp_visual/burrow_sand_splash(my_turf)
	for(var/mob/living/carbon/human/H in my_turf)
		attack_hand(H)
		visible_message(SPAN_DANGER("\The [src] tears into \the [H] from below!"))

/mob/living/simple_animal/hostile/planet/antlion/mega
	name = "antlion queen"
	desc = "A huge antlion. It looks displeased."
	icon_state = "queen"
	icon_living = "queen"
	icon_dead = "queen_dead"
	mob_size = MOB_SIZE_LARGE
	health = 275
	maxHealth = 275
	melee_damage_lower = 25
	melee_damage_upper = 25

	heal_amount = 20

/mob/living/simple_animal/hostile/planet/antlion/mega/Initialize()
	. = ..()
	transform = transform.Scale(2, 2)
	transform = transform.Translate(0, 16)

/obj/effect/temp_visual/burrow_sand_splash
	icon = 'icons/planet/planetary_mobs_effects.dmi'
	icon_state = "splash"
	color = "#dbc56b"

/mob/living/simple_animal/hostile/planet/royalcrab
	name = "cragenoy"
	desc = "It looks like a crustacean with an exceedingly hard carapace. Watch the pinchers!"
	icon_state = "royalcrab"
	icon_living = "royalcrab"
	icon_dead = "royalcrab_dead"
	maxHealth = 150
	health = 150
	speed = 1
	speak_chance = 1
	emote_see = list("skitters","oozes liquid from its mouth", "scratches at the ground", "clicks its claws")

	melee_damage_lower = 5
	melee_damage_upper = 5
	attack_verb_continuous = "pinched"
	attack_verb_simple = "pinch"

/mob/living/simple_animal/hostile/planet/royalcrab/giant
	name = "giant crab"
	desc = "A gigantic crustacean with a blue shell. Its left claw is nearly twice the size of its right."
	icon_state = "bluecrab"
	icon_living = "bluecrab"
	icon_dead = "bluecrab_dead"
	mob_size = MOB_SIZE_HUGE

	melee_damage_lower = 15
	melee_damage_upper = 15

	health = 350
	maxHealth = 350

/mob/living/simple_animal/hostile/planet/royalcrab/giant/Initialize()
	. = ..()
	transform = transform.Scale(2, 2)
	transform = transform.Translate(0, 16)

/mob/living/simple_animal/hostile/planet/jelly
	name = "zeq"
	desc = "It looks like a floating jellyfish. How does it do that?"
	icon_state = "jelly"
	icon_living = "jelly"
	icon_dead = "jelly_dead"
	maxHealth = 75
	health = 75
	speed = 1
	speak_chance = 1
	emote_see = list("wobbles slightly","oozes something out of tentacles' ends")

	melee_damage_type = BURN
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "stings"
	attack_verb_simple = "sting"
	attack_sound = 'sound/items/welder.ogg'
	attack_vis_effect = ATTACK_EFFECT_PUNCH

	butcher_results = null
	footstep_type = null

	var/gets_random_color = TRUE

/mob/living/simple_animal/hostile/planet/jelly/Initialize()
	. = ..()
	if(gets_random_color)
		color = random_color()

/mob/living/simple_animal/hostile/planet/jelly/alt
	icon_state = "jelly-alt"
	icon_living = "jelly-alt"
	icon_dead = "jelly-alt_dead"

/mob/living/simple_animal/hostile/planet/jelly/mega
	name = "zeq queen"
	desc = "A gigantic jellyfish-like creature. Its bell wobbles about almost as if it's ready to burst."
	maxHealth = 300
	health = 300
	gets_random_color = FALSE

	var/jelly_scale = 3
	var/split_type = /mob/living/simple_animal/hostile/planet/jelly/mega/half
	var/megajelly_color

/mob/living/simple_animal/hostile/planet/jelly/mega/Initialize()
	. = ..()
	if(!megajelly_color)
		megajelly_color = random_color()
	color = megajelly_color
	transform = transform.Scale(jelly_scale, jelly_scale)
	var/y_translate = ((jelly_scale-1) * 32)/2
	transform = transform.Translate(0, y_translate)

/mob/living/simple_animal/hostile/planet/jelly/mega/death()
	if(split_type)
		jelly_split()
		qdel(src)
	else
		return ..()

/mob/living/simple_animal/hostile/planet/jelly/mega/proc/jelly_split()
	var/turf/my_turf = get_turf(src)
	playsound(my_turf, 'sound/effects/bamf.ogg', 100, TRUE)
	visible_message(SPAN_USERDANGER("\The [src] rumbles briefly before splitting into two!"))
	for(var/i = 1 to 2)
		var/mob/living/simple_animal/hostile/planet/jelly/mega/child = new split_type(get_turf(src))
		child.megajelly_color = megajelly_color
		child.color = megajelly_color

/mob/living/simple_animal/hostile/planet/jelly/mega/half
	name = "zeq duchess"
	desc = "A huge jellyfish-like creature."
	maxHealth = 150
	health = 150
	jelly_scale = 1.5
	split_type = /mob/living/simple_animal/hostile/planet/jelly/mega/quarter

/mob/living/simple_animal/hostile/planet/jelly/mega/quarter
	name = "zeqling"
	desc = "A jellyfish-like creature."
	health = 75
	maxHealth = 75
	jelly_scale = 1
	split_type = /mob/living/simple_animal/hostile/planet/jelly/mega/fourth

/mob/living/simple_animal/hostile/planet/jelly/mega/fourth
	name = "zeqetta"
	desc = "A tiny jellyfish-like creature."
	health = 40
	maxHealth = 40
	jelly_scale = 0.5
	split_type = null
