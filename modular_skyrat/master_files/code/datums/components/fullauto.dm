/// Because autofire weapons bypass do_fire() they will also bypass the safety check unless we do it here
/datum/component/automatic_fire/start_autofiring()
	if(autofire_stat == AUTOFIRE_STAT_FIRING)
		return
	if(SEND_SIGNAL(parent, COMSIG_GUN_TRY_FIRE, parent) & COMPONENT_CANCEL_GUN_FIRE)
		stop_autofiring()
		return
	
	return ..()
