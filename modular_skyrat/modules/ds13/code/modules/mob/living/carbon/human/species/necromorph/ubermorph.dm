/datum/species/necromorph/ubermorph
	name = SPECIES_NECROMORPH_UBERMORPH
	mob_type	=	/mob/living/carbon/human/necromorph/ubermorph
	name_plural =  "Ubermorphs"
	blurb = "A juvenile hivemind. Constantly regenerating, a nigh-immortal leader of the necromorph army. "

	//Health and Defense
	total_health = INFINITY	//This number doesn't matter, it won't ever be used
	can_obliterate = FALSE
	healing_factor = 4	//Lots of constant healing
	biomass	=	3825	//Endgame, real expensive -- Lowered from 4500 to 3825 = 15% on 14/10/2020
	use_total_biomass = TRUE
	global_limit = 1
	mass = 130
	limb_health_factor = 1	//Not as fragile as a slasher
	virus_immune = 1
	reach = 2
	lasting_damage_factor = 0 //It regenerates this stuff away


	icon_template = 'icons/mob/necromorph/ubermorph.dmi'
	single_icon = FALSE
	lying_rotation = 90
	icon_lying = null//Ubermorph doesnt have a lying icon, due to complexity from regen animations
	pixel_offset_x = -16
	plane = LARGE_MOB_PLANE
	layer = LARGE_MOB_LAYER

	unarmed_types = list(/datum/unarmed_attack/claws/ubermorph, /datum/unarmed_attack/bite/strong) //Bite attack is a backup if blades are severed


	override_limb_types = list(
	BP_HEAD =  /obj/item/organ/external/head/ubermorph
	)


	//Collision and bulk
	strength    = STR_VHIGH
	mob_size	= MOB_LARGE
	bump_flag 	= HEAVY	// What are we considered to be when bumped?
	push_flags 	= ALLMOBS	// What can we push?
	swap_flags 	= ALLMOBS	// What can we swap place with?
	evasion = -5	//Big target, easier to shoot

	slowdown = 1.5 //Modest speed, but he has no charge ability

	//Vision
	view_range = 9
	darksight_tint = DARKTINT_EXCEPTIONAL	//It has psychic senses, can't hide in the dark


	//Audio
	step_volume = VOLUME_MID //Brute stomps are low pitched and resonant, don't want them loud
	step_range = 4
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

	inherent_verbs = list(/mob/living/carbon/human/proc/ubermorph_battlecry, /mob/living/carbon/human/proc/ubermorph_regenerate, /mob/living/carbon/human/proc/ubermorph_lunge, /mob/proc/shout, /mob/proc/sense_verb)
	modifier_verbs = list(KEY_CTRLALT = list(/mob/living/carbon/human/proc/ubermorph_battlecry), KEY_CTRLSHIFT = list(/mob/proc/sense_verb), KEY_ALT = list(/mob/living/carbon/human/proc/ubermorph_lunge))

#define UBERMORPH_PASSIVE	"<h2>PASSIVE: Immortal:</h2><br>\
The Ubermorph cannot be killed by any means. While it can be dismembered, those limbs can always grow back, and its chest can never be destroyed. <br>\
No amount of damage can finish it off, not even massive explosives can do the trick. Any damage dealt is just delaying the inevitable, ubermorph cannot die.<br>\
<br>\
In addition, the ubermorph passively regenerates 4 health per second."

#define UBERMORPH_REGENERATE_DESC	"<h2>Regenerate:</h2><br>\
The Ubermorph starts shaking and screaming in pain, as it regrows a missing limb and heals 40 health, over a period of 4 seconds. Even the head can be regrown."


#define UBERMORPH_LUNGE_DESC	"<h2>Lunge:</h2><br>\
<h3>Hotkey: Alt+Click </h3><br>\
The user rears back for half a second, then stabs forward up to two tiles, punching through any human in the way. The victim takes 30 brute damage, and also heavy damage to an internal organ.<br>\
Targeted at the chest or head, this will cause an injury that will usually result in inevitable death. It can also be used to deal heavy damage to obstacles, enabling doors and walls to be quickly broken down"


#define UBERMORPH_BATTLECRY_DESC "<h2>Battlecry:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click</h3><br>\
<h3>Cooldown: 30 seconds</h3><br>\
The ubermorph drives all nearby allies into a psychic frenzy, granting them a 30% increase to movespeed and attackspeed. Note that attackspeed affects cooldowns of attacks and abilities, and windup times on abilities.<br>\
This effect lasts for 60 seconds. Multiple applications will refresh the duration, but do not stack.<br>\
In addition, battlecry deals 15 damage to all visible enemies.<br>\
Battlecry is best used just before an assault to break the last of the human resistance. If things somehow go south, the damage effect can also be used to scare off people attempting to hold the ubermorph hostage by repeatedly dismembering it."

#define UBERMORPH_SENSE_DESC "<h2>Sense:</h2><br>\
<h3>Hotkey: Ctrl+Shift+Click</h3><br>\
<h3>Cooldown: 12 seconds</h3><br>\
The ubermorph sends out a psychic pulse, detecting all living beings in a radius of 9 tiles. Any humans detected in this matter will be shown onscreen, both to the ubermorph,and to any other nearby necromorphs.<br>\
Sense does not require line of sight, and it can detect people in other rooms, behind walls, in total darkness, or hiding inside objects, like lockers, morgue-drawers, vehicles, etc.<br>\
<br>\
Best used near the end, when all seems quiet, to help the necromorphs hunt down any last survivors that are trying to hide."


/datum/species/necromorph/ubermorph/get_ability_descriptions()
	.= ""
	. += UBERMORPH_PASSIVE
	. += "<hr>"
	. += UBERMORPH_REGENERATE_DESC
	. += "<hr>"
	. += UBERMORPH_LUNGE_DESC
	. += "<hr>"
	. += UBERMORPH_BATTLECRY_DESC
	. += "<hr>"
	. += UBERMORPH_SENSE_DESC

/datum/species/necromorph/ubermorph/get_healthstring()
	return "&#8734;"	//The ubermorph has infinite health, lets try to communicate that

/datum/species/necromorph/ubermorph/handle_death_check(var/mob/living/carbon/human/H)
	//No
	return FALSE

/*
	Basic attack isn't a huge deal, but its powerful anyway because endgame monster
*/
/datum/unarmed_attack/claws/ubermorph
	name = "Piercing talons"
	desc = "An impaling pair of spikes that can punch through flesh and steel."
	damage = 25
	airlock_force_power = 5
	airlock_force_speed = 2.5
	structure_damage_mult = 3	//Wrecks obstacles
	armor_penetration = 30	//No armor will protect you
	shredding = TRUE //Better environment interactions, even if not sharp

/*
	Regenerate
	Immobilises you for 4 seconds, healing a fair chunk of damage and regrowing a missing limb.
	No cooldown, can be used endlessly, can't be interrupted
	It can't be used again while in progress though, obviously
*/
/mob/living/carbon/human/proc/ubermorph_regenerate()
	set name = "Regenerate"
	set category = "Abilities"
	set desc = "Regrows a missing limb and restores some of your health."

	.= regenerate_ability(subtype = /datum/extension/regenerate, _duration = 4 SECONDS, _cooldown = 0)
	if (.)
		play_species_audio(src, SOUND_PAIN, VOLUME_HIGH, 1, 3)


/*
	Battle cry
	Drives necros into a frenzy, increasing their movement and attackspeed.

	Duration is far longer than cooldown, so it has 100% uptime as long as necros stay nearby
	Does not affect yourself, only other allies.
*/
/mob/living/carbon/human/proc/ubermorph_battlecry()
	set name = "Battle Cry"
	set category = "Abilities"
	set desc = "Grants a 30% move and attackspeed buff to other nearby necromorphs, damages non necromorphs. HK: Ctrl+Alt+Click"

	.=frenzy_shout_ability(60 SECONDS, 0.3, 30 SECONDS, FACTION_NECROMORPH, 9)
	if (.)
		play_species_audio(src, SOUND_SHOUT_LONG, VOLUME_MAX, 1, 6)//Very loud, heard far away
		shake_camera(src, 6, 4)

		for (var/mob/living/L in view(species.view_range, src))
			if (!L.is_necromorph() && L.stat != DEAD)
				L.take_overall_damage(15)

		//Lets do some cool effects
		var/obj/effect/effect/expanding_circle/EC = new /obj/effect/effect/expanding_circle(loc, 1.5, 1.5 SECOND,"#ff0000")
		EC.pixel_y += 40	//Offset it so it appears to be at our mob's head
		spawn(4)
			EC = new /obj/effect/effect/expanding_circle(loc, 1.5, 1.5 SECOND,"#ff0000")
			EC.pixel_y += 40	//Offset it so it appears to be at our mob's head
			spawn(4)
				EC = new /obj/effect/effect/expanding_circle(loc, 1.5, 1.5 SECOND,"#ff0000")
				EC.pixel_y += 40	//Offset it so it appears to be at our mob's head

/*
	Lunge: A variant of charge used by ubermorph. Short ranged
	On impact, it impales the victim, dealing heavy damage to both an external AND internal organ. It will probably prove fatal

	We completely replace the charge_attack proc, as we have different safety checks
*/
/mob/living/carbon/human/proc/ubermorph_lunge(var/atom/A)
	set name = "Lunge"
	set category = "Abilities"
	set desc = "A shortrange charge which causes heavy internal damage to one victim. Often fatal. HK: Alt+Click:"

	//Check for an existing charge extension. that means a charge is already in progress or cooling down, don't repeat
	var/datum/extension/charge/EC = get_extension(src, /datum/extension/charge)
	if(istype(EC))
		if (EC.status == CHARGE_STATE_COOLDOWN)
			to_chat(src, "[EC.name] is cooling down. You can use it again in [EC.get_cooldown_time() /10] seconds")
			return
		to_chat(src, "You're already [EC.verb_name]!")
		return FALSE

	//Charge autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 2, src, 999)

	var/dist = get_dist(src, A)
	if (dist < 1) //This is changed from <= , A distance of 1 is allowed
		to_chat(src, "You are too close to [A], get some distance first!")
		return FALSE

	if (!has_organ(BP_R_ARM) && !has_organ(BP_L_ARM))
		to_chat(src, SPAN_DANGER("You have no arms to impale [A] with!"))
		return FALSE

	play_species_audio(src, SOUND_SHOUT, VOLUME_MID, 1, 3)
	//Ok we've passed all safety checks, let's commence charging!
	//We simply create the extension on the movable atom, and everything works from there
	set_extension(src, /datum/extension/charge/lunge, A, 8, 2 SECONDS, 3, FALSE, TRUE, 1, 0, 0.5 SECONDS)

	return TRUE


//The impale
/datum/species/necromorph/ubermorph/charge_impact(var/datum/extension/charge/charge)
	var/mob/living/carbon/human/ubermorph = charge.user
	if (isliving(charge.last_obstacle))
		var/mob/living/L = charge.last_obstacle
		.=FALSE	//We won't keep charging after this
		var/targetstring = "[L.name]"


		if (ishuman(L))
			var/mob/living/carbon/human/H = L

			//Lets deal heavy damage to one external organ
			var/obj/item/organ/external/found_organ = H.find_target_organ(get_zone_sel(ubermorph))

			//Find target organ should never fail, we won't bother checking
			targetstring = "[H]'s [found_organ]"

			playsound(charge., 'sound/weapons/slice.ogg', VOLUME_MAX, 1)
			//Handle the external damage
			ubermorph.launch_strike(L, 30, ubermorph, damage_flags = DAM_SHARP, armor_penetration = 30)//Huge armor penetration to punch through resistance

			//Next, we will also deal damage to one internal organ within the target area, if such exists
			var/obj/item/organ/internal/I = safepick(found_organ.internal_organs)

			if (istype(I))
				I.take_internal_damage(30)	//Heavy damage to an internal organ is often fatal. Try surviving this!



		else
			//If its not human, just deal external damage
			ubermorph.launch_strike(L, 30, ubermorph, damage_flags = DAM_SHARP, armor_penetration = 30)

		ubermorph.Stun(3, TRUE) //User and victim are stunned for a few seconds, giving third parties an opportunity to flee
		L.Stun(3, TRUE)
		play_species_audio(ubermorph, SOUND_ATTACK, VOLUME_MID, 1, 3)
		ubermorph.visible_message(SPAN_DANGER("[ubermorph] punches through [targetstring] with an impaling claw"))

	else
		..()

/*
	Sense
*/
/mob/proc/sense_verb()
	set name = "Sense"
	set category = "Abilities"
	set desc = "Reveals nearby living creatures around you, to yourself and allies. HK: Ctrl+Shift+Click"
	var/datum/extension/sense/S = get_extension(src, /datum/extension/sense)
	if (S)
		return
	set_extension(src, /datum/extension/sense, 9, 9, FACTION_NECROMORPH, 9 SECONDS, 3 SECONDS)
	play_species_audio(src, SOUND_SPEECH, VOLUME_MID, 1, 3)

/datum/species/necromorph/ubermorph/make_scary(mob/living/carbon/human/H)
	//H.set_traumatic_sight(TRUE, 5) //All necrmorphs are scary. Some are more scary than others though