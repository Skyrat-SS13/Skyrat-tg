/atom/movable/screen/screentip/away_dialogue
	screen_loc = "TOP,CENTER"
	maptext_y = -30
	maptext_x = -130
	maptext_width = 300
	maptext_height = 480
	/// Time to remove the text
	var/clear_text_delay = 10 SECONDS
	/// TIme to set 1 character on `clear_text_slow()`
	var/slow_set_per_char = 1
	/// Are we currently clearing/creating text?
	var/setting_text = FALSE
	/// Pre-clear message, used to ensure proper use of the slow text clearing
	var/pre_decay_message = ""

/atom/movable/screen/screentip/away_dialogue/Initialize(mapload, _hud)
	. = ..()
	maptext_width = 300

/// Simple proc to set the dialogue's text
/atom/movable/screen/screentip/away_dialogue/proc/set_text(text, raw_msg)
	maptext = text
	pre_decay_message = text
	addtimer(CALLBACK(src, .proc/clear_text), clear_text_delay)

/// Test this especially, proc to add dialogue to the screentip char-by-char
/atom/movable/screen/screentip/away_dialogue/proc/set_text_slow(text, raw_msg)
	if(setting_text && (maptext == text))
		setting_text = FALSE
		addtimer(CALLBACK(src, .proc/clear_text), clear_text_delay)
		return
	maptext = copytext(text, 1, length(maptext) + 1)
	pre_decay_message = maptext
	setting_text = maptext != text ? TRUE : FALSE
	addtimer(CALLBACK(src, .proc/set_text_slow, text, raw_msg), slow_set_per_char)

/// Wipes the dialogue of the screentip
/atom/movable/screen/screentip/away_dialogue/proc/clear_text()
	maptext = ""
	pre_decay_message = ""

/// Wipes the dialogue of the tip character-by-character
/atom/movable/screen/screentip/away_dialogue/proc/clear_text_slow()
	if(setting_text && (maptext == pre_decay_message))
		setting_text = FALSE
		return
	maptext = copytext(maptext, 1, length(maptext) - 1)
	setting_text = maptext != "" ? TRUE : FALSE
	addtimer(CALLBACK(src, .proc/clear_text_slow), slow_set_per_char)
