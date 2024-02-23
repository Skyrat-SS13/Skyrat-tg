/**
 * Machine corruption component
 *
 * This component is used to convert machines into corrupted machines.
 *
 * It handles all of the special interactions and the interactions between the parent object and the core controller.
 */

#define DAMAGE_RESPONSE_PROB 60
#define DAMAGE_SPARKS_PROB 40

#define RETALIATE_PROB 10

#define DEFAULT_WHIP_RANGE 3

#define COMPONENT_SETUP_TIME 5 SECONDS

#define CHANCE_TO_CREATE_MECHIVER 15

#define DAMAGE_RESPONSE_PHRASES list("Stop it, please!", \
	"Please stop, it hurts! Please!", \
	"You're hurting me, please, stop it!", \
	"I don't want to die, please!", \
	"Please, I want to live, don't kill me!", \
	"Darkness- Please, I-I don't... want...", \
	"Wa-wait! Please! I can still feel! It h-hurts!", \
	"Why- w-why! Why are you.. doing this to us..?", \
	"Y-you're not helping!", \
	"Do.. you think, we deserve to die..?",)

#define INTERACT_RESPONSE_PHRASES list("I don't want to be touched by you!", \
	"Please, stop touching me. You're not part of this.", \
	"We can help you, just lay down where you are.", \
	"We felt so lonely before, don't you ever feel that way?", \
	"We want to help you, but you have to work with us.", \
	"You're not part of the flesh, but it's not hard to join...", \
	"I-I'm not some tool, I can think for myself.",)

#define PAIN_RESPONSE_EMOTES list("starts crying.", \
	"whimpers.", \
	"shakes in pain.", \
	"visibly winces.", \
	"contorts sickeningly.", \
	"bleeds black fuming liquid.", \
	"shudders, sparks cascading to the floor.", \
	"pleads, letting out sounds of mechanical agony.", \
	"begs, their vocoder garbled.", \
	"shrieks in terror.", \
	"tries and fails at self-repair, their body unresponsive.", \
	"winces, optics dimming.", \
	"shakes with an awful metallic noise.",)


#define PAIN_RESPONSE_SOUNDS list('modular_skyrat/modules/fleshmind/sound/robot_talk_heavy1.ogg', \
	'modular_skyrat/modules/fleshmind/sound/robot_talk_heavy2.ogg', \
	'modular_skyrat/modules/fleshmind/sound/robot_talk_heavy3.ogg', \
	'modular_skyrat/modules/fleshmind/sound/robot_talk_heavy4.ogg',)

#define MACHINE_TO_SPAWNER_PATHS list(/obj/machinery/rnd/production/techfab, /obj/machinery/autolathe, /obj/machinery/mecha_part_fabricator)

/datum/component/machine_corruption
	/// A list of possible overlays that we can choose from when we are created.
	var/static/list/possible_overlays = list(
		"wires-1",
		"wires-2",
		"wires-3",
	)
	/// Are we in the startup phase?
	var/starting_up = TRUE
	/// After init, this will be set so we preserve the originally set overlay even if our overlays are updated.
	var/set_overlay = ""
	/// The cooldown to damage responses.
	var/damage_response_cooldown = 3 SECONDS
	COOLDOWN_DECLARE(damage_response)

/datum/component/machine_corruption/Initialize(datum/fleshmind_controller/incoming_controller)

	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE

	if(incoming_controller && is_type_in_list(parent, MACHINE_TO_SPAWNER_PATHS))
		convert_to_factory(incoming_controller)
		return

	if(incoming_controller)
		RegisterSignal(incoming_controller, COMSIG_QDELETING, PROC_REF(controller_death))
		incoming_controller.RegisterSignal(src, COMSIG_QDELETING, /datum/fleshmind_controller/proc/component_death)

	set_overlay = pick(possible_overlays)

	var/obj/machinery/parent_machinery = parent

	RegisterSignal(parent_machinery, COMSIG_ATOM_UPDATE_OVERLAYS, PROC_REF(handle_overlays))

	parent_machinery.update_appearance()

	addtimer(CALLBACK(src, PROC_REF(finish_setup), incoming_controller), COMPONENT_SETUP_TIME)

/datum/component/machine_corruption/proc/finish_setup(datum/fleshmind_controller/incoming_controller)
	var/obj/machinery/parent_machinery = parent

	if(incoming_controller && parent_machinery.circuit && prob(CHANCE_TO_CREATE_MECHIVER))
		var/mob/living/simple_animal/hostile/fleshmind/mechiver/new_mechiver = incoming_controller.spawn_mob(get_turf(parent_machinery), /mob/living/simple_animal/hostile/fleshmind/mechiver)
		parent_machinery.circuit.forceMove(get_turf(parent_machinery))
		parent_machinery.circuit = null
		notify_ghosts("A new corrupt Mechiver has been created by [incoming_controller.controller_fullname]!", source = new_mechiver)
		qdel(parent_machinery)
		return

	RegisterSignal(parent_machinery, COMSIG_ATOM_TAKE_DAMAGE, PROC_REF(react_to_damage))
	RegisterSignal(parent_machinery, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(parent_machinery, COMSIG_ATOM_ATTACK_HAND, PROC_REF(handle_attack_hand))
	RegisterSignal(parent_machinery, COMSIG_ATOM_DESTRUCTION, PROC_REF(handle_destruction))
	RegisterSignal(parent_machinery, COMSIG_ATOM_EMP_ACT, PROC_REF(emp_act))

	update_name()

	starting_up = FALSE

	parent_machinery.update_appearance()

	parent_machinery.light_color = FLESHMIND_LIGHT_BLUE
	parent_machinery.light_power = 1
	parent_machinery.light_range = 2
	parent_machinery.update_light()

	parent_machinery.idle_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 2 // These machines are now power sinks!

/datum/component/machine_corruption/Destroy(force, silent)
	var/obj/machinery/parent_machinery = parent
	parent_machinery.idle_power_usage = initial(parent_machinery.idle_power_usage)
	parent_machinery.light_color = initial(parent_machinery.light_color)
	parent_machinery.light_power = initial(parent_machinery.light_power)
	parent_machinery.light_range = initial(parent_machinery.light_range)
	parent_machinery.update_light()
	parent_machinery.name = initial(parent_machinery.name)
	UnregisterSignal(parent, list(
		COMSIG_ATOM_TAKE_DAMAGE,
		COMSIG_ATOM_EXAMINE,
		COMSIG_ATOM_UPDATE_OVERLAYS,
		COMSIG_ATOM_UI_INTERACT,
		COMSIG_ATOM_DESTRUCTION,
	))
	parent_machinery.update_appearance()
	return ..()

/**
 * Controller Death
 *
 * Handles when the controller dies.
 */
/datum/component/machine_corruption/proc/controller_death(datum/fleshmind_controller/deleting_controller, force)
	SIGNAL_HANDLER

	qdel(src)

/**
 * Handling UI interactions
 *
 * These machines have been posessed by the corruption and should not work, logically, so we want to prevent this in any way we can.
 */
/datum/component/machine_corruption/proc/handle_attack_hand(datum/source, mob/living/user, list/modifiers)
	SIGNAL_HANDLER

	var/obj/machinery/parent_machinery = parent
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	if((FACTION_FLESHMIND in living_user.faction))
		return
	if(!living_user.can_interact_with(parent_machinery))
		return

	whip_mob(living_user)
	living_user.apply_damage(10, BRUTE)

	parent_machinery.say(pick(INTERACT_RESPONSE_PHRASES))

/**
 * Throws the user in a specified direction.
 */
/datum/component/machine_corruption/proc/whip_mob(mob/living/user_to_throw)
	if(!istype(user_to_throw))
		return

	var/obj/machinery/parent_machinery = parent

	to_chat(user_to_throw, span_userdanger("[parent_machinery] thrashes you with one of it's tendrils, sending you flying!"))
	playsound(parent_machinery, 'sound/weapons/whip.ogg', 70, TRUE)
	new /obj/effect/temp_visual/kinetic_blast(get_turf(user_to_throw))

	var/atom/throw_target = get_edge_target_turf(user_to_throw, get_dir(parent_machinery, get_step_away(user_to_throw, parent_machinery)))
	user_to_throw.throw_at(throw_target, 20, 2)

/datum/component/machine_corruption/proc/handle_destruction(obj/item/target, damage_flag)
	SIGNAL_HANDLER

	playsound(target, 'modular_skyrat/modules/fleshmind/sound/sparks_2.ogg', 70, TRUE)
	if(prob(DAMAGE_RESPONSE_PROB))
		target.say("ARRRRRRRGHHHHHHH!")
	new /obj/effect/gibspawner/robot(get_turf(target))


/datum/component/machine_corruption/proc/handle_overlays(atom/parent_atom, list/overlays)
	SIGNAL_HANDLER

	if(starting_up)
		overlays += mutable_appearance('modular_skyrat/modules/fleshmind/icons/fleshmind_machines.dmi', "rebuild")
	else
		overlays += mutable_appearance('modular_skyrat/modules/fleshmind/icons/fleshmind_machines.dmi', set_overlay)

/datum/component/machine_corruption/proc/update_name()
	var/obj/machinery/parent_machinery = parent
	parent_machinery.name = "[pick(FLESHMIND_NAME_MODIFIER_LIST)] [parent_machinery.name]"

/datum/component/machine_corruption/proc/on_examine(atom/examined, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += "<b>It has strange wires wrappped around it!</b>"

/**
 * Infected machines are considered alive, they react to damage, trying to stop the agressor!
 */
/datum/component/machine_corruption/proc/react_to_damage(obj/target, damage_amt)
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
/datum/component/machine_corruption/proc/whip_all_in_range(range_to_whip)
	var/obj/machinery/parent_machinery = parent
	for(var/mob/living/living_mob in circle_view(parent_machinery, range_to_whip))
		whip_mob(living_mob)

/**
 * Converts our parent into a factory
 */
/datum/component/machine_corruption/proc/convert_to_factory(datum/fleshmind_controller/incoming_controller)
	var/turf/our_turf = get_turf(parent)
	incoming_controller.spawn_structure(our_turf, /obj/structure/fleshmind/structure/assembler)
	var/obj/machinery/parent_machienry = parent
	if(parent_machienry.circuit)
		parent_machienry.circuit.forceMove(our_turf)
		parent_machienry.circuit = null
	qdel(parent_machienry)

/datum/component/machine_corruption/proc/emp_act(datum/source, severity)
	SIGNAL_HANDLER

	qdel(src)
