/**
 * Flesh corruption component
 *
 * This component is used to convert objects into corrupted objects.
 *
 * It handles all of the special interactions.
 */

#define DAMAGE_RESPONSE_PROB 60
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

#define PAIN_RESPONSE_EMOTES list("starts crying.", "whimpers.", "shakes in pain.", "visibly winces.", "contorts sickeningly.", "bleeds black fuming liquid.",)

#define PAIN_RESPONSE_SOUNDS list('modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy1.ogg', \
	'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy2.ogg', \
	'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy3.ogg', \
	'modular_skyrat/modules/corrupted_flesh/sound/robot_talk_heavy4.ogg',)

/datum/component/corruption
	/// A list of possible overlays that we can choose from when we are created.
	var/list/possible_overlays = list(
		"wires-1",
		"wires-2",
		"wires-3",
	)
	/// A ref to our controller
	var/datum/weakref/our_controller
	/// After init, this will be set so we preserve the originally set overlay even if our overlays are updated.
	var/set_overlay = ""
	/// The cooldown to damage responses.
	var/damage_response_cooldown = 3 SECONDS
	COOLDOWN_DECLARE(damage_response)

/datum/component/corruption/Initialize(
		datum/corrupted_flesh_controller/incoming_controller,
		react_to_damage = TRUE,
		use_overlays = TRUE,
		update_name = TRUE,
		update_light = TRUE,
		update_examine = TRUE,
		handles_ui_interaction = TRUE,
		handles_destruction = TRUE,
		updates_power_use = TRUE,
	)

	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE

	var/obj/parent_object = parent

	if(incoming_controller)
		our_controller = WEAKREF(incoming_controller)

	if(react_to_damage)
		RegisterSignal(parent_object, COMSIG_ATOM_TAKE_DAMAGE, .proc/react_to_damage)
	if(update_examine)
		RegisterSignal(parent_object, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	if(use_overlays)
		set_overlay = pick(possible_overlays)
		RegisterSignal(parent_object, COMSIG_ATOM_UPDATE_OVERLAYS, .proc/handle_overlays)
	if(handles_ui_interaction)
		RegisterSignal(parent_object, COMSIG_ATOM_UI_INTERACT, .proc/handle_ui_interact)
	if(handles_destruction)
		RegisterSignal(parent_object, COMSIG_ATOM_DESTRUCTION, .proc/handle_destruction)

	if(update_name)
		update_name()

	parent_object.update_appearance()

	if(update_light)
		parent_object.light_color = CORRUPTED_FLESH_LIGHT_BLUE
		parent_object.light_power = 1
		parent_object.light_range = 2
		parent_object.update_light()

	if(updates_power_use && ismachinery(parent))
		var/obj/machinery/parent_machinery = parent
		parent_machinery.idle_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 2 // These machines are now power sinks!

/datum/component/corruption/Destroy(force, silent)
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
/datum/component/corruption/proc/handle_ui_interact(datum/source, mob/user)
	SIGNAL_HANDLER

	var/obj/parent_object = parent
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	if((FACTION_CORRUPTED_FLESH in living_user.faction))
		return
	if(!living_user.can_interact_with(parent_object))
		return

	whip_mob(living_user)
	living_user.apply_damage(10, BRUTE)

	parent_object.say(pick(INTERACT_RESPONSE_PHRASES))

/**
 * Throws the user in a specified direction.
 */
/datum/component/corruption/proc/whip_mob(mob/living/user_to_throw)
	if(!istype(user_to_throw))
		return

	var/obj/parent_object = parent

	to_chat(user_to_throw, span_userdanger("[parent_object] thrashes you with one of it's tendrils, sending you flying!"))
	playsound(parent_object, 'sound/weapons/whip.ogg', 70, TRUE)
	new /obj/effect/temp_visual/kinetic_blast(get_turf(user_to_throw))

	var/atom/throw_target = get_edge_target_turf(user_to_throw, get_dir(parent_object, get_step_away(user_to_throw, parent_object)))
	user_to_throw.throw_at(throw_target, 20, 2)

/datum/component/corruption/proc/handle_destruction(obj/item/target, damage_flag)
	SIGNAL_HANDLER

	playsound(target, 'sound/effects/tendril_destroyed.ogg', 100, TRUE)
	if(prob(DAMAGE_RESPONSE_PROB))
		target.say("ARRRRRRRGHHHHHHH!")
	new /obj/effect/gibspawner/robot(get_turf(target))


/datum/component/corruption/proc/handle_overlays(atom/parent_atom, list/overlays)
	SIGNAL_HANDLER

	overlays += mutable_appearance('modular_skyrat/modules/corrupted_flesh/icons/hivemind_machines.dmi', set_overlay)

/datum/component/corruption/proc/update_name()
	var/obj/parent_object = parent
	parent_object.name = "[pick(CORRUPTED_FLESH_NAME_MODIFIER_LIST)] [parent_object.name]"

/datum/component/corruption/proc/on_examine(atom/examined, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += "<b>It has strange wires wrappped around it!</b>"

/**
 * Infected machines are considered alive, they react to damage, trying to stop the agressor!
 */
/datum/component/corruption/proc/react_to_damage(obj/target, damage_amt)
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
/datum/component/corruption/proc/whip_all_in_range(range_to_whip)
	var/obj/parent_object = parent
	for(var/mob/living/living_mob in circle_view(parent_object, range_to_whip))
		whip_mob(living_mob)
