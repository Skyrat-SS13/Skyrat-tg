/*
	Limb Code
*/
/obj/item/organ/external/leg/right/simple/divider
	can_regrow = FALSE

/obj/item/organ/external/leg/simple/divider
	can_regrow = FALSE

/*
	Leg
	Kicks mobs and bounces off
*/
/mob/living/simple_animal/necromorph/divider_component/leg
	name = "leg"
	icon_state = "leg"
	icon_living = "leg"
	icon_dead = list("leg_dead_1", "leg_dead_2")
	speed = 3
	melee_damage_lower = 3
	melee_damage_upper = 6
	attacktext = "kicked"
	attack_sound = 'sound/weapons/bite.ogg'
	leap_cooldown = 4 SECONDS

	pain_sounds = list('sound/effects/creatures/necromorph/divider/component/leg_pain_1.ogg',
	'sound/effects/creatures/necromorph/divider/component/leg_pain_2.ogg',
	'sound/effects/creatures/necromorph/divider/component/leg_pain_3.ogg',
	'sound/effects/creatures/necromorph/divider/component/leg_pain_3.ogg')

	attack_sounds = list('sound/effects/creatures/necromorph/divider/component/leg_attack_1.ogg',
	'sound/effects/creatures/necromorph/divider/component/leg_attack_2.ogg',
	'sound/effects/creatures/necromorph/divider/component/leg_attack_3.ogg',
	'sound/effects/creatures/necromorph/divider/component/leg_attack_4.ogg')

	leap_state = "leg_leap"
	attack_state = "leg_attack"

//The leg's leap impact is a dropkick, both victim and leg are propelled away from each other wildly
//The victim recieves a heavy blunt hit
/mob/living/simple_animal/necromorph/divider_component/leg/charge_impact(var/datum/extension/charge/leap/charge)
	shake_camera(charge.user,5,3)
	.=TRUE
	if (isliving(charge.last_obstacle))
		var/mob/living/L = charge.last_obstacle
		L.shake_animation(15)
		shake_camera(L,10,6) //Smack
		launch_strike(L, damage = 18, used_weapon = src, damage_flags = 0, armor_penetration = 10, damage_type = BRUTE, armor_type = "melee", target_zone = get_zone_sel(src), difficulty = 50)
		//We are briefly stunned
		Stun(1)

	//If the object isnt dense we must have hit the floor, we wont bounce back off that
	else if (!(charge.last_obstacle.density))
		return FALSE

	//And we're gonna do some knockback
	var/turf/epicentre = get_turf(charge.last_obstacle)
	if (istype(charge.last_obstacle, /atom/movable))
		var/atom/movable/AM = charge.last_obstacle
		AM.apply_push_impulse_from(src, 20)

	//After getting kicked you stagger a bit
	spawn(0.75 SECONDS)
		if (isliving(charge.last_obstacle))
			var/mob/living/L = charge.last_obstacle
			L.lurch()

	spawn()
		//And we ourselves also get knocked back
		//We spawn it off to let the current stack finish first, otherwise we get hit twice
		apply_push_impulse_from(epicentre, 20)

