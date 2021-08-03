/datum/action/bloodsucker/vassal/recuperate
	name = "Sanguine Recuperation"
	desc = "Slowly heal brute damage while active. This process is exhausting, and requires some of your tainted blood."
	button_icon_state = "power_recup"
	amToggle = TRUE
	bloodcost = 5
	cooldown = 100

/datum/action/bloodsucker/vassal/recuperate/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return
	if (owner.stat >= DEAD)
		return FALSE
	return TRUE

/datum/action/bloodsucker/vassal/recuperate/ActivatePower()
	to_chat(owner, "<span class='notice'>Your muscles clench and your skin crawls as your master's immortal blood knits your wounds and gives you stamina.</span>")
	var/mob/living/carbon/C = owner
	var/mob/living/carbon/human/H
	if(ishuman(owner))
		H = owner
	while(ContinueActive(owner))
		C.adjustBruteLoss(-1.5)
		C.adjustFireLoss(-0.5)
		C.adjustToxLoss(-2, forced = TRUE)
		C.blood_volume -= 0.2
		C.adjustStaminaLoss(-15)
		// Stop Bleeding
		//skyrat edit
		if(istype(H) && H.get_total_bleed_rate() > 0 && rand(20) == 0)
			for(var/x in H.bodyparts)
				var/obj/item/bodypart/BP = x
				if(istype(BP))
					BP.generic_bleedstacks -= 5
			//
		C.Jitter(5)
		sleep(10)
	// DONE!
	//DeactivatePower(owner)

/datum/action/bloodsucker/vassal/recuperate/ContinueActive(mob/living/user, mob/living/target)
	return ..() && user.stat <= DEAD && user.blood_volume > 500
