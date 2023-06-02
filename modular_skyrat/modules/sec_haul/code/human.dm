//src is the user that will be carrying, target is the mob to be carried
/mob/living/carbon/human/can_piggyback(mob/living/carbon/target)
	if (src.combat_mode) // YALL WHOS FUCKIN IDEA WAS IT TO MAKE THIS DAMN PIGGYBACK SHIT TF YOU DOING
		balloon_alert(target, "target in combat mode!")
		return FALSE // hey if youre wondering why this was done :)) its because it fucking obliterates maintfu
	. = ..()
