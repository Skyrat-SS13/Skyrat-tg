obj/item/organ/liver/alien/roundstart
	name = "adapted liver"
	icon_state = "liver-x"
	desc = "A liver that is adapted to handle heavy intake of toxins in exchange for being generally weaker, with a high chance to reject its owner if it filters too many toxins whilst being weak to EMP's."
	toxLethality = 2.5 * LIVER_DEFAULT_TOX_LETHALITY // rejects its owner early after too much punishment
	toxTolerance = 3 // complete toxin immunity like xenos have would be too powerful
	emp_vulnerability = 5
