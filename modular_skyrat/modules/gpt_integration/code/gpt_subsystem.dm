SUBSYSTEM_DEF(gpt)
	name = "GPT"
	wait = 0.1 SECONDS
	/// Our API key for the GPT API.
	var/api_key
	/// A list of available GPT-style models, fetched from OpenAI API.
	var/list/gpt_models = list()
	/// A list of currently available endpoint datums. List is associative. endpoint_id = endpoint
	var/list/endpoints = list()
	/// A list of queued and waiting responses from the GPT API.
	var/list/queued_requests = list()
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

/datum/controller/subsystem/gpt/Destroy()
	QDEL_LIST(queued_requests)
	QDEL_LIST(conversations)
	QDEL_LIST(endpoints)
	return ..()

/datum/controller/subsystem/gpt/fire()

	// We will now run through all currently queued responses and check if they have completed or not. If they have completed, make everyone aware of this.
	for(var/datum/gpt_message_request/iterating_request as anything in queued_requests)
		// Check to see if we have a completed response.
		if(!iterating_request.process_request())
			continue

		queued_requests -= iterating_request
		qdel(iterating_request)

/**
 * initialise_conversation
 *
 * Initiates a conversation with the GPT API and creates a conversation thread.
 *
 * Returns: A the conversation for further reference down the line.
 */
/datum/controller/subsystem/gpt/proc/initialise_conversation(preconditioning_prefix, endpoint_id)
	if(!api_key)
		return

	var/datum/gpt_conversation/new_conversation = new(preconditioning_prefix, endpoint_id)
	var/conversation_ref = REF(new_conversation)
	conversations[new_conversation] = conversation_ref

	// Tracking of conversation, if it's deleted, well, we must kill and conversation threads and delete it.
	RegisterSignal(new_conversation, COMSIG_PARENT_QDELETING, PROC_REF(terminate_conversation))

	return new_conversation

/**
 * converse
 *
 * The main proc for conversing with the GPT API when you want to keep conversation history.
 *
 * message: The message to send to the GPT API.
 * conversation_ref: The conversation reference that was returned from initialise_conversation.
 * role: The role of the message, either GPT_ROLE_USER or GPT_ROLE_SYSTEM.
 * callback_to_call: The callback to call when the conversation has recieved a response from the GPT API.
 *
 * Returns: The message request.
*/
/datum/controller/subsystem/gpt/proc/converse(message, conversation_ref, role = GPT_ROLE_USER, datum/callback/callback_to_call)
	if(!api_key)
		return

	if(!(conversation_ref in conversations))
		return

	var/datum/gpt_conversation/conversation = conversations[conversation_ref]

	// Add the message to the chat holder
	conversation.add_message(message, role)

	// Send the request to the GPT API
	return create_gpt_request(messages_to_send = conversation.messages, endpoint_id = conversation.endpoint_id, callback_to_call = callback_to_call)

/**
 * terminate_conversation
 *
 * Terminates a conversation with the GPT API and removes it from the conversation list.
*/
/datum/controller/subsystem/gpt/proc/terminate_conversation(datum/gpt_conversation/conversation)
	SIGNAL_HANDLER

	if(!(conversation in conversations))
		return

	// Check if there is an active request, if so, cancel it.
	for(var/datum/gpt_message_request/iterating_request as anything in queued_requests)
		if(iterating_request.conversation == conversation)
			iterating_request.cancel_request()
			queued_requests -= iterating_request
			qdel(iterating_request)

	UnregisterSignal(conversation, COMSIG_PARENT_QDELETING)

	LAZYREMOVE(conversations, conversation)

/datum/controller/subsystem/gpt/proc/get_conversation(conversation_ref)
	for(var/conversation in conversations)
		if(conversation_ref == conversations[conversation])
			return conversation

/**
 * create_gpt_request
 *
 * Creates a GPT message request and adds it to the queued responses list.
 *
 * messages_to_send: The messages to send to the GPT API. They must be formatted correctly otherwise the request will fail.
 * The correct format is as follows:
 * list(list(GPT_RESPONSE_ID_ROLE = ROLE TYPE HERE, GPT_RESPONSE_ID_CONTENT = CONTENT HERE))
 * endpoint_id: The endpoint to send the request to. This is usually the chat endpoint.
 * model_override: The model to use for this request. If left blank, it will use the default model for the endpoint.
 * conversation: The conversation to send the request to. If left blank, it will not be sent to a conversation.
 * callback_to_call: The callback to call when the request has been completed.
 * manual_checking: If true, the request will not be automatically checked for completion. You will have to manually check it yourself. - Ideally
 * you won't really use this, the subsystem is there for a reason.
 *
 * You can have multiple messages in the list with different role types. This enables you to have advanced conversations with the AI.
 *
 * This will return the message request datum that was created so you can keep track of it.
 */
/datum/controller/subsystem/gpt/proc/create_gpt_request(messages_to_send, endpoint_id = GPT_ENDPOINT_ID_CHAT, model_override, datum/gpt_conversation/conversation, datum/callback/callback_to_call, manual_checking)
	if(!api_key)
		return

	// Create and queue a new request datum
	var/datum/gpt_message_request/request_datum = new(
		incoming_messages = messages_to_send,
		incoming_endpoint = endpoints[endpoint_id],
		incoming_conversation = conversation,
		incoming_callback = callback_to_call,
		incoming_model_override = model_override
	)

	if(!manual_checking)
		// Send the initial request
		request_datum.start_request()
		queued_requests += request_datum

	return request_datum

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

	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_GET, GPT_API_URL_MODELS, "", headers)

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
 * send single request
 *
 * Sends a single request to GPT, the conversation is not logged or stored, but a request is still created for callback.
 *
 * message: The message to send to the GPT API.
 * role: The role of the message, either GPT_ROLE_USER or GPT_ROLE_SYSTEM.
 * endpoint_id: The endpoint ID to send the message to, check available endpoints for more information.
 * preconditioning_prefix: The prefix to send to the GPT API before the actual message, this is used to set the context of the conversation.
 * callback_to_call: The callback to call when the conversation has recieved a response from the GPT API.
 * manual_checking: If this is set to TRUE, the request will not be automatically checked for a response by the subsystem, you will have to manually check it.
 * model_override: The model to use for this request, if left blank, it will use the default model for the endpoint.
 */
/datum/controller/subsystem/gpt/proc/send_single_request(message, role = GPT_ROLE_USER, endpoint_id, preconditioning_prefix, datum/callback/callback_to_call, manual_checking, model_override)
	if(!api_key)
		return message

	var/list/formatted_payload = list()
	if(preconditioning_prefix)
		formatted_payload += format_message(preconditioning_prefix, GPT_ROLE_SYSTEM)

	formatted_payload += format_message(message, role)

	return create_gpt_request(messages_to_send = formatted_payload, endpoint_id = endpoint_id, model_override = model_override, callback_to_call = callback_to_call, manual_checking = manual_checking)

/**
 * format message
 *
 * Takes a single message and formats it for the GPT API.
 */
/datum/controller/subsystem/gpt/proc/format_message(message, role)
	return list(list(GPT_RESPONSE_ID_ROLE = role, GPT_RESPONSE_ID_CONTENT = message))

/**
 * Takes a signle message payload and removes the role.
 */
/datum/controller/subsystem/gpt/proc/deformat_single_message(payload)
	if(LAZYLEN(payload) < 2)
		return payload[1][GPT_RESPONSE_ID_CONTENT]
	var/list/messages = list()
	for(var/message in payload)
		messages += message[GPT_RESPONSE_ID_CONTENT]
	return messages


// This datum represents a request to a GPT endpoint.
/datum/gpt_message_request
	/// The configuration of the endpoint to which the request is being sent.
	var/datum/gpt_endpoint_config/endpoint
	/// An optional override for the model to be used for the request.
	var/model_override
	/// A list of messages to send in the request.
	var/list/messages_to_send
	/// The HTTP request object that will carry out the request.
	var/datum/http_request/request
	/// The conversation that this request is part of.
	var/datum/gpt_conversation/conversation
	/// A callback to be executed when the request is processed.
	var/datum/callback/callback

// The constructor for a GPT message request.
/datum/gpt_message_request/New(incoming_messages, incoming_endpoint, incoming_conversation, incoming_callback, incoming_model_override)
	endpoint = incoming_endpoint
	conversation = incoming_conversation
	callback = incoming_callback
	model_override = incoming_model_override
	messages_to_send = incoming_messages

// Cleans up the request object when it is destroyed.
/datum/gpt_message_request/Destroy(force, ...)
	endpoint = null
	conversation = null
	QDEL_NULL(request)
	QDEL_NULL(callback)
	return ..()

// Starts the request to the GPT endpoint.
/datum/gpt_message_request/proc/start_request()
	request = endpoint.create_http_request(messages_to_send, model_override)
	request.begin_async()

// Checks if the HTTP request is complete. Only used for manual checking.
/datum/gpt_message_request/proc/check_request()
	return request.is_complete()

// Checks the status of the request and processes the response if it is complete.
/datum/gpt_message_request/proc/process_request()
	if(!request.is_complete())
		return FALSE

	var/datum/http_response/response = request.into_response()
	var/list/processed_responses = endpoint.process_http_response(response)

	// Add the message to the conversation we have automatically.
	if(conversation)
		for(var/list/response_message in processed_responses)
			conversation.add_message(response_message[GPT_RESPONSE_ID_CONTENT], response_message[GPT_RESPONSE_ID_ROLE])
		SEND_SIGNAL(conversation, COMSIG_GPT_CONVERSATION_RESPONSE_RECEIVED, processed_responses)

	callback?.Invoke(processed_responses)
	SEND_SIGNAL(src, COMSIG_GPT_MESSAGE_REQUEST_PROCESSED, processed_responses)

	return processed_responses

// Cancels the request and calls the callback with a cancellation message.
/datum/gpt_message_request/proc/cancel_request()
	var/list/processed_responses = list("REQUEST CANCELLED" = "REQUEST CANCELLED")
	callback?.Invoke(processed_responses)
	SEND_SIGNAL(src, COMSIG_GPT_MESSAGE_REQUEST_PROCESSED, processed_responses)

