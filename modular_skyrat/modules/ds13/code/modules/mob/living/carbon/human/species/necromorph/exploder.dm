/*
	Exploder variant, the most common necromorph.

*/

/datum/species/necromorph/exploder
	name = SPECIES_NECROMORPH_EXPLODER
	name_plural =  "Exploders"
	mob_type = /mob/living/carbon/human/necromorph/exploder
	blurb = "An expendable suicide bomber, the exploder's sole purpose is to go out in a blaze of glory, and hopefully take a few people with it."
	unarmed_types = list(/datum/unarmed_attack/bite/weak/exploder) //Bite attack is a backup if blades are severed
	total_health = 85	//It has high health for the sake of making it a bit harder to destroy without targeting the pustule. Exploding the pustule is always an instakill
	biomass = 70
	mass = 50

	biomass_reclamation_time	=	5 MINUTES
	view_range = 6
	darksight_tint = DARKTINT_POOR

	icon_template = 'icons/mob/necromorph/exploder.dmi'
	icon_lying = "_lying"
	pixel_offset_x = -8
	single_icon = FALSE
	evasion = 10	//Awkward movemetn makes it a tricky target
	spawner_spawnable = TRUE
	virus_immune = 1

	//Audio
	step_volume = VOLUME_QUIET
	step_range = 6	//We want to hear it coming
	step_priority = 3



	has_limbs = list(
	BP_CHEST =  list("path" = /obj/item/organ/external/chest/simple, "height" = new /vector2(1,1.65)),
	BP_HEAD =   list("path" = /obj/item/organ/external/head/simple, "height" = new /vector2(1.65,1.85)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/simple, "height" = new /vector2(0,1.60)),	//The exploder's right arm reaches the floor
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/simple/exploder, "height" = new /vector2(0.8,1.60)),
	BP_L_HAND = list("path" = /obj/item/organ/external/hand/exploder_pustule, "height" = new /vector2(0,0.8)),
	BP_L_LEG =  list("path" = /obj/item/organ/external/leg/simple, "height" = new /vector2(0,1))
	)



	has_organ = list(    // which required-organ checks are conducted.
	BP_HEART =    /obj/item/organ/internal/heart/undead,
	BP_LUNGS =    /obj/item/organ/internal/lungs/undead,
	BP_BRAIN =    /obj/item/organ/internal/brain/undead/torso,
	BP_EYES =     /obj/item/organ/internal/eyes/torso
	)

	organ_substitutions = list(BP_R_LEG = BP_L_LEG,
	BP_HEAD = BP_CHEST)

	//The exploder has only one fused leg, but the right arm is also used to support movement
	locomotion_limbs = list(BP_R_ARM, BP_L_LEG)

	//Only one of the exploder's arms ends in a hand
	grasping_limbs = list(BP_R_ARM)


	species_audio = list(
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/exploder/exploder_attack_1.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_attack_2.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_attack_3.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_attack_4.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_attack_5.ogg'),
	SOUND_DEATH = list('sound/effects/creatures/necromorph/exploder/exploder_death_1.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_death_2.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_death_3.ogg'),
	SOUND_FOOTSTEP = list('sound/effects/footstep/exploder_footstep_1.ogg',
	'sound/effects/footstep/exploder_footstep_2.ogg',
	'sound/effects/footstep/exploder_footstep_3.ogg',
	'sound/effects/footstep/exploder_footstep_4.ogg',
	'sound/effects/footstep/exploder_footstep_5.ogg',
	'sound/effects/footstep/exploder_footstep_6.ogg',
	'sound/effects/footstep/exploder_footstep_7.ogg',
	'sound/effects/footstep/exploder_footstep_multi_1.ogg' = 0.4,	//These uncommon sounds play multiple footsteps in a single audio file
	'sound/effects/footstep/exploder_footstep_multi_2.ogg' = 0.4,
	'sound/effects/footstep/exploder_footstep_multi_3.ogg' = 0.4,
	'sound/effects/footstep/exploder_footstep_multi_4.ogg' = 0.4),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/exploder/exploder_pain_1.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_pain_2.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_pain_3.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_pain_4.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_pain_5.ogg'),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/exploder/exploder_shout_1.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_2.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_3.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_4.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_5.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_6.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_7.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/exploder/exploder_shout_long_1.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_long_2.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_long_3.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_long_4.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_shout_long_5.ogg'),
	SOUND_SPEECH = list('sound/effects/creatures/necromorph/exploder/exploder_speech_1.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_speech_2.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_speech_3.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_speech_4.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_speech_5.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_speech_6.ogg',
	'sound/effects/creatures/necromorph/exploder/exploder_speech_7.ogg')
	)


	slowdown = 4

	inherent_verbs = list(/atom/movable/proc/exploder_charge, /mob/living/carbon/human/proc/exploder_explode, /mob/proc/shout)
	modifier_verbs = list(KEY_CTRLALT = list(/atom/movable/proc/exploder_charge),
	KEY_CTRLSHIFT = list(/mob/living/carbon/human/proc/exploder_explode))


#define EXPLODER_PASSIVE	"<h2>PASSIVE: Explosive Pustule:</h2><br>\
The Exploder's left hand is a massive pustule full of flammable chemicals, which can create a devastating explosion when triggered.<br>\
The pustule is very fragile, and can be detonated by a fairly minor quantity of damage aimed at it, so it is vitally important to avoid gunfire while approaching enemies.<br>\
<br>\
The pustule does NOT automatically detonate on death, and if the exploder's left arm is severed, the pustule can fall off without exploding."

#define EXPLODER_PASSIVE_2	"<h2>PASSIVE: Lightbearer:</h2><br>\
The Exploder pustule grows brightly, providing a source of light all around him.<br>\
If the exploder successfully detonates its pustule, the area around where he died is revealed to necrovision for 30 seconds post-death."

#define EXPLODER_CHARGE_DESC	"<h2>Charge:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 20 seconds</h3><br>\
The user screams for a few seconds, then runs towards the target at high speed. If they successfully hit a human, the explosive pustule detonates immediately.<br>\
A successful charge is the most effective and reliable way to detonate. It should be considered the prime goal of the exploder."


#define EXPLODER_EXPLODE_DESC "<h2>Explode:</h2><br>\
<h3>Hotkey: Ctrl+Shift+Click</h3><br>\
The last resort. The exploder screams and shakes violently for 3 seconds, before detonating the pustule.<br>\
 This is quite telegraphed and it can give your victims time to back away before the explosion. Not the most ideal way to detonate, but it can be a viable backup if you fail to hit something with charge."

/datum/species/necromorph/exploder/get_ability_descriptions()
	.= ""
	. += EXPLODER_CHARGE_DESC
	. += "<hr>"
	. += EXPLODER_EXPLODE_DESC

//The exploder periodically makes random sounds
/datum/species/necromorph/exploder/setup_defense(var/mob/living/carbon/human/H)
	.=..()
	set_extension(H,/datum/extension/auto_sound/exploder)


/datum/extension/auto_sound/exploder
	valid_sounds = list(SOUND_SHOUT, SOUND_PAIN)


/datum/unarmed_attack/bite/weak/exploder
	required_limb = list(BP_CHEST)

/*---------------------
	Pustule
---------------------*/
/*
	The exploder's left hand is a giant organic bomb
*/

/obj/item/organ/external/hand/exploder_pustule
	organ_tag = BP_L_HAND
	name = "pustule"
	icon_name = "l_hand"
	max_damage = 15
	min_broken_damage = 15
	w_class = ITEM_SIZE_HUGE
	body_part = HAND_LEFT
	parent_organ = BP_L_ARM
	joint = "left wrist"
	amputation_point = "left wrist"
	tendon_name = "carpal ligament"
	arterial_bleed_severity = 0.5
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE
	base_miss_chance = -5	//Big  target
	var/exploded = FALSE
	can_regrow = FALSE	//This is once only

//The pustule casts soft yellow light in a broad area
/obj/item/organ/external/hand/exploder_pustule/Initialize()
	set_light(1, 1, 9, 2, COLOR_NECRO_YELLOW)
	.=..()

/*
	The actual explosion!
*/
//A multi-level explosion using a broad variety of cool mechanics
/obj/item/organ/external/hand/exploder_pustule/proc/explode()
	if (exploded)
		return

	exploded = TRUE


	var/turf/T = get_turf(src)
	//A bioblast, dealing some burn and acid damage
	spawn()
		bioblast(epicentre = T,
		power = 60,
		maxrange = 4,
		falloff_factor = 0.3)

	//A normal explosion
	spawn()
		//Max power 2 because hull breaches are not cool
		T.EXPLOSION_LARGE

	spawn()
		//An immediate second, smaller explosion to deal more damage
		T.EXPLOSION_STANDARD

	//Make sure the pustule is deleted if these explosions don't destroy it
	spawn()
		if (!QDELETED(src))
			qdel(src)

	//If we're still attached to the owner, spawn a scrying eye and gib them
	if (owner && loc == owner)
		new /obj/effect/scry_eye/exploder(T)
		owner.gib()
	return TRUE

//When severed, the pustule always explodes, no clean cutting off
/obj/item/organ/external/hand/exploder_pustule/droplimb(var/clean, var/disintegrate = DROPLIMB_EDGE, var/ignore_children, var/silent, var/atom/cutter)
	if (!explode())
		.=..(FALSE, DROPLIMB_BLUNT, ignore_children, silent)	//We pass false to clean, and droplimb blunt to make sure its detonated



//Once severed, the pustule can be picked up and thrown as a grenade, detonation on impact
/obj/item/organ/external/hand/exploder_pustule/throw_impact(atom/hit_atom, var/speed)
	explode()



/*
	Checks
*/
/datum/species/necromorph/exploder/proc/can_explode(var/mob/living/carbon/human/H)
	.=FALSE
	var/obj/item/organ/external/hand/exploder_pustule/E = H.get_organ(BP_L_HAND)
	if (QDELETED(E) || !istype(E) || E.is_stump() || E.exploded || E.owner != H)
		return

	return TRUE


/mob/living/carbon/human/proc/exploder_explode()
	set name = "Explode"
	set category = "Abilities"

	if (incapacitated())
		return

	var/datum/species/necromorph/exploder/ES = species
	if (!ES.can_explode(src))
		return


	play_species_audio(src, SOUND_SHOUT_LONG, VOLUME_HIGH, 1, 3)
	//Lots of shaking with increasing frequency and violence
	custom_shake_animation(5, 4, 3, TRUE, FALSE)
	sleep(3)
	custom_shake_animation(7, 5, 3, TRUE, FALSE)
	sleep(3)
	custom_shake_animation(10, 6, 3, TRUE, FALSE)
	sleep(3)
	custom_shake_animation(12, 7, 3, TRUE, FALSE)
	sleep(3)
	custom_shake_animation(14, 8, 3, TRUE, FALSE)
	sleep(3)

	custom_shake_animation(16, 9, 3, TRUE, FALSE)
	sleep(3)
	custom_shake_animation(18, 10, 3, TRUE, FALSE)
	sleep(3)
	custom_shake_animation(20, 11, 3, TRUE, FALSE)
	sleep(3)
	custom_shake_animation(22, 12, 3, TRUE, FALSE)
	sleep(3)
	custom_shake_animation(25, 14, 3, TRUE, FALSE)
	sleep(3)


	//Make sure its still there
	if (!ES.can_explode(src))
		return

	var/obj/item/organ/external/hand/exploder_pustule/E = get_organ(BP_L_HAND)
	E.explode()	//Kaboom!




/*---------------------
	Pustule Arm
---------------------*/
/*
	The exploder's left arm is a thin pair of bones that the pustule is attached to.
*/
/obj/item/organ/external/arm/simple/exploder
	w_class = ITEM_SIZE_SMALL
	arterial_bleed_severity = 0
	base_miss_chance = 20	//Thin and hard target, trying to shoot this is a risky move

//When severed, the arm is always cut cleanly, so that the pustule drops off without detonating
/obj/item/organ/external/arm/simple/exploder/droplimb(var/clean, var/disintegrate = DROPLIMB_EDGE, var/ignore_children, var/silent, var/atom/cutter)
	.=..(TRUE, DROPLIMB_EDGE, ignore_children, silent)	//We pass true to clean, and droplimb edge to make sure its cleanly cut


//When severed, the arm is a seperate object with the pustule in its contents. We pass along events to it
/obj/item/organ/external/arm/simple/exploder/throw_impact(atom/hit_atom, var/speed)
	for (var/obj/item/organ/external/hand/exploder_pustule/EP in contents)
		EP.throw_impact(hit_atom, speed)

	.=..()



/obj/item/organ/external/arm/simple/exploder/bullet_act(var/obj/item/projectile/P, var/def_zone)
	for (var/obj/item/organ/external/hand/exploder_pustule/EP in contents)
		EP.bullet_act(P, def_zone)

	.=..()



/*
	Abilities
*/
/atom/movable/proc/exploder_charge(var/mob/living/A)
	set name = "Charge"
	set category = "Abilities"

	//Charge autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 1, src, 999)


	.= charge_attack(A, _delay = 1.5 SECONDS, _speed = 3, _lifespan = 6 SECONDS)
	if (.)
		var/mob/H = src
		if (istype(H))
			H.face_atom(A)

			//Long shout when targeting mobs, normal when targeting objects
			if (ismob(A))
				H.play_species_audio(src, SOUND_SHOUT_LONG, VOLUME_HIGH, 1, 3)
			else
				H.play_species_audio(src, SOUND_SHOUT, VOLUME_HIGH, 1, 3)
		shake_animation(30)



/*
	Exploders have a special charge impact. They detonate on impact
*/
/datum/species/necromorph/exploder/charge_impact(var/mob/living/charger, var/atom/obstacle, var/power, var/target_type, var/distance_travelled)
	if (target_type == CHARGE_TARGET_PRIMARY && isliving(obstacle))
		//Make sure its still there
		if (!can_explode(charger))
			return



		var/mob/living/L = obstacle
		L.Weaken(3)	//Knock them down
		charger.forceMove(get_turf(obstacle))	//Move ontop of them for maximum damage

		var/obj/item/organ/external/hand/exploder_pustule/E = charger.get_organ(BP_L_HAND)
		E.explode()	//Kaboom!

		return FALSE
	else
		return ..()








//Dropped on a successful explosion
/obj/effect/scry_eye/exploder
	lifespan = 30 SECONDS