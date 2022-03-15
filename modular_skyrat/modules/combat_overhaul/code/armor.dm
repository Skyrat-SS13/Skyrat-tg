/datum/armor
	/// Our integrity, from 0 - 100 percent.
	var/integrity = 100

/datum/armor/getRating(rating, ignore_integrity) // THIS IS A PROC OVERRIDE
	return ignore_integrity ? vars[rating] : vars[rating] / 100 * integrity

// Degrades the armor integrity.
/datum/armor/proc/degrade(damage, damage_type)
	if(vars[damage_type] <= 0) // If the rating type has no armor, don't damage it.
		return
	integrity = clamp(integrity - damage / 10, 0, 100)
