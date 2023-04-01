/// We don't want our mobs to cremate from just being set on fire.
/// Round-removal shouldn't be this stupidly easy, even upstream.
/mob/living/carbon/check_cremation(delta_time, times_fired)
	return
