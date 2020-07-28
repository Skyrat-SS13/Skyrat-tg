/datum/species
	var/has_genitals = TRUE //if this goes to 2, blame coders
	var/has_anus = TRUE //same with this
	var/has_breasts = FALSE

/datum/species/proc/has_penis(mob/living/carbon/human/H)
	return has_genitals && H.has_penis

/datum/species/proc/has_vagina(mob/living/carbon/human/H)
	return has_genitals && H.has_vagina

/datum/species/proc/has_anus(mob/living/carbon/human/H)
	return has_anus

/datum/species/proc/has_breasts(mob/living/carbon/human/H)
	return has_breasts || (H.has_breasts)
