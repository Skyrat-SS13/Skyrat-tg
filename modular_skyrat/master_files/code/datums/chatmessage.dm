////
//	Modular runechat color selector solution
/datum/chatmessage/generate_image(text, atom/target, mob/owner, datum/language/language, list/extra_classes, lifespan)

	if(ismob(target))
		var/mob/speaker = target

		if(speaker.client?.prefs)
			if(speaker.chat_color_name != speaker.name)

				speaker.chat_color_name = speaker.name // So the main proc doesn't overwrite this


				// Check for the custom color if they have one
				var/enable_chat_color_player = speaker.client.prefs.read_preference(/datum/preference/toggle/enable_chat_color_player)
				if (enable_chat_color_player && speaker.name == speaker.real_name)
					var/chat_color_player = speaker.client.prefs.read_preference(/datum/preference/color/chat_color_player)
					var/hex_value = sanitize_hexcolor(chat_color_player)
					target.chat_color = hex_value
					target.chat_color_darkened = (hex_value + "c0") // Add an alpha-channel to darken


				// If they are acting as someone else, find out who
				if(speaker.name != speaker.real_name && speaker.name != "Unknown")
					for(var/mob/living/carbon/human/copy as anything in GLOB.player_list)
						if(speaker.name == copy.real_name && copy.client?.prefs)

							// Give them the color of the person they are acting as
							var/enable_chat_color_copy = copy.client.prefs.read_preference(/datum/preference/toggle/enable_chat_color_player)
							if(enable_chat_color_copy)
								var/chat_color_copy = copy.client.prefs.read_preference(/datum/preference/color/chat_color_player)
								var/hex_value = sanitize_hexcolor(chat_color_copy)
								target.chat_color = hex_value
								target.chat_color_darkened = (hex_value + "c0")

							else // If they have the pref disabled, run the default generator again
								target.chat_color = colorize_string(target.name)
								target.chat_color_darkened = colorize_string(target.name, 0.85, 0.85)

							break


				// Display as a static white if acting as 'unknown'
				if(speaker.name == "Unknown")
					target.chat_color = "#FFFFFF"
					target.chat_color_darkened = "#FFFFFFc0"

	return ..()
