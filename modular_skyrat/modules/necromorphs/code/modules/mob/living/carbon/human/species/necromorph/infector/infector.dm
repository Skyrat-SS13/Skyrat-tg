//These are used to position the arm sprite during swing
#define TONGUE_OFFSETS	list(S_NORTH = new /vector2(6, 16), S_SOUTH = new /vector2(-2, 8), S_EAST = new /vector2(26, 10), S_WEST = new /vector2(-14, 10))

#define	FLAP_MINIMUM_RANGE	3

#define FLAP_COOLDOWN	(3 SECONDS)
#define FLAP_SINGLE_WING_IMPAIRMENT	(0.4)

#define INFECTOR_STING_DAMAGE	9

/datum/species/necromorph/infector
	name = SPECIES_NECROMORPH_INFECTOR
	mob_type	=	/mob/living/carbon/human/necromorph/infector
	name_plural =  "Infectors"
	blurb = "A high value, fragile support, the Infector works as a builder and healer"
	total_health = 155

	//Normal necromorph flags plus no slip
	species_flags = SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_MINOR_CUT | SPECIES_FLAG_NO_POISON  | SPECIES_FLAG_NO_BLOCK | SPECIES_FLAG_NO_SLIP
	stability = 2


	icon_template = 'icons/mob/necromorph/infector.dmi'
	icon_lying = "_lying"
	pixel_offset_x = -4
	single_icon = FALSE
	//health_doll_offset	= 56


	biomass = 150
	require_total_biomass	=	BIOMASS_REQ_T2
	mass = 30
	biomass_reclamation_time	=	15 MINUTES
	marker_spawnable = TRUE


	//Collision and bulk
	strength    = STR_LOW
	mob_size	= MOB_MEDIUM
	bump_flag 	= SIMPLE_ANIMAL	// Quadrupedal and physically weak
	push_flags 	= ALLMOBS	// What can we push?
	swap_flags 	= ALLMOBS	// What can we swap place with?
	can_pull_mobs = MOB_PULL_SMALLER
	can_pull_size = ITEM_SIZE_NORMAL
	evasion = 10
	reach = 2



	inherent_verbs = list(/mob/living/carbon/human/proc/infector_flap,
	/mob/living/carbon/human/proc/infector_sting,
	/mob/living/carbon/human/proc/infector_execution,
	/mob/living/carbon/human/proc/select_essence_ability,
	/mob/living/carbon/human/proc/use_selected_essence_ability,
	/mob/proc/shout,/mob/proc/shout_long)

	modifier_verbs = list(
	KEY_CTRLALT = list(/mob/living/carbon/human/proc/use_selected_essence_ability),
	KEY_ALT = list(/mob/living/carbon/human/proc/infector_flap),
	KEY_MIDDLE = list(/mob/living/carbon/human/proc/infector_sting),
	KEY_CTRLSHIFT = list(/mob/living/carbon/human/proc/infector_execution))


	unarmed_types = list(/datum/unarmed_attack/proboscis)

	slowdown = 5.5 //Note, this is a terribly awful way to do speed, bay's entire speed code needs redesigned

	//Vision
	view_range = 10


	has_limbs = list(BP_CHEST =  list("path" = /obj/item/organ/external/chest/simple, "height" = new /vector2(0, 2.5)),
	BP_HEAD = list("path" = /obj/item/organ/external/arm/tentacle/proboscis, "height" = new /vector2(1.5, 2.5)),	//The infector is tall and all of its limbs are too
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/wing, "height" = new /vector2(0, 2.0)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/wing, "height" = new /vector2(0, 2.0))
	)

	locomotion_limbs = list(BP_R_ARM, BP_L_ARM)

	grasping_limbs = list()	//It has no grasping limbs, it cannot grab or pull anything

	has_organ = list(    // which required-organ checks are conducted.
	BP_HEART =    /obj/item/organ/internal/heart/undead,
	BP_LUNGS =    /obj/item/organ/internal/lungs/undead,
	BP_BRAIN =    /obj/item/organ/internal/brain/undead/torso,
	BP_EYES =     /obj/item/organ/internal/eyes/torso
	)

	//Audio

	step_volume = VOLUME_QUIET //Infector stomps are low pitched and resonant, don't want them loud
	step_range = 4
	step_priority = 5
	pain_audio_threshold = 0.03 //Gotta set this low to compensate for his high health




	species_audio = list(SOUND_FOOTSTEP = list('sound/effects/footstep/infector_footstep_1.ogg',
	'sound/effects/footstep/infector_footstep_2.ogg',
	'sound/effects/footstep/infector_footstep_3.ogg',
	'sound/effects/footstep/infector_footstep_4.ogg'),
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/infector/infector_attack_1.ogg',
	'sound/effects/creatures/necromorph/infector/infector_attack_2.ogg',
	'sound/effects/creatures/necromorph/infector/infector_attack_3.ogg',
	'sound/effects/creatures/necromorph/infector/infector_attack_4.ogg',
	'sound/effects/creatures/necromorph/infector/infector_attack_5.ogg'),
	SOUND_DEATH = list('sound/effects/creatures/necromorph/infector/infector_death_1.ogg',
	'sound/effects/creatures/necromorph/infector/infector_death_2.ogg',
	'sound/effects/creatures/necromorph/infector/infector_death_3.ogg',
	'sound/effects/creatures/necromorph/infector/infector_death_4.ogg'),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/infector/infector_pain_1.ogg',
	 'sound/effects/creatures/necromorph/infector/infector_pain_2.ogg',
	 'sound/effects/creatures/necromorph/infector/infector_pain_3.ogg',
	 'sound/effects/creatures/necromorph/infector/infector_pain_4.ogg'),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/infector/infector_shout_1.ogg',
	'sound/effects/creatures/necromorph/infector/infector_shout_2.ogg',
	'sound/effects/creatures/necromorph/infector/infector_shout_3.ogg',
	'sound/effects/creatures/necromorph/infector/infector_shout_4.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/infector/infector_shout_long_1.ogg',
	'sound/effects/creatures/necromorph/infector/infector_shout_long_2.ogg',
	'sound/effects/creatures/necromorph/infector/infector_shout_long_3.ogg')
	)

	//HUD Handling
	hud_type = /datum/hud_data/necromorph/infector


#define INFECTOR_PASSIVE_1	"<h2>PASSIVE: Necrotoxin:</h2><br>\
The infector's attacks, both melee and ranged, inject the victim with Necrotoxin, which slowly deals damage over time. \n\
If this poison kills the victim, they will automatically be reanimated as a necromorph shortly after death. \n\
Note that this effect only happens if the victim slowly dies of poison, death by other causes will prevent it."

#define INFECTOR_PASSIVE_2	"<h2>PASSIVE: Essence:</h2><br>\
The infector stores up a special resource called Essence over time. This is used to trigger some of its special abilities. \n\
One point is generated per minute"





#define INFECTOR_FLAP_DESC 	"<h2>Flap:</h2><br>\
<h3>Hotkey: Alt+Click </h3><br>\
<h3>Cooldown: 3 seconds</h3><br>\
The Infector flaps its wings to generate lift, allowing it to get a short distance off the ground and glide towards the target point. \n\
This is much faster than walking around, though trickier to control. \n\
If one of its wings is missing, flap is penalised in accuracy and cooldown. If both wings are missing, this ability is disabled."

#define INFECTOR_STING_DESC "<h2>Venomous Sting:</h2><br>\
<h3>Hotkey: Middle Click</h3><br>\
<h3>Cooldown: 10 seconds</h3><br>\
The infector fires a quick spine, which applies necrotoxin on hit. Has a long cooldown between uses, as the infector is not a frontline combatant"

#define INFECTOR_PARASITE_DESC "<h2>Execution: Parasite Leap:</h2><br>\
<h3>Hotkey: Ctrl+Shift+Click</h3><br>\
<h3>Cooldown: 1 minute</h3><br>\
An elaborate finishing move performed on a standing victim. The infector wraps around the target, clinging on tight as it attempts to probe their skull.\n\
It will take some time to complete, depending on the victim's head protection, and the infector is very vulnerable to grappling while attempting this.\n\
If this technique is successful, not only will the victim be killed, but they will be immediately converted into a necromorph, with a higher chance to get more powerful options."

#define INFECTOR_ESSENCE_DESC	"<h2>Essence Ability:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
This hotkey combo activates your currently selected essence ability. These abilities consume Essence, a resource that recharges over time. Be sure to select it with the verb in the Necromorph tab first.\n\
Unless otherwise noted, all abilities are touch-range only, and can only affect something adjacent to you.\n\
\
\
\
<h3>Reanimate:</h3><br>\
Converts the target corpse into a randomly selected necromorph. Slashers are most common, but other options are possible depending on a variety of esoteric factors.\
Fresher, more intact corpses, of higher ranking crewmembers or antagonists, give better conversion results. A head is required.\
\
<h3>Mend:</h3><br>\
Repairs a target necromorph, consuming essence each second to restore their health\
\
<h3>Engorge:</h3><br>\
Makes the targeted necromorph larger, increasing its health, movespeed and view range. This effect is permanant but does not stack\
\
<h3>Forming:</h3><br>\
A series of abilities that use essence to create new corruption nodes. Only a small part of the cost is paid up front to start the construction\
The rest is paid over time while working on it. Other infectors can assist, spending their own essence.\
All of them except New Growth require corruption to build upon\
"

/datum/species/necromorph/infector/get_ability_descriptions()
	.= ""
	. += INFECTOR_PASSIVE_1
	. += "<hr>"
	. += INFECTOR_PASSIVE_2
	. += "<hr>"
	. += INFECTOR_FLAP_DESC
	. += "<hr>"
	. += INFECTOR_STING_DESC
	. += "<hr>"
	. += INFECTOR_PARASITE_DESC
	. += "<hr>"
	. += INFECTOR_ESSENCE_DESC

/*--------------------------------
	Organs
--------------------------------*/
/obj/item/organ/external/arm/tentacle/proboscis
	name = "proboscis"
	organ_tag = BP_HEAD
	icon_name = "proboscis"
	retracted = TRUE
	parent_organ = BP_CHEST
/*
//The tongue has a slithering noise for when it goes in and out
/obj/item/organ/external/arm/tentacle/proboscis/retract()
	.=..()
	if (. && owner)
		var/tonguesound = pick(list('sound/effects/creatures/necromorph/infector/proboscis_extract_1.ogg',
		'sound/effects/creatures/necromorph/infector/proboscis_extract_2.ogg',
		'sound/effects/creatures/necromorph/infector/proboscis_extract_3.ogg'))
		playsound(owner, tonguesound, VOLUME_LOW, TRUE)

/obj/item/organ/external/arm/tentacle/proboscis/extend()
	.=..()
	if (. && owner)
		var/tonguesound = pick(list('sound/effects/creatures/necromorph/infector/proboscis_extract_1.ogg',
		'sound/effects/creatures/necromorph/infector/proboscis_extract_2.ogg',
		'sound/effects/creatures/necromorph/infector/proboscis_extract_3.ogg'))
		playsound(owner, tonguesound, VOLUME_MID, TRUE)
*/
/obj/item/organ/external/arm/wing
	name = "left wing"
	icon_name = "l_wing"

/obj/item/organ/external/arm/right/wing
	name = "right wing"
	icon_name = "r_wing"

/*--------------------------------
	Proboscis Attack
--------------------------------*/
/datum/unarmed_attack/proboscis
	name = "Sting"
	desc = "Requires proboscis"
	attack_verb = list("stings", "injects", "probes", "thrusts into", "jabs")
	attack_noun = list("sting", "inject", "probe", "thrust", "proboscis", "jab")
	attack_sound = list('sound/effects/attacks/whip_1.ogg', 'sound/effects/attacks/whip_2.ogg','sound/effects/attacks/whip_3.ogg','sound/effects/attacks/whip_4.ogg',)

	damage = INFECTOR_STING_DAMAGE
	armor_penetration = 5
	delay = 4 SECONDS	//Long delay makes for low DPS, this is a hit and run thing

	required_limb = list(BP_HEAD)
	auto_extend = TRUE
	attack_sound = 'sound/weapons/slice.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	sharp = TRUE
	edge = FALSE

/datum/unarmed_attack/proboscis/execution
	//Special version of our unarmed attack only used during the execution move, not normally triggerable
	delay = 0
	difficulty = 30
	allow_dismemberment = FALSE

//This is only applied if the attack lands cleanly, and isnt blocked
/datum/unarmed_attack/proboscis/apply_effects(var/datum/strike/strike)
	.=..()
	inject_necrotoxin(strike.target, 5)


//This is a proc so it can be used in another place later
/proc/inject_necrotoxin(var/mob/living/L, var/quantity = 5)
	if (istype(L) && !(L.is_necromorph()))
		if (!L.reagents.has_reagent(/datum/reagent/toxin/necro))
			to_chat(L, "<span class='warning'>You feel a tiny prick.</span>")
		L.reagents.add_reagent(/datum/reagent/toxin/necro, quantity)




/*--------------------------------
	Venomous Sting
--------------------------------*/
/mob/living/carbon/human/proc/infector_sting(var/atom/A)
	set name = "Sting"
	set category = "Abilities"
	set desc = "A weak projectile which poisons the victim. HK: Alt+Click"

	face_atom(A)

	.= shoot_ability(/datum/extension/shoot/longshot/spine, A , /obj/item/projectile/bullet/spine/venomous, accuracy = 50, dispersion = 0, num = 1, windup_time = 0 SECONDS, fire_sound = null, cooldown = 10 SECONDS)
	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 3)

//Poisons the victim on impact but only if their armor didn't stop the hit
/obj/item/projectile/bullet/spine/venomous/on_hit(var/atom/target, var/blocked = 0, var/def_zone = null)
	if (isliving(target) && !blocked)
		inject_necrotoxin(target)
	. = ..()

/datum/extension/shoot/longshot/spine
	name = "Sting"
	base_type = /datum/extension/shoot/longshot/spine

/*--------------------------------
	Flap
--------------------------------*/

/mob/living/carbon/human/proc/infector_flap(var/atom/A)
	set name = "Flap"
	set category = "Abilities"


	var/mob/living/carbon/human/H = src

	if (!can_charge(A))
		return

	//The leaper can't flap if its missing too many wings. Specifically, it must have at least one, though there are penalties for not having both

	var/missing = 0
	if (!H.has_organ(BP_R_ARM))
		missing++

	if (!H.has_organ(BP_L_ARM))
		missing++


	var/cooldown = FLAP_COOLDOWN
	var/speed = 3.25

	if (missing >= 2)
		to_chat(src, SPAN_DANGER("You need at least one wing to flap!"))
		return
	else if (missing == 1)
		//Flapping with one wing is inaccurate and slower
		speed /= 1 + FLAP_SINGLE_WING_IMPAIRMENT
		cooldown	*= 1 + FLAP_SINGLE_WING_IMPAIRMENT
		//Target a random tile around the target
		if (prob(80))
			A = pick(trange(1, A))
		else
			A = pick(trange(2, A))

	//Do a chargeup animation. Pulls back and down, and then launches forwards
	//The time is equal to the windup time of the attack, plus 0.5 seconds to prevent a brief stop and ensure launching is a fluid motion
	var/vector2/pixel_offset = get_new_vector(0, -6)
	var/vector2/cached_pixels = get_new_vector(src.pixel_x, src.pixel_y)
	animate(src, pixel_x = src.pixel_x + pixel_offset.x, pixel_y = src.pixel_y + pixel_offset.y, time = 0.17 SECONDS, easing = EASE_OUT|CUBIC_EASING, flags = ANIMATION_PARALLEL)
	animate(pixel_x = cached_pixels.x, pixel_y = cached_pixels.y, easing = EASE_IN|CUBIC_EASING, time = 0.17 SECONDS)
	release_vector(pixel_offset)
	release_vector(cached_pixels)


	return leap_attack(A, subtype = /datum/extension/charge/leap/flap, _cooldown = cooldown, _delay = 0.3 SECONDS, _speed = speed, _maxrange = 9,_lifespan = 3 SECONDS)



/datum/extension/charge/leap/flap
	verb_action = "soars"
	verb_name = "flying"
	name = "Flap"
	mobile_windup = TRUE
	extra_pass_flags = (PASS_FLAG_TABLE | PASS_FLAG_FLYING | PASS_FLAG_NOMOB)
	wind_down_time = (0.25 SECONDS)


/datum/extension/charge/leap/flap/execution
	extra_pass_flags = (PASS_FLAG_TABLE | PASS_FLAG_FLYING)

/datum/extension/charge/leap/flap/start()
	playsound(user, pick(list('sound/effects/creatures/necromorph/infector/infector_flap_1.ogg',
	'sound/effects/creatures/necromorph/infector/infector_flap_2.ogg',
	'sound/effects/creatures/necromorph/infector/infector_flap_3.ogg',
	'sound/effects/creatures/necromorph/infector/infector_flap_4.ogg',
	'sound/effects/creatures/necromorph/infector/infector_flap_5.ogg')), VOLUME_MID, TRUE)
	.=..()

