/**
 * The procedure to check the text of the entered messages on ntnrc_client.dm
 *
 * The procedure checks the entered text for emptiness and the presence of control characters. 
 * If the text contains control characters or is empty, the procedure returns an empty value. 
 * Arguments:
 * * text - Message Text
 */
/proc/reject_bad_message(text)
	var/non_whitespace = FALSE
	var/char = ""
	for(var/i = 1, i <= length(text), i += length(char))
		char = text[i]
		switch(text2ascii(char))
			if(0 to 31)
				return
			if(32)
				continue
			else
				non_whitespace = TRUE
		if (non_whitespace)
			return text

/**
 * The procedure for checking the text of the entered username on the file ntnrc_client.dm
 *
 * The procedure checks the entered username for emptiness, presence of control characters and length. 
 * If the text contains control characters, is empty or too long, the procedure returns an empty value.
 * * text - Username Text
 * * max_length - Allowable length
 */
/proc/reject_bad_username(text, max_length = 32)
	var/non_whitespace = FALSE
	var/char = ""
	
	if(length(text) > max_length)
		return
	else
		for(var/i = 1, i <= length(text), i += length(char))
			char = text[i]
			switch(text2ascii(char))
				if(0 to 31)
					return
				if(32)
					continue
				else
					non_whitespace = TRUE
		if (non_whitespace)
			return text

/**
 * The procedure for checking the text of the entered chat name in the file ntnrc_client.dm
 *
 * The procedure checks the entered text for emptiness, presence of control characters and length. 
 * If the text contains control characters, is empty or too long, the procedure returns an empty value.
 * * text - Chat Text
 * * max_length - Allowable length
 */
/proc/reject_bad_chatname(text, max_length = 12)
	var/non_whitespace = FALSE
	var/char = ""
	
	if (length(text) > max_length)
		return
	else
		for(var/i = 1, i <= length(text), i += length(char))
			char = text[i]
			switch(text2ascii(char))
				if(0 to 31)
					return
				if(32)
					continue
				else
					non_whitespace = TRUE
		if (non_whitespace)
			return text
