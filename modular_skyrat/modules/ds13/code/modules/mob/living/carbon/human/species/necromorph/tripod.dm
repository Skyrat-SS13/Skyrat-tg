#define LEAP_SHOCKWAVE_DAMAGE	10
#define LEAP_CONE_DAMAGE	10
#define LEAP_CONE_WEAKEN	2
#define LEAP_REDUCED_COOLDOWN	3 SECONDS
#define TONGUE_EXTEND_TIME 7 SECONDS	//How long the tongue stays out and visible after any tongue move

#define ARM_SWING_RANGE	4

//These are used to position the arm sprite during swing
#define LEFT_ARM_OFFSETS	list("[NORTH]" = new /vector2(-4, 12), "[SOUTH]" = new /vector2(8, 8), "[EAST]" = new /vector2(14, 2), "[WEST]" = new /vector2(8, 6))
#define RIGHT_ARM_OFFSETS	list("[NORTH]" = new /vector2(12, 12), "[SOUTH]" = new /vector2(-8, 6), "[EAST]" = new /vector2(-2, 4), "[WEST]" = new /vector2(-6, 6))
#define TONGUE_OFFSETS	list("[NORTH]" = new /vector2(6, 16), "[SOUTH]" = new /vector2(-2, 8), "[EAST]" = new /vector2(26, 10), "[WEST]" = new /vector2(-14, 10))

/datum/species/necromorph/tripod
	name = SPECIES_NECROMORPH_TRIPOD
	mob_type	=	/mob/living/carbon/human/necromorph/tripod
	name_plural =  "Tripods"
	blurb = "A heavy skirmisher, the tripod is adept at leaping around open spaces and fighting against multiple distant targets."
	total_health = 450
	torso_damage_mult = 0.65 //Hitting centre mass is fine for tripod

	//Normal necromorph flags plus no slip
	species_flags = SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_MINOR_CUT | SPECIES_FLAG_NO_POISON  | SPECIES_FLAG_NO_BLOCK | SPECIES_FLAG_NO_SLIP
	stability = 2

	icon_template = 'icons/mob/necromorph/tripod.dmi'
	icon_lying = "_lying"
	pixel_offset_x = -54
	single_icon = FALSE
	health_doll_offset	= 56

	plane = LARGE_MOB_PLANE
	layer = LARGE_MOB_LAYER

	biomass = 350
	mass = 250
	biomass_reclamation_time	=	15 MINUTES
	marker_spawnable = TRUE


	//Collision and bulk
	strength    = STR_VHIGH
	mob_size	= MOB_LARGE
	bump_flag 	= HEAVY	// What are we considered to be when bumped?
	push_flags 	= ALLMOBS	// What can we push?
	swap_flags 	= ALLMOBS	// What can we swap place with?
	evasion = 0	//Tripod has no natural evasion, but this value will be constantly modified by a passive ability
	reach = 2

	//Implacable
	stun_mod = 0.5
	weaken_mod = 0.3
	paralysis_mod = 0.3


	inherent_verbs = list(/mob/living/carbon/human/proc/tripod_leap,
	/mob/living/carbon/human/proc/tripod_arm_swing,
	/mob/living/carbon/human/proc/tripod_tongue_lash,
	/mob/living/carbon/human/proc/tripod_kiss,
	/mob/proc/shout,/mob/proc/shout_long)

	modifier_verbs = list(
	KEY_CTRLALT = list(/mob/living/carbon/human/proc/tripod_leap),
	KEY_ALT = list(/mob/living/carbon/human/proc/tripod_arm_swing),
	KEY_MIDDLE = list(/mob/living/carbon/human/proc/tripod_tongue_lash),
	KEY_CTRLSHIFT = list(/mob/living/carbon/human/proc/tripod_kiss))


	unarmed_types = list(/datum/unarmed_attack/punch/tripod)

	slowdown = 5 //Note, this is a terribly awful way to do speed, bay's entire speed code needs redesigned

	//Vision
	view_range = 12


	has_limbs = list(BP_CHEST =  list("path" = /obj/item/organ/external/chest/giant, "height" = new /vector2(0, 2.5)),
	BP_HEAD = list("path" = /obj/item/organ/external/arm/tentacle/tripod_tongue, "height" = new /vector2(1.5, 2.5)),	//The tripod is tall and all of its limbs are too
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/giant, "height" = new /vector2(0, 2.0)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/giant, "height" = new /vector2(0, 2.0))
	)

	locomotion_limbs = list(BP_R_ARM, BP_L_ARM)

	grasping_limbs = list(BP_R_ARM, BP_L_ARM)

	has_organ = list(    // which required-organ checks are conducted.
	BP_HEART =    /obj/item/organ/internal/heart/undead,
	BP_LUNGS =    /obj/item/organ/internal/lungs/undead,
	BP_BRAIN =    /obj/item/organ/internal/brain/undead/torso,
	BP_EYES =     /obj/item/organ/internal/eyes/torso
	)

	//Audio

	step_volume = VOLUME_QUIET //Tripod stomps are low pitched and resonant, don't want them loud
	step_range = 4
	step_priority = 5
	pain_audio_threshold = 0.03 //Gotta set this low to compensate for his high health
	species_audio = list(SOUND_FOOTSTEP = list('sound/effects/footstep/tripod_footstep_1.ogg',
	'sound/effects/footstep/tripod_footstep_2.ogg',
	'sound/effects/footstep/tripod_footstep_3.ogg',
	'sound/effects/footstep/tripod_footstep_4.ogg',
	'sound/effects/footstep/tripod_footstep_5.ogg',
	'sound/effects/footstep/tripod_footstep_6.ogg'),
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/tripod/tripod_attack_1.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_attack_2.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_attack_3.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_attack_4.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_attack_5.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_attack_6.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_attack_7.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_attack_8.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_attack_9.ogg'),
	SOUND_DEATH = list('sound/effects/creatures/necromorph/tripod/tripod_death_1.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_death_2.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_death_3.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_death_4.ogg'),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/tripod/tripod_pain_1.ogg',
	 'sound/effects/creatures/necromorph/tripod/tripod_pain_2.ogg',
	 'sound/effects/creatures/necromorph/tripod/tripod_pain_3.ogg',
	 'sound/effects/creatures/necromorph/tripod/tripod_pain_4.ogg',
	 'sound/effects/creatures/necromorph/tripod/tripod_pain_5.ogg',),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/tripod/tripod_shout_1.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_2.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_3.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_4.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_5.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_6.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/tripod/tripod_shout_long_1.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_long_2.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_long_3.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_long_4.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_long_5.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_shout_long_6.ogg')
	)



#define TRIPOD_PASSIVE_1	"<h2>PASSIVE: Personal Space:</h2><br>\
The tripod needs room to manoeuvre. For each clear tile within 2 radius around it, the tripod gains bonus evasion, up to a maximum of 35 if standing in a completely open space."

#define TRIPOD_PASSIVE_2	"<h2>PASSIVE: Cadence:</h2><br>\
The tripod is capable of a great top speed, but its huge mass requires some time to start moving. Tripod gains bonus movespeed for each tile it moves in the same direction, up to double speed after moving 5 tiles.<br>\
This speed bonus is lost if you stop moving in a straight line"


#define TRIPOD_LEAP_DESC	"<h2>High Leap:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Damage: 10 radial + 10 cone</h3><br>\
<h3>Cooldown: 6 seconds</h3><br>\
The tripod's signature ability. Leaps high into the air and briefly out of view, before landing hard at the designated spot. <br>\
Deals a small amount of damage to victims in a 1 tile radius around the landing point, and additional damage+knockdown to a cone shaped area infront of the tripod as it lands"


#define TRIPOD_SWING_DESC 	"<h2>Arm Swing:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 3 seconds</h3><br>\
<h3>Damage: 20</h3><br>\
The Tripod swings one of its huge arms around in a vast arc, hitting mobs and objects infront of it. Swing deals good knockback and has a 3-tile range, however it has a few downsides:<br>\
-Arm swing hits around waist height, and thus will not hit mobs which are already lying on the floor<br>\
-With such a huge arm, precise aiming is impossible. When striking humans, arm swing will hit random bodyparts, not a specified location<br>\
-Arm swing does not have the force to break through obstacles. The attack will stop on hitting any dense object that blocks the swing.<br>\
-Friendly fire is fully active, be careful not to hit your fellow necromorphs!"

#define TRIPOD_TONGUE_DESC "<h2>Tongue Lash:</h2><br>\
<h3>Hotkey: Middle Click</h3><br>\
<h3>Cooldown: 6 seconds</h3><br>\
The tripod swings its tongue around quickly, slashing anyone caught in its path. Though not as powerful as an arm swing, <br>\
the tongue strikes much more quickly, can hit downed targets, and most importantly, auto-aims at nearby victims. In addition, the tongue is precise and can hit where you aim."

#define TRIPOD_DEATHKISS_DESC "<h2>Execution: Kiss of Death:</h2><br>\
<h3>Hotkey: Ctrl+Shift+Click</h3><br>\
<h3>Cooldown: 1 minute</h3><br>\
An elaborate finishing move performed on a downed victim. The tripod forces its tongue down the victim's throat, tearing their head off from inside, and ripping their body in two.<br>\
If performed successfully on a live crewman, it yields a bonus of 10kg biomass for the marker, "

/datum/species/necromorph/tripod/get_ability_descriptions()
	.= ""
	. += TRIPOD_PASSIVE_1
	. += "<hr>"
	. += TRIPOD_PASSIVE_2
	. += "<hr>"
	. += TRIPOD_LEAP_DESC
	. += "<hr>"
	. += TRIPOD_SWING_DESC
	. += "<hr>"
	. += TRIPOD_TONGUE_DESC
	. += "<hr>"
	. += TRIPOD_DEATHKISS_DESC

/*--------------------------------
	Organs
--------------------------------*/
/obj/item/organ/external/arm/tentacle/tripod_tongue
	name = "tongue"
	organ_tag = BP_HEAD
	icon_name = "tongue"
	retracted = TRUE
	parent_organ = BP_CHEST

//The tongue has a slithering noise for when it goes in and out
/obj/item/organ/external/arm/tentacle/tripod_tongue/retract()
	.=..()
	if (. && owner)
		var/tonguesound = pick(list('sound/effects/creatures/necromorph/tripod/tripod_tongue_extract_1.ogg',
		'sound/effects/creatures/necromorph/tripod/tripod_tongue_extract_2.ogg',
		'sound/effects/creatures/necromorph/tripod/tripod_tongue_extract_3.ogg'))
		playsound(owner, tonguesound, VOLUME_LOW, TRUE)

/obj/item/organ/external/arm/tentacle/tripod_tongue/extend()
	.=..()
	if (. && owner)
		var/tonguesound = pick(list('sound/effects/creatures/necromorph/tripod/tripod_tongue_extract_1.ogg',
		'sound/effects/creatures/necromorph/tripod/tripod_tongue_extract_2.ogg',
		'sound/effects/creatures/necromorph/tripod/tripod_tongue_extract_3.ogg'))
		playsound(owner, tonguesound, VOLUME_MID, TRUE)

/*--------------------------------
	Cadence
--------------------------------*/
/datum/species/necromorph/tripod/setup_movement(var/mob/living/carbon/human/H)
	.=..()
	set_extension(H, /datum/extension/cadence/tripod)



/datum/extension/cadence/tripod
	max_speed_buff = 2.5
	max_steps = 6


/*--------------------------------
	Evasion
--------------------------------*/
/datum/species/necromorph/tripod/setup_defense(var/mob/living/carbon/human/H)
	.=..()
	set_extension(H, /datum/extension/tripod_evasion)

/*
	Tripod punch, heavy damage, slow
*/
/datum/unarmed_attack/punch/tripod
	name = "Claw Strike"
	desc = "A modestly powerful punch that is cumbersome to use"
	delay = 20
	damage = 14
	airlock_force_power = 3
	airlock_force_speed = 1.5
	structure_damage_mult = 1.5	//Slightly annoys obstacles
	shredding = TRUE //Better environment interactions, even if not sharp
	edge = TRUE


/*--------------------------------
	Leap
--------------------------------*/
/mob/living/carbon/human/proc/tripod_leap(var/atom/target)
	set name = "High Leap"
	set desc = "Leaps to a target location, dealing damage around the landing point, and knockdown in a frontal cone"
	set category = "Abilities"

	.=high_leap_ability(target, windup_time = 0.8 SECOND, winddown_time = 0.8 SECOND, cooldown = 6 SECONDS, minimum_range = 3, travel_speed = 5.25)
	if(.)
		play_species_audio(src, SOUND_SHOUT, VOLUME_MID, 1, 2)

/datum/species/necromorph/tripod/high_leap_impact(var/mob/living/user, var/atom/target, var/distance, var/start_location)

	//We play a sound!
	var/sound_file = pick(list('sound/effects/impacts/hard_impact_1.ogg',
	'sound/effects/impacts/hard_impact_2.ogg',
	'sound/effects/impacts/low_impact_1.ogg',
	'sound/effects/impacts/low_impact_2.ogg'))
	playsound(user, sound_file, VOLUME_MID, TRUE)

	//The leap impact deals two burst of damage.

	//Firstly, to mobs within 1 tile of us
	new /obj/effect/effect/expanding_circle(user.loc, -0.65, 0.5 SECONDS)
	for (var/mob/living/L in range(1, user))
		if (L == user)
			continue

		shake_camera(src,8,2)

		L.take_overall_damage(LEAP_SHOCKWAVE_DAMAGE)

	var/vector2/direction = Vector2.DirectionBetween(start_location, get_turf(user))

	var/conehit = FALSE

	//Secondly, to mobs in a frontal cone
	var/matrix/rotation = direction.Rotation()
	new /obj/effect/effect/forceblast/tripod(user.loc, 0.65 SECOND, rotation)
	spawn(1.5)
		new /obj/effect/effect/forceblast/tripod(user.loc, 0.65 SECOND, rotation)
	spawn(3)
		new /obj/effect/effect/forceblast/tripod(user.loc, 0.75 SECOND, rotation)
	for (var/turf/T as anything in get_cone(user.loc, direction, 3, 80))
		for (var/mob/living/L in T)
			if (L == user)
				continue

			L.take_overall_damage(LEAP_CONE_DAMAGE)
			L.Weaken(LEAP_CONE_WEAKEN)
			shake_camera(src,10,3)
			conehit = TRUE

	if (conehit)
		//If we managed to hit any mob with the cone, we get rewarded with half cooldown on the leap
		var/datum/extension/high_leap/E = get_extension(user, /datum/extension/high_leap)
		if (E)
			E.cooldown = LEAP_REDUCED_COOLDOWN

	release_vector(direction)


/obj/effect/effect/forceblast/tripod
	color = "#EE0000"
	max_length = 4








/*--------------------------------
	Arm Swing
--------------------------------*/
/mob/living/carbon/human/proc/tripod_arm_swing(var/atom/target)
	set name = "Arm Swing"
	set desc = "Swings an arm in a wide radius"
	set category = "Abilities"


	if (!target)
		target = dir

	var/num_arms = 0
	var/selected_arm
	//Alright lets check our arm status first
	var/obj/item/organ/external/arm/left = get_organ(BP_L_ARM)
	var/obj/item/organ/external/arm/right = get_organ(BP_R_ARM)

	if (QDELETED(left) || left.is_stump() || left.retracted)
		left = null
	else
		num_arms++

	if (QDELETED(right) || right.is_stump() || right.retracted)
		right = null
	else
		num_arms++

	if (num_arms <= 0)
		to_chat(src, SPAN_DANGER("You have no arms to swing!"))
		return

	else if (num_arms == 1)
		if (left)
			selected_arm = BP_L_ARM
		else
			selected_arm = BP_R_ARM
	else
		//If we have both arms, then the user gets to choose which to swing based on their selected hand
		if (hand)
			selected_arm = BP_L_ARM
		else
			selected_arm = BP_R_ARM



	var/swing_dir = CLOCKWISE
	var/effect
	//Alright we have finally chosen what arm to swing with, what will that affect?
	if (selected_arm == BP_L_ARM)
		swing_dir = CLOCKWISE
		effect = /obj/effect/effect/swing/tripod_left
	else
		swing_dir = ANTICLOCKWISE
		effect = /obj/effect/effect/swing/tripod_right


	//Okay lets actually start the swing
	.=swing_attack(swing_type = /datum/extension/swing/tripod_arm,
	source = src,
	target = target,
	angle = 150,
	range = ARM_SWING_RANGE,
	duration = 0.85 SECOND,
	windup = 0.8 SECONDS,
	cooldown = 3.5 SECONDS,
	effect_type = effect,
	damage = 20,
	damage_flags = DAM_EDGE,
	stages = 8,
	swing_direction = swing_dir)

	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 2)
		spawn(0.8 SECONDS)
			var/sound_effect = pick(list('sound/effects/attacks/big_swoosh_1.ogg',
			'sound/effects/attacks/big_swoosh_2.ogg',
			'sound/effects/attacks/big_swoosh_3.ogg',))
			playsound(src, sound_effect, VOLUME_LOW, TRUE)




//Swing FX
/obj/effect/effect/swing/tripod_left
	icon_state = "tripod_left"
	default_scale = 1.65
	pass_flags = PASS_FLAG_TABLE | PASS_FLAG_FLYING

/obj/effect/effect/swing/tripod_right
	icon_state = "tripod_right"
	default_scale = 1.65
	pass_flags = PASS_FLAG_TABLE | PASS_FLAG_FLYING


//Extension subtype
/datum/extension/swing/tripod_arm
	base_type = /datum/extension/swing/tripod_arm
	var/limb_used
	precise = FALSE


//The arm swing may be terminated early by obstacles
/datum/extension/swing/tripod_arm/hit_turf(var/turf/T)
	var/timepercent = current_stage / stages
	var/range = get_dist(user, T)

	//To make it feel less janky, we'll only do this bumping effect if at least 30% of the swing has happened. So no being blocked right at the start
	//In addition we won't be blocked by things at the limit of our range
	if (timepercent > 0.3	&& range < ARM_SWING_RANGE)
		var/list/tocheck = list(T)
		tocheck += T.contents

		for (var/atom/A in tocheck)
			if (ismob(A))
				continue

			//If something solid in the turf would block us, we terminate the swing
			if (A.density)
				if (!A.CanPass(effect))	//We use the effect object as the collision tester
					A.shake_animation(60)
					to_chat(user, "Your arm bounces sharply off of [A]")
					playsound(A, "thud", VOLUME_LOUD, TRUE)
					//TODO: Sound here
					return FALSE

	.=..()


/datum/extension/swing/tripod_arm/hit_mob(var/mob/living/L)
	//We harmlessly swooce over lying targets
	if (L.lying)
		return FALSE
	.=..()
	if (.)
		//If we hit someone, we'll knock them away diagonally in the direction of our swing
		var/push_angle = 45
		if (swing_direction == ANTICLOCKWISE)
			push_angle *= -1

		var/vector2/push_direction = target_direction.Turn(push_angle)
		L.apply_impulse(push_direction, 200)
		release_vector(push_direction)

/datum/extension/swing/tripod_arm/windup_animation()
	var/vector2/back_offset = target_direction.Turn(180) * 16
	animate(user, pixel_x = user.pixel_x + back_offset.x, pixel_y = user.pixel_y + back_offset.y, easing = BACK_EASING, time = windup * 0.3)
	var/vector2/forward_offset = target_direction * 48
	animate(pixel_x = user.pixel_x + forward_offset.x, pixel_y = user.pixel_y + forward_offset.y, easing = QUAD_EASING, time = windup * 0.7)
	sleep(windup)

	switch (swing_direction)
		//Cache the limb used
		if (CLOCKWISE)
			limb_used = BP_L_ARM
		else
			limb_used = BP_R_ARM

	var/mob/living/carbon/human/H = user
	//We will temporarily retract the arm from the sprite
	var/obj/item/organ/external/E = H.get_organ(limb_used)
	if (E)
		E.retracted = TRUE
		H.update_body(TRUE)

	release_vector(back_offset)
	release_vector(forward_offset)


/datum/extension/swing/tripod_arm/setup_effect()
	.=..()
	//The parent code will move the effect object to the centre of our sprite, now we will offset it farther to the appropriate shoulder joint
	var/vector2/offset
	if (limb_used == BP_L_ARM)
		offset = LEFT_ARM_OFFSETS["[user.dir]"]
	else
		offset = RIGHT_ARM_OFFSETS["[user.dir]"]

	effect.pixel_x += offset.x
	effect.pixel_y += offset.y

/datum/extension/swing/tripod_arm/cleanup_effect()
	.=..()
	var/mob/living/carbon/human/H = user

	//Slide back to normal position
	animate(H, pixel_x = H.default_pixel_x, pixel_y = H.default_pixel_y, time = 5)
	//Put the arm back now
	var/obj/item/organ/external/E = H.get_organ(limb_used)
	if (E)
		E.retracted = FALSE
		H.update_body(TRUE)








/*--------------------------------
	Tongue Lash
--------------------------------*/
/mob/living/carbon/human/proc/tripod_tongue_lash(var/atom/target)
	set name = "Tongue Lash"
	set desc = "Your bladed tongue swings in a moderate arc around you, automatically seeking nearby victims"
	set category = "Abilities"

	//First of all, lets be sure we have the tongue organ
	var/obj/item/organ/external/arm/tentacle/tripod_tongue/E = get_organ(BP_HEAD)
	if (!istype(E) || E.is_stump())
		to_chat(src, SPAN_DANGER("You have no tongue to swing with!"))
		return


	//Alright lets find a nearby target
	var/list/possible_targets = get_valid_target(origin = src,
	radius = 2,
	valid_types = list(/mob/living),
	allied = list(src, FALSE),
	visualnet = null,
	require_corruption = FALSE,
	view_limit = TRUE,
	LOS_block = FALSE,
	num_required = 0,
	special_check = null)

	//If we found anything we'll use it.
	//Otherwise just aim at the clickpoint
	if (possible_targets.len)
		target = possible_targets[1]

	//If no clickpoint and no nearby mobs, just swing at the air infront of us
	if (!target)
		target = src.dir

	//Okay lets actually start the swing
	.=swing_attack(swing_type = /datum/extension/swing/tripod_tongue,
	source = src,
	target = target,
	angle = 120,
	range = 2,
	duration = 0.5 SECOND,
	windup = 0,
	cooldown = 6 SECONDS,
	effect_type = /obj/effect/effect/swing/tripod_tongue,
	damage = 18,
	damage_flags = DAM_EDGE | DAM_SHARP,
	stages = 4,
	swing_direction = pick(CLOCKWISE, ANTICLOCKWISE))


	var/sound_effect = pick(list('sound/effects/creatures/necromorph/tripod/tripod_tongue_lash_1.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_tongue_lash_2.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_tongue_lash_3.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_tongue_lash_4.ogg',
	'sound/effects/creatures/necromorph/tripod/tripod_tongue_lash_5.ogg'))
	playsound(src, sound_effect, VOLUME_MID, TRUE)

//Extension subtype
/datum/extension/swing/tripod_tongue
	base_type = /datum/extension/swing/tripod_tongue
	effect_cleanup_delay = 0.4 SECONDS
	precise = TRUE




/datum/extension/swing/tripod_tongue/setup_effect()
	.=..()
	//The parent code will move the effect object to the centre of our sprite, now we will offset it farther to the appropriate shoulder joint
	var/vector2/offset = TONGUE_OFFSETS["[user.dir]"]
	effect.pixel_x += offset.x
	effect.pixel_y += offset.y

/datum/extension/swing/tripod_tongue/cleanup_effect()
	.=..()
	//As the tongue swing ends, the tongue is extended as a targetable organ for a while
	var/obj/item/organ/external/arm/tentacle/tripod_tongue/E = user.get_organ(BP_HEAD)
	if (!istype(E) || E.is_stump())
		return
	E.extend_for(TONGUE_EXTEND_TIME)

//Tongue effect
/obj/effect/effect/swing/tripod_tongue
	icon_state = "tongue"
	default_scale = 1.5
	pass_flags = PASS_FLAG_TABLE | PASS_FLAG_FLYING

















/*--------------------------------
	The Kiss of Death
--------------------------------*/


/*
	The tripod's execution move.
		-Pins the target down with an impaling claw
		-Screams
		-Forces its huge tongue down the victim's throat (muting them at this point)
		-Pulls the tongue out rapidly, tearing the victim's head off (finisher stage)
		-Tear the victim in half at the waist (post finisher)

	Requires the target to be lying down in order to start
	Requires us to have the tongue and at least one arm intact
*/
/mob/living/carbon/human/proc/tripod_kiss(var/mob/living/carbon/human/target)
	set name = "Kiss of Death"
	set desc = "An elaborate multistage execution that rewards extra biomass on success"
	set category = "Abilities"

	if (!istype(target) || target.stat == DEAD || !target.lying)
		target = null
		var/list/possible_targets = get_valid_target(origin = src,
		radius = 1,
		valid_types = list(/mob/living/carbon/human),
		allied = list(src, FALSE),
		visualnet = null,
		require_corruption = FALSE,
		view_limit = TRUE,
		LOS_block = FALSE,
		num_required = 0,
		special_check = null)

		for (var/mob/living/carbon/human/H in possible_targets)
			if (H.stat == DEAD && H.lying)
				target = H
				break

		if (!target)
			return

	perform_execution(/datum/extension/execution/tripod_kiss, target)






/datum/extension/execution/tripod_kiss
	name = "Kiss of Death"
	base_type = /datum/extension/execution/tripod_kiss
	cooldown = 1 MINUTE

	reward_biomass = 10
	reward_energy = 150
	reward_heal = 40

	all_stages = list(/datum/execution_stage/tripod_claw_pin,
	/datum/execution_stage/tripod_scream,
	/datum/execution_stage/tripod_tongue_force,
	/datum/execution_stage/finisher/tripod_tongue_pull,
	/datum/execution_stage/tripod_bisect)


	vision_mod = -6


/datum/extension/execution/tripod_kiss/interrupt()
	.=..()
	user.play_species_audio(src, SOUND_PAIN, VOLUME_MID, 1, 2)

/datum/extension/execution/tripod_kiss/can_start()
	//Lets check that we have what we need

	//The victim must be lying on the floor
	if (!victim.lying)
		return FALSE

	//We need our tongue still attached
	var/obj/item/organ/external/tongue = user.get_organ(BP_HEAD)
	if (!LAZYLIMB(tongue))
		return FALSE

	//We require at least one arm intact
	var/obj/item/organ/external/arm/left = user.get_organ(BP_L_ARM)
	var/obj/item/organ/external/arm/right = user.get_organ(BP_R_ARM)
	if (!LAZYLIMB(left) && !LAZYLIMB(right))
		return FALSE

	.=..()

/datum/extension/execution/tripod_kiss/acquire_target()

	.=..()
	if (.)
		//We must face sideways to perform this move.
		if (victim.x > user.x)
			user.facedir(EAST)
		else
			user.facedir(WEST)

		//We extend our tongue indefinitely
		var/obj/item/organ/external/arm/tentacle/tripod_tongue/E = user.get_organ(BP_HEAD)
		if (!istype(E) || E.is_stump())
			return
		E.extend()


/datum/extension/execution/tripod_kiss/stop()
	.=..()
	//Once we're done, we'll retract the tongue after some time
	var/obj/item/organ/external/arm/tentacle/tripod_tongue/E = user.get_organ(BP_HEAD)
	if (!istype(E) || E.is_stump())
		return
	//We call extend_for even though its already extended, this will set a timer to retract it
	E.extend_for(TONGUE_EXTEND_TIME)





//Claw pin: Deals some heavy damage and stuns the victim
//----------------------------------------------------
/datum/execution_stage/tripod_claw_pin
	duration = 3 SECOND

	//Rises up into the air then comes down upon the victim fast
/datum/execution_stage/tripod_claw_pin/enter()
	animate(host.user, pixel_y = host.user.pixel_y + 16, time = duration * 0.7)
	animate(pixel_y = host.user.pixel_y - 18, time = duration * 0.3, easing = BACK_EASING)
	spawn(duration*0.9)

		//After a delay we must redo safety checks
		if (host.safety_check() == EXECUTION_CONTINUE)
			//Okay lets hit 'em
			host.victim.apply_damage(25, BRUTE, BP_GROIN, 0, DAM_SHARP, host.user)
			host.victim.Stun(8)
			host.victim.Weaken(8)	//Lets make sure they stay down
			host.user.visible_message(SPAN_EXECUTION("[host.user] impales [host.victim] through the groin with a vast claw, pinning them to the floor!"))
			playsound(host.victim, 'sound/weapons/slice.ogg', VOLUME_MID, 1)


/datum/execution_stage/tripod_claw_pin/interrupt()

	host.victim.stunned = 0
	host.victim.weakened = 0





//Scream: Just calls shout_long, no stun to self
//----------------------------------------------------
/datum/execution_stage/tripod_scream
	duration = 2 SECOND

/datum/execution_stage/tripod_scream/enter()
	host.user.do_shout(SOUND_SHOUT_LONG, FALSE)





//Tongue Force: Slowly forces the tongue into the victim's mouth
//Animation makes the user go down and tilt forward
//----------------------------------------------------
/datum/execution_stage/tripod_tongue_force
	duration = 5 SECOND

/datum/execution_stage/tripod_tongue_force/enter()
	//We will gradually tilt forward
	var/angle = 30
	if (host.user.dir & WEST)
		angle *= -1
	animate(host.user, pixel_y = host.user.pixel_y - 16, transform = turn(host.user.get_default_transform(), angle), time = duration)

	//You can't speak with a massive sword-like tongue down your throat
	host.victim.silent += 10

	host.user.visible_message(SPAN_EXECUTION("[host.user] starts forcing its tongue down [host.victim]'s throat!"))
	spawn(8)
		var/tonguesound = pick(list('sound/effects/creatures/necromorph/tripod/tripod_tongueforce_1.ogg',
		'sound/effects/creatures/necromorph/tripod/tripod_tongueforce_2.ogg',
		'sound/effects/creatures/necromorph/tripod/tripod_tongueforce_3.ogg'))
		playsound(host.victim, tonguesound, VOLUME_LOUD, TRUE)


/datum/execution_stage/tripod_tongue_force/interrupt()

	host.victim.silent =0

https://bigmemes.funnyjunk.com/pictures/Long+boi_073bf6_7722185.jpg


//Tongue Pull: Rips the tongue out sharply, victim's head is torn off
//Animation makes the user go down and tilt forward
//----------------------------------------------------
/datum/execution_stage/finisher/tripod_tongue_pull
	duration = 2 SECOND

/datum/execution_stage/finisher/tripod_tongue_pull/enter()
	var/angle = -55
	if (host.user.dir & WEST)
		angle *= -1

	//Swing back and up like a shampoo advert
	animate(host.user, pixel_y = host.user.pixel_y + 12, transform = turn(host.user.get_default_transform(), angle*0.3), time = 6, easing = BACK_EASING)
	animate(pixel_y = host.user.pixel_y + 12, transform = turn(host.user.get_default_transform(), angle*0.6), time = 6,)

	spawn(4)
		var/obj/item/organ/external/head = host.victim.get_organ(BP_HEAD)
		if (istype(head))
			head.droplimb(cutter = host.user)
			host.user.visible_message(SPAN_EXECUTION("[host.user] whips back, violently tearing [host.victim]'s head off!"))

			var/sound_effect = pick(list('sound/effects/organic/flesh_tear_1.ogg',
			'sound/effects/organic/flesh_tear_2.ogg',
			'sound/effects/organic/flesh_tear_3.ogg',))
			playsound(host.victim, sound_effect, VOLUME_MID, TRUE)



	.=..()




//Tongue Pull: Rips the tongue out sharply, victim's head is torn off
//Animation makes the user go down and tilt forward
//----------------------------------------------------
/datum/execution_stage/tripod_bisect
	duration = 5 SECOND

/datum/execution_stage/tripod_bisect/enter()
	var/x_offset = -48
	var/angle = 30
	if (host.user.dir & WEST)
		angle *= -1
		x_offset *= -1

	var/slamtime = 8
	//Slam down one last time
	animate(host.user, pixel_y = host.user.default_pixel_y - 8, transform = turn(host.user.get_default_transform(), angle*-0.2), time = slamtime, easing = BACK_EASING)
	animate(host.user, pixel_y = host.user.default_pixel_y - 8, transform = turn(host.user.get_default_transform(), angle*1.2), time = slamtime)

	//Pause briefly
	animate(time = 6)
	//And then pull back to tear off the lower body
	animate(pixel_x = host.user.pixel_x + x_offset, time = 10, easing = CIRCULAR_EASING)

	spawn(slamtime+6)
		if (host.safety_check() == EXECUTION_CONTINUE)
			var/obj/item/organ/external/groin = host.victim.get_organ(BP_GROIN)
			if (istype(groin))
				groin.droplimb(cutter = host.user)
				host.user.visible_message(SPAN_EXECUTION("[host.user] drags its massive claw backwards, brutally tearing [host.victim] in half!"))
				var/sound_effect = pick(list('sound/effects/organic/flesh_tear_1.ogg',
				'sound/effects/organic/flesh_tear_2.ogg',
				'sound/effects/organic/flesh_tear_3.ogg',))
				playsound(host.victim, sound_effect, VOLUME_HIGH, TRUE)

/datum/species/necromorph/tripod/make_scary(mob/living/carbon/human/H)
	//H.set_traumatic_sight(TRUE, 5) //All necrmorphs are scary. Some are more scary than others though








#undef LEAP_SHOCKWAVE_DAMAGE
#undef LEAP_CONE_DAMAGE
#undef LEAP_CONE_WEAKEN
#undef LEAP_REDUCED_COOLDOWN
#undef TONGUE_EXTEND_TIME

#undef LEFT_ARM_OFFSETS
#undef RIGHT_ARM_OFFSETS
#undef TONGUE_OFFSETS