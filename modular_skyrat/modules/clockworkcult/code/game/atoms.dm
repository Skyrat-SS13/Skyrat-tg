/**
  * Respond to ratvar eating our atom
  *
  * Default behaviour is to send COMSIG_ATOM_RATVAR_ACT and return
  */
/atom/proc/ratvar_act()
	SEND_SIGNAL(src, COMSIG_ATOM_RATVAR_ACT)

/**
  * Respond to the eminence clicking on our atom
  *
  * Default behaviour is to send COMSIG_ATOM_EMAG_ACT and return
  */
/atom/proc/eminence_act(mob/living/simple_animal/eminence/eminence)
	SEND_SIGNAL(src, COMSIG_ATOM_EMINENCE_ACT, eminence)
