/obj/item/organ/external/arm/tentacle
	limb_flags = ORGAN_FLAG_CAN_AMPUTATE | ORGAN_FLAG_CAN_GRASP | ORGAN_FLAG_FINGERPRINT


/obj/item/organ/external/arm/tentacle/slim
	organ_tag = BP_L_ARM
	name = "tentacle"
	icon_name = "tentacle"
	max_damage = 30
	min_broken_damage = 18
	w_class = ITEM_SIZE_NORMAL
	body_part = ARM_LEFT
	parent_organ = BP_CHEST
	joint = "left elbow"
	amputation_point = "left shoulder"
	tendon_name = "palmaris longus tendon"
	artery_name = "basilic vein"
	base_miss_chance = 16