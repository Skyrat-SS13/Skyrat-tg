/**
 * GPT Endpoint Config
 *
 * GPT endpoints are used to communicate with the GPT API using HTTP requests and are set up according to the GPT API documentation.
 * Each endpoint has a unique function and interacts with a different Open AI API. These will be cached in the GPT Subsystem and
 * can be accessed accordingly.
 *
 * For each variable on this datum please reference the open AI API documentation: https://platform.openai.com/docs/api-reference
 *
 * For the base endpoint, we are utilising the CHAT model: https://platform.openai.com/docs/api-reference/chat
 *
 * Please note that endpoints are not intended to be used to store any information and only act as a way to communicate with the GPT API.
 */

/datum/gpt_endpoint_config
	/// The ID of the endpoint. This is used to identify the endpoint in the GPT system.
	var/endpoint_id = GPT_ENDPOINT_ID_CHAT
	/// The API URL of this endpoint
	var/url = GPT_API_URL_CHAT
	/// The HTTP method of this endpoint
	var/method = RUSTG_HTTP_METHOD_POST
	/// The recommended GPT model for this endpoint
	var/recommended_model = "gpt-3.5-turbo"
	/// What is the maximum amount of tokens we can generate per request?
	var/max_tokens = GPT_DEFAULT_MAX_TOKENS
	/// What is the temperature of the model?
	var/temperature = GPT_DEFAULT_TEMPERATURE
	/// How many responses should we generate?
	var/number_to_generate = GPT_DEFAULT_NUMBER_TO_GENERATE



/**
 * form_api_request_body
 *
 * Forms the request body for the GPT API.
 */

/datum/gpt_endpoint_config/proc/form_api_request_body(messages, model_override)
	var/list/api_body = list(
		"model" = model_override ? model_override : recommended_model,
		"messages" = messages,
		"max_tokens" = max_tokens,
		"temperature" = temperature,
		"n" = number_to_generate,
		"user" = CONFIG_GET(string/gpt_api_user),
	)

	return api_body

/**
 * form_api_request_header
 *
 * Forms the request header for the GPT API.
 *
 * api_key: The API key to use for the request.
 */
/datum/gpt_endpoint_config/proc/form_api_request_header(api_key)
	return list("Authorization" = "Bearer [api_key]", "Content-Type" = "application/json")

/**
 * create_http_request
 *
 * Creates an HTTP request to the GPT API using the request header and request body procs.
 *
 * Returns: The HTTP request.
 */
/datum/gpt_endpoint_config/proc/create_http_request(messages_to_send, model_override)
	// Set up the required headers for the GPT API
	var/list/headers = form_api_request_header(SSgpt.api_key)

	// Create the JSON body for the request
	var/list/body = form_api_request_body(messages_to_send, model_override)

	// Encode the json for export
	var/body_json = json_encode(body)

	// Create a new HTTP request
	var/datum/http_request/request = new()

	// Set up the HTTP request
	request.prepare(method, url, body_json, headers)

	return request


/**
 * process_http_response
 *
 * Processes the HTTP response from the GPT API and formats it correctly while also handling any errors that occur.
 *
 * Returns: The formatted messages list, format is as follows:
 * message = role
 *
 * As we do not want to cause other things to crash with null responses, we just send the error reason! Easier debugging.
 */
/datum/gpt_endpoint_config/proc/process_http_response(datum/http_response/incoming_response)
	var/list/responses = list()

	if(incoming_response.errored && incoming_response.status_code != 200)
		stack_trace("GPT REQUEST ERROR: [incoming_response.error]")
		responses += list(GPT_RESPONSE_ID_ROLE = "error", GPT_RESPONSE_ID_CONTENT = "HTTP ERROR: [incoming_response.error]")
		return responses

	var/list/incoming_response_json = json_decode(incoming_response["body"])

	if(LAZYLEN(incoming_response_json["error"]))
		stack_trace("GPT RESPONSE ERROR: [incoming_response_json["error"]["message"]]")
		responses += list(GPT_RESPONSE_ID_ROLE = "error", GPT_RESPONSE_ID_CONTENT = "GPT RESPONSE ERROR: [incoming_response_json["error"]["message"]]")
		return responses

	for(var/list/message in incoming_response_json["choices"]["message"])
		responses += list(GPT_RESPONSE_ID_ROLE = message[GPT_RESPONSE_ID_ROLE], GPT_RESPONSE_ID_CONTENT = message[GPT_RESPONSE_ID_CONTENT])

	return responses
