/obj/item/organ/internal/appendix/become_inflamed()
	if(engaged_role_play_check(owner, station = TRUE, dorms = TRUE))
		return

	if(!(owner.mind && owner.mind.assigned_role && owner.mind.assigned_role.job_flags & JOB_CREW_MEMBER))
		return

	return ..()
