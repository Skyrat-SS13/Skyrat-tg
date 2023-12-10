/mob/living/carbon/proc/self_grasp_bleeding_limb(obj/item/bodypart/grasped_part, supress_message = FALSE)
	if(!grasped_part?.can_be_grasped())
		return
	var/starting_hand_index = active_hand_index
	if(starting_hand_index == grasped_part.held_index)
		to_chat(src, span_danger("You can't grasp your [grasped_part.name] with itself!"))
		return

	to_chat(src, span_warning("You try grasping at your [grasped_part.name], trying to stop the bleeding..."))
	if(!do_after(src, 0.75 SECONDS))
		to_chat(src, span_danger("You fail to grasp your [grasped_part.name]."))
		return

	var/obj/item/hand_item/self_grasp/grasp = new
	if(starting_hand_index != active_hand_index || !put_in_active_hand(grasp))
		to_chat(src, span_danger("You fail to grasp your [grasped_part.name]."))
		QDEL_NULL(grasp)
		return
	grasp.grasp_limb(grasped_part)
