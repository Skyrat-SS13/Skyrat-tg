/*
	The hunter can be thought of as a mini ubermorph, It has some of the same powers, including regeneration,
	though generally to a lower degree

	The hunter is not completely immortal, but it is hard to kill. When its health is reduced to zero, it is simply stunned for
	a significant period, not killed.

	More advanced tactics are needed to kill it, There are three main ways:
		1. Fire. A certain total quantity of burn damage suffered (in addition to being at 0 health generally) will kill it.
			Any kind of burn damage counts for this purpose. Fire, explosions, acid, lasers, etc.

		2. Lasting damage: The hunter can build up lasting damage like any other necro. If it builds up enough to reduce its max HP to zero, then it will die

		3. Exile: Launch it into space, or otherwise off the map

*/
#define CUMULATIVE_BURN_DAMAGE	0.5
#define FAKEDEATH_HEAL_TIME	4 SECONDS
#define ARM_SWING_RANGE_HUNTER	3
/datum/species/necromorph/hunter
	name = SPECIES_NECROMORPH_HUNTER
	mob_type	=	/mob/living/carbon/human/necromorph/hunter
	name_plural =  "Hunters"
	blurb = "A rapidly regenerating vanguard, designed to lead the charge, suffer a glorious death, then get back up and do it again.\
	Avoid fire though."

	//Health and Defense
	total_health = 275
	torso_damage_mult = 0.5 //Hitting centre mass more fine for hunter
	can_obliterate = FALSE
	healing_factor = 4	//Minor constant healing
	burn_heal_factor = 0.15
	dismember_mult = 1
	biomass = 400
	require_total_biomass	=	BIOMASS_REQ_T3
	mass = 250
	limb_health_factor = 1	//Not as fragile as a slasher
	virus_immune = 1
	reach = 2


	icon_template = 'icons/mob/necromorph/hunter.dmi'
	single_icon = FALSE
	lying_rotation = 90
	icon_lying = null
	pixel_offset_x = -8
	layer = LARGE_MOB_LAYER

	unarmed_types = list(/datum/unarmed_attack/blades/strong, /datum/unarmed_attack/bite/strong) //Bite attack is a backup if blades are severed

	inherent_verbs = list(/mob/living/carbon/human/proc/hunter_regenerate, /mob/living/carbon/human/proc/hunter_hookblade, /mob/living/carbon/human/proc/hunter_taunt, /mob/proc/shout)
	modifier_verbs = list(KEY_ALT = list(/mob/living/carbon/human/proc/hunter_hookblade), KEY_CTRLALT = list(/mob/living/carbon/human/proc/hunter_taunt))


	override_limb_types = list(
	BP_HEAD =  /obj/item/organ/external/head/hunter
	)


	//Collision and bulk
	strength    = STR_VHIGH
	mob_size	= MOB_LARGE
	bump_flag 	= HEAVY	// What are we considered to be when bumped?
	push_flags 	= ALLMOBS	// What can we push?
	swap_flags 	= ALLMOBS	// What can we swap place with?
	evasion = -5	//Big target, easier to shoot

	slowdown = 4 //Modest speed, but he has no charge ability

	//Vision
	view_range = 8
	darksight_tint = DARKTINT_GOOD


	//Audio
	step_volume = VOLUME_MID //Brute stomps are low pitched and resonant, don't want them loud
	step_range = 3
	step_priority = 5
	pain_audio_threshold = 0.03 //Gotta set this low to compensate for his high health
	species_audio = list(SOUND_FOOTSTEP = list('sound/effects/footstep/ubermorph_footstep_1.ogg',
	'sound/effects/footstep/ubermorph_footstep_2.ogg',
	'sound/effects/footstep/ubermorph_footstep_3.ogg',
	'sound/effects/footstep/ubermorph_footstep_4.ogg'),
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_1.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_2.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_3.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_4.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_5.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_6.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_7.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_attack_8.ogg'),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_1.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_2.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_3.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_4.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_5.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_6.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_7.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_pain_8.ogg'),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_1.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_2.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_3.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_4.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_5.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_6.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_7.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_8.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_1.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_2.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_3.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_shout_long_4.ogg'),
	SOUND_SPEECH = list('sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_1.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_2.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_3.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_4.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_5.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_6.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_7.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_speech_8.ogg'),
	SOUND_REGEN = list('sound/effects/creatures/necromorph/ubermorph/ubermorph_regen_1.ogg',
	'sound/effects/creatures/necromorph/ubermorph/ubermorph_regen_2.ogg')
	)




#define HUNTER_PASSIVE	"<h2>PASSIVE: Pseudo Immortal:</h2><br>\
The Hunter cannot be killed by normal means. When its health is reduced to zero, it will not die, but instead just be stunned for a long while<br>\
It can regrow lost limbs, and even repair lasting damage if left alone<br>\
The hunter can only die when one of the following is true<br>\
	1. It sustains total burn damage greater than [CUMULATIVE_BURN_DAMAGE * 100]% of its max health.<br>\
	2. It sustains enough lasting damage to reduce its max health to nothing<br>\
	3. It is launched out of the map, off the edge of space<br>\
In addition, the Hunter passively regenerates 2 health per second."

#define HUNTER_PASSIVE_2	"<h2>PASSIVE: False Death:</h2><br>\
When the hunter's health drops to 0, it does not die, but instead falls unconscious for 15 seconds. <br>\
If it is still alive at the end of this time period, it immediately heals 100 damage, and regrows two missing limbs.<br>\
This effect has a cooldown of 2 minutes"

#define HUNTER_REGENERATE_DESC	"<h2>Regenerate:</h2><br>\
<h3>Cooldown: 30 seconds</h3><br>\
The Hunter starts shaking and screaming in pain, as it regrows a missing limb and heals 30 health, over a period of 8 seconds.<br>\
 This also heals 20 lasting damage. The hunter's regenerate is much less effective against burn damage, healing it at only 33% of the normal rate."


#define HUNTER_LUNGE_DESC	"<h2>Hookblade:</h2><br>\
<h3>Hotkey: Alt+Click </h3><br>\
The hunter springs forwards up to two tiles, and swings its claws in a wide arc. Any victims hit will suffer 15 damage, and be pulled in"


#define HUNTER_TAUNT_DESC "<h2>Taunt:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click</h3><br>\
<h3>Duration: up to 5 minutes</h3><br>\
<h3>Cooldown: 30 seconds</h3><br>\
With a bloody roar, the hunter draws attention of nearby foes, making it hard for them to focus on his allies. <br>\
The hunter himself recieves 15% incoming damage reduction and 20% bonus movespeed while taunt is active.<br>\
Other necromorphs he sees, instead gain 30% incoming damage reduction and 10% evasion.<br>\
This support buff is added and removed as necromorphs enter and leave his view, not just at the start.<br>\
<br>\
Taunt has a very long possible duration, but it will terminate early if the hunter is knocked down, or goes for six seconds without seeing an enemy stand against him."


/datum/species/necromorph/hunter/get_ability_descriptions()
	.= ""
	. += HUNTER_PASSIVE
	. += "<hr>"
	. += HUNTER_PASSIVE_2
	. += "<hr>"
	. += HUNTER_REGENERATE_DESC
	. += "<hr>"
	. += HUNTER_LUNGE_DESC
	. += "<hr>"
	. += HUNTER_TAUNT_DESC


/*
	Anatomy
*/
/obj/item/organ/external/head/hunter
	glowing_eyes = FALSE
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_HEALS_OVERKILL
	var/eye_icon = 'icons/mob/necromorph/hunter.dmi'

/obj/item/organ/external/head/hunter/replaced(var/mob/newowner)
	.=..()


	//Lets do a little animation for the eyes lighting up
	var/image/LR = image(eye_icon, newowner, "eyes_anim")
	LR.plane = EFFECTS_ABOVE_LIGHTING_PLANE
	LR.layer = EYE_GLOW_LAYER
	flick_overlay_source(LR, newowner, 3 SECONDS)

	//Activate the actual glow
	spawn(2.7 SECONDS)
		glowing_eyes = TRUE
		eye_icon_location = eye_icon
		owner.update_body(TRUE)




/*
	Hunter Abilities:
	1. Hookblade
		A small leap forward and aoe swipe. Humans hit suffer hefty damage and are pulled in


	2. Taunt
		Buffs all other nearby necros, giving them damage resistance and evasion, while you are marked in red.
		Effect is long lasting, but immediately ends if you're knocked down

*/




/*
	3. Regenerate
		Same as ubermorphs ability, but weaker and slower

*/
/mob/living/carbon/human/proc/hunter_regenerate()
	set name = "Regenerate"
	set category = "Abilities"
	set desc = "Regrows a missing limb and restores some of your health."

	.= regenerate_ability(subtype = /datum/extension/regenerate/hunter)
	if (.)
		play_species_audio(src, SOUND_PAIN, VOLUME_HIGH, 1, 3)

/datum/extension/regenerate/hunter
	cooldown = 30 SECONDS
	duration = 8 SECONDS
	lasting_damage_heal = 20
	heal_amount = 30
	burn_heal_mult = 0.33


/*
	Passive regen is triggered during false death
*/
/datum/extension/regenerate/hunter_passive
	duration = 8 SECONDS
	max_limbs = 5
	lasting_damage_heal = 35
	burn_heal_mult = 0.01
	heal_amount = 100




/*
	Immortality
*/
/datum/species/necromorph/hunter/get_weighted_total_limb_damage(var/mob/living/carbon/human/H, var/return_list)
	.=..()
	if (islist(.))
		.["burn"] = H.getFireLoss()


//Called when health reaches 0, but not actually dying
/mob/living/carbon/human/proc/false_death()
	if (can_false_death())
		set_extension(src, /datum/extension/false_death)
		play_species_audio(src, SOUND_DEATH, VOLUME_HIGH)


//Hunter has special death rules
/datum/species/necromorph/hunter/handle_death_check(var/mob/living/carbon/human/H)
	var/list/results = get_weighted_total_limb_damage(H, TRUE)

	//Is damage higher than our max health?
	if (results["damage"] >= H.max_health)

		//Lets check if we actually die

		//1. Enough total burn damage
		if (results["burn"] >= (H.max_health * CUMULATIVE_BURN_DAMAGE))
			return TRUE


		//2. Enough lasting damage
		if (H.getLastingDamage() >= H.max_health)
			return TRUE

		//If parent is true, health reached 0. That does not mean we die
		H.false_death()
		return FALSE



/*
	Hookblade
	A two part ability, starting off with a tiny charge, and then a swing at the end
*/
/mob/living/carbon/human/proc/hunter_hookblade(var/atom/A)
	set name = "Hookblade"
	set category = "Abilities"
	set desc = "A shortrange charge with a swing at the end, pulling in all enemies it hits. HK: Alt+Click:"

	//Check for an existing charge extension. that means a charge is already in progress or cooling down, don't repeat
	var/datum/extension/charge/EC = get_extension(src, /datum/extension/charge)
	if(istype(EC))
		if (EC.status == CHARGE_STATE_COOLDOWN)
			to_chat(src, "[EC.name] is cooling down. You can use it again in [EC.get_cooldown_time() /10] seconds")
			return
		to_chat(src, "You're already [EC.verb_name]!")
		return FALSE

	play_species_audio(src, SOUND_SHOUT, VOLUME_MID, 1, 3)
	//Ok we've passed all safety checks, let's commence charging!
	//We simply create the extension on the movable atom, and everything works from there

	//(var/datum/holder, var/atom/_target, var/_speed , var/_lifespan, var/_maxrange, var/_homing, var/_inertia = FALSE, var/_power, var/_cooldown, var/_delay)
	set_extension(src, /datum/extension/charge/lunge/hunter, A, 6, 2 SECONDS, 3, FALSE, FALSE, 1, 6 SECONDS, 0.25 SECONDS)

	return TRUE





/datum/extension/charge/lunge/hunter/peter_out_effects()

	var/mob/living/carbon/human/H = user
	spawn()
		H.hookblade_swing(target)

/datum/species/necromorph/hunter/charge_impact(var/datum/extension/charge/charge)
	var/mob/living/carbon/human/H = charge.user
	spawn()
		H.hookblade_swing(charge.target)







/*--------------------------------
	Arm Swing
--------------------------------*/

/mob/living/carbon/human/proc/hookblade_swing(var/atom/target)

	if (!target)
		target = dir

	//Okay lets actually start the swing
	.=swing_attack(swing_type = /datum/extension/swing/arm/hunter,
	source = src,
	target = target,
	angle = 150,
	range = ARM_SWING_RANGE_HUNTER,
	duration = 0.65 SECOND,
	windup = 0,
	cooldown = 0,//5 SECONDS, //TODO: Uncomment this
	damage = 12.5,
	damage_flags = DAM_EDGE,
	stages = 8)

	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 2)
		spawn(0.8 SECONDS)
			var/sound_effect = pick(list('sound/effects/attacks/big_swoosh_1.ogg',
			'sound/effects/attacks/big_swoosh_2.ogg',
			'sound/effects/attacks/big_swoosh_3.ogg',))
			playsound(src, sound_effect, VOLUME_LOW, TRUE)


//Extension subtype
/datum/extension/swing/arm/hunter
	base_type = /datum/extension/swing/arm/hunter
	precise = FALSE
	left = /obj/effect/effect/swing/hunter_left
	right = /obj/effect/effect/swing/hunter_right

	offsets_left = list(S_NORTH = new /vector2(-52, -12), S_SOUTH = new /vector2(-32, -16), S_EAST = new /vector2(-42, -14), S_WEST = new /vector2(-40, -10))
	offsets_right = list(S_NORTH = new /vector2(-36, -12), S_SOUTH = new /vector2(-56, -18), S_EAST = new /vector2(-42, -8), S_WEST = new /vector2(-46, -6))



//Swing FX
/obj/effect/effect/swing/hunter_left
	icon_state = "hunter_left"
	default_scale = 1


/obj/effect/effect/swing/hunter_right
	icon_state = "hunter_right"
	default_scale = 1


//At the end of the windup, just before we start, we'll set the user's density to false
/datum/extension/swing/arm/hunter/windup_animation()
	.=..()
	user.density = FALSE



/datum/extension/swing/arm/hunter/hit_mob(var/mob/living/L)
	.=..()
	if (.)
		//If we hit someone, we'll pull them in a direction which is generally towards us
		//Since our density is false, they can pass through us
		var/push_angle = rand_between(140, 220)

		var/vector2/push_direction = target_direction.Turn(push_angle)
		L.apply_impulse(push_direction, 200)
		release_vector(push_direction)


/datum/extension/swing/arm/hunter/cleanup_effect()
	.=..()

	var/mob/M = user
	//This will set our density back to what it ought to be
	spawn(15)
		M.update_lying_buckled_and_verb_status()




/*
	Taunt
	Provides a defensive buff to the hunter, and a larger one to his allies
*/
/mob/living/carbon/human/proc/hunter_taunt()
	set name = "Taunt"
	set category = "Abilities"
	set desc = "Provides a defensive buff to the hunter, and a larger one to his allies. HK: CtrlAlt+Click:"

	if (!can_taunt())
		return


	play_species_audio(src, SOUND_SHOUT_LONG, VOLUME_MAX, 1, 3)
	set_extension(src, /datum/extension/taunt)
	//Lets do some cool effects
	var/obj/effect/effect/expanding_circle/EC = new /obj/effect/effect/expanding_circle(loc, 1.5, 1.5 SECOND,"#ff0000")
	EC.pixel_y += 40	//Offset it so it appears to be at our mob's head
	spawn(4)
		EC = new /obj/effect/effect/expanding_circle(loc, 1.5, 1.5 SECOND,"#ff0000")
		EC.pixel_y += 40	//Offset it so it appears to be at our mob's head
		spawn(4)
			EC = new /obj/effect/effect/expanding_circle(loc, 1.5, 1.5 SECOND,"#ff0000")
			EC.pixel_y += 40	//Offset it so it appears to be at our mob's head

	return TRUE