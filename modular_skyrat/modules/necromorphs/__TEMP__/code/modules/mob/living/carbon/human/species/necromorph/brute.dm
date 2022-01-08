#define BRUTE_BIOBOMB_IMPACT_DAMAGE	12
#define BRUTE_BIOBOMB_BLAST_DAMAGE	30

/datum/species/necromorph/brute
	name = SPECIES_NECROMORPH_BRUTE
	mob_type	=	/mob/living/carbon/human/necromorph/brute
	name_plural =  "Brutes"
	blurb = "A powerful linebreaker and assault specialist, the brute can smash through almost any obstacle, and its tough frontal armor makes it perfect for assaulting entrenched positions. \n\
	Very vulnerable to flanking attacks"
	total_health = 500
	torso_damage_mult = 1 //Hitting centre mass is fine for brute

	//Normal necromorph flags plus no slip
	species_flags = SPECIES_FLAG_NO_PAIN | SPECIES_FLAG_NO_MINOR_CUT | SPECIES_FLAG_NO_POISON  | SPECIES_FLAG_NO_BLOCK | SPECIES_FLAG_NO_SLIP
	stability = 2

	icon_template = 'icons/mob/necromorph/brute.dmi'
	icon_normal = "brute-d"
	icon_lying = "brute-d-dead"//Temporary icon so its not invisible lying down
	icon_dead = "brute-d-dead"
	health_doll_offset	= 74

	pixel_offset_x = -16
	layer = LARGE_MOB_LAYER
	require_total_biomass	=	BIOMASS_REQ_T3
	biomass = 400
	mass = 250
	biomass_reclamation_time	=	15 MINUTES
	virus_immune = 1

	//Collision and bulk
	strength    = STR_VHIGH
	mob_size	= MOB_LARGE
	bump_flag 	= HEAVY	// What are we considered to be when bumped?
	push_flags 	= ALLMOBS	// What can we push?
	swap_flags 	= ALLMOBS	// What can we swap place with?
	density_lying = TRUE	//Chunky boi
	evasion = -15	//Big target, easier to shoot
	reach = 2

	//Implacable
	stun_mod = 0.5
	weaken_mod = 0.3
	paralysis_mod = 0.3

	//Big targets are less vulnerable to fire and explosions
	burn_mod = 0.85

	inherent_verbs = list(/atom/movable/proc/brute_charge, /atom/movable/proc/brute_slam, /atom/movable/proc/curl_verb, /mob/living/carbon/human/proc/biobomb, /mob/proc/shout)
	modifier_verbs = list(KEY_MIDDLE = list(/mob/living/carbon/human/proc/biobomb),
	KEY_CTRLALT = list(/atom/movable/proc/brute_charge),
	KEY_ALT = list(/atom/movable/proc/brute_slam),
	KEY_CTRLSHIFT = list(/atom/movable/proc/curl_verb))

	unarmed_types = list(/datum/unarmed_attack/punch/brute)

	slowdown = 5 //Note, this is a terribly awful way to do speed, bay's entire speed code needs redesigned
	slow_turning = TRUE		//Slow turning and limited clicks ensures he can't just 360quickscope someone who sneaked up behind
	limited_click_arc = 90

	//Vision
	view_range = 4
	view_offset = 3 * WORLD_ICON_SIZE

	//Brute Armor vars
	var/armor_front = 30	//Flat reduction applied to incoming damage within a 45 degree cone infront
	var/armor_flank = 20	//Flat reduction applied to incoming damage within a 90 degree cone infront. Doesnt stack with front
	var/curl_armor_mult = 1.5	//Multiplier applied to armor when we are curled up
	var/armor_coverage = 96 //What percentage of our body is covered by armor plating. 95 = 5% chance for hits to strike a weak spot


	has_limbs = list(
	BP_CHEST =  list("path" = /obj/item/organ/external/chest/giant),
	BP_GROIN =  list("path" = /obj/item/organ/external/groin/giant),
	BP_HEAD =   list("path" = /obj/item/organ/external/head/giant),
	BP_L_ARM =  list("path" = /obj/item/organ/external/arm/giant),
	BP_R_ARM =  list("path" = /obj/item/organ/external/arm/right/giant),
	BP_L_LEG =  list("path" = /obj/item/organ/external/leg/giant),
	BP_R_LEG =  list("path" = /obj/item/organ/external/leg/right/giant),
	BP_L_HAND = list("path" = /obj/item/organ/external/hand/giant),
	BP_R_HAND = list("path" = /obj/item/organ/external/hand/right/giant),
	BP_L_FOOT = list("path" = /obj/item/organ/external/foot/giant),
	BP_R_FOOT = list("path" = /obj/item/organ/external/foot/right/giant)
	)

	grasping_limbs = list(BP_R_HAND, BP_L_HAND)
	//Audio
	step_volume = 10 //Brute stomps are low pitched and resonant, don't want them loud
	step_range = 4
	step_priority = 5
	pain_audio_threshold = 0.03 //Gotta set this low to compensate for his high health
	species_audio = list(SOUND_FOOTSTEP = list('sound/effects/footstep/brute_step_1.ogg',
	'sound/effects/footstep/brute_step_2.ogg',
	'sound/effects/footstep/brute_step_3.ogg',
	'sound/effects/footstep/brute_step_4.ogg',
	'sound/effects/footstep/brute_step_5.ogg',
	'sound/effects/footstep/brute_step_6.ogg'),
	SOUND_PAIN = list('sound/effects/creatures/necromorph/brute/brute_pain_1.ogg',
	 'sound/effects/creatures/necromorph/brute/brute_pain_2.ogg',
	 'sound/effects/creatures/necromorph/brute/brute_pain_3.ogg',
	 'sound/effects/creatures/necromorph/brute/brute_pain_extreme.ogg' = 0.2),
	SOUND_DEATH = list('sound/effects/creatures/necromorph/brute/brute_death.ogg'),
	SOUND_ATTACK = list('sound/effects/creatures/necromorph/brute/brute_attack_1.ogg',
	'sound/effects/creatures/necromorph/brute/brute_attack_2.ogg',
	'sound/effects/creatures/necromorph/brute/brute_attack_3.ogg'),
	SOUND_SHOUT = list('sound/effects/creatures/necromorph/brute/brute_shout_1.ogg',
	'sound/effects/creatures/necromorph/brute/brute_shout_2.ogg',
	'sound/effects/creatures/necromorph/brute/brute_shout_3.ogg'),
	SOUND_SHOUT_LONG = list('sound/effects/creatures/necromorph/brute/brute_shout_long.ogg')
	)

	variants = list(SPECIES_NECROMORPH_BRUTE = list(WEIGHT = 1),
	SPECIES_NECROMORPH_BRUTE_FLESH = list(WEIGHT = 1))


#define BRUTE_PASSIVE_1	"<h2>PASSIVE: Tunnel Vision:</h2><br>\
The brute has extremely restricted vision, able only to see a few tiles infront of it, and none behind it. This makes it very vulnerable to flanking attacks. Keep the enemy infront of you!"

#define BRUTE_PASSIVE_2	"<h2>PASSIVE: Organic Plating:</h2><br>\
The brute's front and side are covered in tough armor, impenetrable to most light weapons. This armor has a 95% chance to intercept attacks, and blocks a flat 25 damage at the front, or 15 at the side.<br>\
Any projectiles completely blocked in this matter will ricochet off and possibly hit something else. Melee attackers will be stunned, opening them to a counter attack.<br>\
<br>\
The unarmored areas are extremely vulnerable, and there's no armor on the rear. Any hit that isn't caused by armor will send the brute into a forced curl for 5 seconds. This forcing effect has a 1 minute cooldown."


#define BRUTE_CHARGE_DESC	"<h2>Charge:</h2><br>\
<h3>Hotkey: Ctrl+Alt+Click </h3><br>\
<h3>Cooldown: 20 seconds</h3><br>\
The user screams for a few seconds, then starts barrelling towards the target at moderate speed. While charging, the brute will hit all mobs it passes near.<br>\
This charge has high momentum, and will keep going for a long time, or until stopped by an obstacle<br>\
If the user hits a solid obstacle while charging, they will be stunned and take some minor damage. The obstacle will also be hit hard, and destroyed in some cases. <br>\
<br>\
The brute's charge is a high risk move. If used correctly, it's like bowling people, allowing you to smash through a crowd and send them flying. But you will be stunned and vulnerable afterwards, and easily surrounded."


#define BRUTE_SLAM_DESC "<h2>Slam:</h2><br>\
<h3>Hotkey: Alt Click</h3><br>\
<h3>Cooldown: 8 seconds</h3><br>\
The brute's signature move. Slam causes the user to rear back over 1.25 seconds, and then smash down in a devastating hit. The resulting strike hits a 3x2 area of effect infront of the user.<br>\
Mobs hit by slam will take up to 40 damage depending on distance, and will be knocked down. This damage is doubled if the victim was already lying down when hit, making it an excellent finishing move<br>\
<br>\
Slam deals massive damage to any objects caught in its radius, making it an excellent obstacle-clearing ability. It will easily break through doors, barricades, machinery, girders, windows, etc. With repeated uses and some patience, you can even dig your way through solid walls, creating new paths<br>\
Slam is heavily telegraphed, and hard to land hits with. Don't count on reliably hitting humans with it if they have any space to dodge"

#define BRUTE_BOMB_DESC	"<h2>Bio-bomb:</h2><br>\
<h3>Hotkey: Middle Click </h3><br>\
<h3>Cooldown: 10 seconds</h3><br>\
The user rears back, and launches an organic explosive from their belly. Deals 10 damage on direct impact, and an additional variable damage (up to 25) in burn and acid over a small area of effect.<br>\
Biobomb is a weak, low risk poking and initiation ability, intended to force the enemy to charge at you. It can be used as a way to deal damage and slow down agile humans who keep at a distance. <br>\
It is certainly no use in close combat, and is generally easy to dodge due to being heavily telegraphed. Use it to force a fight up close, and then switch to your melee abilities for serious damage dealing."


#define BRUTE_CURL "<h2>Curl:</h2><br>\
<h3>Hotkey: Ctrl+Shift+Click</h3><br>\
The user curls up into a ball, attempting to shield their vulnerable parts from damage, but becoming unable to turn, move or attack. While curled up, the strength of the brute's organic armor is massively increased (75% more!) and its coverage is increased to 100%<br>\
This causes the brute to be practically invincible to attacks from the front and side, however the rear is still completely undefended.<br>\
Brute will be forced into a reflexive curl under certain circumstances, but it can also be used manually. With the right timing, you can tank an entire firing squad while they waste ammo and deal no damage to you, leaving them vulnerable for your allies to attack from another angle."

/datum/species/necromorph/brute/get_ability_descriptions()
	.= ""
	. += BRUTE_PASSIVE_1
	. += "<hr>"
	. += BRUTE_PASSIVE_2
	. += "<hr>"
	. += BRUTE_CHARGE_DESC
	. += "<hr>"
	. += BRUTE_SLAM_DESC
	. += "<hr>"
	. += BRUTE_BOMB_DESC
	. += "<hr>"
	. += BRUTE_CURL

/datum/species/necromorph/brute/fleshy
	name = SPECIES_NECROMORPH_BRUTE_FLESH
	icon_normal = "brute-f"
	icon_lying = "brute-f-dead"//Temporary icon so its not invisible lying down
	icon_dead = "brute-f-dead"
	mob_type = /mob/living/carbon/human/necromorph/bruteflesh

	NECROMORPH_VISUAL_VARIANT
/*
	Brute charge: Slower but more powerful due to mob size.
	Shorter windup time making it deadly at close range
	Inertia is enabled, it will keep going til it faceplants into a wall
	Unlike other mobs, the brute's charge has no autotargeting
*/
/atom/movable/proc/brute_charge(var/atom/A)
	set name = "Charge"
	set category = "Abilities"


	.= brute_charge_attack(A, _delay = 1.25 SECONDS, _speed = 4, _lifespan = 8 SECONDS, _inertia = TRUE)
	if (.)
		var/mob/living/carbon/human/H = src
		if (istype(H))
			H.face_atom(A)
			if (isliving(A) && prob(40)) //When we're charging a mob, sometimes do the long shout
				H.play_species_audio(H, SOUND_SHOUT_LONG, VOLUME_HIGH, 1, 5)
			else
				H.play_species_audio(H, SOUND_SHOUT, VOLUME_HIGH, 1, 5)
		shake_animation(50)


/atom/movable/proc/brute_slam(var/atom/A)
	set name = "Slam"
	set category = "Abilities"

	var/direction = get_dir(src, A)
	A = get_step(src, direction)


	if (!A)
		A = get_step(src, dir)


	.=slam_attack(A, _damage = 35, _power = 1, _cooldown = 8 SECONDS, _windup_time = 1.65 SECONDS)
	if (.)
		var/mob/living/carbon/human/H = src
		H.play_species_audio(H, SOUND_SHOUT, VOLUME_HIGH, 1, 3)





/*
	Brute punch, heavy damage, slow
*/
/datum/unarmed_attack/punch/brute
	name = "Heavy punch"
	desc = "A powerful punch that hits like a truck. Human-sized creatures will be sent flying and stunnned. Deals massive damage to airlocks and structures."
	delay = 25
	damage = 28
	airlock_force_power = 5
	airlock_force_speed = 2.5
	structure_damage_mult = 2.5	//Wrecks obstacles
	shredding = TRUE //Better environment interactions, even if not sharp

//Brute punch causes knockback on any mob smaller than itself
/datum/unarmed_attack/punch/brute/apply_effects(var/datum/strike/strike)
	if (istype(strike.target, /atom/movable))
		var/mob/living/carbon/human/user = strike.user
		var/atom/movable/AM = strike.target
		AM.apply_push_impulse_from(strike.user, user.mass, 0)
		return TRUE

	//Return parent as a fallback if something went wrong
	return ..()


/*
	Brute Armor
*/

//The brute takes less damage from front and side attacks.
/datum/species/necromorph/brute/handle_organ_external_damage(var/obj/item/organ/external/organ, brute, burn, damage_flags, used_weapon)
	//First of all, we need to figure out where the attack is coming from
	var/atom/source
	var/penetration = 0
	if (isatom(used_weapon))	//Its possible used weapon might be a string, useless to us

		source = get_turf(used_weapon)

		if (isitem(used_weapon))
			var/obj/item/I = used_weapon
			penetration = I.armor_penetration


	if (!source)
		return ..() //If we can't figure out where the attack came from, we'll just let it through

	//Now that we know where it came from, lets figure out who we are
	var/mob/living/L = organ.owner

	//If its a projectile inour turf, we'll check the turf it came from instead
	if (isprojectile(used_weapon))
		var/obj/item/projectile/P = used_weapon
		if (P.loc == L.loc)
			source = get_turf(P.last_loc)

	//Lastly, if the source is ourselves, or on the same tile as us, we'll let it through
	if (used_weapon == L || source == L.loc)
		return ..()

	//Now lets check if we're curled up
	var/curled = FALSE
	var/datum/extension/curl/E = get_extension(L, /datum/extension/curl)
	if(istype(E) && E.status == 2) //Status 2 is curled up
		curled = TRUE

	//Ok, how much can we take off this damage
	var/reduction = 0

	//First of all lets factor in the possibility of the hit striking a gap in our armor
	//Note: The gaps are covered up when curled
	if (curled || prob(armor_coverage))
		if (target_in_frontal_arc(L, source, 45)) //If its within 45 degrees, we use front armor
			reduction = armor_front
		else if (target_in_frontal_arc(L, source, 90)) //If its >45 but within 90, we use the weaker flank armor
			reduction = armor_flank

		if (curled)
			reduction *= curl_armor_mult

	//Armor penetration on attacks goes through the armor
	reduction -= penetration

	if (!reduction)
		//The target must be behind us or hit a gap, the attack will go through unhindered
		if(!curled && L.curl_ability(_automatic = TRUE, _force_time = 5 SECONDS))
			to_chat(L, SPAN_DANGER("You reflexively curl up in panic"))
		return ..()

	//Ok lets reduce that damage!
	//Brute first
	if (brute > 0)
		var/minus = min(reduction, brute)
		brute -= minus
		reduction -= minus
	//Then burn if theres any
	if (burn > 0 && reduction > 0)
		var/minus = min(reduction, burn)
		burn -= minus
		reduction -= minus

	//Now lets see if we got it all
	if (burn <= 0 && brute <= 0)
		//We blocked it! Lets do any effects related to bouncing off
		handle_armor_bounceoff(L, used_weapon)

	return ..()

//Brute armor does various neat effects if it fully blocks a hit
/datum/species/necromorph/brute/proc/handle_armor_bounceoff(var/mob/user, var/atom/A)
	if (isprojectile(A))
		//Projectiles will ricochet off in a random direction
		var/obj/item/projectile/P = A
		P.last_result = PROJECTILE_DEFLECT
		return

	//Mobs striking the armor with melee attacks will be rattled
	var/mob/living/M
	if (ismob(A))
		M=A
	else
		M = A.get_holding_mob()

	if (M)
		//We found a mob
		M.Stun(3)
		M.shake_animation(40)
		shake_camera(M, duration = 4 SECONDS, strength = 5)
		return

/datum/species/necromorph/brute/make_scary(mob/living/carbon/human/H)
	//H.set_traumatic_sight(TRUE, 5) //All necrmorphs are scary. Some are more scary than others though



/*
	Bio-bomb
*/
/mob/living/carbon/human/proc/biobomb(var/atom/A)
	set name = "Bio-bomb"
	set category = "Abilities"
	set desc = "A moderate-strength projectile for longrange shooting. HK: Middleclick"

	//Don't do anything unless we're sure we can fire
	if (!can_shoot(FALSE))
		return

	var/firesound = pick(list('sound/effects/creatures/necromorph/cyst/cyst_fire_1.ogg',
	'sound/effects/creatures/necromorph/cyst/cyst_fire_2.ogg',
	'sound/effects/creatures/necromorph/cyst/cyst_fire_3.ogg',
	'sound/effects/creatures/necromorph/cyst/cyst_fire_4.ogg'))

	face_atom(A)
	.= shoot_ability(/datum/extension/shoot/brute_biobomb, A , /obj/item/projectile/bullet/biobomb/weak, accuracy = 50, dispersion = 0, num = 1, windup_time = 1.25 SECONDS, fire_sound = firesound, nomove = 2 SECOND, cooldown = 12 SECONDS)
	if (.)
		play_species_audio(src, SOUND_ATTACK, VOLUME_MID, 1, 3)


/datum/extension/shoot/brute_biobomb/windup_animation()
	var/mob/living/L = user
	var/x_direction
	if (target.x > L.x)
		x_direction = 1
	else if (target.x < L.x)
		x_direction = -1


	//We do the windup animation. This involves the user slowly rising into the air, and tilting back if striking horizontally
	animate(L, transform=turn(matrix(), L.default_rotation + (25*(x_direction*-1))),pixel_x = L.default_pixel_x + 8*(x_direction*-1), time = windup_time, flags = ANIMATION_PARALLEL)
	sleep(windup_time)

/datum/extension/shoot/brute_biobomb/fire_animation()
	spawn(4)
		var/mob/living/L = user
		animate(L, transform=L.get_default_transform(),pixel_x = L.default_pixel_x, time = 0.8 SECOND, flags = ANIMATION_PARALLEL)

/obj/item/projectile/bullet/biobomb/weak
	blast_power = BRUTE_BIOBOMB_BLAST_DAMAGE
	damage = BRUTE_BIOBOMB_IMPACT_DAMAGE