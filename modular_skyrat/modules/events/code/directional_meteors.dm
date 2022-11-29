/*
/ Oldbase port-ish! Adds on to TG's meteors to both have a timed warning, and come from a single direction
/ This shifts the event from 'fuck up the station and give engineers something to do' (leaving the crew miserable as air freezes over)
/ To 'give engineering time to brace for impact, and crew time to evacuate the affected area' (meaning that, with teamwork, damage can be minimized!)

/ ALSO INCLUDES CHANGES IN code/modules/meteors/meteors.dm and code/modules/events/meteor_wave.dm (Mostly just adding direction variables into spots they're needed)
/ Ctrl+F "//SKYRAT EDIT - DIRECTIONAL METEORS" to find them all
*/

/datum/round_event/meteor_wave
	/// Which cardinal direction the meteors will spawn on
	var/direction
	/// Cardinal direction translated into Nautical direction, used in announcements and selected on setup()
	var/directionstring

//TG doesn't have a meteor_wave/setup() but all round_events call it before launching. So we can have fun with it here!
//setup() also happens BEFORE new() which means we can set up directional stuff here and have it carry over to the event still!
/datum/round_event/meteor_wave/setup()
	announce_when = 1
	start_when = rand(60, 90) //TG's only gives SIX SECONDS between alert and impact. Lame! We'll give around two minutes - start_when * SSEvents.wait (20 deciseconds (2 sec))
	end_when = start_when + 60 //Meteors will hit for a full minute.
	direction = pick(GLOB.cardinals)
	switch(direction)
		if(NORTH)
			directionstring = "Fore"
		if(SOUTH)
			directionstring = "Aft"
		if(EAST)
			directionstring = "Starboard"
		if(WEST)
			directionstring = "Port"

/datum/round_event/meteor_wave/start()
	..()
	priority_announce("Meteor collision imminent on station's [directionstring] side. All crew, brace for impact.", "Meteor Alert", "meteors") //Here's hoping they were prepared by now!
	return

/datum/round_event/meteor_wave/announce(fake)
	priority_announce("Meteors have been detected on collision course with the station, headed towards its [directionstring] side. Estimated time until impact: [round((start_when * SSevents.wait) / 10, 0.1)] seconds.", "Meteor Alert", "meteors")
