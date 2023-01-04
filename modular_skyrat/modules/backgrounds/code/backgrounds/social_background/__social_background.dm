/**
 * Social Backgrounds. What company, government you either associate with, or are a part of. Decides your passport.
 * Required languages can be set, but these should only be for special empire-specific corps. Optional languages, however, are encouraged.
 */
/datum/background_info/social_background
	/// The passport used by the social background, given on spawn.
	var/obj/item/passport/// passport = /obj/item/passport // Commented out. Will be uncommented next PR, this is to save time.
	/// Used for passports, purely visual for now.
	/// This being true means that the parent empire or corporation maintains a relevant and sustainable space fleet.
	var/space_faring = TRUE
