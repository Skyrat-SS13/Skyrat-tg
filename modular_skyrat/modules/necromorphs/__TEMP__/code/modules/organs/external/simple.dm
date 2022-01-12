//Simple organs come in a set of 6:
	/*
		Head
		Torso
		Right Arm
		Left Arm
		Left Leg
		Right Leg

		There are no hands, feet or groin
		Hands should be drawn into the arm sprite
		Feet should be drawn into the leg sprite
		Groin should be drawn into the torso sprite
	*/
/obj/item/organ/external/head/simple
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_HEALS_OVERKILL

/obj/item/organ/external/chest/simple
	limb_flags = ORGAN_FLAG_HEALS_OVERKILL

//The arms have fingerprints since no hand
/obj/item/organ/external/arm/simple
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_GRASP | ORGAN_FLAG_FINGERPRINT

/obj/item/organ/external/arm/right/simple
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_GRASP | ORGAN_FLAG_FINGERPRINT

//Legs connect directly to torso
/obj/item/organ/external/leg/simple
	parent_organ = BP_CHEST

/obj/item/organ/external/leg/right/simple
	parent_organ = BP_CHEST

