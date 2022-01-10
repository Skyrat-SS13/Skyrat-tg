/*
	Helpers
*/
/mob/proc/get_active_or_available_arm(var/messages = TRUE)
	var/num_arms = 0
	var/selected_arm
	//Alright lets check our arm status first
	var/obj/item/organ/external/arm/left = get_organ(BP_L_ARM)
	var/obj/item/organ/external/arm/right = get_organ(BP_R_ARM)

	if (QDELETED(left) || left.is_stump() || left.retracted)
		left = null
	else
		num_arms++

	if (QDELETED(right) || right.is_stump() || right.retracted)
		right = null
	else
		num_arms++

	if (num_arms <= 0)
		if (messages)
			to_chat(src, SPAN_DANGER("You have no arms to swing!"))
		return

	else if (num_arms == 1)
		if (left)
			selected_arm = BP_L_ARM
		else
			selected_arm = BP_R_ARM
	else
		//If we have both arms, then the user gets to choose which to swing based on their selected hand
		if (hand)
			selected_arm = BP_L_ARM
		else
			selected_arm = BP_R_ARM


	return selected_arm


/mob/proc/get_swing_dir()
	var/selected_arm = get_active_or_available_arm()
	if (selected_arm == BP_L_ARM)
		return CLOCKWISE
	else
		return ANTICLOCKWISE