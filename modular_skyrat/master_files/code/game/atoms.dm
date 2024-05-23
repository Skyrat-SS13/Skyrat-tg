// Stop All Animations nulls the mob's transform, so we have to call update_body_size to ensure that it gets scaled properly again
/atom/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_STOP_ALL_ANIMATIONS] && check_rights(R_VAREDIT))
		var/mob/living/carbon/human/human_mob = src
		if(!istype(human_mob))
			return

		human_mob.dna.current_body_size = BODY_SIZE_NORMAL // because if we don't set this, update_body_size will think that it has no work to do.
		human_mob.dna.update_body_size()

/// Called after a loadout item gets custom named
/atom/proc/on_loadout_custom_named()
	return

/// Called after a loadout item gets a custom description
/atom/proc/on_loadout_custom_described()
	return
