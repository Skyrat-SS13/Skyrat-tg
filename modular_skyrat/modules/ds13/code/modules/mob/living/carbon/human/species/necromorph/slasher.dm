/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

#define SLASHER_DODGE_EVASION	60
#define SLASHER_DODGE_DURATION	1.5 SECONDS

/datum/species/necromorph/slasher
	name = SPECIES_NECROMORPH_SLASHER
	name_plural =  "Slashers"
	mob_type = /mob/living/carbon/human/necromorph/slasher
	blurb = "The frontline soldier of the necromorph horde. Slow when not charging, but its blade arms make for powerful melee attacks"
	unarmed_types = list(/datum/unarmed_attack/blades, /datum/unarmed_attack/bite/weak) //Bite attack is a backup if blades are severed
	total_health = 90
	biomass = 50
	mass = 70

	biomass_reclamation_time	=	7 MINUTES

	icon_template = '/modular_skyrat/modules/ds13/icons/mob/necromorph/slasher/fleshy.dmi'
	damage_mask = '/modular_skyrat/modules/ds13/icons/mob/necromorph/slasher/damage_mask.dmi'
	icon_lying = "_lying"
	pixel_offset_x = -8
	single_icon = FALSE
	evasion = 0	//No natural evasion
	spawner_spawnable = TRUE

	//Slashers hold their arms up in an overhead pose, so they override height too
	override_limb_types = list(
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/blade, "height" = new /vector2(1.6,2)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/blade/right, "height" = new /vector2(1.6,2))
	)

	hud_type = /datum/hud_data/necromorph/slasher


	species_audio = list(
	SOUND_ATTACK = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_attack_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_attack_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_attack_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_attack_4.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_attack_5.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_attack_6.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_attack_7.ogg'),
	SOUND_DEATH = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_death_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_death_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_death_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_death_4.ogg'),
	SOUND_PAIN = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_pain_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_pain_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_pain_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_pain_4.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_pain_5.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_pain_6.ogg'),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/slasher/slasher_shout_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_shout_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_shout_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_shout_4.ogg'),
	SOUND_SHOUT_LONG = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_shout_long_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_shout_long_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_shout_long_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_shout_long_4.ogg'),
	SOUND_SPEECH = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_speech_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher/slasher_speech_2.ogg')
	)

	slowdown = 3.5

	inherent_verbs = list(/atom/movable/proc/slasher_charge, /mob/living/proc/slasher_dodge, /mob/proc/shout)
	modifier_verbs = list(KEY_CTRLALT = list(/atom/movable/proc/slasher_charge),
	KEY_ALT = list(/mob/living/proc/slasher_dodge))

//slasher variants share a bodytype with the base slasher, same clothes fit all
/datum/species/necromorph/slasher/get_bodytype()
	return SPECIES_NECROMORPH_SLASHER


//Ancient version, formerly default, now uncommon
/datum/species/necromorph/slasher/desiccated
	name = SPECIES_NECROMORPH_SLASHER_DESICCATED
	icon_template = '/modular_skyrat/modules/ds13/icons/mob/necromorph/slasher/desiccated.dmi'
	marker_spawnable = FALSE
	preference_settable = FALSE



/*
	Blade Arm
*/
/obj/item/organ/external/arm/blade/slasher
	limb_height = new /vector2(1.6,2)	//Slashers hold their blade arms high

/obj/item/organ/external/arm/blade/slasher/right
	organ_tag = BP_R_ARM
	name = "right arm"
	icon_name = "r_arm"
	body_part = ARM_RIGHT
	joint = "right elbow"
	amputation_point = "right shoulder"





/*Roughly speaking, enhanced versions of necromorphs have:
	250% biomass cost and max health
	150% damage on attacks and abilites
	80% windup and cooldown times, move and attack delays
*/
/datum/species/necromorph/slasher/enhanced
	name = SPECIES_NECROMORPH_SLASHER_ENHANCED
	marker_spawnable = TRUE 	//Enable this once we have sprites for it
	mob_type = /mob/living/carbon/human/necromorph/slasher_enhanced
	unarmed_types = list(/datum/unarmed_attack/blades/strong, /datum/unarmed_attack/bite/strong)
	total_health = 225
	slowdown = 2.8
	biomass = 125
	view_range = 8
	mass = 120
	mob_size	= MOB_LARGE
	bump_flag 	= HEAVY
	spawner_spawnable = FALSE


	icon_template = '/modular_skyrat/modules/ds13/icons/mob/necromorph/slasher_enhanced.dmi'
	icon_lying = "_lying"
	//lying_rotation = 90

	biomass_reclamation_time	=	11 MINUTES

	limb_health_factor = 1.75

	inherent_verbs = list(/atom/movable/proc/slasher_charge_enhanced, /mob/living/proc/slasher_dodge_enhanced, /mob/proc/shout, /mob/proc/shout_long)
	modifier_verbs = list(KEY_CTRLALT = list(/atom/movable/proc/slasher_charge_enhanced),
	KEY_ALT = list(/mob/living/proc/slasher_dodge_enhanced))


	override_limb_types = list(
	BP_HEAD =  /obj/item/organ/external/head/simple/slasher_enhanced
	)

	species_audio = list(
	SOUND_ATTACK = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_4.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_5.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_6.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_7.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_8.ogg'),
	SOUND_DEATH = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_3.ogg'),
	SOUND_PAIN = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_4.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_5.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_extreme.ogg' = 0.2),
	SOUND_SHOUT = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_4.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_5.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_6.ogg'),
	SOUND_SHOUT_LONG = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_4.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_5.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_6.ogg'),
	SOUND_SPEECH = list('/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_1.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_2.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_3.ogg',
	'/modular_skyrat/modules/ds13/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_4.ogg')
	)



/* Unarmed attacks*/
/datum/unarmed_attack/blades
	name = "Scything blades"
	desc = "These colossal blades can cleave a man in half."
	attack_verb = list("slashed", "scythed", "cleaved")
	attack_noun = list("slash", "cut", "cleave", "chop", "stab")
	eye_attack_text = "impales"
	eye_attack_text_victim = "blade"
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	sharp = TRUE
	edge = TRUE
	shredding = TRUE
	damage = 16
	delay = 13
	airlock_force_power = 2
	armor_penetration = 5

#define SLASHER_CHARGE_DESC	"<h2>Charge:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 20 seconds</h3><br>\
The user screams for a few seconds, then runs towards the target at high speed. If they successfully hit the target, they deal two free melee attacks on impact.<br>\
Charge has some autoaim, clicking within 1 tile of a living mob is enough to target them. It will also attempt to home in on targets, but will not path around obstacles<br>\
If the user hits a solid obstacle while charging, they will be stunned and take some minor damage. The obstacle will also be hit hard, and destroyed in some cases. <br>\
<br>\
Charge is a great move to initiate a fight, or to damage obstacles blocking your path. If you manage to land that first hit on a human, it is devastating, and often fatal."


#define SLASHER_DODGE_DESC "<h2>Dodge:</h2><br>\
<h3>Hotkey: Alt+Click</h3><br>\
<h3>Cooldown: 6 seconds</h3><br>\
A simple trick, dodge causes the user to leap one tile to the side, and gain a large but brief bonus to evasion, making them almost impossible to hit.<br>\
The evasion bonus only lasts 1.5 seconds, so it's best used while an enemy is already firing at you. <br>\

Dodge is a skill that requires careful timing, but if used correctly, it can allow you to assault an entrenched firing line, and get close enough to land a few hits."

/datum/species/necromorph/slasher/get_ability_descriptions()
	.= ""
	. += SLASHER_CHARGE_DESC
	. += "<hr>"
	. += SLASHER_DODGE_DESC


//Can't slash things without arms
/datum/unarmed_attack/blades/is_usable(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target, var/zone)
	if(!user.has_organ(BP_R_ARM) && !user.has_organ(BP_L_ARM))
		return FALSE
	return TRUE

/datum/unarmed_attack/blades/strong
	damage = 24
	delay = 11
	airlock_force_power = 3
	armor_penetration = 10

/*
	Abilities
*/
/atom/movable/proc/slasher_charge(var/mob/living/A)
	set name = "Charge"
	set category = "Abilities"

	//Charge autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 2, src, 999)


	.= charge_attack(A, _delay = 1 SECONDS, _speed = 5.0, _lifespan = 6 SECONDS)
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


/atom/movable/proc/slasher_charge_enhanced(var/mob/living/A)
	set name = "Charge"
	set category = "Abilities"

	//Charge autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 2, src, 999)

	.= charge_attack(A, _delay = 0.75 SECONDS, _speed = 5.5, _lifespan = 6 SECONDS)
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


/mob/living/proc/slasher_dodge()
	set name = "Dodge"
	set category = "Abilities"


	.= dodge_ability(_duration = SLASHER_DODGE_DURATION, _cooldown = 6 SECONDS, _power = SLASHER_DODGE_EVASION)


/mob/living/proc/slasher_dodge_enhanced()
	set name = "Dodge"
	set category = "Abilities"


	.= dodge_ability(_duration = SLASHER_DODGE_DURATION, _cooldown = 5 SECONDS, _power = SLASHER_DODGE_EVASION*1.2)

/*
	Slashers have a special charge impact. Each of their blade arms gets a free hit on impact with the primary target
*/
/datum/species/necromorph/slasher/charge_impact(var/datum/extension/charge/charge)
	if (charge.last_target_type == CHARGE_TARGET_PRIMARY && isliving(charge.last_obstacle))
		var/mob/living/carbon/human/H = charge.user
		var/mob/living/L = charge.last_obstacle

		//We need to be in harm intent for this, set it if its not already
		if (H.a_intent != I_HURT)
			H.a_intent_change(I_HURT)

		//This is a bit of a hack because unarmed attacks are poorly coded:
			//We'll set the user's last attack to some time in the past so they can attack again
		if (H.has_organ(BP_R_ARM))
			H.last_attack = 0
			H.UnarmedAttack(L)

		if (H.has_organ(BP_L_ARM))
			H.last_attack = 0
			H.UnarmedAttack(L)
		return FALSE
	else
		return ..()






//Special death condition: Slashers die when they lose both blade arms
/datum/species/necromorph/slasher/handle_death_check(var/mob/living/carbon/human/H)
	.=..()
	if (!.)
		if (!H.has_organ(BP_L_ARM) && !H.has_organ(BP_R_ARM))
			return TRUE



#undef SLASHER_DODGE_EVASION
#undef SLASHER_DODGE_DURATION