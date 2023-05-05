/client/proc/call_gpt()
	set category = "Admin.Fun"
	set name = "Call GPT API"
	set desc = "Gets a response from the GPT API."

	var/prompt = tgui_input_text(usr, "What would you like to prompt the GPT API with?", "Call GPT API")

	if(!prompt)
		return

	var/list/formatted_message = list(list("role" = GPT_ROLE_USER, "content" = prompt))

	var/selected_model = tgui_input_list(usr, "What model would you like to use?", "Call GPT API", SSgpt.gpt_models, GPT_DEFAULT_MODEL)

	var/list/responses = SSgpt.send_gpt_request(formatted_message, model_override = selected_model)

	for(var/message in responses)
		to_chat(usr, "RESPONSE | User: [responses[message]] | Message: [message]")

