/*
/ Oldbase port! Overwrites TG's meteors to both have a timed warning, and come from a single direction
/ This shifts the event from 'fuck up the station and give engineers something to do' (leaving the crew miserable as air freezes over)
/ To 'give engineering time to brace for impact, and crew time to evacuate the affected area' (meaning that, with teamwork, damage can be minimized!)
*/

//These three procs are identical to, and override, TG's as of 10/25/2022; they only add the 'dir'/'direction' variable but its safer to override
/proc/spawn_meteors(number = 10, list/meteortypes, dir)
	for(var/i in 1 to number)
		spawn_meteor(meteortypes, dir)

/proc/spawn_meteor(list/meteortypes, dir)
	var/turf/pickedstart
	var/turf/pickedgoal
	var/max_i = 10//number of tries to spawn meteor.
	while(!isspaceturf(pickedstart))
		var/startSide = dir || pick(GLOB.cardinals)
		var/startZ = pick(SSmapping.levels_by_trait(ZTRAIT_STATION))
		pickedstart = spaceDebrisStartLoc(startSide, startZ)
		pickedgoal = spaceDebrisFinishLoc(startSide, startZ)
		max_i--
		if(max_i<=0)
			return
	var/Me = pick_weight(meteortypes)
	new Me(pickedstart, pickedgoal)

/datum/round_event/meteor_wave/tick()
	if(ISMULTIPLE(activeFor, 3))
		spawn_meteors(5, wave_type, direction) //meteor list types defined in gamemode/meteor/meteors.dm

/datum/round_event/meteor_wave
	/// Which cardinal direction the meteors will spawn on
	var/direction

 //TG doesn't have a meteor_wave/setup() but all round_events call it before launching. So we can have fun with it here!
/datum/round_event/meteor_wave/setup()
	announce_when = 1
	start_when = rand(60, 90) //TG's always has a set number - it gives the alert, then happens after SIX SECONDS. Lame! We'll give up to a minute and a half to prep.
	end_when = start_when + 60 //Meteors will hit for a full minute.

/datum/round_event/meteor_wave/determine_wave_type()
	if(!wave_name)
		wave_name = pick_weight(list(
			"normal" = 50,
			"threatening" = 40,
			"catastrophic" = 10))
	//The only chunk of skyrat code - rest of proc is identical to TG as of 10/25/2022
	if(!direction)
		direction = pick(GLOB.cardinals)
	//End of skyrat code
	switch(wave_name)
		if("normal")
			wave_type = GLOB.meteors_normal
		if("threatening")
			wave_type = GLOB.meteors_threatening
		if("catastrophic")
			if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
				wave_type = GLOB.meteorsSPOOKY
			else
				wave_type = GLOB.meteors_catastrophic
		if("meaty")
			wave_type = GLOB.meteorsB
		if("space dust")
			wave_type = GLOB.meteorsC
		if("halloween")
			wave_type = GLOB.meteorsSPOOKY
		else
			WARNING("Wave name of [wave_name] not recognised.")
			kill()

/datum/round_event/meteor_wave/announce(fake)
	var/directionstring
	switch(direction)
		if(NORTH)
			directionstring = " towards the fore"
		if(SOUTH)
			directionstring = " towards the aft"
		if(EAST)
			directionstring = " towards starboard"
		if(WEST)
			directionstring = " towards port"
	priority_announce("Meteors have been detected on collision course with the station[directionstring]. Estimated time until impact: [round((start_when * SSevents.wait) / 10, 0.1)] seconds.", "Meteor Alert", "meteors")
