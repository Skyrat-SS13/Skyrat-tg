/**
 * Follow component
 *
 * A simple component that allows hostile mobs to follow another mob in their faction.
 * Default behaviour is alt click.
 *
 * @author Gandalf2k15
 */
/datum/component/follow
	/// Sounds we play when the mob starts following.
	var/list/follow_sounds
	/// Sounds we play when the mob stops following via alt click.
	var/list/unfollow_sounds
	/// Are we currently following? Used for playing sounds.
	var/following = FALSE
	/// Our parent mob.
	var/mob/living/simple_animal/hostile/parent_mob

/datum/component/follow/Initialize(_follow_sounds, _unfollow_sounds, follow_distance = 1, follow_speed = 2)
	if(!ishostile(parent))
		return COMPONENT_INCOMPATIBLE
	if(_follow_sounds)
		follow_sounds = _follow_sounds
	if(_unfollow_sounds)
		unfollow_sounds = _unfollow_sounds
	RegisterSignal(parent, COMSIG_HOSTILE_MOB_LOST_TARGET, .proc/lost_target)
	RegisterSignal(parent, COMSIG_CLICK_ALT, .proc/toggle_follow)
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/on_examine)

/datum/component/follow/Destroy(force, silent)
	UnregisterSignal(parent, COMSIG_HOSTILE_MOB_LOST_TARGET)
	UnregisterSignal(parent, COMSIG_CLICK_ALT)
	parent_mob = null
	QDEL_LIST(follow_sounds)
	QDEL_LIST(unfollow_sounds)
	return ..()

/datum/component/follow/proc/lost_target()
	SIGNAL_HANDLER
	following = FALSE

/datum/component/follow/proc/toggle_follow(datum/source, mob/user)
	SIGNAL_HANDLER
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	if(!living_user.can_interact_with(parent_mob))
		return
	if(!faction_check(living_user, parent_mob))
		return
	following = !following
	if(following)
		if(follow_sounds)
			playsound(parent_mob, pick(follow_sounds), 100)
		INVOKE_ASYNC(parent_mob, /atom/movable.proc/say, "Following you!")
		parent_mob.Goto(living_user)
	else
		if(unfollow_sounds)
			playsound(parent_mob, pick(unfollow_sounds), 100)
		INVOKE_ASYNC(parent_mob, /atom/movable.proc/say, "No longer following!")
		parent_mob.LoseTarget()

/datum/component/follow/proc/on_examine(datum/source, mob/examiner, list/examine_text)
	examine_text += "Alt-click to make them follow you!"
