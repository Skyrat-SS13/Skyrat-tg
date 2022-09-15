/*
*	INVENTORY SYSTEM EXTENTION
*/

// Just by analogy with the TG code. No ideas for what this is.
/mob/proc/update_inv_vagina()
	return
/mob/proc/update_inv_anus()
	return
/mob/proc/update_inv_nipples()
	return
/mob/proc/update_inv_penis()
	return
/// Helper proc for calling all the lewd slot update_inv_ procs.
/mob/proc/update_inv_lewd()
	update_inv_vagina()
	update_inv_anus()
	update_inv_nipples()
	update_inv_penis()

/**
*	I needed this code for ballgag, because it doesn't muzzle, it kinda voxbox
*	wearer for moaning. So i really need it, don't touch or whole ballgag will be broken
*	for ballgag mute audible emotes
*	adding is_ballgagged() proc here. Hope won't break anything important.
*	This is kinda shitcode, but they said don't touch main code or they will break my knees.
*	i love my knees, please merge.
*	more shitcode can be found in code/datums/emotes.dm
*	in /datum/emote/proc/select_message_type(mob/user, intentional) proc. Sorry for that, i had no other choise.
*/
/mob/proc/is_ballgagged()
	return FALSE


/// Proc for condoms. Need to prevent cum appearing on the floor.
/mob/proc/wear_condom()
	return FALSE
