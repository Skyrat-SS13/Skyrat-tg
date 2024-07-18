//to either get inside, or out, of a host
/datum/action/cooldown/mob_cooldown/borer/choosing_host
	name = "Inhabit/Uninhabit Host"
	cooldown_time = 10 SECONDS
	button_icon_state = "host"
	click_to_activate = TRUE

/datum/action/cooldown/mob_cooldown/borer/choosing_host/Activate(atom/target)
	if(get_dist(owner, target) > 1)
		owner.balloon_alert(owner, "too far")
		return
	if(!ishuman(target))
		owner.balloon_alert(owner, "not human")
		return
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.try_enter_host(target))
		return
	. = ..()
	return TRUE

/datum/action/cooldown/mob_cooldown/borer/choosing_host/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	// Check if we already have a human_host
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.human_host)
		return
	if(cortical_owner.try_leave_host())
		StartCooldown()
	return
