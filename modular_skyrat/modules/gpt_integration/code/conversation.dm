/**
 * A datum for holding a GPT conversation, used in API Chat Completion.
 */

/datum/component/gpt_conversation
	/// A reference to our conversation in the GPT subsystem.
	var/conversation_ref
	/// The endpoint ID we use for conversing.
	var/endpoint_id = GPT_ENDPOINT_ID_CHAT
	/// The prefix that we will use to get GPT into character.
	var/conditioning_prefix = GPT_CONDITIONING_PREFIX_SS13_1
	/// Are we waiting for a response from GPT?
	var/busy = FALSE


/datum/component/gpt_conversation/Initialize(...)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, PROC_REF(on_attack_hand))
	RegisterSignal(parent, COMSIG_MOVABLE_HEAR, PROC_REF(on_hear_message))

	conversation_ref = SSgpt.initialise_conversation(conditioning_prefix, endpoint_id)

/datum/component/gpt_conversation/proc/on_attack_hand(datum/source, mob/user, list/modifiers)
	SIGNAL_HANDLER

	if(busy)
		to_chat(user, span_danger("[parent] is talking! Wait for them to finish."))
		return

	INVOKE_ASYNC(src, PROC_REF(user_converse), user)

	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/gpt_conversation/proc/on_hear_message(datum/source, list/hearing_args)
	SIGNAL_HANDLER

	if(busy)
		return

	var/mob/speaker = hearing_args[HEARING_SPEAKER]

	if(get_dist(speaker, parent) > 3)
		return

	var/message = "[speaker] : [hearing_args[HEARING_RAW_MESSAGE]]"

	INVOKE_ASYNC(src, PROC_REF(converse), message)

/mob/living/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods, message_range)
	. = ..()


/datum/component/gpt_conversation/proc/user_converse(mob/user)
	var/message = tgui_input_text(user, "What would you like to say?", "Converse!")

	if(!message)
		return

	var/formatted_message = "[user] : [message]"

	converse(formatted_message)

/datum/component/gpt_conversation/proc/converse(message_to_send, role = GPT_ROLE_USER, silent)
	busy = TRUE

	if(!silent && ismob(parent))
		var/mob/parent_mob = parent
		parent_mob.thinking_IC = TRUE
		parent_mob.create_typing_indicator()

	var/response = SSgpt.converse(message_to_send, conversation_ref, role)

	if(!silent && ismob(parent))
		var/mob/parent_mob = parent
		parent_mob.thinking_IC = FALSE
		parent_mob.remove_typing_indicator()

	busy = FALSE
	var/atom/movable/parent_atom = parent
	parent_atom.say(response, forced = TRUE)



/datum/component/gpt_conversation/monkey
	conditioning_prefix = GPT_CONDITIONING_PREFIX_SS13_1_MONKEY
