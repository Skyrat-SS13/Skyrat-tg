#define INTERACTION_MATRIX_ID_SAY "SAY"
#define INTERACTION_MATRIX_ID_EMOTE "EMOTE"
#define INTERACTION_MATRIX_ID_LOOKAROUND "LOOKAROUND"

/**
 * Interaction matrix
 *
 * An interaction matrix is a 2D array of interactions between two objects.
 * It lists the available commands as well as the available responses and interpolates them into the game world.
 */

/datum/interaction_matrix
	var/list/initial_actions = list(
		INTERACTION_MATRIX_ID_SAY = /datum/interaction_instance/say,
		INTERACTION_MATRIX_ID_EMOTE = /datum/interaction_instance/emote,
	)
	/// A list of currently active interaction instances that are processing.
	var/list/active_instances = list()

/datum/interaction_matrix/Destroy(force, ...)
	QDEL_NULL(active_instances)
	return ..()

/**
 * process_interaction
 *
 * This will take a string and then process it into any interactions it mentions.
 *
 * It will return the combination of all processed interactions.
 */
/datum/interaction_matrix/proc/process_interaction(atom/interactor, input)
	// Our command list, fully formatted! COMMAND = INPUTS
	var/list/command_list = list()
	// First, remove the brackets at the beginning and end of the input text.
	input_text = copytext(input, 2, length(input))
	// Split the input text into separate command strings.
	var/list/seperated_commands = splittext(input_text, "><")

	for(var/command_string in seperated_commands)
		// Split the command string into a command and its specifics.
		var/list/split_command = splittext(command_string, ":")
		// Store the command and its specifics in the associative list.
		commands_list[split_command[1]] = split_command[2]

	var/output = ""

	// Now that we have a list of commands, we can process them.
	for(var/command in command_list)
		// Get the interaction instance for this command.
		var/datum/interaction_instance/interaction_instance = new initial_actions[command]
		interaction_instance.process_input(interactor, command_list[command], src)
		LAZYADD(active_instances, interaction_instance)


// This is a callback for when the interaction finishes.
/datum/interaction_matrix/interaction_finished(output, datum/interaction_instance/used_instance)
	LAZYREMOVE(active_instances, used_instance)
	SEND_SIGNAL(src, COMSIG_INTERACTION_FINISHED, output)


/datum/interaction_matrix/proc/create_matrix_payload()
	var/interaction_payload = "Here are a list of interactions you can do, and their inputs, formatted like so: 'COMMAND ID:COMMAND DESCRIPTION'"
	for(var/datum/interaction_instance/iterating_instance as anything in interaction_instances)
		interaction_payload += "[iterating_instance.interaction_id]:[iterating_instance.get_formatted_inputs()]"

/**
 * Interaction instance
 *
 * An interaction instance is a single interaction between two objects. It takes input and then outputs a response.
 *
 * These can be used to interact with in game things. It depicts how it should interact, and the result of said attempt.
 */
/datum/interaction_instance
	/// The ID of the interaction, it is used to identify it.
	var/interaction_id
	/// The unique instance ID that GPT has assigned this instance.
	var/unique_id
	/// The description of what this interaction does. This must explain what the interaction does so that GPT can understand how to use it.
	var/description
	/// The instance modifier description.
	var/modifier_description
	/// A description of what this interaction returns.
	var/return_description = "nothing"
	/// The compatible type for this interaction.
	var/list/compatible_types
	/// Our callback for when we finish processing.
	var/datum/callback/matrix_callback

/datum/interaction_instance/Destroy(force, ...)
	QDEL_NULL(matrix_callback)
	return ..()

/datum/interaction_instance/proc/get_interaction_instructions()
	var/formatted_instructions = "Format this command like so: <COMMAND ID[modifier_description ? ":[modifier_description]>" : ">"]. This command will return:"

/**
 * Takes the input and processes it, returning a response.
 */
/datum/interaction_instance/proc/process_input(atom/movable/interactor, list/inputs, datum/interaction_matrix/incoming_matrix)
	matrix_callback = CALLBACK(incoming_matrix, PROC_REF(interaction_finished))
	INVOKE_ASYNC(src, PROC_REF(do_input), WEAKREF(interactor), input)

/datum/interaction_instance/proc/do_input(atom/movable/interactor, input)
	return FALSE

/datum/interaction_instance/proc/finish_input(output)
	matrix_callback.Invoke(output, src)


// SAY interaction
/datum/interaction_instance/say
	interaction_id = INTERACTION_MATRIX_ID_SAY
	description = "Enables you to say something in game as your entity."
	modifier_description = "The text you want to say."

/datum/interaction_instance/say/do_input(datum/weakref/interactor_weakref, input)
	var/atom/movable/interactor = interactor_weakref?.resolve()
	if(!interactor)
		return FALSE
	interactor.say(input)
	finish_input()

// EMOTE interaction
/datum/interaction_instance/emote
	interaction_id = INTERACTION_MATRIX_ID_EMOTE
	description = "Enables you to emote something in game as your entity."
	modifier_description = "The text you want to emote."

/datum/interaction_instance/emote/do_input(datum/weakref/interactor_weakref, input)
	var/atom/movable/interactor = interactor_weakref?.resolve()
	if(!interactor)
		return FALSE
	interactor.say(input)
	finish_input()

// LOOKAROUND interaction
/datum/interaction_instance/lookaround
	interaction_id = INTERACTION_MATRIX_ID_LOOKAROUND
	description = "Enables you to look around in game as your entity."
	modifier_description = null
	return_description = "A list of things that you can see. Formatted like this:(REF)(NAME)(DESCRIPTION)"

/datum/interaction_instance/lookaround/do_input(datum/weakref/interactor_weakref, input)
	var/atom/movable/interactor = interactor_weakref?.resolve()
	if(!interactor)
		return FALSE
	var/seen_items
	for(var/atom/movable/iterating_movable in view(6, interactor))
		seen_items += "([REF(iterating_movable)])([iterating_movable.name])([iterating_movable.description])()"
