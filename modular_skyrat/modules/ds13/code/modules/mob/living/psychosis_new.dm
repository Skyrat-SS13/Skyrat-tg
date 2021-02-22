#define PSYCHOSIS_EFFECT_SHAKE 1
#define PSYCHOSIS_EFFECT_LAUGHTER 2
#define PSYCHOSIS_EFFECT_HITSELF 3
#define PSYCHOSIS_EFFECT_HALLUCINATIONS 4
#define PSYCHOSIS_EFFECT_WEIRDSCREEN 5


/**

Interfaces to make things scary.

*/

/**

Methods to apply and remove traumatic sight status to an atom
@param state = boolean flag, TRUE if you're setting up an atom as a traumatic sight, FALSE if removing

*/


/atom/proc/set_traumatic_sight(state, intensity = 3, poll_rate = 5 SECONDS, view_range = world.view, duration = 5 SECONDS)
	if(state)
		set_extension(src, /datum/extension/traumatic_sight, poll_rate, view_range, duration, intensity)
	else
		remove_extension(src, /datum/extension/traumatic_sight)

/**

Method to apply the psychosis extension to a mob. Should be called by necromorphs attacking or some such behaviour.
@param intensity -> the intensity of the psychosis effect. This can stack.
@param duration -> the duration (seconds) of the psychosis effect.

*/

/mob/living/carbon/human/proc/apply_psychosis(intensity, duration)
	var/datum/extension/psychosis/psy = get_extension(src, /datum/extension/psychosis)
	if(psy)//No need to add multiple psychosis components. Let's just intensify the existing one.
		duration += psy.duration
		intensity += psy.intensity
		psy.start_psychosis() //Restart the psychosis effects, or else we'd have cases where it'd just fizzle out.
		return
	set_extension(src, /datum/extension/psychosis, duration, intensity)

/**

Extension code.

*/

/datum/extension/psychosis
	name = "Psychotic trauma"
	expected_type = /mob/living/carbon/human
	flags = EXTENSION_FLAG_IMMEDIATE
	var/mob/living/carbon/user
	var/duration = 10 SECONDS
	var/intensity = 1 //Field to represent the maximum level of trauma that a mob can receive.
	var/max_intensity = PSYCHOSIS_EFFECT_WEIRDSCREEN //Update this as you code more psychosis effects. Used by the random number generator.
	var/countdown
	var/psychosis_timer

/datum/extension/psychosis/New(var/datum/holder, var/_duration, var/_intensity)
	. = ..()
	duration = _duration SECONDS
	intensity = (_intensity <= max_intensity) ? _intensity : max_intensity //Strip off over-intensities that may break things.
	user = holder
	start_psychosis()

/**

Method to begin psychosis effects, and start the countdown timer

*/

/datum/extension/psychosis/proc/start_psychosis()
	if(countdown)
		deltimer(countdown)
	to_chat(user, SPAN_WARNING("You start to feel a little bit unhinged..."))
	countdown = addtimer(CALLBACK(src, /datum/extension/psychosis/proc/finish), duration, TIMER_STOPPABLE) //Countdown to release them from their psychosis.
	apply_psychosis_effects()

/**

Method to cripple the victim with insanity effects. Calls recursively via timers until finishing.

*/

/datum/extension/psychosis/proc/apply_psychosis_effects()
	var/effect = rand(PSYCHOSIS_EFFECT_SHAKE, intensity) //Update this as required. Only coded in a few as of now
	if(user.stat == DEAD || user.stat == UNCONSCIOUS)
		return FALSE
	switch(effect)
		if(PSYCHOSIS_EFFECT_SHAKE)
			user.visible_message("<span class='warning'><b>[user]</b> starts shaking in fear!</span>","<span class='warning'>You feel terrified!</span>")
			user.shake_animation(20)
		if(PSYCHOSIS_EFFECT_LAUGHTER)
			switch(rand(0,3))
				if(1)
					user.custom_pain("You suddenly feel an urge to laugh.",0)
					user.emote("laugh")
				if(2)
					user.custom_pain("You burst out laughing!",1)
					user.emote("laugh")
				if(3 to max_intensity)
					user.custom_pain("You burst out into an uncontrollable fit of laughter!",1)
					user.emote("laugh")
		if(PSYCHOSIS_EFFECT_HITSELF)
			user.a_intent  = I_HURT
			user.attack_hand(user)
			user.visible_message("<span class='warning'><b>[user]</b> slaps themselves!</span>","<span class='warning'>You slap yourself!</span>")
		if(PSYCHOSIS_EFFECT_HALLUCINATIONS)
			user.visible_message("<span class='warning'><b>[user]</b> looks around wildly!</span>","<span class='warning'>You feel your eyes darting around to faraway places...</span>")
			user.adjust_hallucination(20,20)
		if(PSYCHOSIS_EFFECT_WEIRDSCREEN)
			user.overlay_fullscreen("insane", /obj/screen/fullscreen/insane)
	psychosis_timer = addtimer(CALLBACK(src, /datum/extension/psychosis/proc/apply_psychosis_effects), rand(0, duration/2), TIMER_STOPPABLE) //Call recursively. Delay from 0 seconds to half the duration, so that theyre always guaranteed to get one psychosis effect.
	return TRUE
/**

Method to finish up the psychosis effects, clear any screen effects we put on them, and stop the timer for new psychosis effects.

*/

/datum/extension/psychosis/proc/finish()
	to_chat(user, SPAN_NOTICE("You start to feel a little bit less panicked"))
	remove_extension(holder, /datum/extension/psychosis)
	user.clear_fullscreen("insane")
	if(psychosis_timer)
		deltimer(psychosis_timer) //Stops the timer calling on a null object (src)

/datum/extension/psychosis/Destroy()
	.=..()

/obj/screen/fullscreen/insane
	icon_state = "insane"
	layer = DAMAGE_LAYER
	alpha = 180
	mouse_opacity = 0

/**

Traumatic sight extensions

-A class that allows you to make an object apply psych damage periodically.

*/

/datum/extension/traumatic_sight
	name = "Traumatic sight"
	expected_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE
	var/poll_rate = 10 SECONDS //How often should we update our list of affected mobs?
	var/duration = 2 SECONDS //How long should we insane-ify people for? Remember that this stacks!
	var/view_range = 15
	var/intensity = 3
	var/poll_timer
	var/atom/source

/datum/extension/traumatic_sight/New(var/datum/holder, var/_poll_rate, var/_view_range, var/_duration, var/_intensity)
	. = ..()
	poll_rate = _poll_rate SECONDS
	src.holder = holder
	src.source = holder
	view_range = _view_range
	duration = _duration SECONDS
	intensity = _intensity
	tick()

/**

A method to apply psychosis effects to people that can see the source of the traumatic sight.
This method updates recursively via timers once every few seconds to avoid over-use of process() and view()

*/

/datum/extension/traumatic_sight/proc/tick()
	if(poll_timer)
		deltimer(poll_timer)
	poll_timer = addtimer(CALLBACK(src, /datum/extension/traumatic_sight/proc/tick), poll_rate, TIMER_STOPPABLE)
	apply_psychosis_effects()

/**

A method to apply physical psychosis effects.

*/

/datum/extension/traumatic_sight/proc/apply_psychosis_effects()
	for(var/mob/living/carbon/human/M in source.atoms_in_view(view_range))
		if(!istype(M))
			continue
		if(M.eye_blind <= 0 && M.species?.psychosis_vulnerable() && M.equipment_tint_total < TINT_BLIND) //The blinded cannot be scared by what they see.
			M.apply_psychosis(intensity, duration)
