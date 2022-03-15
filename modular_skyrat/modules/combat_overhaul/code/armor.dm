/datum/armor
	/// Our integrity, from 0 - 100 percent.
	var/integrity = 100

/datum/armor/getRating(rating) // THIS IS A PROC OVERRIDE
	return vars[rating] / 100 * integrity // Armor can be damaged in our new system, so this override enables us to use it to calculate things.

// Degrades the armor integrity.
/datum/armor/proc/degrade(damage, damage_type)
	if(vars[damage_type] <= 0) // If the rating type has no armor, don't damage it.
		return
	integrity = clamp(integrity - damage / 100, 0, 100)
	to_chat(world, "DEGRADE: [damage], [damage_type], [integrity]")
