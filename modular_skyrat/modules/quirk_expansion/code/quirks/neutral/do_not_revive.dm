/datum/quirk/dnr
	name = "Do Not Revive"
	desc = "For whatever reason, you cannot be revived in any way."
	gain_text = span_notice("Your spirit gets too scarred to accept revival.")
	lose_text = span_notice("You can feel your soul healing again.")
	medical_record_text = "Patient is a DNR, and cannot be revived in any way."
	value = 0
	mob_trait = TRAIT_DNR
	icon = "skull-crossbones"
