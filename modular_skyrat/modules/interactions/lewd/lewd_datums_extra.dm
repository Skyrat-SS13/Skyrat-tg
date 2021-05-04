/datum/interaction/lewd/jack
	command = "jack"
	description = "Jerk yourself off."
	interaction_sound = null
	require_user_hands = REQUIRE_ANY
	require_user_penis = REQUIRE_EXPOSED
	user_not_tired = TRUE
	user_is_target = TRUE
	max_distance = 0

/datum/interaction/lewd/jack/display_interaction(mob/living/carbon/human/user)
	user.do_jackoff(user)

/datum/interaction/lewd/fingerass_self
	command = "fingerm_self"
	description = "Finger yourself."
	interaction_sound = null
	require_user_hands = REQUIRE_ANY
	require_user_anus = REQUIRE_EXPOSED
	user_not_tired = TRUE
	user_is_target = TRUE
	max_distance = 0

/datum/interaction/lewd/fingerass_self/display_interaction(mob/living/carbon/human/user)
	user.do_fingerass_self(user)

/datum/interaction/lewd/finger_self
	command = "finger_self"
	description = "Finger your own pussy."
	require_user_hands = REQUIRE_ANY
	require_user_vagina = REQUIRE_EXPOSED
	interaction_sound = null
	user_not_tired = TRUE
	user_is_target = TRUE
	max_distance = 0

/datum/interaction/lewd/finger_self/display_interaction(mob/living/carbon/human/user)
	user.do_fingering_self(user)
	
/datum/interaction/lewd/titgrope_self
	command = "titgrope_self"
	description = "Grope your own breasts."
	require_user_breasts = REQUIRE_ANY
	user_is_target = TRUE
	interaction_sound = null
	max_distance = 0

/datum/interaction/lewd/titgrope_self/display_interaction(mob/living/carbon/human/user)
	user.do_titgrope_self(user)
