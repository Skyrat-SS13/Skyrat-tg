#define TRIGGER_RANGE 2

/mob/living/carbon/human/npc

/mob/living/carbon/human/npc/commander
	name = "Commander Stevens"
	real_name = "Commander Stevens"
	move_resist = MOVE_FORCE_EXTREMELY_STRONG //leg day has not been skipped
	/// If they've been triggered
	var/started_trigger = FALSE

/mob/living/carbon/human/npc/commander/Initialize()
	. = ..()
	equipOutfit(/datum/outfit/centcom/naval/commander) //they're not actually CC so change later
	for(var/turf/iterating_turf in range(TRIGGER_RANGE, src))
		RegisterSignal(iterating_turf, COMSIG_ATOM_ENTERED, .proc/trigger)

/mob/living/carbon/human/npc/commander/proc/trigger()
	SIGNAL_HANDLER
	if(started_trigger)
		return
	started_trigger = TRUE
	addtimer(CALLBACK(src, .proc/start_blabbing), 3 SECONDS)

/mob/living/carbon/human/npc/commander/proc/start_blabbing()
	say("Ah, you're here!")
	sleep(1.5 SECONDS)
	say("As I'm sure you were briefed upstairs, I'll keep this light.")
	sleep(2 SECONDS)
	say("The shuttle's ready to depart, with enough power and supplies to last you the journey.")
	sleep(2.5 SECONDS)
	say("Good luck out there, marines. You're doing great work for science.")
	sleep(0.3 SECONDS)
	emote("nod")

#undef TRIGGER_RANGE
