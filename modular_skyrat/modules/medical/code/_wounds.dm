/datum/wound/blunt/moderate/hips
	name = "Hip Dislocation"
	desc = "Patient's thighbone has been forced out of it's socket, causing painful and ineffective locomotion."
	treat_text = "Recommended application of bonesetter to the groin, though manual relocation by applying an aggressive grab to the patient and helpfully interacting with their groin may suffice."
	examine_desc = "seems to be sitting at a weird angle"
	occur_text = "pops loudly"
	severity = WOUND_SEVERITY_MODERATE
	viable_zones = list(BODY_ZONE_PRECISE_GROIN)

/datum/wound/blunt/moderate/jaw
	name = "Jaw Dislocation"
	desc = "Patient has a dislocated jaw, causing pain and discomfort."
	treat_text = "Recommended application of bonesetter to the head, though forcing the jaw back in place by applying an aggressive grab to the patient and helpfully interacting with their head may suffice."
	examine_desc = "is red and swollen"
	occur_text = "snaps audibly"
	severity = WOUND_SEVERITY_MODERATE
	viable_zones = list(BODY_ZONE_HEAD)

/datum/wound/blunt/moderate/ribcage
	name = "Rib Dislocation"
	desc = "Patient has dislocated ribs, causing extreme pain and labored breathing."
	treat_text = "Recommended application of bonesetter to the chest, though massaging cartilage by applying an aggressive grab to the laid down patient and helpfully interacting with their chest may suffice."
	examine_desc = "is red and swollen"
	occur_text = "pops loudly"
	severity = WOUND_SEVERITY_MODERATE
	viable_zones = list(BODY_ZONE_CHEST)
