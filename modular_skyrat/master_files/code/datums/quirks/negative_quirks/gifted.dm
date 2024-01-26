/datum/quirk/gifted
	name = "Gifted"
	desc = "You were born a bit lucky, intelligent, or something in between. You're able to do a little more."
	icon = FA_ICON_DOVE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN
	value = -6
	mob_trait = TRAIT_GIFTED
	gain_text = span_danger("You feel like you're just a little bit more flexible.")
	lose_text = span_notice("You feel a little less flexible.")
	medical_record_text = "Patient has a history of uncanny fortune."
	hardcore_value = 0
