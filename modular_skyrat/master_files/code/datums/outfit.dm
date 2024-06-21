/datum/outfit
	/// Bitflag-based variable to store which parts of the uniform have been modified by the loadout, to avoid them being overriden again.
	var/modified_outfit_slots = NONE
	/// Underwear and bras are separated now
	var/datum/sprite_accessory/bra = null
