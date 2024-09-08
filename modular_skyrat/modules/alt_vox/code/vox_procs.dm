// Make sure that the code compiles with AI_VOX undefined
#ifdef AI_VOX
#define VOX_DELAY 300

/mob/living/silicon/ai
	/// The currently selected VOX Announcer voice.
	var/vox_type = VOX_BMS
	/// The list of available VOX Announcer voices to choose from.
	var/list/vox_voices = list(VOX_HL, VOX_NORMAL, VOX_BMS)
	/// The VOX word(s) that were previously inputed.
	var/vox_word_string

/mob/living/silicon/ai/verb/announcement_help()

	set name = "Announcement Help"
	set desc = "Display a list of vocal words to announce to the crew."
	set category = "AI Commands"

	if(incapacitated)
		return

	var/dat = {"
	<font class='bad'>WARNING:</font> Misuse of the announcement system will get you job banned.<BR><BR>
	Here is a list of words you can type into the 'Announcement' button to create sentences to vocally announce to everyone on the same level at you.<BR>
	<UL><LI>You can also click on the word to PREVIEW it.</LI>
	<LI>You can only say 30 words for every announcement.</LI>
	<LI>Do not use punctuation as you would normally, if you want a pause you can use the full stop and comma characters by separating them with spaces, like so: 'Alpha . Test , Bravo'.</LI>
	<LI>Numbers are in word format, e.g. eight, sixty, etc </LI>
	<LI>Sound effects begin with an 's' before the actual word, e.g. scensor</LI>
	<LI>Use Ctrl+F to see if a word exists in the list.</LI></UL><HR>
	"}
	switch(vox_type)
		if(VOX_NORMAL)
			var/index = 0
			for(var/word in GLOB.vox_sounds)
				index++
				dat += "<A href='?src=[REF(src)];say_word=[word]'>[capitalize(word)]</A>"
				if(index != GLOB.vox_sounds.len)
					dat += " / "
		if(VOX_HL)
			var/index = 0
			for(var/word in GLOB.vox_sounds_hl)
				index++
				dat += "<A href='?src=[REF(src)];say_word=[word]'>[capitalize(word)]</A>"
				if(index != GLOB.vox_sounds_hl.len)
					dat += " / "
		if(VOX_MIL)
			var/index = 0
			for(var/word in GLOB.vox_sounds_mil)
				index++
				dat += "<A href='?src=[REF(src)];say_word=[word]'>[capitalize(word)]</A>"
				if(index != GLOB.vox_sounds_mil.len)
					dat += " / "
		if(VOX_BMS)
			var/index = 0
			for(var/word in GLOB.vox_sounds_bms)
				index++
				dat += "<A href='?src=[REF(src)];say_word=[word]'>[capitalize(word)]</A>"
				if(index != GLOB.vox_sounds_bms.len)
					dat += " / "

	var/datum/browser/popup = new(src, "announce_help", "Announcement Help", 500, 400)
	popup.set_content(dat)
	popup.open()


/mob/living/silicon/ai/proc/announcement()
	var/static/announcing_vox = 0 // Stores the time of the last announcement
	if(announcing_vox > world.time)
		to_chat(src, span_notice("Please wait [DisplayTimeText(announcing_vox - world.time)]."))
		return

	var/message = input(src, "WARNING: Misuse of this verb can result in you being job banned. More help is available in 'Announcement Help'", "Announcement", src.last_announcement) as text|null

	if(!message || announcing_vox > world.time)
		return

	last_announcement = message

	if(incapacitated)
		return

	if(control_disabled)
		to_chat(src, span_warning("Wireless interface disabled, unable to interact with announcement PA."))
		return

	var/list/words = splittext(trim(message), " ")
	var/list/incorrect_words = list()

	if(words.len > 30)
		words.len = 30

	switch(vox_type)
		if(VOX_NORMAL)
			for(var/word in words)
				word = lowertext(trim(word))
				if(!word)
					words -= word
					continue
				if(!GLOB.vox_sounds[word])
					incorrect_words += word
		if(VOX_HL)
			for(var/word in words)
				word = lowertext(trim(word))
				if(!word)
					words -= word
					continue
				if(!GLOB.vox_sounds_hl[word])
					incorrect_words += word
		if(VOX_MIL)
			for(var/word in words)
				word = lowertext(trim(word))
				if(!word)
					words -= word
					continue
				if(!GLOB.vox_sounds_mil[word])
					incorrect_words += word
		if(VOX_BMS)
			for(var/word in words)
				word = lowertext(trim(word))
				if(!word)
					words -= word
					continue
				if(!GLOB.vox_sounds_bms[word])
					incorrect_words += word

	if(incorrect_words.len)
		to_chat(src, span_notice("These words are not available on the announcement system: [english_list(incorrect_words)]."))
		return

	announcing_vox = world.time + VOX_DELAY

	log_game("[key_name(src)] made a vocal announcement with the following message: [message].")
	log_talk(message, LOG_SAY, tag="VOX Announcement")
	say(";[message]", forced = "VOX Announcement")

	for(var/word in words)
		play_vox_word(word, src.z, null, vox_type)


/proc/play_vox_word(word, z_level, mob/only_listener, vox_type)

	word = lowertext(word)
	var/sound_file
	var/volume = 100
	switch(vox_type)
		if(VOX_HL)
			if(GLOB.vox_sounds_hl[word])
				sound_file = GLOB.vox_sounds_hl[word]
				volume = 75
		if(VOX_MIL)
			if(GLOB.vox_sounds_mil[word])
				sound_file = GLOB.vox_sounds_mil[word]
				volume = 50 // My poor ears...
		if(VOX_BMS)
			if(GLOB.vox_sounds_bms[word])
				sound_file = GLOB.vox_sounds_bms[word]
		else
			if(GLOB.vox_sounds[word])
				sound_file = GLOB.vox_sounds[word]
	// If the vox stuff are disabled, or we failed getting the word from the list, just early return.
	if(!sound_file)
		return FALSE
	var/sound/voice = sound(sound_file, wait = 1, channel = CHANNEL_VOX, volume = volume)
	voice.status = SOUND_STREAM

	// If there is no single listener, broadcast to everyone in the same z level
	if(!only_listener)
		// Play voice for all mobs in the z level
		for(var/mob/player_mob in GLOB.player_list)
			if(!player_mob.can_hear() || !(safe_read_pref(player_mob.client, /datum/preference/toggle/sound_announcements)))
				continue

			var/turf/player_turf = get_turf(player_mob)
			if(player_turf.z != z_level)
				continue

			SEND_SOUND(player_mob, voice)

	else
		SEND_SOUND(only_listener, voice)

	return TRUE


/mob/living/silicon/ai/verb/switch_vox()
	set name = "Switch Vox Voice"
	set desc = "Switch your VOX announcement voice!"
	set category = "AI Commands"

	if(incapacitated)
		return
	var/selection = tgui_input_list(src, "Please select a new VOX voice:", "VOX VOICE", vox_voices)
	if(selection == null)
		return
	vox_type = selection

	to_chat(src, "Vox voice set to [vox_type]")


/mob/living/silicon/ai/verb/display_word_string()
	set name = "Display Word String"
	set desc = "Display the list of recently pressed vox lines."
	set category = "AI Commands"

	if(incapacitated)
		return

	to_chat(src, vox_word_string)

/mob/living/silicon/ai/verb/clear_word_string()
	set name = "Clear Word String"
	set desc = "Clear recent vox words."
	set category = "AI Commands"

	vox_word_string = ""

#undef VOX_DELAY
#endif
