/*

	Frenzy scream ability, used by ubermorph.
	Buffs all necromorphs (except the user) within a wide range, granting them a 20% bonus to move speed and attack speed#

	This extension is used to handle the effect on the buffed person

*/
/datum/extension/frenzy_buff
	name = "Frenzy"
	var/verb_name = "frenzied"
	expected_type = /mob/living/carbon/human
	flags = EXTENSION_FLAG_IMMEDIATE
	var/mob/living/carbon/human/user
	var/duration
	var/intensity
	var/lifetimer

	statmods = list(STATMOD_MOVESPEED_MULTIPLICATIVE = 1,
	STATMOD_ATTACK_SPEED = 1)

/datum/extension/frenzy_buff/New(var/datum/holder, var/_duration, var/_intensity)
	statmods[STATMOD_MOVESPEED_MULTIPLICATIVE] = 1+intensity
	statmods[STATMOD_ATTACK_SPEED] = intensity
	..()
	user = holder
	intensity = _intensity

	set_timer(_duration)
	to_chat(user, SPAN_NOTICE("You feel your muscles twitch with renewed energy!"))

//Resets the timer, refreshing the duration to a new specified value
/datum/extension/frenzy_buff/proc/set_timer(var/newduration)
	if (newduration)
		duration = newduration
	deltimer(lifetimer)
	lifetimer = addtimer(CALLBACK(src, /datum/extension/frenzy_buff/proc/finish), duration, TIMER_STOPPABLE)

/datum/extension/frenzy_buff/proc/finish()
	to_chat(user, SPAN_NOTICE("You feel your body slowing down as your muscles relax"))

	remove_extension(holder, /datum/extension/frenzy_buff)


/*
	This extension handles cooldown on the user
*/

/datum/extension/frenzy_cooldown
	name = "Battlecry"
	flags = EXTENSION_FLAG_IMMEDIATE
	var/cooldown_time
	var/cooltimer
	var/started_at

/datum/extension/frenzy_cooldown/New(var/datum/holder,var/cooldown)
	..()
	started_at = world.time
	cooldown_time = cooldown
	cooltimer = addtimer(CALLBACK(src, .proc/finish), cooldown_time, TIMER_STOPPABLE)

/datum/extension/frenzy_cooldown/proc/finish()
	remove_extension(holder, /datum/extension/frenzy_cooldown)




//Now, the ability to actually do things!
/mob/living/proc/frenzy_shout_ability(var/_duration, var/_intensity, var/_cooldown, var/_faction, var/_range)
	//First lets check we can actually do it
	if (incapacitated(INCAPACITATION_KNOCKOUT))
		return FALSE 	//Gotta be conscious. But being knocked down is fine

	var/mob/living/carbon/human/H = src
	if (istype(H) && !H.has_organ(BP_HEAD))
		return FALSE	//I have no mouth and I must scream


	//Check the cooldown
	var/datum/extension/frenzy_cooldown/EC = get_extension(src, /datum/extension/frenzy_cooldown)
	if(istype(EC))
		to_chat(src, "[EC.name] is cooling down. You can use it again in [((EC.started_at + EC.cooldown_time) - world.time) * 0.1] seconds")
		return FALSE

	var/list/tobuff = list()

	//Okay we are good to go. Lets find our list of allies
	for (var/mob/living/L in range(src, _range))

		if (L == src)
			continue //Its a support ability, doesnt affect yourself

		//Selective buffing
		if (_faction && L.faction != _faction)
			continue

		if (L.stat == DEAD)
			continue //No point buffing the dead


		tobuff += L


	//Alrighty lets do this!
	for (var/mob/living/L in tobuff)
		var/datum/extension/frenzy_buff/FB = get_extension(L, /datum/extension/frenzy_cooldown)
		//Check if its already buffed, unlikely but we don't want duplicate extensions
		//If it already exists, we'll extend the duration instead of remaking it. This ensures the message about muscle twitching doesn't repeat
		if (istype(FB))
			FB.set_timer(_duration)
		else
			set_extension(L, /datum/extension/frenzy_buff, _duration, _intensity)


	//Now that we've buffed them all, lets set cooldown on the user, and tell them how it went
	set_extension(src, /datum/extension/frenzy_cooldown, _cooldown)
	if (tobuff.len)
		to_chat(src, SPAN_NOTICE("You have empowered your allies! [english_list(tobuff,"","","\n")]"))
	else
		to_chat(src, SPAN_NOTICE("Nobody hears your call."))

	return TRUE

