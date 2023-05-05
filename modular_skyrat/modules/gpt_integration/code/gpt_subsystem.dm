SUBSYSTEM_DEF(gpt)
	name = "GPT"
	flags = SS_NO_FIRE
	/// Our API key for the GPT API.
	var/api_key
	/// A list of available GPT-style models, fetched from OpenAI API.
	var/list/gpt_models = list()
	/// A list of currently available endpoint datums. List is associative. endpoint_id = endpoint
	var/list/endpoints = list()
	/// A list of queued and waiting responses from the GPT API.
	var/list/queued_responses = list()
	/// A list of actively running GPT conversations.
	var/list/conversations = list()

/datum/controller/subsystem/gpt/Initialize()
	// CHECK API KEY EXISTS
	api_key = CONFIG_GET(string/gpt_api_key)

	if(!api_key)
		return SS_INIT_NO_NEED

	// Fetch all of them models using a rudamentary API call.
	gpt_models = get_models()

	// Populate the endpoint list with all the available endpoints.
	for(var/gpt_endpoint_type in typesof(/datum/gpt_endpoint_config))
		var/datum/gpt_endpoint_config/new_endpoint = new(gpt_endpoint_type)
		endpoints[new_endpoint.endpoint_id] = new_endpoint

/**
 * initialise_conversation
 *
 * Initiates a conversation with the GPT API and creates a conversation thread.
 *
 * Returns: A unique identifier for the conversation for further reference down the line.
 */
/datum/controller/subsystem/gpt/proc/initialise_conversation(preconditioning_prefix, endpoint_id)
	if(!api_key)
		return

	var/datum/gpt_conversation/new_conversation = new(preconditioning_prefix, endpoint_id)
	var/conversation_reference = REF(new_conversation)
	conversations[conversation_reference] = new_conversation

	return conversation_reference

/**
 * converse
 *
 * The main proc for conversing with the GPT API when you want to keep conversation history.
 *
 * message: The message to send to the GPT API.
 * conversation_ref: The conversation reference that was returned from initialise_conversation.
 * role: The role of the message, either GPT_ROLE_USER or GPT_ROLE_SYSTEM.
 *
 * Returns: The deformatted response from the GPT API.
*/
/datum/controller/subsystem/gpt/proc/converse(message, conversation_ref, role = GPT_ROLE_USER)
	if(!api_key)
		return

	if(!conversations[conversation_ref])
		return

	if(conversation_ref in queued_responses)
		return

	var/datum/gpt_conversation/chat_holder = conversations[conversation_ref]

	// Add the message to the chat holder
	chat_holder.add_message(message, role)

	queued_responses += conversation_ref

	// Send the request to the GPT API
	var/list/response = send_gpt_request(chat_holder.messages, chat_holder.endpoint_id)

	queued_responses -= conversation_ref

	// Add the response to the chat holder
	for(var/response_message in response)
		chat_holder.add_message(response_message, response[response_message])

	return deformat_single_message(response)

/**
 * terminate_conversation
 *
 * Terminates a conversation with the GPT API and removes it from the conversation list.
*/
/datum/controller/subsystem/gpt/proc/terminate_conversation(conversation_ref)
	if(!conversations[conversation_ref])
		return

	if(conversation_ref in queued_responses)
		UNTIL(!(conversation_ref in queued_responses))

	LAZYREMOVE(conversations, conversations[conversation_ref])

/datum/controller/subsystem/gpt/proc/get_conversation(conversation_ref)
	return conversations[conversation_ref]

/**
 * send_gpt_request
 *
 * Sends a HTTP request to the GPT API using the request header and request body procs.
 *
 * messages_to_send: The messages to send to the GPT API. They must be formatted correctly otherwise the request will fail.
 * The correct format is as follows:
 * list(list("role" = ROLE TYPE HERE, "content" = CONTENT HERE))
 *
 * Role is used to define where the message has come from, if it's the AI or the user.
 *
 * Content is the actual message that is being sent.
 *
 * You can have multiple messages in the list with different role types. This enables you to have advanced conversations with the AI.
 *
 * Naturally this is not ASYNC and will block the thread until the request is complete.
 *
 */
/datum/controller/subsystem/gpt/proc/send_gpt_request(messages_to_send, endpoint_id = GPT_ENDPOINT_ID_CHAT, model_override)
	if(!api_key)
		return

	var/datum/gpt_endpoint_config/selected_endpoint = endpoints[endpoint_id]

	// Create the HTTP request
	var/datum/http_request/request = selected_endpoint.create_http_request(messages_to_send)

	// Send the request and wait for the response
	request.begin_async()

	UNTIL(request.is_complete())

	return selected_endpoint.process_http_response(request.into_response())

/**
 * get_models
 *
 * Fetches all of the available GPT models from the OpenAI API.
 *
 * Returns: A list of all of the available GPT models.
 */
/datum/controller/subsystem/gpt/proc/get_models()
	// Set up the required headers and URL for the GPT API
	var/list/headers = list("Authorization" = "Bearer [api_key]")
	var/url = "https://api.openai.com/v1/models"

	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_GET, url, "", headers)

	// Send the request and wait for the response
	request.begin_async()

	UNTIL(request.is_complete())

	var/datum/http_response/response = request.into_response()
	var/list/response_json = json_decode(response["body"])

	if(LAZYLEN(response_json["error"]))
		CRASH("GPT RESPONSE ERROR: [response_json["error"]["message"]]")

	var/list/models = list()
	for(var/model_data in response_json["data"])
		models += model_data["id"]

	return models


/**
 * send signle request
 *
 * Sends a single request to GPT, the conversation is not logged or stored.
 */
/datum/controller/subsystem/gpt/proc/send_single_request(message, role = GPT_ROLE_USER, endpoint_id, preconditioning_prefix)
	if(!api_key)
		return message

	var/list/formatted_payload = list()
	if(preconditioning_prefix)
		formatted_payload += format_message(preconditioning_prefix, GPT_ROLE_SYSTEM)

	formatted_payload += format_message(message, role)

	return deformat_single_message(send_gpt_request(formatted_payload, endpoint_id))

/**
 * format message
 *
 * Takes a single message and formats it for the GPT API.
 */
/datum/controller/subsystem/gpt/proc/format_message(message, role)
	return list(list("role" = role, "content" = message))

/**
 * Takes a signle message payload and removes the role.
 */
/datum/controller/subsystem/gpt/proc/deformat_single_message(payload)
	for(var/message in payload)
		return message
