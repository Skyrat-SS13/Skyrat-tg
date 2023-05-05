/**
 * Chat Holders
 *
 * Chat holders are basically used to keep track of all the messages between GPT and the user in a correct format.
 */
/datum/gpt_conversation
	/// A list of all messages between GPT and the endpoint.
	var/list/messages = list()
	/// The endpoint ID that we use to communicate with.
	var/endpoint_id

/datum/gpt_conversation/New(conditioning_prefix, endpoint_id)
	if(conditioning_prefix)
		add_message(conditioning_prefix)

	src.endpoint_id = endpoint_id

/datum/gpt_conversation/proc/add_message(message, role = GPT_ROLE_USER)
	if(!message)
		return
	var/list/formatted_message = list(list("role" = role, "content" = message))
	messages += formatted_message

/datum/gpt_conversation/proc/remove_last_message()
	if(!LAZYLEN(messages))
		return
	LAZYREMOVE(messages, messages[LAZYLEN(messages)])

/datum/gpt_conversation/proc/clear_messages(include_prefix)
	if(include_prefix)
		messages = list()
		return
	if(LAZYLEN(messages) < 2)
		return
	var/index = 2
	for(var/message in messages)
		LAZYREMOVE(messages, messages[index])
		index++
