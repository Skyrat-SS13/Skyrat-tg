/mob/living/silicon/verb/robot_nom(var/mob/living/T in oview(1))
	set name = "Eat Mob"
	set category = "Vore"
	set desc = "Allows you to eat someone."

	if (stat != CONSCIOUS)
		return
	if(!CHECK_BITFIELD(T.vore_flags,DEVOURABLE))
		return
	return feed_grabbed_to_self(src,T)
