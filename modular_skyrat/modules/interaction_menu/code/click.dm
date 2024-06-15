/mob/living/carbon/human/click_ctrl_shift(mob/user) //We have to remove the can_interact check from humans.
	SEND_SIGNAL(src, COMSIG_CLICK_CTRL_SHIFT, user)
	return
