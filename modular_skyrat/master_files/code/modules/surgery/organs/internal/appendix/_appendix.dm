/obj/item/organ/internal/appendix/become_inflamed()
	if(engaged_role_play_check(owner))
		return

	if(!(owner.mind.assigned_role.job_flags & JOB_CREW_MEMBER))
		return

	..()
