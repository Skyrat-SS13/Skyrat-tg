/// The subsystem used to play ambience to users every now and then, makes them real excited.
SUBSYSTEM_DEF(ambience)
	name = "Ambience"
	flags = SS_BACKGROUND|SS_NO_INIT
	priority = FIRE_PRIORITY_AMBIENCE
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 1 SECONDS
	///Assoc list of listening client - next ambience time
	var/list/ambience_listening_clients = list()

/datum/controller/subsystem/ambience/fire(resumed)
	for(var/client/client_iterator as anything in ambience_listening_clients)

		if(isnull(client_iterator))
			ambience_listening_clients -= client_iterator
			continue

		if(ambience_listening_clients[client_iterator] > world.time)
			continue //Not ready for the next sound

		var/area/current_area = get_area(client_iterator.mob)

		//SKYRAT EDIT ADDITION BEGIN
		var/volume_mod = 30

		if(current_area.ambience_index == AMBIENCE_GENERIC)
			volume_mod = 85
		//SKYRAT EDIT END

		var/sound = pick(current_area.ambientsounds)

		SEND_SOUND(client_iterator.mob, sound(sound, repeat = 0, wait = 0, volume = volume_mod, channel = CHANNEL_AMBIENCE)) //SKYRAT EDIT CHANGE - ORIGINAL: SEND_SOUND(client_iterator.mob, sound(sound, repeat = 0, wait = 0, volume = 25, channel = CHANNEL_AMBIENCE))

		ambience_listening_clients[client_iterator] = world.time + rand(current_area.min_ambience_cooldown, current_area.max_ambience_cooldown)
