///Rave Visor - Gives you a rainbow visor and plays jukebox music to you.
/obj/item/mod/module/visor/rave
	name = "MOD rave visor module"
	desc = "A Super Cool Awesome Visor (SCAV), intended for modular suits."
	icon_state = "rave_visor"
	complexity = 1
	overlay_state_inactive = "module_rave"
	/// The client colors applied to the wearer.
	var/datum/client_colour/rave_screen
	/// The current element in the rainbow_order list we are on.
	var/rave_number = 1
	/// The track we selected to play.
	var/datum/track/selection
	/// A list of all the songs we can play.
	var/list/songs = list()
	/// A list of the colors the module can take.
	var/static/list/rainbow_order = list(
		list(1,0,0,0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0),
		list(1,0,0,0, 0,0.5,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0),
		list(1,0,0,0, 0,1,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0),
		list(0,0,0,0, 0,1,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0),
		list(0,0,0,0, 0,0.5,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0),
		list(1,0,0,0, 0,0,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0),
	)

/obj/item/mod/module/visor/rave/Initialize(mapload)
	. = ..()
	var/list/tracks = flist("[global.config.directory]/jukebox_music/sounds/")
	for(var/sound in tracks)
		var/datum/track/track = new()
		track.song_path = file("[global.config.directory]/jukebox_music/sounds/[sound]")
		var/list/sound_params = splittext(sound,"+")
		if(length(sound_params) != 3)
			continue
		track.song_name = sound_params[1]
		track.song_length = text2num(sound_params[2])
		track.song_beat = text2num(sound_params[3])
		songs[track.song_name] = track
	if(length(songs))
		var/song_name = pick(songs)
		selection = songs[song_name]

/obj/item/mod/module/visor/rave/on_activation()
	. = ..()
	if(!.)
		return
	rave_screen = mod.wearer.add_client_colour(/datum/client_colour/rave)
	rave_screen.update_colour(rainbow_order[rave_number])
	if(selection)
		mod.wearer.playsound_local(get_turf(src), null, 50, channel = CHANNEL_JUKEBOX, sound_to_use = sound(selection.song_path), use_reverb = FALSE)

/obj/item/mod/module/visor/rave/on_deactivation(display_message = TRUE, deleting = FALSE)
	. = ..()
	if(!.)
		return
	QDEL_NULL(rave_screen)
	if(selection)
		mod.wearer.stop_sound_channel(CHANNEL_JUKEBOX)
		if(deleting)
			return
		SEND_SOUND(mod.wearer, sound('sound/machines/terminal_off.ogg', volume = 50, channel = CHANNEL_JUKEBOX))

/obj/item/mod/module/visor/rave/generate_worn_overlay(mutable_appearance/standing)
	. = ..()
	for(var/mutable_appearance/appearance as anything in .)
		appearance.color = active ? rainbow_order[rave_number] : null

/obj/item/mod/module/visor/rave/on_active_process(seconds_per_tick)
	rave_number++
	if(rave_number > length(rainbow_order))
		rave_number = 1
	mod.wearer.update_clothing(mod.slot_flags)
	rave_screen.update_colour(rainbow_order[rave_number])

/obj/item/mod/module/visor/rave/get_configuration()
	. = ..()
	if(length(songs))
		.["selection"] = add_ui_configuration("Song", "list", selection.song_name, clean_songs())

/obj/item/mod/module/visor/rave/configure_edit(key, value)
	switch(key)
		if("selection")
			if(active)
				return
			selection = songs[value]

/obj/item/mod/module/visor/rave/proc/clean_songs()
	. = list()
	for(var/track in songs)
		. += track
