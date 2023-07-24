/// Copy traits from one organ to another - e.g. with custom roundstart organs that should still get species traits applied.
/obj/item/organ/proc/copy_traits_from(obj/item/organ/old_organ)
	if(isnull(old_organ))
		return

	// make sure the organ gets the actions from any species specific things (like hemophage blood drain, etc)
	for(var/datum/action/action as anything in old_organ.actions)
		add_item_action(action.type)
	// copy corruption flag from hemophage if applicable
	if(old_organ.organ_flags & ORGAN_TUMOR_CORRUPTED)
		organ_flags |= ORGAN_TUMOR_CORRUPTED
