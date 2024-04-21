/**
 * # Speech Component
 *
 * Sends a message. Requires a shell.
 *
 * This file is based off of speech.dm
 * Any changes made to that file should be copied over with discretion
 */
/obj/item/circuit_component/speech
	/// Whether the quiet mode flag is on or not
	var/datum/port/input/quietmode

/obj/item/circuit_component/speech/populate_ports()
	. = ..()
	quietmode = add_input_port("Quiet Mode", PORT_TYPE_NUMBER, default = 0) //Add new quiet mode port to component (and default to off)

/obj/item/circuit_component/speech/input_received(datum/port/input/port)
	if(!parent.shell)
		return

	if(TIMER_COOLDOWN_RUNNING(parent.shell, COOLDOWN_CIRCUIT_SPEECH))
		return

	if(message.value)
		var/atom/movable/shell = parent.shell
		shell.say(message.value, forced = "circuit speech | [parent.get_creator()]", message_range = quietmode.value ? WHISPER_RANGE : MESSAGE_RANGE)
		TIMER_COOLDOWN_START(shell, COOLDOWN_CIRCUIT_SPEECH, speech_cooldown)
