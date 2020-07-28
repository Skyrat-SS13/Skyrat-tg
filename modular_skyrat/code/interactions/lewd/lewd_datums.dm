/datum/interaction/lewd/kiss
	command = "deepkiss"
	description = "Kiss them deeply."
	require_user_mouth = TRUE
	require_target_mouth = TRUE
	write_log_user = "kissed"
	write_log_target = "was kissed by"
	interaction_sound = null
	max_distance = 1

/datum/interaction/lewd/kiss/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(user.get_lust() < 5)
		user.set_lust(5)
	if(target.get_lust() < 5)
		target.set_lust(5)

/datum/interaction/lewd/kiss/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.get_lust() >= 3)
		user.visible_message("<font color=purple>\The <b>[user]</b> gives an intense, lingering kiss to \the <b>[target]</b>.</font>")
	else
		user.visible_message("<font color=purple>\The <b>[user]</b> kisses \the <b>[target]</b> deeply.</font>")

/datum/interaction/lewd/titgrope
	command = "titgrope"
	description = "Grope their breasts."
	require_target_breasts = REQUIRE_ANY
	write_log_user = "groped"
	write_log_target = "was groped by"
	interaction_sound = null
	max_distance = 1

/datum/interaction/lewd/titgrope/post_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()

/datum/interaction/lewd/titgrope/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.a_intent == INTENT_HELP)
		user.visible_message(
				pick("<font color=purple>\The <b>[user]</b> gently gropes \the <b>[target]</b>'s breast.</font>",
					 "<font color=purple>\The <b>[user]</b> softly squeezes \the <b>[target]</b>'s breasts.</font>",
					 "<font color=purple>\The <b>[user]</b> grips \the <b>[target]</b>'s breasts.</font>",
					 "<font color=purple>\The <b>[user]</b> runs a few fingers over \the <b>[target]</b>'s breast.</font>",
					 "<font color=purple>\The <b>[user]</b> delicately teases \the <b>[target]</b>'s nipple.</font>",
					 "<font color=purple>\The <b>[user]</b> traces a touch across \the <b>[target]</b>'s breast.</font>"))
	if(user.a_intent == INTENT_HARM)
		user.visible_message(
				pick("<font color=purple>\The <b>[user]</b> aggressively gropes \the <b>[target]</b>'s breast.</font>",
					 "<font color=purple>\The <b>[user]</b> grabs \the <b>[target]</b>'s breasts.</font>",
					 "<font color=purple>\The <b>[user]</b> tightly squeezes \the <b>[target]</b>'s breasts.</font>",
					 "<font color=purple>\The <b>[user]</b> slaps at \the <b>[target]</b>'s breasts.</font>",
					 "<font color=purple>\The <b>[user]</b> gropes \the <b>[target]</b>'s breasts roughly.</font>"))
	if(prob(5 + target.get_lust()))
		if(target.a_intent == INTENT_HELP)
			user.visible_message(
				pick("<font color=purple>\The <b>[target]</b> shivers in arousal.</font>",
					 "<font color=purple>\The <b>[target]</b> moans quietly.</font>",
					 "<font color=purple>\The <b>[target]</b> breathes out a soft moan.</font>",
					 "<font color=purple>\The <b>[target]</b> gasps.</font>",
					 "<font color=purple>\The <b>[target]</b> shudders softly.</font>",
					 "<font color=purple>\The <b>[target]</b> trembles as hands run across bare skin.</font>"))
			if(target.get_lust() < 5)
				target.set_lust(5)
		if(target.a_intent == INTENT_DISARM)
			if (target.restrained())
				user.visible_message(
					pick("<font color=purple>\The <b>[target]</b> twists playfully against the restraints.</font>",
						 "<font color=purple>\The <b>[target]</b> squirms away from <b>[user]</b>'s hand.</font>",
						 "<font color=purple>\The <b>[target]</b> slides back from <b>[user]</b>'s roaming hand.</font>",
						 "<font color=purple>\The <b>[target]</b> thrusts bare breasts forward into <b>[user]</b>'s hands.</font>"))
			else
				user.visible_message(
					pick("<font color=purple>\The <b>[target]</b> playfully bats at <b>[user]</b>'s hand.</font>",
						 "<font color=purple>\The <b>[target]</b> squirms away from <b>[user]</b>'s hand.</font>",
						 "<font color=purple>\The <b>[target]</b> guides <b>[user]</b>'s hand across bare breasts.</font>",
						 "<font color=purple>\The <b>[target]</b> teasingly laces a few fingers over <b>[user]</b>'s knuckles.</font>"))
			if(target.get_lust() < 10)
				target.add_lust(1)
	if(target.a_intent == INTENT_GRAB)
		user.visible_message(
				pick("<font color=purple>\The <b>[target]</b> grips <b>[user]</b>'s wrist tight.</font>",
				 "<font color=purple>\The <b>[target]</b> digs nails into <b>[user]</b>'s arm.</font>",
				 "<font color=purple>\The <b>[target]</b> grabs <b>[user]</b>'s wrist for a second.</font>"))
	if(target.a_intent == INTENT_HARM)
		user.adjustBruteLoss(1)
		user.visible_message(
				pick("<font color=purple>\The <b>[target]</b> pushes <b>[user]</b> roughly away.</font>",
				 "<font color=purple>\The <b>[target]</b> digs nails angrily into <b>[user]</b>'s arm.</font>",
				 "<font color=purple>\The <b>[target]</b> fiercely struggles against <b>[user]</b>.</font>",
				 "<font color=purple>\The <b>[target]</b> claws <b>[user]</b>'s forearm, drawing blood.</font>",
				 "<font color=purple>\The <b>[target]</b> slaps <b>[user]</b>'s hand away.</font>"))
	return

/datum/interaction/lewd/nipsuck
	command = "nipsuck"
	description = "Suck their nipples."
	require_target_topless = TRUE
	require_user_mouth = TRUE
	write_log_user = "sucked nipples"
	write_log_target = "had their nipples sucked by"
	interaction_sound = null
	max_distance = 1

/datum/interaction/lewd/nipsuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if((user.a_intent == INTENT_HELP) || (user.a_intent == INTENT_DISARM))
		user.visible_message(
				pick("<font color=purple>\The <b>[user]</b> gently sucks on \the <b>[target]</b>'s [pick("nipple", "nipples")].</font>",
					"<font color=purple>\The <b>[user]</b> gently nibs \the <b>[target]</b>'s [pick("nipple", "nipples")].</font>",
					"<font color=purple>\The <b>[user]</b> licks \the <b>[target]</b>'s [pick("nipple", "nipples")].</font>"))
		if(target.has_breasts(REQUIRE_EXPOSED))
			var/modifier = 1
			var/obj/item/organ/genital/breasts/B = target.getorganslot(ORGAN_SLOT_BREASTS)
			switch(B.size)
				if("c" || "d" || "e")
					modifier = 2
				if("f" || "g" || "h")
					modifier = 3
				if("i")
					modifier = 4
				if("j")
					modifier = 5
				else
					modifier = 1
			target.reagents.add_reagent(/datum/reagent/consumable/milk, rand(1,2 * modifier))
		
	if(user.a_intent == INTENT_HARM)
		user.visible_message(
				pick("<font color=purple>\The <b>[user]</b> bites \the <b>[target]</b>'s [pick("nipple", "nipples")].</font>",
					"<font color=purple>\The <b>[user]</b> aggressively sucks \the <b>[target]</b>'s [pick("nipple", "nipples")].</font>"))
		if(target.has_breasts(REQUIRE_EXPOSED))
			var/modifier = 1
			var/obj/item/organ/genital/breasts/B = target.getorganslot(ORGAN_SLOT_BREASTS)
			switch(B.size)
				if("c" || "d" || "e")
					modifier = 2
				if("f" || "g" || "h")
					modifier = 3
				if("i")
					modifier = 4
				if("j")
					modifier = 5
				else
					modifier = 1
			target.reagents.add_reagent(/datum/reagent/consumable/milk, rand(1,3 * modifier)) //aggressive sucking leads to high rewards
	
	if(user.a_intent == INTENT_GRAB)
		user.visible_message(
				pick("<font color=purple>\The <b>[user]</b> sucks \the <b>[target]</b>'s [pick("nipple", "nipples")] intently.</font>",
					"<font color=purple>\The <b>[user]</b> feasts \the <b>[target]</b>'s [pick("nipple", "nipples")].</font>",
					"<font color=purple>\The <b>[user]</b> glomps \the <b>[target]</b>'s [pick("nipple", "nipples")].</font>"))
		if(target.has_breasts(REQUIRE_EXPOSED))
			var/modifier = 1
			var/obj/item/organ/genital/breasts/B = target.getorganslot(ORGAN_SLOT_BREASTS)
			switch(B.size)
				if("c" || "d" || "e")
					modifier = 2
				if("f" || "g" || "h")
					modifier = 3
				if("i")
					modifier = 4
				if("j")
					modifier = 5
				else
					modifier = 1
			target.reagents.add_reagent(/datum/reagent/consumable/milk, rand(1,3 * modifier)) //aggressive sucking leads to high rewards

	if(prob(5 + target.get_lust()))
		if(target.a_intent == INTENT_HELP)
			if(!target.has_breasts())
				user.visible_message(
					pick("<font color=purple>\The <b>[target]</b> shivers in arousal.</font>",
						"<font color=purple>\The <b>[target]</b> moans quietly.</font>",
						"<font color=purple>\The <b>[target]</b> breathes out a soft moan.</font>",
						"<font color=purple>\The <b>[target]</b> gasps.</font>",
						"<font color=purple>\The <b>[target]</b> shudders softly.</font>",
						"<font color=purple>\The <b>[target]</b> trembles as their chest gets molested.</font>"))
			else
				user.visible_message(
					pick("<font color=purple>\The <b>[target]</b> shivers in arousal.</font>",
						"<font color=purple>\The <b>[target]</b> moans quietly.</font>",
						"<font color=purple>\The <b>[target]</b> breathes out a soft moan.</font>",
						"<font color=purple>\The <b>[target]</b> gasps.</font>",
						"<font color=purple>\The <b>[target]</b> shudders softly.</font>",
						"<font color=purple>\The <b>[target]</b> trembles as their breasts get molested.</font>",
						"<font color=purple>\The <b>[target]</b> quivers in arousal as \the <b>[user]</b> delights themselves on their milk.</font>"))
			if(target.get_lust() < 5)
				target.set_lust(5)
		if(target.a_intent == INTENT_DISARM)
			if (target.restrained())
				if(!target.has_breasts())
					user.visible_message(
						pick("<font color=purple>\The <b>[target]</b> twists playfully against the restraints.</font>",
							"<font color=purple>\The <b>[target]</b> squirms away from \the <b>[user]</b>'s mouth.</font>",
							"<font color=purple>\The <b>[target]</b> slides back from \the <b>[user]</b>'s mouth.</font>",
							"<font color=purple>\The <b>[target]</b> thrusts their bare chest forward into \the <b>[user]</b>'s mouth.</font>"))
				else 
					user.visible_message(
						pick("<font color=purple>\The <b>[target]</b> twists playfully against the restraints.</font>",
							"<font color=purple>\The <b>[target]</b> squirms away from \the <b>[user]</b>'s mouth.</font>",
							"<font color=purple>\The <b>[target]</b> slides back from \the <b>[user]</b>'s mouth.</font>",
							"<font color=purple>\The <b>[target]</b> thrust their bare breasts forward into \the <b>[user]</b>'s mouth.</font>"))
			else
				if(!target.has_breasts())
					user.visible_message(
						pick("<font color=purple>\The <b>[target]</b> playfully shoos away \the <b>[user]</b>'s head.</font>",
							"<font color=purple>\The <b>[target]</b> squirms away from \the <b>[user]</b>'s mouth.</font>",
							"<font color=purple>\The <b>[target]</b> holds \the <b>[user]</b>'s head against their chest.</font>",
							"<font color=purple>\The <b>[target]</b> teasingly caresses \the <b>[user]</b>'s neck.</font>"))
				else
					user.visible_message(
						pick("<font color=purple>\The <b>[target]</b> playfully shoos away \the <b>[user]</b>'s head.</font>",
							"<font color=purple>\The <b>[target]</b> squirms away from \the <b>[user]</b>'s mouth.</font>",
							"<font color=purple>\The <b>[target]</b> holds \the <b>[user]</b>'s head against their breast.</font>",
							"<font color=purple>\The <b>[target]</b> teasingly caresses \the <b>[user]</b>'s neck.</font>",
							"<font color=purple>\The <b>[target]</b> rubs their breasts against \the <b>[user]</b>'s head.</font>"))
			if(target.get_lust() < 10)
				target.add_lust(1)
	if(target.a_intent == INTENT_GRAB)
		user.visible_message(
				pick("<font color=purple>\The <b>[target]</b> grips \the <b>[user]</b>'s head tight.</font>",
				 "<font color=purple>\The <b>[target]</b> digs nails into \the <b>[user]</b>'s scalp.</font>",
				 "<font color=purple>\The <b>[target]</b> grabs and shoves \the <b>[user]</b>'s head away.</font>"))
	if(target.a_intent == INTENT_HARM)
		user.adjustBruteLoss(1)
		user.visible_message(
				pick("<font color=purple>\The <b>[target]</b> slaps \the <b>[user]</b> away.</font>",
				 "<font color=purple>\The <b>[target]</b> scratches <b>[user]</b>'s face.</font>",
				 "<font color=purple>\The <b>[target]</b> fiercely struggles against <b>[user]</b>.</font>",
				 "<font color=purple>\The <b>[target]</b> claws <b>[user]</b>'s face, drawing blood.</font>",
				 "<font color=purple>\The <b>[target]</b> elbows <b>[user]</b>'s mouth away.</font>"))
	target.dir = get_dir(target, user)
	user.dir = get_dir(user, target)
	playlewdinteractionsound(user.loc, pick('modular_skyrat/sound/interactions/oral1.ogg',
						'modular_skyrat/sound/interactions/oral2.ogg'), 70, 1, -1)
	return

/datum/interaction/lewd/oral
	command = "suckvag"
	description = "Go down on them."
	require_user_mouth = TRUE
	require_target_vagina = REQUIRE_EXPOSED
	write_log_user = "gave head to"
	write_log_target = "was given head by"
	interaction_sound = null
	user_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/oral/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_oral(target, "vagina")

/datum/interaction/lewd/oral/blowjob
	command = "suckcock"
	description = "Suck them off."
	require_target_vagina = REQUIRE_NONE
	require_target_penis = REQUIRE_EXPOSED
	target_not_tired = TRUE

/datum/interaction/lewd/oral/blowjob/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_oral(target, "penis")

/datum/interaction/lewd/fuck
	command = "fuckvag"
	description = "Fuck their pussy."
	require_user_penis = REQUIRE_EXPOSED
	require_target_vagina = REQUIRE_EXPOSED
	write_log_user = "fucked"
	write_log_target = "was fucked by"
	interaction_sound = null
	user_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/fuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_vaginal(target)

/datum/interaction/lewd/fuck/anal
	command = "fuckass"
	description = "Fuck their ass."
	require_target_vagina = REQUIRE_NONE
	require_target_anus = REQUIRE_EXPOSED
	user_not_tired = TRUE

/datum/interaction/lewd/fuck/anal/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_anal(target)

/datum/interaction/lewd/finger
	command = "finger"
	description = "Finger their pussy."
	require_user_hands = REQUIRE_ANY
	require_target_vagina = REQUIRE_EXPOSED
	interaction_sound = null
	user_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/finger/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_fingering(target)

/datum/interaction/lewd/fingerass
	command = "fingerm"
	description = "Finger their ass."
	interaction_sound = null
	require_user_hands = REQUIRE_ANY
	require_target_anus = REQUIRE_EXPOSED
	user_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/fingerass/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_fingerass(target)


/datum/interaction/lewd/facefuck
	command = "facefuck"
	description = "Fuck their mouth."
	interaction_sound = null
	require_target_mouth = TRUE
	user_not_tired = TRUE
	require_user_penis = REQUIRE_EXPOSED
	max_distance = 0

/datum/interaction/lewd/facefuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_facefuck(target)

/datum/interaction/lewd/throatfuck
	command = "throatfuck"
	description = "Fuck their throat. | Does oxy damage."
	interaction_sound = null
	require_user_penis = REQUIRE_EXPOSED
	require_target_mouth = TRUE
	user_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/throatfuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_throatfuck(target)

/datum/interaction/lewd/handjob
	command = "handjob"
	description = "Jerk them off."
	interaction_sound = null
	require_user_hands = TRUE
	require_target_penis = REQUIRE_EXPOSED
	target_not_tired = TRUE
	max_distance = 1

/datum/interaction/lewd/handjob/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_handjob(target)

/datum/interaction/lewd/breastfuck
	command = "breastfuck"
	description = "Fuck their breasts."
	interaction_sound = null
	require_user_penis = REQUIRE_EXPOSED
	user_not_tired = TRUE
	require_target_breasts = REQUIRE_EXPOSED
	max_distance = 0

/datum/interaction/lewd/breastfuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_breastfuck(target)

/datum/interaction/lewd/mount
	command = "mount"
	description = "Mount with your pussy."
	interaction_sound = null
	require_user_vagina = REQUIRE_EXPOSED
	require_target_penis = REQUIRE_EXPOSED
	user_not_tired = TRUE
	target_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/mount/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_mount(target)

/datum/interaction/lewd/mountass
	command = "mountm"
	description = "Mount with your ass."
	interaction_sound = null
	require_user_anus = REQUIRE_EXPOSED
	require_target_penis = REQUIRE_EXPOSED
	user_not_tired = TRUE
	target_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/mountass/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_mountass(target)

/datum/interaction/lewd/tribadism
	command = "tribadism"
	description = "Grind your pussy against theirs."
	interaction_sound = null
	require_target_vagina = REQUIRE_EXPOSED
	require_user_vagina = REQUIRE_EXPOSED
	user_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/tribadism/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_tribadism(target)

/datum/interaction/lewd/rimjob
	command = "rimjob"
	description = "Lick their ass."
	interaction_sound = null
	require_user_mouth = TRUE
	require_target_anus = REQUIRE_EXPOSED
	user_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/rimjob/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_rimjob(target)

/datum/interaction/lewd/mountface
	command = "mountface"
	description = "Ass to face."
	interaction_sound = null
	require_target_mouth = TRUE
	require_user_anus = REQUIRE_EXPOSED
	user_not_tired = TRUE
	max_distance = 0

/datum/interaction/lewd/mountface/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_mountface(target)

/datum/interaction/lewd/lickfeet
	command = "lickfeet"
	description = "Lick their feet."
	interaction_sound = null
	require_user_mouth = TRUE
	require_target_feet = REQUIRE_ANY
	require_target_num_feet = 1
	max_distance = 1

/datum/interaction/lewd/lickfeet/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_lickfeet(target)

/datum/interaction/lewd/grindface
	command = "grindface"
	description = "Feet grind their face."
	interaction_sound = null
	require_target_mouth = TRUE
	require_user_num_feet = 1
	require_user_feet = REQUIRE_ANY
	max_distance = 0

/datum/interaction/lewd/grindface/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_grindface(target)

/datum/interaction/lewd/grindmouth
	command = "grindmouth"
	description = "Feet grind their mouth."
	interaction_sound = null
	require_target_mouth = TRUE
	require_user_num_feet = 1
	require_user_feet = REQUIRE_ANY
	max_distance = 0

/datum/interaction/lewd/grindmouth/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_grindmouth(target)

/datum/interaction/lewd/footfuck
	command = "footfuck"
	description = "Rub your cock on their foot."
	interaction_sound = null
	require_target_num_feet = 1
	require_target_feet = REQUIRE_ANY
	require_user_penis = REQUIRE_EXPOSED
	user_not_tired = TRUE
	max_distance = 1

/datum/interaction/lewd/footfuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_footfuck(target)

/datum/interaction/lewd/footfuck/double
	command = "footfuckdouble"
	description = "Rub your cock between their feet."
	require_target_num_feet = 2

/datum/interaction/lewd/footfuck/double/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_dfootfuck(target)

/datum/interaction/lewd/footjob
	command = "footjob"
	description = "Jerk them off with your foot."
	interaction_sound = null
	require_user_num_feet = 1
	require_user_feet = REQUIRE_ANY
	require_target_penis = REQUIRE_EXPOSED
	target_not_tired = TRUE
	max_distance = 1

/datum/interaction/lewd/footjob/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_footjob(target)

/datum/interaction/lewd/footjob/double
	command = "footjob_double"
	description = "Jerk them off with both of your feet."
	require_user_num_feet = 2

/datum/interaction/lewd/footjob/double/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_dfootjob(target)

/datum/interaction/lewd/footjob/vagina
	command = "footjob_vaginal"
	description = "Rub their vagina with your foot."
	require_target_vagina = REQUIRE_EXPOSED
	require_target_penis = REQUIRE_NONE

/datum/interaction/lewd/footjob/vagina/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_footjob_v(target)

/datum/interaction/lewd/thighs
	command = "thigh_smother"
	description = "Smother them."
	max_distance = 0
	require_user_bottomless = TRUE
	require_target_mouth = TRUE
	interaction_sound = null
	user_not_tired = TRUE
	write_log_user = "thigh-trapped"
	write_log_target = "was smothered by"

/datum/interaction/lewd/thighs/display_interaction(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target)
    user.thigh_smother(target)

/datum/interaction/lewd/nuts
	command = "nut_face"
	description = "Nuts to face."
	interaction_sound = null
	require_user_balls = REQUIRE_EXPOSED
	require_target_mouth = TRUE
	max_distance = 0
	write_log_user = "make-them-suck-their-nuts"
	write_log_target = "was made to suck nuts by"

/datum/interaction/lewd/nuts/display_interaction(var/mob/living/carbon/human/user, var/mob/living/carbon/human/target)
	user.nut_face(target)

/datum/interaction/lewd/nut_smack
	command = "smack_nuts"
	description = "Smack their nuts."
	interaction_sound = 'modular_skyrat/sound/interactions/slap.ogg'
	simple_message = "USER slaps TARGET's nuts!"
	require_target_balls = REQUIRE_EXPOSED
	needs_physical_contact = TRUE
	max_distance = 1
	write_log_user = "slapped-nuts"
	write_log_target = "had their nuts slapped by"

//Weird shit section
/datum/interaction/lewd/earfuck
	command = "earfuck"
	description = "Fuck their ear."
	interaction_sound = null
	simple_message = "USER penetrates TARGET's ear!"
	require_user_penis = REQUIRE_EXPOSED
	require_target_ears = REQUIRE_EXPOSED
	max_distance = 1
	write_log_user = "earfucked"
	write_log_target = "had their ear fucked by"
	extreme = TRUE

/datum/interaction/lewd/earfuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_earfuck(target)

/datum/interaction/lewd/earfuck/earsocketfuck
	command = "earsocketfuck"
	description = "Fuck their earsocket."
	interaction_sound = null
	simple_message = "USER penetrates TARGET's earsocket!"
	require_user_penis = REQUIRE_EXPOSED
	require_target_earsockets = REQUIRE_EXPOSED
	max_distance = 1
	write_log_user = "earsocket fucked"
	write_log_target = "had their earsocket fucked by"
	extreme = TRUE

/datum/interaction/lewd/eyefuck
	command = "eyefuck"
	description = "Fuck their eye."
	interaction_sound = null
	simple_message = "USER penetrates TARGET's eye!"
	require_user_penis = REQUIRE_EXPOSED
	require_target_eyes = REQUIRE_EXPOSED
	max_distance = 1
	write_log_user = "eyefucked"
	write_log_target = "had their eye fucked by"
	extreme = TRUE

/datum/interaction/lewd/eyefuck/display_interaction(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.do_eyefuck(target)

/datum/interaction/lewd/eyefuck/eyesocketfuck
	command = "eyesocketfuck"
	description = "Fuck their eyesocket."
	interaction_sound = null
	simple_message = "USER penetrates TARGET's eyesocket!"
	require_user_penis = REQUIRE_EXPOSED
	require_target_eyesockets = REQUIRE_EXPOSED
	max_distance = 1
	write_log_user = "eyesocketfucked"
	write_log_target = "had their eyesocket fucked by"
	extreme = TRUE
//
