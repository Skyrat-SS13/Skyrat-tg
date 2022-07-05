/**
 * Daytime lover
 *
 * Positive moodlet for being outside during the day
 * Negative moodlet for being outside during the night
 */
/datum/quirk/daytime_lover
	name = "Daytime Lover"
	desc = "You absolutely adore daytime, but you hate nighttime!"
	gain_text = span_notice("You crave daytime!")
	lose_text = span_notice("Daytime isn't so important to you anymore.")
	medical_record_text = "Patient seems to have an abnormal admiration for daytime."
	value = 0
	icon = "sun"

/**
 * Nighttime lover
 *
 * Positive moodlet for being outside during the night
 * Negative moodlet for being outside during the day
 */
/datum/quirk/nighttime_lover
	name = "Nighttime Lover"
	desc = "You absolutely adore nighttime, but you hate daytime!"
	gain_text = span_notice("You crave nighttime!")
	lose_text = span_notice("Nighttime isn't so important to you anymore.")
	medical_record_text = "Patient seems to have an abnormal admiration for nighttime."
	value = 0
	icon = "moon"
