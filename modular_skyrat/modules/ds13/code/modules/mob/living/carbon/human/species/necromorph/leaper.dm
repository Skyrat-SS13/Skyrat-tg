/*
	Leaper

	Specialised ambush necromorph. Notable features:
		-Slow base movement speed and weak primary attacks
		-Very long vision radius
		-High evasion due to unusual posture
		-Leap attack allows rapid strike over long distances, flies over most intervening obstacles
		-Tail attack ability up close deals high damage
		-No legs. Uses arms and tail to move, can continue moving as long as at least one of the three remains
*/

/datum/species/necromorph/leaper
	name = SPECIES_NECROMORPH_LEAPER
	name_plural =  "Leapers"
	mob_type	=	/mob/living/carbon/human/necromorph/leaper
	blurb = "A long range ambusher, the leaper can leap on unsuspecting victims from afar, knock them down, and tear them apart with its bladed tail. Not good for prolonged combat though."
	unarmed_types = list(/datum/unarmed_attack/claws) //Bite attack is a backup if blades are severed
	total_health = 100
	biomass = 75

	//Normal necromorph flags plus no slip
	species_flags = SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_MINOR_CUT | SPECIES_FLAG_NO_POISON  | SPECIES_FLAG_NO_BLOCK | SPECIES_FLAG_NO_SLIP
	stability = 2

	icon_template = 'icons/mob/necromorph/leaper.dmi'
	icon_lying = "_lying"
	single_icon = FALSE
	spawner_spawnable = TRUE
	virus_immune = 1
	pixel_offset_x = -16

	evasion = 20	//Harder to hit than usual

	view_range = 9
	view_offset = (WORLD_ICON_SIZE*3)	//Can see much farther than usual

	darksight_tint = DARKTINT_GOOD

	has_limbs = list(
	BP_CHEST =  list("path" = /obj/item/organ/external/chest/simple),
	BP_HEAD =   list("path" = /obj/item/organ/external/head/simple),
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/simple),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/simple),
	BP_TAIL =  list("path" = /obj/item/organ/external/tail/leaper)
	)

	organ_substitutions = list(BP_L_LEG = BP_TAIL,
	BP_R_LEG = BP_TAIL,
	BP_L_FOOT = BP_TAIL,
	BP_R_FOOT = BP_TAIL)

	inherent_verbs = list(/atom/movable/proc/leaper_leap, /mob/living/carbon/human/proc/tailstrike_leaper, /mob/living/proc/leaper_gallop, /mob/proc/shout)
	modifier_verbs = list(KEY_CTRLALT = list(/atom/movable/proc/leaper_leap),
	KEY_CTRLSHIFT = list(/mob/living/proc/leaper_gallop),
	KEY_ALT = list(/mob/living/carbon/human/proc/tailstrike_leaper))

	slowdown = 4.5

	//Leaper has no legs, it moves with arms and tail
	locomotion_limbs = list(BP_R_ARM, BP_L_ARM, BP_TAIL)

	species_audio = list(SOUND_FOOTSTEP = list('sound/effects/footstep/leaper_footstep_1.ogg',
	'sound/effects/footstep/leaper_footstep_2.ogg',
	'sound/effects/footstep/leaper_footstep_3.ogg',
	'sound/effects/footstep/leaper_footstep_4.ogg',
	'sound/effects/footstep/leaper_footstep_5.ogg'),
	SOUND_CLIMB = list('sound/effects/footstep/wall_climb_1.ogg',
	'sound/effects/footstep/wall_climb_2.ogg',
	'sound/effects/footstep/wall_climb_3.ogg',
	'sound/effects/footstep/wall_climb_4.ogg',
	'sound/effects/footstep/wall_climb_5.ogg',
	'sound/effects/footstep/wall_climb_6.ogg'),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/leaper/leaper_pain_1.ogg',
	 'sound/effects/creatures/necromorph/leaper/leaper_pain_2.ogg',
	 'sound/effects/creatures/necromorph/leaper/leaper_pain_3.ogg',
	 'sound/effects/creatures/necromorph/leaper/leaper_pain_4.ogg',
	 'sound/effects/creatures/necromorph/leaper/leaper_pain_5.ogg',
	 'sound/effects/creatures/necromorph/leaper/leaper_pain_6.ogg',
	 'sound/effects/creatures/necromorph/leaper/leaper_pain_7.ogg'),
	SOUND_DEATH = list('sound/effects/creatures/necromorph/leaper/leaper_death_1.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_death_2.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_death_3.ogg'),
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/leaper/leaper_attack_1.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_attack_2.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_attack_3.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_attack_4.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_attack_5.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_attack_6.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_attack_7.ogg'),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/leaper/leaper_shout_1.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_shout_2.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_shout_3.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_shout_4.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_shout_5.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_shout_6.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/leaper/leaper_shout_long_1.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_shout_long_2.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_shout_long_3.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_shout_long_4.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_shout_long_5.ogg'),
	SOUND_SPEECH = list('sound/effects/creatures/necromorph/leaper/leaper_speech_1.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_speech_2.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_speech_3.ogg',
	'sound/effects/creatures/necromorph/leaper/leaper_speech_4.ogg')
	)

#define LEAPER_LEAP_DESC	"<h2>Leap:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 6 seconds</h3><br>\
The user screams for a few seconds, then leaps through the air towards the target at high speed. If they successfully hit the target, that target is knocked down, leaving them vulnerable to followup attacks.<br>\
Leap has some autoaim, clicking within 1 tile of a living mob is enough to target them. It will not home in on targets though, so you're in trouble if they move after you start.<br>\
While in the air, the leaper doesn't count as touching the ground, and will harmlessly soar over ground traps and barricades<br>\
If the user hits a solid obstacle while leaping, they will be knocked down and take some moderate damage. The obstacle will also be hit hard, and destroyed in some cases. <br>\
<br>\
Leap is best used to initiate a fight by ambushing an unaware opponent. Combined with the leaper's long vision range, you can jump on someone before they've even seen you, and catch them by surprise"


#define LEAPER_TAILSTRIKE_DESC "<h2>Tailstrike:</h2><br>\
<h3>Hotkey: Alt+Click</h3><br>\
<h3>Cooldown: 2.5 seconds</h3><br>\
The leaper stands on its arms, swinging its tail around over 0.75 seconds to deal a powerful hit to a target up to 2 tiles away.<br>\
Tailstrike hits hard, and can even destroy obstacles, but it is slow, heavily telegraphed, and easy to dodge. Very difficult to land on a target that won't stay still<br>\

Best used to finish off stunned/downed/injured victims, or for smashing a path through doors and terrain"

#define LEAPER_GALLOP_DESC "<h2>Gallop:</h2><br>\
<h3>Hotkey: Ctrl+Shift+Click</h3><br>\
<h3>Cooldown: 10 seconds</h3><br>\
The leaper breaks into a gallop, gaining a HUGE boost to speed for 4 seconds. During this time it briefly becomes the fastest of all necromorphs.<br>\
While galloping, the leaper is very vulnerable. Taking any damage, or bumping into any obstacles, will cause it to collapse and become stunned for a while<br>\

Gallop is great to use to follow up a Leap into battle, allowing you to quickly escape before your victim gets their bearings and hits you. <br>\
It can be used to chase down a fleeing opponent, to move along long hallways quickly, and it also allows the leaper to serve as a beast of burden, dragging corpses back faster than anyone else can."

/datum/species/necromorph/leaper/get_ability_descriptions()
	.= ""
	. += WALLRUN_DESC
	. += "<hr>"
	. += LEAPER_LEAP_DESC
	. += "<hr>"
	. += LEAPER_TAILSTRIKE_DESC
	. += "<hr>"
	. += LEAPER_GALLOP_DESC


/datum/species/necromorph/leaper/enhanced
	name = SPECIES_NECROMORPH_LEAPER_ENHANCED
	marker_spawnable = FALSE 	//Enable this once we have sprites for it
	mob_type	=	/mob/living/carbon/human/necromorph/leaper/enhanced
	unarmed_types = list(/datum/unarmed_attack/claws/strong)
	slowdown = 3
	total_health = 200
	evasion = 30

	biomass = 240
	biomass_reclamation = 0.75
	spawner_spawnable = FALSE

	inherent_verbs = list(/atom/movable/proc/leaper_leap_enhanced, /mob/living/carbon/human/proc/tailstrike_leaper_enhanced)
	modifier_verbs = list(KEY_CTRLALT = list(/atom/movable/proc/leaper_leap_enhanced),
	KEY_ALT = list(/mob/living/carbon/human/proc/tailstrike_leaper_enhanced))



//Light claw attack, not its main means of damage
/datum/unarmed_attack/claws/leaper
	damage = 7

/datum/unarmed_attack/claws/leaper/strong
	damage = 10.5 //Noninteger damage values are perfectly fine, contrary to popular belief


//The leaper has a tail instead of legs
/obj/item/organ/external/tail/leaper
	max_damage = 75
	min_broken_damage = 40
	throwforce = 30 //The leaper's tail makes an excellent weapon if thrown after severing
	edge = TRUE
	sharp = TRUE
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_STAND | ORGAN_FLAG_CAN_GRASP


//The leaper's arms are used for locomotion so they get the stand flag too
/obj/item/organ/external/arm/leaper
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_GRASP | ORGAN_FLAG_CAN_STAND

/obj/item/organ/external/arm/right/leaper
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_GRASP | ORGAN_FLAG_CAN_STAND



//Leap attack
/atom/movable/proc/leaper_leap(var/mob/living/A)
	set name = "Leap"
	set category = "Abilities"

	//Leap autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 2, src, 999)

	var/mob/living/carbon/human/H = src

	if (!H.can_charge(A))
		return

	//Do a chargeup animation. Pulls back and then launches forwards
	//The time is equal to the windup time of the attack, plus 0.5 seconds to prevent a brief stop and ensure launching is a fluid motion
	var/vector2/pixel_offset = Vector2.DirectionBetween(src, A) * -16
	var/vector2/cached_pixels = get_new_vector(src.pixel_x, src.pixel_y)
	animate(src, pixel_x = src.pixel_x + pixel_offset.x, pixel_y = src.pixel_y + pixel_offset.y, time = 1.5 SECONDS, easing = BACK_EASING, flags = ANIMATION_PARALLEL)
	animate(pixel_x = cached_pixels.x, pixel_y = cached_pixels.y, time = 0.3 SECONDS)
	release_vector(pixel_offset)
	release_vector(cached_pixels)
	//Long shout when targeting mobs, normal when targeting objects
	if (ismob(A))
		H.play_species_audio(H, SOUND_SHOUT_LONG, 100, 1, 3)
	else
		H.play_species_audio(H, SOUND_SHOUT, 100, 1, 3)

	return leap_attack(A, _cooldown = 6 SECONDS, _delay = 1.3 SECONDS, _speed = 7, _maxrange = 11,_lifespan = 8 SECONDS, _maxrange = 20)


/atom/movable/proc/leaper_leap_enhanced(var/mob/living/A)
	set name = "Leap"
	set category = "Abilities"

	//Leap autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 1, src, 999)

	var/mob/living/carbon/human/H = src

	//Do a chargeup animation
	var/vector2/pixel_offset = Vector2.DirectionBetween(src, A) * -16
	var/vector2/cached_pixels = get_new_vector(src.pixel_x, src.pixel_y)
	animate(src, pixel_x = src.pixel_x + pixel_offset.x, pixel_y = src.pixel_y + pixel_offset.y, time = 0.7 SECONDS, easing = BACK_EASING, flags = ANIMATION_PARALLEL)
	animate(pixel_x = cached_pixels.x, pixel_y = cached_pixels.y, time = 0.3 SECONDS)

	//Long shout when targeting mobs, normal when targeting objects
	if (ismob(A))
		H.play_species_audio(H, SOUND_SHOUT_LONG, 100, 1, 3)
	else
		H.play_species_audio(H, SOUND_SHOUT, 100, 1, 3)

	return leap_attack(A, _cooldown = 4 SECONDS, _delay = 1 SECONDS, _speed = 8, _maxrange = 11, _lifespan = 8 SECONDS, _maxrange = 20)


//Special effects for leaper impact, its pretty powerful if it lands on the primary target mob, but it backfires if it was blocked by anything else
/datum/species/necromorph/leaper/charge_impact(var/datum/extension/charge/leap/charge)
	.=..()	//We call the parent charge impact too, all the following effects are in addition to the default behaviour
	var/mob/living/carbon/human/H = charge.user
	shake_camera(charge.user,5,3)
	.=TRUE //We stop on the first hit either way
	//To be considered a success, we must leap onto a mob, and they must be the one we intended to hit
	if (isliving(charge.last_obstacle))
		var/mob/living/L = charge.last_obstacle
		L.Weaken(5) //Down they go!
		L.apply_damage(3*(charge.distance_travelled+1), used_weapon = charge.user) //We apply damage based on the distance. We add 1 to the distance because we're moving into their tile too
		shake_camera(L,5,3)
		//And lets also land ontop of them
		H.play_species_audio(H, SOUND_SHOUT, 100, 1, 3) //Victory scream
		.=FALSE
		spawn(2)
			H.Move(charge.last_obstacle.loc)
	else if (charge.last_obstacle.density)
	//If something else blocked our leap, or if we hit a dense object (even intentionally) we get pretty rattled
		H.Weaken(2)
		H.apply_damage(15, used_weapon = charge.last_obstacle) //ow
		H.play_species_audio(H, SOUND_PAIN, VOLUME_MID, 1, 3) //It huuurts
		.=FALSE


//Tailstrike attack
/mob/living/carbon/human/proc/tailstrike_leaper(var/atom/A)
	set name = "Tail Strike"
	set category = "Abilities"

	if (!A)
		A = get_step(src, dir)


	.=tailstrike_attack(A, _damage = 22.5, _windup_time = 0.75 SECONDS, _winddown_time = 1.2 SECONDS, _cooldown = 0.5)
	if (.)
		//The sound has a randomised delay
		spawn(rand_between(0, 2 SECONDS))
			play_species_audio(src, SOUND_ATTACK, 30, 1)


/mob/living/carbon/human/proc/tailstrike_leaper_enhanced(var/atom/A)
	set name = "Tail Strike"
	set category = "Abilities"

	if (!A)
		A = get_step(src, dir)

	//The sound has a randomised delay
	if(tailstrike_attack(A, _damage = 28, _windup_time = 0.6 SECONDS, _winddown_time = 1 SECONDS, _cooldown = 0))
		spawn(rand_between(0, 1.8 SECONDS))
			play_species_audio(src, SOUND_ATTACK, 30, 1)



//Gallop ability
/mob/living/proc/leaper_gallop()
	set name = "Gallop"
	set category = "Abilities"
	set desc = "Gives a huge burst of speed, but makes you vulnerable"
	var/mob/living/carbon/human/H = src
	if (!H.has_organ(BP_L_ARM) || !H.has_organ(BP_R_ARM) || !H.has_organ(BP_TAIL))
		to_chat(H, SPAN_WARNING("You require a tail and both arms to use this ability!"))
		return


	if (gallop_ability(_duration = 4 SECONDS, _cooldown = 10 SECONDS, _power = 3))
		H.play_species_audio(H, SOUND_SHOUT, VOLUME_MID, 1, 3)


//Wallrunning
/datum/species/necromorph/leaper/setup_movement(var/mob/living/carbon/human/H)
	set_extension(H, /datum/extension/wallrun)