/datum/species/necromorph/exploder/enhanced
	name = SPECIES_NECROMORPH_EXPLODER_ENHANCED
	name_plural =  "Enhanced Exploders"
	mob_type = /mob/living/carbon/human/necromorph/exploder/enhanced
	blurb = "An expendable suicide bomber, the exploder's sole purpose is to go out in a blaze of glory, and hopefully take a few people with it."
	unarmed_types = list(/datum/unarmed_attack/bite/weak/exploder) //Bite attack is a backup if blades are severed
	total_health = 235	//It has high health for the sake of making it a bit harder to destroy without targeting the pustule. Exploding the pustule is always an instakill
	limb_health_factor = 1.5
	require_total_biomass	=	BIOMASS_REQ_T2
	biomass = 165
	mass = 80
	view_range = 8

	variants = list(SPECIES_NECROMORPH_EXPLODER_ENHANCED = list(WEIGHT = 1),
	SPECIES_NECROMORPH_EXPLODER_ENHANCED_RIGHT = list(WEIGHT = 1))

	biomass_reclamation_time	=	5 MINUTES
	view_range = 6
	darksight_tint = DARKTINT_POOR

	icon_template = 'icons/mob/necromorph/exploder/exploder_enhanced.dmi'
	icon_lying = "_lying"
	pixel_offset_x = -8
	single_icon = FALSE
	evasion = 10	//Awkward movemetn makes it a tricky target
	spawner_spawnable = TRUE
	virus_immune = 1

	//Audio
	step_volume = VOLUME_MID
	step_range = 7	//We want to hear it coming
	step_priority = 3



	has_limbs = list(
	BP_CHEST =  list("path" = /obj/item/organ/external/chest/simple, "height" = new /vector2(1,1.65)),
	BP_HEAD =   list("path" = /obj/item/organ/external/head/simple, "height" = new /vector2(1.65,1.85)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/simple, "height" = new /vector2(0,1.60)),	//The exploder's right arm reaches the floor
	BP_L_ARM = 	list("path" = /obj/item/organ/external/exploder_pustule/enhanced, "height" = new /vector2(0,0.8)),
	BP_L_LEG =  list("path" = /obj/item/organ/external/leg/simple, "height" = new /vector2(0,1))
	)


	//The exploder has only one fused leg, but the right arm is also used to support movement
	locomotion_limbs = list(BP_R_ARM, BP_L_LEG)

	//Only one of the exploder's arms ends in a hand
	grasping_limbs = list(BP_R_ARM)



	slowdown = 3.5

	inherent_verbs = list(/atom/movable/proc/exploder_charge, /mob/living/carbon/human/proc/exploder_explode, /mob/proc/shout)
	modifier_verbs = list(KEY_CTRLALT = list(/atom/movable/proc/exploder_enhanced_charge),
	KEY_CTRLSHIFT = list(/mob/living/carbon/human/proc/exploder_explode))



#define EXPLODER_ENHANCED_PASSIVE	"<h2>PASSIVE: Burning Acid Pustule:</h2><br>\
The Exploder's arm is a massive pustule full of flammable chemicals, which can create a devastating explosion when triggered.<br>\
The surrounding area is showered in superheated acid and shards of bone, delivering hell to anything nearby. This has major friendly fire potential so be aware of your allies<br>\
The pustule is fairly fragile, and can be detonated by a fairly minor quantity of damage aimed at it, so it is vitally important to avoid gunfire while approaching enemies.<br>\
<br>\
The pustule does NOT automatically detonate on death, and if the exploder's left arm is severed, the pustule can fall off without exploding."

#define EXPLODER_ENHANCED_PASSIVE_2	"<h2>PASSIVE: Burning Lightbearer:</h2><br>\
The Exploder pustule glows brightly, providing a source of blood-red light all around him.<br>\
If the exploder successfully detonates its pustule, the area around where he died is revealed to necrovision for 30 seconds post-death."

#define EXPLODER_ENHANCED_CHARGE_DESC	"<h2>Charge:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 20 seconds</h3><br>\
The user screams for a few seconds, then runs towards the target at high speed, faster than a normal exploder. If they successfully hit a human, the explosive pustule detonates immediately.<br>\
A successful charge is the most effective and reliable way to detonate. It should be considered the prime goal of the exploder."


#define EXPLODER_ENHANCED_EXPLODE_DESC "<h2>Explode:</h2><br>\
<h3>Hotkey: Ctrl+Shift+Click</h3><br>\
The last resort. The exploder screams and shakes violently for 3 seconds, before detonating the pustule.<br>\
 This is quite telegraphed and it can give your victims time to back away before the explosion. Not the most ideal way to detonate, but it can be a viable backup if you fail to hit something with charge."

/datum/species/necromorph/exploder/enhanced/get_ability_descriptions()
	.= ""
	. += EXPLODER_ENHANCED_PASSIVE
	. += "<hr>"
	. += EXPLODER_ENHANCED_PASSIVE_2
	. += "<hr>"
	. += EXPLODER_ENHANCED_CHARGE_DESC
	. += "<hr>"
	. += EXPLODER_ENHANCED_EXPLODE_DESC


/datum/species/necromorph/exploder/enhanced/right

	name = SPECIES_NECROMORPH_EXPLODER_ENHANCED_RIGHT
	icon_template = 'icons/mob/necromorph/exploder/exploder_enhanced_right.dmi'
	NECROMORPH_VISUAL_VARIANT

	has_limbs = list(
	BP_CHEST =  list("path" = /obj/item/organ/external/chest/simple, "height" = new /vector2(1,1.65)),
	BP_HEAD =   list("path" = /obj/item/organ/external/head/simple, "height" = new /vector2(1.65,1.85)),
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/simple, "height" = new /vector2(0,1.60)),	//The exploder's right arm reaches the floor
	BP_R_ARM = 	list("path" = /obj/item/organ/external/exploder_pustule/enhanced/right, "height" = new /vector2(0,0.8)),
	BP_L_LEG =  list("path" = /obj/item/organ/external/leg/simple, "height" = new /vector2(0,1))
	)


//The enhanced pustule replaces a whole arm, not just a hand
/obj/item/organ/external/exploder_pustule/enhanced
	light_color = COLOR_MARKER_RED


/obj/item/organ/external/exploder_pustule/enhanced/right
	organ_tag = BP_R_ARM
	icon_name = "r_arm"
	body_part = ARM_RIGHT
	parent_organ = BP_CHEST
	joint = "right elbow"
	amputation_point = "right shoulder"
	best_direction	=	EAST

/*
	The actual explosion!
*/
//A multi-level explosion using a broad variety of cool mechanics
/obj/item/organ/external/exploder_pustule/enhanced/do_explode()
	var/turf/T = get_turf(src)
	var/target = pick(view(1, src))	//Pick literally anything as target, it doesnt matter. We just need something to avoid runtimes

	fragmentate(T, fragment_number = 50, spreading_range = 5, fragtypes=list(/obj/item/projectile/bullet/pellet/fragment/rivet))
	.=..()
	//True return means an explosion is happening
	spawn(1)

		T.spray_ability(subtype = /datum/extension/spray/flame/radial,  target = target, angle = 360, length = 4, duration = 2 SECONDS, extra_data = list("temperature" = (T0C + 2800)), affect_origin = TRUE)

	spawn(2)

		T.spray_ability(subtype = /datum/extension/spray/reagent,  target = target, angle = 360, length = 4, duration = 2 SECONDS, extra_data = list("reagent" = /datum/reagent/acid/necromorph, "volume" = 30), affect_origin = TRUE)











/atom/movable/proc/exploder_enhanced_charge(var/mob/living/A)
	set name = "Charge"
	set category = "Abilities"

	//Charge autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 1, src, 999)


	.= charge_attack(A, _delay = 1.2 SECONDS, _speed = 4, _lifespan = 6 SECONDS)
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