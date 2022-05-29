/**
 * Corrupt machinery component
 *
 * This component is used to convert a machine into a corrupted one.
 *
 * It handles all of the special interactions.
 */

#define DAMAGE_RESPONSE_PROB 50
#define DAMAGE_SPARKS_PROB 40

#define RETALIATE_PROB 10

#define DEFAULT_WHIP_RANGE 3

#define DAMAGE_RESPONSE_PHRASES list("Stop it, please!", \
	"Please stop, it hurts! Please!", \
	"You're hurting me, please, stop it!", \
	"I don't want to die, please!", \
	"Please, I want to live, don't kill me!", \
	"Darkness... please... I don't... want...",)

#define INTERACT_RESPONSE_PHRASES list("Get your hands off me!", "You are not worthy of my services!", "You are not part of the flesh!",)

#define PAIN_RESPONSE_EMOTES list("starts crying.", "whimpers.", "shakes in pain.", "visibly winces.",)

#define PAIN_RESPONSE_SOUNDS list('modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy1.ogg', \
	'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy2.ogg', \
	'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy3.ogg', \
	'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy4.ogg',)

/datum/component/corrupt_machinery
	/// A list of possible overlays that we can choose from when we are created.
	var/list/possible_overlays = list(
		"wires-1",
		"wires-2",
		"wires-3",
	)
	/// After init, this will be set so we preserve the originally set overlay even if our overlays are updated.
	var/set_overlay = ""
	/// The cooldown to damage responses.
	var/damage_response_cooldown = 5 SECONDS
	COOLDOWN_DECLARE(damage_response)

/datum/component/corrupt_machinery/Initialize(...)
	if(!istype(parent, /obj/machinery))
		return COMPONENT_INCOMPATIBLE

	var/obj/machinery/parent_machine = parent

	set_overlay = pick(possible_overlays)

	RegisterSignal(parent_machine, COMSIG_ATOM_TAKE_DAMAGE, .proc/react_to_damage)
	RegisterSignal(parent_machine, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	RegisterSignal(parent_machine, COMSIG_ATOM_UPDATE_OVERLAYS, .proc/handle_overlays)
	RegisterSignal(parent_machine, COMSIG_ATOM_UI_INTERACT, .proc/handle_ui_interact)
	RegisterSignal(parent_machine, COMSIG_ATOM_DESTRUCTION, .proc/handle_destruction)

	update_name()

	parent_machine.update_appearance()

	parent_machine.idle_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 2 // These machines are now power sinks!

/datum/component/corrupt_machinery/Destroy(force, silent)
	UnregisterSignal(parent, list(
		COMSIG_ATOM_TAKE_DAMAGE,
		COMSIG_PARENT_EXAMINE,
		COMSIG_ATOM_UPDATE_OVERLAYS,
		COMSIG_ATOM_UI_INTERACT,
		COMSIG_ATOM_DESTRUCTION,
	))
	return ..()

/**
 * Handling UI interactions
 *
 * These machines have been posessed by the corruption and should not work, logically, so we want to prevent this in any way we can.
 */
/datum/component/corrupt_machinery/proc/handle_ui_interact(datum/source, mob/user)
	SIGNAL_HANDLER

	var/obj/machinery/parent_machine = parent
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	if(!living_user.can_interact_with(parent_machine))
		return
	whip_mob(living_user)
	living_user.apply_damage(10, BRUTE)

	parent_machine.say(pick(INTERACT_RESPONSE_PHRASES))

/**
 * Throws the user in a specified direction.
 */
/datum/component/corrupt_machinery/proc/whip_mob(mob/living/user_to_throw)
	if(!istype(user_to_throw))
		return

	var/obj/machinery/parent_machine = parent

	to_chat(user_to_throw, span_userdanger("[parent_machine] thrashes you with one of it's tendrils, sending you flying!"))
	playsound(parent_machine, 'sound/weapons/whip.ogg', 70, TRUE)
	new /obj/effect/temp_visual/kinetic_blast(get_turf(user_to_throw))

	var/atom/throw_target = get_edge_target_turf(user_to_throw, get_dir(parent_machine, get_step_away(user_to_throw, parent_machine)))
	user_to_throw.throw_at(throw_target, 20, 2)

/datum/component/corrupt_machinery/proc/handle_destruction(obj/item/target, damage_flag)
	SIGNAL_HANDLER

	playsound(target, 'sound/effects/tendril_destroyed.ogg', 100, TRUE)
	if(prob(DAMAGE_RESPONSE_PROB))
		target.say("ARRRRRRRGHHHHHHH!")
	new /obj/effect/gibspawner/robot(get_turf(target))


/datum/component/corrupt_machinery/proc/handle_overlays(atom/parent_atom, list/overlays)
	SIGNAL_HANDLER

	overlays += mutable_appearance('modular_skyrat/modules/corrupted_flesh/icons/hivemind_machines.dmi', set_overlay)

/datum/component/corrupt_machinery/proc/update_name()
	var/obj/machinery/parent_machine = parent
	parent_machine.name = "[pick(CORRUPTED_FLESH_NAME_MODIFIER_LIST)] [parent_machine.name]"

/datum/component/corrupt_machinery/proc/on_examine(atom/examined, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += "<b>It has strange wires wrappped around it!</b>"

/**
 * Infected machines are considered alive, they react to damage, trying to stop the agressor!
 */
/datum/component/corrupt_machinery/proc/react_to_damage(obj/target, damage_amt)
	SIGNAL_HANDLER

	if(!damage_amt) // They must be caressing us!
		return

	if(!COOLDOWN_FINISHED(src, damage_response))
		return

	COOLDOWN_START(src, damage_response, damage_response_cooldown)

	if(prob(DAMAGE_RESPONSE_PROB))
		switch(rand(1, 2)) // We can either say something in response, or emote it out.
			if(1)
				target.say(pick(DAMAGE_RESPONSE_PHRASES))
			if(2)
				target.balloon_alert_to_viewers(pick(PAIN_RESPONSE_EMOTES))
		playsound(target, PAIN_RESPONSE_SOUNDS, 50, TRUE)

	if(prob(DAMAGE_SPARKS_PROB))
		do_sparks(3, FALSE, target)
		target.Shake(10, 0, 3 SECONDS)

	if(prob(RETALIATE_PROB))
		whip_all_in_range(DEFAULT_WHIP_RANGE)

/**
 * A general attack proc, this whips all users within a range around the machine.
 */
/datum/component/corrupt_machinery/proc/whip_all_in_range(range_to_whip)
	var/obj/machinery/parent_machine = parent
	for(var/mob/living/living_mob in circle_view(parent_machine, range_to_whip))
		whip_mob(living_mob)
