/datum/powernet/get_electrocute_damage()
	if(avail >= 1000)
		var/damage = clamp(20 + round(avail/25000), 20, 195) + rand(-5,5)
		return damage * HUMAN_HEALTH_MODIFIER
	else
		return 0
