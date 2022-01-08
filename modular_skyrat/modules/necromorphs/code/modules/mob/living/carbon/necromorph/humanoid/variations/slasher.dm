/*
	Slasher variant, the most common necromorph. Has an additional pair of arms with scything blades on the end
*/

#define SLASHER_DODGE_EVASION	60
#define SLASHER_DODGE_DURATION	1.5 SECONDS

/mob/living/carbon/necromorph/humanoid/slasher
	name = "Slasher"
	icon = 'modular_skyrat/modules/necromorphs/icons/mob/necromorph/slasher.dmi'
	icon_state = "slasher_d"
//	varient = "slasher"
	bodyparts = list(
		/obj/item/bodypart/chest/necromorph,
		/obj/item/bodypart/head/necromorph,
		/obj/item/bodypart/l_arm/necromorph,
		/obj/item/bodypart/r_arm/necromorph,
		/obj/item/bodypart/r_leg/necromorph,
		/obj/item/bodypart/l_leg/necromorph,
		)




	/* GLOBAL_LIST_INIT(slasher, list(
	SOUND_ATTACK = list(list(
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_attack_1.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_attack_2.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_attack_3.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_attack_4.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_attack_5.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_attack_6.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_attack_7.ogg'), 100, 0)
	SOUND_DEATH = list(list(
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_death_1.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_death_2.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_death_3.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_death_4.ogg'), 100, 0)
	SOUND_PAIN = list(list(
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_pain_1.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_pain_2.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_pain_3.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_pain_4.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_pain_5.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_pain_6.ogg'), 100, 0)
	SOUND_SHOUT = list(list(
		'sound/effects/creatures/necromorph/slasher/slasher_shout_1.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_shout_2.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_shout_3.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_shout_4.ogg'), 100, 0)
	SOUND_SHOUT_LONG = list(list(
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_shout_long_1.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_shout_long_2.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_shout_long_3.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_shout_long_4.ogg'), 100, 0)
	SOUND_SPEECH = list(list(
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_speech_1.ogg',
		'/modular_skyrat/modules/necromorph/sound/effects/creatures/necromorph/slasher/slasher_speech_2.ogg'), 100, 0)
*/
