/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

#define EXPLODER_DODGE_EVASION	60
#define EXPLODER_DODGE_DURATION	1.5 SECONDS

/datum/species/necromorph/exploder
	name = SPECIES_NECROMORPH_EXPLODER
	id = SPECIES_NECROMORPH_EXPLODER
	can_have_genitals = FALSE
	say_mod = "hisses"
	limbs_id = "exploder"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/exploder.dmi'
	//body_position_pixel_x_offset = 0
	//body_position_pixel_y_offset = 0
//	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/exploder/fleshy.dmi'
	//eyes_icon = 'modular_skyrat/master_files/icons/mob/species/vox_eyes.dmi'
//	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/exploder/fleshy.dmi'
//	mutant_bodyparts = list()

	//Audio
	step_volume = VOLUME_QUIET
	step_range = 6	//We want to hear it coming
	step_priority = 3

	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		NO_UNDERWEAR,
		FACEHAIR
	)

	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sexes = 0

/*
	Slasher variant. Damage Calculation and Effects
*/

	damage_overlay_type = "xeno"
	attack_sound = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_5.ogg')
	miss_sound = 'sound/weapons/slashmiss.ogg'
	attack_verb = "slash"

	attack_effect = ATTACK_EFFECT_CLAW

/*
	Slasher variant. Traits
*/

	species_traits = list(HAS_FLESH, HAS_BONE)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOMETABOLISM,
		TRAIT_TOXIMMUNE,
		TRAIT_RESISTHEAT,
		TRAIT_NOBREATH,
		TRAIT_RESISTCOLD,
		TRAIT_RESISTHIGHPRESSURE,
		TRAIT_RESISTLOWPRESSURE,
		TRAIT_RADIMMUNE,
		TRAIT_GENELESS,
		TRAIT_PIERCEIMMUNE,
		TRAIT_NOHUNGER,
		TRAIT_EASYDISMEMBER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_XENO_IMMUNE,
		TRAIT_NOCLONELOSS,
	)


/*
	Slasher variant. Mutant Parts
*/
	mutanteyes = /obj/item/organ/eyes/night_vision
	mutanttongue = /obj/item/organ/tongue/zombie

	default_mutant_bodyparts = list(
		"tail" = "None",
		"snout" = "None",
		"ears" = "None",
		"legs" = "Normal Legs",
		"wings" = "None",
		"taur" = "None",
		"horns" = "None"
	)

	bodypart_overides = list(
	BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/necromorph,\
	BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/necromorph,\
	BODY_ZONE_HEAD = /obj/item/bodypart/head/necromorph,\
	BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/necromorph,\
	BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/necromorph,\
	BODY_ZONE_CHEST = /obj/item/bodypart/chest/necromorph)

	species_audio = list(
	SOUND_ATTACK = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_attack_5.ogg'),
	SOUND_DEATH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_death_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_death_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_death_3.ogg'),
	SOUND_FOOTSTEP = list('modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_7.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_multi_1.ogg' = 0.4,	//These uncommon sounds play multiple footsteps in a single audio file
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_multi_2.ogg' = 0.4,
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_multi_3.ogg' = 0.4,
	'modular_skyrat/modules/necromorphs/sound/effects/footstep/exploder_footstep_multi_4.ogg' = 0.4),
	SOUND_PAIN = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_pain_5.ogg'),
	SOUND_SHOUT = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_7.ogg'),
	SOUND_SHOUT_LONG = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_shout_long_5.ogg'),
	SOUND_SPEECH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/exploder/exploder_speech_7.ogg')
	)



#define EXPLODER_PASSIVE	"<h2>PASSIVE: Explosive Pustule:</h2><br>\
The Exploder's left hand is a massive pustule full of flammable chemicals, which can create a devastating explosion when triggered.<br>\
The pustule is very fragile, and can be detonated by a fairly minor quantity of damage aimed at it, so it is vitally important to avoid gunfire while approaching enemies.<br>\
<br>\
The pustule does NOT automatically detonate on death, and if the exploder's left arm is severed, the pustule can fall off without exploding."

#define EXPLODER_PASSIVE_2	"<h2>PASSIVE: Lightbearer:</h2><br>\
The Exploder pustule glows brightly, providing a source of light all around him.<br>\
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

//The exploder periodically makes random sounds
/datum/species/necromorph/exploder/setup_defense(var/mob/living/carbon/human/H)
	.=..()
	set_extension(H,/datum/extension/auto_sound/exploder)


/datum/extension/auto_sound/exploder
	valid_sounds = list(SOUND_SHOUT, SOUND_PAIN)


// /datum/unarmed_attack/bite/weak/exploder
// 	required_limb = list(BP_CHEST)


// /datum/species/necromorph/exploder/get_ability_descriptions()
// 	.= ""
// 	. += EXPLODER_PASSIVE
// 	. += "<hr>"
// 	. += EXPLODER_PASSIVE_2
// 	. += "<hr>"
// 	. += EXPLODER_CHARGE_DESC
// 	. += "<hr>"
// 	. += EXPLODER_EXPLODE_DESC

/*---------------------
	Pustule
---------------------*/
/*
	The exploder's left hand is a giant organic bomb
*/

// /obj/item/organ/external/exploder_pustule
// 	name = "pustule"
// 	organ_tag = BP_L_ARM
// 	icon_name = "l_arm"
// 	max_damage = 30
// 	min_broken_damage = 15
// 	w_class = ITEM_SIZE_HUGE
// 	body_part = ARM_LEFT
// 	parent_organ = BP_CHEST
// 	joint = "left elbow"
// 	amputation_point = "left shoulder"
// 	tendon_name = "palmaris longus tendon"
// 	artery_name = "basilic vein"
// 	arterial_bleed_severity = 0.75
// 	limb_flags = ORGAN_FLAG_CAN_AMPUTATE
// 	base_miss_chance = 12
// 	best_direction	=	WEST
// 	defensive_group = null
// 	light_color = COLOR_NECRO_YELLOW
// 	var/exploded = FALSE
// 	base_miss_chance = -10

// /obj/item/organ/external/exploder_pustule/hand
// 	organ_tag = BP_L_HAND
// 	icon_name = "l_hand"
// 	body_part = HAND_LEFT
// 	parent_organ = BP_L_ARM
// 	joint = "left wrist"
// 	amputation_point = "left wrist"
// 	tendon_name = "carpal ligament"
// 	light_color = COLOR_NECRO_YELLOW

// The pustule casts soft yellow light in a broad area
// /obj/item/organ/external/exploder_pustule/Initialize()
// 	set_light(1, 1, 9, 2, light_color)
// 	.=..()


// /obj/item/organ/external/exploder_pustule/right
// 	organ_tag = BP_R_ARM
// 	icon_name = "r_arm"
// 	body_part = ARM_RIGHT
// 	parent_organ = BP_CHEST
// 	joint = "right elbow"
// 	amputation_point = "right shoulder"
// 	best_direction	=	EAST

/*
	The actual explosion!
*/
//A multi-level explosion using a broad variety of cool mechanics
// /obj/item/organ/external/exploder_pustule/proc/explode()
// 	if (exploded)
// 		return
// 	exploded = TRUE
// 	do_explode()


// /obj/item/organ/external/exploder_pustule/proc/do_explode()

// 	var/turf/T = get_turf(src)
// 	link_necromorphs_to(SPAN_NOTICE("Exploder Exploding at LINK"), T)


// 	//A bioblast, dealing some burn and acid damage
// 	spawn()
// 		bioblast(epicentre = T,
// 		power = 60,
// 		maxrange = 4,
// 		falloff_factor = 0.3)

// 	//A normal explosion
// 	spawn()
// 		//Max power 2 because hull breaches are not cool
// 		T.EXPLOSION_LARGE

// 	spawn()
// 		//An immediate second, smaller explosion to deal more damage
// 		T.EXPLOSION_STANDARD

// 	//Make sure the pustule is deleted if these explosions don't destroy it
// 	spawn()
// 		if (!QDELETED(src))
// 			qdel(src)

// 	//If we're still attached to the owner, spawn a scrying eye and gib them
// 	if (owner && loc == owner)
// 		new /obj/effect/scry_eye/exploder(T)
// 		owner.gib()
// 	return TRUE

//When severed, the pustule always explodes, no clean cutting off
// /obj/item/organ/external/exploder_pustule/droplimb(var/clean, var/disintegrate = DROPLIMB_EDGE, var/ignore_children, var/silent, var/atom/cutter)
// 	if (!explode())
// 		.=..(FALSE, DROPLIMB_BLUNT, ignore_children, silent)	//We pass false to clean, and droplimb blunt to make sure its detonated



//Once severed, the pustule can be picked up and thrown as a grenade, detonation on impact
// /obj/item/organ/external/exploder_pustule/throw_impact(atom/hit_atom, var/speed)
// 	explode()



/*
	Checks
*/
// /datum/species/necromorph/exploder/proc/can_explode(var/mob/living/carbon/human/H)
// 	.=FALSE
// 	var/obj/item/organ/external/exploder_pustule/E = H.get_organ_by_type(/obj/item/organ/external/exploder_pustule)
// 	if (QDELETED(E) || !istype(E) || E.is_stump() || E.exploded || E.owner != H)
// 		return

// 	return TRUE


// /mob/living/carbon/human/proc/exploder_explode()
// 	set name = "Explode"
// 	set category = "Abilities"

// 	if (incapacitated())
// 		return

// 	var/datum/species/necromorph/exploder/ES = species
// 	if (!ES.can_explode(src))
// 		return


// 	play_species_audio(src, SOUND_SHOUT_LONG, VOLUME_HIGH, 1, 3)
// 	//Lots of shaking with increasing frequency and violence
// 	custom_shake_animation(5, 4, 3, TRUE, FALSE)
// 	sleep(3)
// 	custom_shake_animation(7, 5, 3, TRUE, FALSE)
// 	sleep(3)
// 	custom_shake_animation(10, 6, 3, TRUE, FALSE)
// 	sleep(3)
// 	custom_shake_animation(12, 7, 3, TRUE, FALSE)
// 	sleep(3)
// 	custom_shake_animation(14, 8, 3, TRUE, FALSE)
// 	sleep(3)

// 	custom_shake_animation(16, 9, 3, TRUE, FALSE)
// 	sleep(3)
// 	custom_shake_animation(18, 10, 3, TRUE, FALSE)
// 	sleep(3)
// 	custom_shake_animation(20, 11, 3, TRUE, FALSE)
// 	sleep(3)
// 	custom_shake_animation(22, 12, 3, TRUE, FALSE)
// 	sleep(3)
// 	custom_shake_animation(25, 14, 3, TRUE, FALSE)
// 	sleep(3)


// 	//Make sure its still there
// 	if (!ES.can_explode(src))
// 		return

// 	var/obj/item/organ/external/exploder_pustule/E = get_organ_by_type(/obj/item/organ/external/exploder_pustule)
// 	E.explode()	//Kaboom!



// /obj/item/organ/external/arm/simple/exploder/right
// 	organ_tag = BP_R_ARM
// 	icon_name = "r_arm"
// 	body_part = ARM_RIGHT
// 	joint = "right elbow"
// 	amputation_point = "right shoulder"
// 	best_direction	=	EAST

/*
	Exploders have a special charge impact. They detonate on impact
*/
// /datum/species/necromorph/exploder/charge_impact(var/datum/extension/charge/charge)
// 	var/mob/living/carbon/human/charger = charge.user
// 	if (isliving(charge.last_obstacle))
// 		//Make sure its still there
// 		var/mob/living/L = charge.last_obstacle
// 		if (!can_explode(charger))
// 			return

// 		//Bonus behaviour if we hit our originally intended target
// 		if (charge.last_target_type == CHARGE_TARGET_PRIMARY)
// 			L.Weaken(3)	//Knock them down
// 			charger.forceMove(get_turf(charge.last_obstacle))	//Move ontop of them for maximum damage


// 		var/obj/item/organ/external/exploder_pustule/E = charger.get_organ_by_type(/obj/item/organ/external/exploder_pustule)
// 		if (istype(E))
// 			E.explode()	//Kaboom!

// 		return FALSE
// 	else
// 		return ..()

#undef EXPLODER_DODGE_EVASION
#undef EXPLODER_DODGE_DURATION

