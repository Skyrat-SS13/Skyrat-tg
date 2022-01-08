/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

#define SLASHER_DODGE_EVASION	60
#define SLASHER_DODGE_DURATION	1.5 SECONDS

/datum/species/necromorph/slasher
	name = SPECIES_NECROMORPH_SLASHER
	id = SPECIES_NECROMORPH_SLASHER
	can_have_genitals = FALSE
	say_mod = "hisses"
/*
	Slasher, Icon Controllers
*/

//	icon = 'modular_skyrat/modules/horrorform/icons/mob/animal.dmi'
//	icon_state = "horror"
//	icon_living = "horror"
//	icon_dead = "horror_dead"

	limbs_id = "slasher"
	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher.dmi'
	//body_position_pixel_x_offset = 0
	//body_position_pixel_y_offset = 0
//	icon_template = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
	//eyes_icon = 'modular_skyrat/master_files/icons/mob/species/vox_eyes.dmi'
//	limbs_icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher/fleshy.dmi'
//	mutant_bodyparts = list()

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
	attack_sound = 'sound/weapons/slice.ogg'
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


	//Slashers hold their arms up in an overhead pose, so they override height too
	mutant_bodyparts = list(
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/blade, "height" = new /vector2(1.6,2)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/blade/right, "height" = new /vector2(1.6,2))
	)


	species_audio = list(
	SOUND_ATTACK = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_attack_7.ogg'),
	SOUND_DEATH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_death_4.ogg'),
	SOUND_PAIN = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_pain_6.ogg'),
	SOUND_SHOUT = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_4.ogg'),
	SOUND_SHOUT_LONG = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_shout_long_4.ogg'),
	SOUND_SPEECH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_speech_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher/slasher_speech_2.ogg')
	)



/datum/species/necromorph/slasher/enhanced
	name = SPECIES_NECROMORPH_SLASHER_ENHANCED


	species_audio = list(
	SOUND_ATTACK = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_6.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_7.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_attack_8.ogg'),
	SOUND_DEATH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_death_3.ogg'),
	SOUND_PAIN = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_pain_extreme.ogg' = 0.2),
	SOUND_SHOUT = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_6.ogg'),
	SOUND_SHOUT_LONG = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_4.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_5.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_shout_long_6.ogg'),
	SOUND_SPEECH = list('modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_1.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_2.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_3.ogg',
	'modular_skyrat/modules/necromorphs/sound/effects/creatures/necromorph/slasher_enhanced/eslasher_speech_4.ogg')
	)

#define SLASHER_CHARGE_DESC	"<h2>Charge:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 20 seconds</h3><br>\
The user screams for a few seconds, then runs towards the target at high speed. If they successfully hit the target, they deal two free melee attacks on impact.<br>\
Charge has some autoaim, clicking within 1 tile of a living mob is enough to target them. It will also attempt to home in on targets, but will not path around obstacles<br>\
If the user hits a solid obstacle while charging, they will be stunned and take some minor damage. The obstacle will also be hit hard, and destroyed in some cases. <br>\
<br>\
Charge is a great move to initiate a fight, or to damage obstacles blocking your path. If you manage to land that first hit on a human, it is devastating, and often fatal."


#define SLASHER_DODGE_DESC "<h2>Dodge:</h2><br>\
<h3>Hotkey: Middle Mouse Click</h3><br>\
<h3>Cooldown: 6 seconds</h3><br>\
A simple trick, dodge causes the user to leap one tile to the side, and gain a large but brief bonus to evasion, making them almost impossible to hit.<br>\
The evasion bonus only lasts 1.5 seconds, so it's best used while an enemy is already firing at you. <br>\

Dodge is a skill that requires careful timing, but if used correctly, it can allow you to assault an entrenched firing line, and get close enough to land a few hits."

#define SLASHER_FEND_DESC "<h2>Fend:</h2><br>\
<h3>Hotkey: Alt+Click</h3><br>\
A toggleable ability, the slasher shields its body with its claws, trading off movespeed for defensive ability. Fend gives an active block that flatly reduces damage of hits\n\
The block chance is slightly random, but is most effective with melee attacks, aimed at the upper body, and from the front. If a blocked projectile is weak enough, it will bounce off\n\
Weak melee attacks will provoke a devastating counterattack instead.\n\
In addition, fend grants a 20% reduction to all incoming damage while active, but it halves your movespeed.\n\
Fend automatically cancels when you perform a charge or a melee attack. Dodge will not interrupt it though, and those two can be comboed together to approach enemies."

#undef SLASHER_DODGE_EVASION
#undef SLASHER_DODGE_DURATION
