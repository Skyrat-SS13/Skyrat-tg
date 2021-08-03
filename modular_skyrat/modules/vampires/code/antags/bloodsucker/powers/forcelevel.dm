/datum/action/bloodsucker/levelup
	name = "Forced Evolution"
	desc = "Spend the lovely sanguine running through your veins; aging you at an accelerated rate."
	button_icon_state = "power_feed"
	var/total_uses = 1
	bloodcost = 50
	cooldown = 50
	bloodsucker_can_buy = TRUE


/datum/action/bloodsucker/levelup/CheckCanUse(display_error)
	. = ..()
	if(!.)
		return

	return TRUE


/datum/action/bloodsucker/levelup/ActivatePower()
	var/datum/antagonist/bloodsucker/bloodsuckerdatum = owner.mind.has_antag_datum(ANTAG_DATUM_BLOODSUCKER)
	if(istype(bloodsuckerdatum))
		bloodsuckerdatum.ForcedRankUp()	// Rank up! Must still be in a coffin to level!

	total_uses++
	bloodcost = total_uses * 50
