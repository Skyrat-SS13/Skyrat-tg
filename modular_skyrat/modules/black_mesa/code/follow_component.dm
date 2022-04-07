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
	/// The speed at which we follow the user.
	var/follow_speed = 2
	/// The distance we keep from the user.
	var/follow_distance = 1
	/// Are we currently following? Used for playing sounds.
	var/following = FALSE
	/// Our parent mob.
	var/mob/living/simple_animal/hostile/parent_mob

/datum/component/follow/Initialize(_follow_sounds, _unfollow_sounds, _follow_distance = 1, _follow_speed = 2)
	if(!ishostile(parent))
		return COMPONENT_INCOMPATIBLE
	if(_follow_sounds)
		follow_sounds = _follow_sounds
	if(_unfollow_sounds)
		unfollow_sounds = _unfollow_sounds
	if(_follow_distance)
		follow_distance = _follow_distance
	if(_follow_speed)
		follow_speed = _follow_speed
	RegisterSignal(parent, COMSIG_HOSTILE_MOB_LOST_TARGET, .proc/lost_target)
	RegisterSignal(parent, COMSIG_CLICK_ALT, .proc/toggle_follow)
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	parent_mob = parent

/datum/component/follow/Destroy(force, silent)
	UnregisterSignal(parent, COMSIG_HOSTILE_MOB_LOST_TARGET)
	UnregisterSignal(parent, COMSIG_CLICK_ALT)
	parent_mob = null
	return ..()

/datum/component/follow/proc/lost_target()
	SIGNAL_HANDLER
	following = FALSE

/datum/component/follow/proc/toggle_follow(datum/source, mob/living/living_user)
	SIGNAL_HANDLER
	if(!istype(living_user) || !living_user.canUseTopic(parent_mob, TRUE))
		return
	following = !following
	if(following)
		if(follow_sounds)
			playsound(parent_mob, pick(follow_sounds), 100)
		INVOKE_ASYNC(parent_mob, /atom/movable.proc/say, "Following you!")
		parent_mob.Goto(living_user, follow_speed, follow_distance)
	else
		if(unfollow_sounds)
			playsound(parent_mob, pick(unfollow_sounds), 100)
		INVOKE_ASYNC(parent_mob, /atom/movable.proc/say, "No longer following!")
		parent_mob.LoseTarget()

/datum/component/follow/proc/on_examine(datum/source, mob/examiner, list/examine_text)
	examine_text += "Alt-click to make them follow you!"
