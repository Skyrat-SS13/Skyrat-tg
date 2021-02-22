/datum/species/necromorph/divider
	name = SPECIES_NECROMORPH_DIVIDER
	name_plural =  "Dividers"
	mob_type = /mob/living/carbon/human/necromorph/divider
	blurb = "A bizarre walking horrorshow, slow but extremely durable. On death, it splits into five smaller creatures, in an attempt to find a new body to control. The divider is hard to kill, and has several abilities which excel at pinning down a lone target."
	unarmed_types = list(/datum/unarmed_attack/claws/strong/divider)
	total_health = 225
	biomass = 150
	mass = 120
	limb_health_factor = 1.0

	evasion = -10	//Slow and predictable

	override_limb_types = list(

	)
	has_limbs = list(
	BP_HEAD =  list("path" = /obj/item/organ/external/head/simple/divider, "height" = new /vector2(2,2.4)),
	BP_CHEST =  list("path" = /obj/item/organ/external/chest/simple/divider, "height" = new /vector2(1,2)),
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/simple/divider, "height" = new /vector2(0.8,2)),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/simple/divider, "height" = new /vector2(0.8,2)),
	BP_L_LEG =  list("path" = /obj/item/organ/external/leg/simple/divider, "height" = new /vector2(0,1)),
	BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/simple/divider, "height" = new /vector2(0,1))
	)

	view_range = 9//The world looks small from up here

	biomass_reclamation_time	=	12 MINUTES

	icon_template = 'icons/mob/necromorph/divider.dmi'
	icon_lying = null
	lying_rotation = 90
	pixel_offset_x = -8
	single_icon = FALSE
	spawner_spawnable = FALSE


	slowdown = 5.5

	//hud_type = /datum/hud_data/necromorph/divider


	species_audio = list(
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/divider/divider_attack_1.ogg',
	'sound/effects/creatures/necromorph/divider/divider_attack_2.ogg',
	'sound/effects/creatures/necromorph/divider/divider_attack_3.ogg'),
	SOUND_DEATH = list('sound/effects/creatures/necromorph/divider/divider_death.ogg'),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/divider/divider_pain_1.ogg',
	'sound/effects/creatures/necromorph/divider/divider_pain_2.ogg',
	'sound/effects/creatures/necromorph/divider/divider_pain_3.ogg'),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/divider/divider_shout_1.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_2.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_3.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_4.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/divider/divider_shout_long_1.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_2.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_3.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_4.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_5.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_6.ogg'),
	SOUND_SPEECH = list('sound/effects/creatures/necromorph/divider/divider_shout_long_1.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_2.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_3.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_4.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_5.ogg',
	'sound/effects/creatures/necromorph/divider/divider_shout_long_6.ogg')
	)//Since it has so many of them and no speech sounds, the divider uses its long shouts for speech


	species_audio_volume = list(SOUND_SHOUT_LONG = VOLUME_MAX, SOUND_SPEECH = VOLUME_HIGH, SOUND_SHOUT = VOLUME_MID)

	slowdown = 3.5

	inherent_verbs = list(/mob/living/carbon/human/proc/divider_divide, /mob/living/carbon/human/proc/divider_tongue, /mob/living/carbon/human/proc/divider_arm_swing, /mob/proc/shout, /mob/proc/shout_long)
	modifier_verbs = list(KEY_CTRLSHIFT = list(/mob/living/carbon/human/proc/divider_divide),
	KEY_CTRLALT = list(/mob/living/carbon/human/proc/divider_tongue),
	KEY_ALT = list(/mob/living/carbon/human/proc/divider_arm_swing))

#define LEFT_ARM_OFFSETS	list("[NORTH]" = new /vector2(-64, -10), "[SOUTH]" = new /vector2(-16, -10), "[EAST]" = new /vector2(-36, -14), "[WEST]" = new /vector2(-36, -14))
#define RIGHT_ARM_OFFSETS	list("[NORTH]" = new /vector2(-28, -10), "[SOUTH]" = new /vector2(-48, -10), "[EAST]" = new /vector2(-40, -14), "[WEST]" = new /vector2(-36,-14))


#define DIVIDER_PASSIVE_1	"<h2>PASSIVE: Gestalt Being:</h2><br>\
The divider is a colony of smaller creatures working in tandem. <br>\
On death, dismemberment, or manual division, it will split off into its component parts - five in total.<br>\
The original player will control the head component, while four other players will be drawn from the necroqueue to control the arms and legs."

#define DIVIDER_PASSIVE_2	"<h2>PASSIVE: Strange Anatomy:</h2><br>\
The divider has a tiny head atop its huge frame, and its torso has a sizeable hole in it. <br>\
This means that these parts of its body are comparitively much harder to hit with projectile attacks"

#define DIVIDER_PASSIVE_3	"<h2>PASSIVE: Momentum:</h2><br>\
The divider is slow and ponderous to start, building up speed over ten tiles. At full speed it will scream at nearby humans."

#define DIVIDER_SWING_DESC 	"<h2>Swipe:</h2><br>\
<h3>Hotkey: Alt+Click </h3><br>\
<h3>Cooldown: 3.5 seconds</h3><br>\
<h3>Damage: 15</h3><br>\
The divider swings one of its clawed arms in a wide arc, dealing moderate damage over a small area. Effective in close combat, as well as being very quick to use."


#define DIVIDER_TONGUE_DESC 	"<h2>Execution: Tonguetacle:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 12 seconds</h3><br>\
The divider launches its ropelike prehensile tongue, attempting to latch onto a victim.<br>\
 If it hits a standing humanoid, it will wrap around their neck, rooting them in place as it slowly garottes their throat.<br>\
  The tongue will deal damage over time until it completely severs the neck and decapitates the victim, but it can be interrupted if the divider is knocked down, decapitated, or the tongue itself takes enough damage.<br>\
  <br>\
  The tongue is vulnerable to blades and takes double damage from edged weapons.<br>\
  Tonguetacle is best used on a lone victim who is trying to escape, it is fairly easy for teammates to break them out of it if they aren't alone."

#define DIVIDER_COMPONENTS 	"<h2>Components:</h2><br>\
On death, dismemberment or manual splitting, the divider seperates into five smaller creatures. Two arms, two legs, and one head. <br>\
All of these have a basic attack and a leap ability, though the leap is quite different for each.<br>\
The goal of the head is to find a new host body to support itself. The arms and legs are servants, they exist to distract and weaken victims to draw attention from the head."

#define DIVIDER_ARM_DESC 	"<h2>Arm</h2><br>\
<h3>Basic Attack: Scratch: 2-4 dmg </h3><br>\
<h3>Passive: Wallrun</h3><br>\
<h3>Leap Ability: Parasite Grip (Alt+Click)</h3><br>\
The arm's leap ability will cause it to cling onto any human it hits, and start repeatedly attacking them. Each attack deals minor damage, and heals itself, though not targeting any specific bodypart.<br>\
In addition, each attack causes the victim to stagger around, disrupting their aim and view. Makes a great distraction!"

#define DIVIDER_LEG_DESC 	"<h2>Leg</h2><br>\
<h3>Basic Attack: Kick: 3-6 dmg </h3><br>\
<h3>Passive: Faster movespeed and lower leap cooldown</h3><br>\
<h3>Leap Ability: Dropkick (Alt+Click)</h3><br>\
The leg's leap ability hits hard, staggering the victim and dealing 15 damage. The leg bounces off the victim, allowing it to quickly circle around for another hit. This can be aimed, and it's possible to smash limbs off your victim."

#define DIVIDER_HEAD_DESC 	"<h2>Head</h2><br>\
<h3>Basic Attack: Whip: 4-6 dmg </h3><br>\
<br>\
<h3>Leap Ability: Hostile Takeover (Alt+Click)</h3><br>\
Requires a standing, live human victim. The head's leap starts an execution move, slowly strangling the victim until their neck is completely severed. Then it will wrap its tentacles around the spine and take control of the new host body.<br>\
Hostile Takeover cannot be cancelled once started, it's do or die.<br>\
If successful, the marker is awarded bonus biomass!<br>\
<h3>Alternate Ability: Reanimate (Ctrl+Alt+Click)</h3><br>\
Reanimate can be used to take control of any already-headless corpse on the ground. This is safe and easy, but does not give any extra rewards"



/datum/species/necromorph/divider/get_ability_descriptions()
	.= ""
	. += DIVIDER_PASSIVE_1
	. += "<hr>"
	. += DIVIDER_PASSIVE_2
	. += "<hr>"
	. += DIVIDER_PASSIVE_3
	. += "<hr>"
	. += DIVIDER_SWING_DESC
	. += "<hr>"
	. += DIVIDER_TONGUE_DESC
	. += "<hr>"
	. += "<hr>"
	. += DIVIDER_COMPONENTS
	. += "<hr>"
	. += DIVIDER_ARM_DESC
	. += "<hr>"
	. += DIVIDER_LEG_DESC
	. += "<hr>"
	. += DIVIDER_HEAD_DESC

/datum/unarmed_attack/claws/strong/divider
	airlock_force_power = 2.5
	armor_penetration = 5

/*
	Division
*/
/mob/living/carbon/human/proc/divider_divide()
	set category = "Abilities"
	set name = "Divide"

	if (stat == DEAD)
		return
	playsound(src, 'sound/effects/creatures/necromorph/divider/divider_split.ogg', VOLUME_LOUD, TRUE)
	facedir(SOUTH)
	root()

	//Fall over
	shake_animation(45)
	spawn(1.25 SECONDS)
		if (!lying)
			Weaken(99)
		shake_animation(45)
		sleep(0.75 SECONDS)

		var/datum/species/necromorph/divider/D = species
		if (istype(D))
			D.divide(src)

/datum/species/necromorph/divider/handle_amputated(var/mob/living/carbon/human/H, var/obj/item/organ/external/E, var/clean, var/disintegrate, var/ignore_children, var/silent)
	//If the limb is cut uncleanly with an edge, then its gonna fly, so we'll give it a window to finish flying then create the mob where it lands
	if (disintegrate == DROPLIMB_EDGE && !clean)
		spawn(20)
			if (!QDELETED(E))
				E.create_divider_component(H, deletion_delay = 0)
		return

	else if (!QDELETED(E))
		//If its a different type of cut, the limb is about to be deleted, we've got to get in there first, right now

		//We create the limb right here
		var/mob/living/L = E.create_divider_component(H, deletion_delay = 1 SECOND)

		//And then throw the newly created creature
		L.throw_at(pick(trange(3, H)), speed = (BASE_THROW_SPEED / 2))


/datum/species/necromorph/divider/handle_death(var/mob/living/carbon/human/H) //Handles any species-specific death events (such as dionaea nymph spawns).
	divide(H)
	.=..()


//Called on death or when using the ability manually. Disconnects all limbs
/datum/species/necromorph/divider/proc/divide(var/mob/living/carbon/human/H)
	H.facedir(SOUTH)
	for (var/limbtype in list(BP_HEAD, BP_L_ARM, BP_R_ARM, BP_L_LEG, BP_R_LEG))
		var/obj/item/organ/external/E = H.get_organ(limbtype)
		if (istype(E) && !E.is_stump())
			E.droplimb(TRUE, DROPLIMB_EDGE, FALSE, FALSE, H)



/*
	Movement
*/
/datum/species/necromorph/divider/setup_movement(var/mob/living/carbon/human/H)
	.=..()
	set_extension(H, /datum/extension/cadence/divider)

/datum/extension/cadence/divider
	max_speed_buff = 1
	max_steps = 10

/datum/extension/cadence/divider/max_speed_reached()
	var/turf/T = get_turf(user)
	if (user.check_audio_cooldown(SOUND_SHOUT) && T.is_seen_by_crew())
		user.play_species_audio(user,SOUND_SHOUT)
		user.set_audio_cooldown(SOUND_SHOUT, 12 SECONDS)

/*
	Limb Code
*/
/obj/item/organ/external
	var/divider_component_type = /mob/living/simple_animal/necromorph/divider_component/arm


/obj/item/organ/external/proc/create_divider_component(var/mob/living/carbon/human/H, var/deletion_delay = 0)
	if (!divider_component_type)
		return FALSE
	var/mob/living/simple_animal/necromorph/divider_component/L = new divider_component_type(get_turf(src))
	divider_component_type = null //This is an efficient way to mark that this organ has already been turned into a mob, and shouldn't do it again
	L.dna = dna


	//Turning into a component deletes the organ, but let it finish execution first, make it invisible in the meantime
	alpha = 0
	spawn(deletion_delay)
		if (!QDELETED(src))
			qdel(src)
	return L




/*
	The divider has a hole in its torso, harder to land hits
*/
/obj/item/organ/external/chest/simple/divider
	base_miss_chance = 35




/*--------------------------------
	Arm Swing
--------------------------------*/
/mob/living/carbon/human/proc/divider_arm_swing(var/atom/target)
	set name = "Swipe"
	set desc = "Swings an arm in a moderate radius"
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
		effect = /obj/effect/effect/swing/divider_left
	else
		swing_dir = ANTICLOCKWISE
		effect = /obj/effect/effect/swing/divider_right


	//Okay lets actually start the swing
	.=swing_attack(swing_type = /datum/extension/swing/divider_arm,
	source = src,
	target = target,
	angle = 130,
	range = 3,
	duration = 0.85 SECOND,
	windup = 0.4 SECONDS,
	cooldown = 3.5 SECONDS,
	effect_type = effect,
	damage = 20,
	damage_flags = DAM_EDGE,
	stages = 8,
	swing_direction = swing_dir)

	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 2)
		var/sound_effect = pick(list('sound/effects/attacks/big_swoosh_1.ogg',
		'sound/effects/attacks/big_swoosh_2.ogg',
		'sound/effects/attacks/big_swoosh_3.ogg',))
		playsound(src, sound_effect, VOLUME_LOW, TRUE)

/datum/extension/swing/divider_arm/windup_animation()
	var/vector2/back_offset = target_direction.Turn(180) * 16
	animate(user, pixel_x = user.pixel_x + back_offset.x, pixel_y = user.pixel_y + back_offset.y, easing = BACK_EASING, time = windup * 0.3)
	var/vector2/forward_offset = target_direction * 24
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


/datum/extension/swing/divider_arm/setup_effect()
	.=..()
	//The parent code will move the effect object to the centre of our sprite, now we will offset it farther to the appropriate shoulder joint
	var/vector2/offset
	if (limb_used == BP_L_ARM)
		offset = LEFT_ARM_OFFSETS["[user.dir]"]
	else
		offset = RIGHT_ARM_OFFSETS["[user.dir]"]

	effect.pixel_x += offset.x
	effect.pixel_y += offset.y

/datum/extension/swing/divider_arm/cleanup_effect()
	.=..()
	var/mob/living/carbon/human/H = user

	//Slide back to normal position
	animate(H, pixel_x = H.default_pixel_x, pixel_y = H.default_pixel_y, time = 5)
	//Put the arm back now
	var/obj/item/organ/external/E = H.get_organ(limb_used)
	if (E)
		E.retracted = FALSE
		H.update_body(TRUE)

//Swing FX
/obj/effect/effect/swing/divider_left
	icon_state = "divider_left"
	default_scale = 1
	pass_flags = PASS_FLAG_TABLE | PASS_FLAG_FLYING

/obj/effect/effect/swing/divider_right
	icon_state = "divider_right"
	default_scale = 1
	pass_flags = PASS_FLAG_TABLE | PASS_FLAG_FLYING


//Extension subtype
/datum/extension/swing/divider_arm
	base_type = /datum/extension/swing/divider_arm
	var/limb_used


#undef LEFT_ARM_OFFSETS
#undef RIGHT_ARM_OFFSETS