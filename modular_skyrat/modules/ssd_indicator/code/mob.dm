GLOBAL_VAR_INIT(ssd_indicator_overlay, mutable_appearance('modular_skyrat/modules/ssd_indicator/icons/ssd_indicator.dmi', "default0", FLY_LAYER))

/mob/living
	var/ssd_indicator = FALSE
	var/lastclienttime = 0

/mob/living/proc/set_ssd_indicator(var/state)
	if(state == ssd_indicator)
		return
	ssd_indicator = state
	if(ssd_indicator)
		add_overlay(GLOB.ssd_indicator_overlay)
	else
		cut_overlay(GLOB.ssd_indicator_overlay)

/mob/living/Login()
	. = ..()
	set_ssd_indicator(FALSE)

/mob/living/Logout()
	lastclienttime = world.time
	set_ssd_indicator(TRUE)
	. = ..()

/*
//EDIT - TRANSFER CKEY IS NOT A THING ON THE TG CODEBASE, if things break too bad because of it, consider implementing it
//This proc should stop mobs from having the overlay when someone keeps jumping control of mobs, unfortunately it causes Aghosts to have their character without the SSD overlay, I wasn't able to find a better proc unfortunately
/mob/living/transfer_ckey(mob/new_mob, send_signal = TRUE)
	..()
	set_ssd_indicator(FALSE) 
*/
