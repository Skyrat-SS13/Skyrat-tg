#define INTERACTION_MATRIX_ID_SAY "SAY"
#define INTERACTION_MATRIX_ID_EMOTE "EMOTE"

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

/datum/interaction_matrix/New()
	// create and populate the interaction instances
	for(var/datum/interaction_instance/iterating_insance in initial_actions)
		iterating_instance = new()
		interaction_instances[iterating_instance.interaction_id] = iterating_instance

/**
 * process_interaction
 *
 * This will take a string and then process it into any interactions it mentions.
 *
 * It will return the combination of all processed interactions.
 */
/datum/interaction_matrix/process_interaction(atom/interactor, input)
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
		var/datum/interaction_instance/interaction_instance = interaction_instances[command]
		interaction_instance.process_input(interactor, command_list[command], src)


// This is a callback for when the interaction finishes.
/datum/interaction_matrix/interaction_finished(atom/movable/interactor, output)


/datum/interaction_matrix/proc/create_matrix_payload()
	var/interaction_payload = ""
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
	/// The list of possible inputs for this interaction.
	var/list/possible_inputs
	/// The compatible type for this interaction.
	var/list/compatible_types
	/// Our callback for when we finish processing.
	var/datum/callback/matrix_callback

/datum/interaction_instance/proc/get_formatted_inputs()
	var/formatted_inputs = ""
	for(var/input in possible_inputs)
		formatted_inputs += "[input]|"

	return formatted_inputs

/**
 * Takes the input and processes it, returning a response.
 */
/datum/interaction_instance/proc/process_input(atom/movable/interactor, input, datum/interaction_matrix/incoming_matrix)
	matrix_callback = CALLBACK(incoming_matrix, PROC_REF(interaction_finished))
	do_input(atom/movable/interactor, input

/datum/interaction_instance/proc/do_input()
	matrix_callback.invoke()

/datum/interaction_instance/proc/decode_input(input)
	var/decoded_input = ""
	var/list/input_modifiers = splittext_char(input, ":")

// SAY interaction
/datum/interaction_instance/say
	interaction_id = INTERACTION_MATRIX_ID_SAY
	possible_inputs = list(

	)

/datum/interaction_instance/say/process_input(atom/movable/interactor, input, datum/interaction_matrix/incoming_matrix)
	interactor.say(input)

// EMOTE interaction
/datum/interaction_instance/emote
	interaction_id = INTERACTION_MATRIX_ID_EMOTE

/datum/interaction_instance/emote/process_input(atom/movable/interactor, input)
	interactor
