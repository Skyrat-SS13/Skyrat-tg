

/datum/action/bloodsucker/lunge
	name = "Predatory Lunge"
	desc = "Prepare the strenght to grapple your prey."
	button_icon_state = "power_lunge"
	bloodcost = 10
	cooldown = 30
	bloodsucker_can_buy = TRUE
	warn_constant_cost = TRUE
	amToggle = TRUE
	var/leap_skill_mod = 5

/datum/action/bloodsucker/lunge/New()
	. = ..()
	

/datum/action/bloodsucker/lunge/Destroy()
	. = ..()
	UnregisterSignal(owner, COMSIG_CARBON_TACKLED)

/datum/action/bloodsucker/lunge/ActivatePower()
	var/mob/living/carbon/user = owner
	var/datum/antagonist/bloodsucker/B = user.mind.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
	var/datum/component/tackler/T = user.LoadComponent(/datum/component/tackler)
	T.stamina_cost = 50
	T.base_knockdown = 3 SECONDS
	T.range = 4
	T.speed = 0.8
	T.skill_mod = 5 //Monstrous tackling
	T.min_distance = 2
	active = TRUE
	user.toggle_throw_mode()
	RegisterSignal(user, COMSIG_CARBON_TACKLED, .proc/DelayedDeactivatePower)
	while(B && ContinueActive(user))
		B.AddBloodVolume(-0.1)
		sleep(5)

//Without this, the leap component would get removed too early, causing the normal crash into effects.
/datum/action/bloodsucker/lunge/proc/DelayedDeactivatePower() 
	addtimer(CALLBACK(src, .proc/DeactivatePower), 1 SECONDS, TIMER_UNIQUE)

/datum/action/bloodsucker/lunge/DeactivatePower(mob/living/user = owner)
	. = ..()
	qdel(user.GetComponent(/datum/component/tackler))
	UnregisterSignal(user, COMSIG_CARBON_TACKLED)
