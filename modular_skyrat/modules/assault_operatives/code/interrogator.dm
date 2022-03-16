#define STAGE_PROCESS_TIME_LOWER 30 SECONDS
#define STAGE_PROCESS_TIME_UPPER 1 MINUTES
#define ALERT_CREW_TIME 25 SECONDS

/**
 * The interrorgator, a piece of machinery used in assault ops to extract GoldenEye keys from heads of staff.
 *
 * This device has 3 stages.
 *
 * This device has a few requirements to function:
 * 1. Must be on station Z-level
 * 2. Must be a head of staff with a linked interrogate objective
 * 3. Must be alive
 * 4. Must not be a duplicate key
 *
 * After a key has been extracted, it will send a pod somewhere into maintenance, and the syndicates will know about it straight away.
 */

/obj/machinery/interrogator
	name = "In-TERROR-gator"
	desc = "A morraly corrupt piece of machinery used to extract the human mind into a GoldenEye authentication key. The process is said to be one of the most painful experiences someone can endure."
	icon = 'modular_skyrat/modules/assault_operatives/icons/goldeneye.dmi'
	icon_state = "interrogator_open"
	state_open = FALSE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	/// Is the door locked?
	var/locked = FALSE
	var/processing = FALSE
	var/process_finish_time
	var/timer_id
	var/mob/living/carbon/human/human_occupant

/obj/machinery/interrogator/examine(mob/user)
	. = ..()
	. += "It requies a direct link to a Nanotrasen defence network, stay near a Nanotrasen comms sat!"

/obj/machinery/interrogator/AltClick(mob/user)
	. = ..()
	if(!can_interact(user))
		return
	if(!processing)
		attempt_extract(user)
	else
		stop_extract(user)

/obj/machinery/interrogator/interact(mob/user)
	if(user == occupant)
		return
	if(state_open)
		close_machine()
		return
	if(!processing && !locked)
		open_machine()
		return

/obj/machinery/interrogator/update_icon_state()
	. = ..()
	if(occupant)
		icon_state = processing ? "interrogator_on" : "interrogator_off"
	else
		icon_state = state_open ? "interrogator_open" : "interrogator_closed"

/obj/machinery/interrogator/Destroy()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	human_occupant = null
	return ..()

/obj/machinery/interrogator/container_resist_act(mob/living/user)
	if(!locked)
		open_machine()

/obj/machinery/interrogator/open_machine(drop)
	..()
	human_occupant = null

/obj/machinery/interrogator/proc/stop_extract()
	processing = FALSE
	locked = FALSE
	human_occupant = null
	playsound(src, 'sound/machines/buzz-two.ogg', 100)
	balloon_alert_to_viewers("process aborted!")
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	update_appearance()

/obj/machinery/interrogator/proc/check_requirements()
	if(!human_occupant)
		return FALSE
	if(state_open)
		return FALSE
	if(!is_station_level(z))
		return FALSE
	if(human_occupant.stat == DEAD)
		return FALSE
	return TRUE

/obj/machinery/interrogator/proc/attempt_extract(mob/user)
	if(!occupant)
		balloon_alert_to_viewers("no occupant!")
		return
	if(state_open)
		balloon_alert_to_viewers("door open!")
		return
	if(!is_station_level(z))
		balloon_alert_to_viewers("no comms link!")
		return
	if(!ishuman(occupant))
		balloon_alert_to_viewers("invalid target dna!")
		return
	human_occupant = occupant
	if(human_occupant.stat == DEAD)
		balloon_alert_to_viewers("occupant is dead!")
		return
	var/datum/objective/interrogate/objective = get_goldeneye_target(human_occupant)
	if(!objective || objective.goldeneye_key_uploaded) // Preventing abuse by method of duplication.
		balloon_alert_to_viewers("no goldeneye data!")
		playsound(src, 'sound/machines/scanbuzz.ogg', 100)
		return

	start_extract()

/obj/machinery/interrogator/proc/start_extract()
	to_chat(human_occupant, span_userdanger("You feel dread wash over you as you hear the door on [src] lock!"))
	locked = TRUE
	processing = TRUE
	say("Starting DNA data extraction!")
	timer_id = addtimer(CALLBACK(src, .proc/stage_one), rand(STAGE_PROCESS_TIME_LOWER, STAGE_PROCESS_TIME_UPPER), TIMER_STOPPABLE|TIMER_UNIQUE) //Random times so crew can't anticipate exactly when it will drop.
	update_appearance()

/obj/machinery/interrogator/proc/stage_one()
	if(!check_requirements())
		say("Critical error! Aborting.")
		playsound(src, 'sound/machines/scanbuzz.ogg', 100)
		return
	to_chat(human_occupant, span_danger("As [src] whirrs to life you feel some cold metal restraints deploy around you, you can't move!"))
	playsound(loc, 'sound/items/rped.ogg', 60)
	say("Stage one complete!")
	minor_announce("SECURITY BREACH DETECTED, NETWORK COMPROMISED! READING COORDINATES...", "GoldenEye Defence Network")
	timer_id = addtimer(CALLBACK(src, .proc/stage_two), rand(STAGE_PROCESS_TIME_LOWER, STAGE_PROCESS_TIME_UPPER), TIMER_STOPPABLE|TIMER_UNIQUE)

/obj/machinery/interrogator/proc/stage_two()
	if(!check_requirements())
		say("Critical error! Aborting.")
		playsound(src, 'sound/machines/scanbuzz.ogg', 100)
		return
	to_chat(human_occupant, span_userdanger("You feel a sharp pain as a drill penetrates your skull, it's unbearable!"))
	human_occupant.emote("scream")
	human_occupant.apply_damage(30, BRUTE, BODY_ZONE_HEAD)
	playsound(src, 'sound/effects/wounds/blood1.ogg', 100)
	playsound(src, 'sound/items/drill_use.ogg', 100)
	say("Stage two complete!")
	minor_announce("SECURITY BREACH DETECTED, NETWORK COMPROMISED! COORDINATES: [x], [y], [z]", "GoldenEye Defence Network")
	timer_id = addtimer(CALLBACK(src, .proc/stage_three), rand(STAGE_PROCESS_TIME_LOWER, STAGE_PROCESS_TIME_UPPER), TIMER_STOPPABLE|TIMER_UNIQUE)

/obj/machinery/interrogator/proc/stage_three()
	if(!check_requirements())
		say("Critical error! Aborting.")
		playsound(src, 'sound/machines/scanbuzz.ogg', 100)
		return
	to_chat(human_occupant, span_userdanger("You feel something penetrating your brain, it feels as though your childhood memories are fading! Please, make it stop! After a moment of slience you realise you can't remember what happened to you!"))
	human_occupant.emote("scream")
	human_occupant.apply_damage(20, BRUTE, BODY_ZONE_HEAD)
	human_occupant.Jitter(3 MINUTES)
	human_occupant.Unconscious(1 MINUTES)
	playsound(src, 'sound/effects/dismember.ogg', 100)
	playsound(src, 'sound/machines/ping.ogg', 100)
	say("Process complete! A key is being sent aboard! Crew will shortly detect the keycard!")
	send_keycard()
	processing = FALSE
	locked = FALSE
	update_appearance()
	addtimer(CALLBACK(src, .proc/announce_creation), ALERT_CREW_TIME)

/obj/machinery/interrogator/proc/announce_creation()
	priority_announce("CRITICAL SECURITY BREACH DETECTED! A GoldenEye authentication key has been illegally printed, locate it at all costs!", "GoldenEye Defence Network", ANNOUNCER_KLAXON, has_important_message = TRUE)
	for(var/obj/item/pinpointer/nuke/disk_pinpointers in GLOB.pinpointer_list)
		disk_pinpointers.switch_mode_to(TRACK_GOLDENEYE) //Pinpointer will track the newly created goldeneye key.

/obj/machinery/interrogator/proc/send_keycard()
	var/turf/landingzone = find_drop_turf()
	var/obj/item/goldeneye_key/new_key
	if(!landingzone)
		new_key = new(src)
	else
		new_key = new
	new_key.extract_name = human_occupant.real_name
	var/datum/objective/interrogate/objective = get_goldeneye_target(human_occupant)
	objective.linked_key = src
	new_key.linked_objective = objective
	var/obj/structure/closet/supplypod/pod = new
	new /obj/effect/pod_landingzone(landingzone, pod, new_key)
	for(var/obj/item/pinpointer/nuke/goldeneye/disk_pinpointers in GLOB.pinpointer_list)
		disk_pinpointers.target = new_key
		disk_pinpointers.switch_mode_to(TRACK_GOLDENEYE) //Pinpointer will track the newly created goldeneye key.

/obj/machinery/interrogator/proc/find_drop_turf()
	var/list/possible_turfs = list()

	var/obj/structure/test_structure = new() // This is apparently the most intuative way to check if a turf is able to support entering.

	for(var/area/maintenance/maint_area in world)
		for(var/turf/floor in maint_area)
			if(!is_station_level(floor.z))
				continue
			if(floor.Enter(test_structure))
				possible_turfs += floor
	qdel(test_structure)

	//Pick a turf to spawn at if we can
	if(length(possible_turfs))
		return pick(possible_turfs)
