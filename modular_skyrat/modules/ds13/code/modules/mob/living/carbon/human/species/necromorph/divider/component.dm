
/*
	Component Species

	This is only used for creating a preference option to opt in/out of playing components
	its not actually assigned to anyone
*/
/datum/species/necromorph/divider_component
	name = SPECIES_NECROMORPH_DIVIDER_COMPONENT
	marker_spawnable = FALSE
	spawner_spawnable = FALSE
	preference_settable = TRUE




/*
	Component Mobs
*/
/mob/living/simple_animal/necromorph/divider_component
	max_health = 35
	icon = 'icons/mob/necromorph/divider/components_large.dmi'
	var/leap_windup_time = 0.8 SECOND
	var/leap_range = 6
	var/leap_cooldown = 10 SECONDS
	speed = 3
	var/leap_state
	var/attack_state
	pixel_x = -16
	default_pixel_x = -16
	evasion = 40

/mob/living/simple_animal/necromorph/divider_component/do_attack_animation(var/atom/target)
	flick(attack_state, src)
	.=..()


/mob/living/simple_animal/necromorph/divider_component/update_icon()
	if (pass_flags & PASS_FLAG_FLYING)
		icon_state = leap_state
		return

	.=..()

/mob/living/simple_animal/necromorph/divider_component/Initialize()
	.=..()
	dna = new()
	dna.species = SPECIES_NECROMORPH_DIVIDER
	add_modclick_verb(KEY_ALT, /mob/living/simple_animal/necromorph/divider_component/proc/leap)
	get_controlling_player()

//Called when this atom starts charging at another, just before taking the first step
/mob/living/simple_animal/necromorph/divider_component/charge_started(var/datum/extension/charge/charge)
	update_icon()

//Called when this atom starts finishes a charge, called after everything, just before the cooldown timer starts
/mob/living/simple_animal/necromorph/divider_component/charge_ended(var/datum/extension/charge/charge)
	update_icon()


/mob/living/simple_animal/necromorph/divider_component/proc/get_controlling_player()
	SSnecromorph.fill_vessel_from_queue(src, SPECIES_NECROMORPH_DIVIDER_COMPONENT)

/datum/extension/charge/leap/component
	blur_filter_strength = 1


/mob/living/simple_animal/necromorph/divider_component/proc/leap(var/atom/A)
	set name = "Leap Attack"
	set category = "Abilities"

	//Leap autotargets enemies within one tile of the clickpoint
	if (!isliving(A))
		A = autotarget_enemy_mob(A, 2, src, 999)


	if (!can_charge(A))
		return

	//Starting a leap plays an attack sound which ignores cooldown
	if (LAZYLEN(attack_sounds))
		playsound(src, pick(attack_sounds), VOLUME_HIGH, TRUE)

	//Do a chargeup animation. Pulls back and then launches forwards
	//The time is equal to the windup time of the attack, plus 0.5 seconds to prevent a brief stop and ensure launching is a fluid motion
	var/vector2/pixel_offset = Vector2.DirectionBetween(src, A) * -16
	var/vector2/cached_pixels = get_new_vector(src.pixel_x, src.pixel_y)
	flick(attack_state, src)
	animate(src, pixel_x = src.pixel_x + pixel_offset.x, pixel_y = src.pixel_y + pixel_offset.y, time = (leap_windup_time - (0.3 SECONDS)), easing = BACK_EASING, flags = ANIMATION_PARALLEL)
	animate(pixel_x = cached_pixels.x, pixel_y = cached_pixels.y, time = 0.3 SECONDS)

	release_vector(pixel_offset)
	release_vector(cached_pixels)

	//Long shout when targeting mobs, normal when targeting objects
	/*
	if (ismob(A))
		H.play_species_audio(H, SOUND_SHOUT_LONG, 100, 1, 3)
	else
		H.play_species_audio(H, SOUND_SHOUT, 100, 1, 3)
	*/

	return leap_attack(A, _cooldown = leap_cooldown, _delay = (leap_windup_time - (0.2 SECONDS)), _speed = 7, _maxrange = 6, _lifespan = 5 SECONDS, subtype = /datum/extension/charge/leap/component)


















