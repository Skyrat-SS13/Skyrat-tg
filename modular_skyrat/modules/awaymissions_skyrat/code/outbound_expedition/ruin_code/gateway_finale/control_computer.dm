/obj/machinery/computer/outbound_gateway
	name = "gateway startup console"
	desc = "A console with scrolling text and a big, red button left of the keyboard."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	max_integrity = INFINITY
	/// Ref to the gateway controller
	var/datum/outbound_gateway_controller/gate_controller
	/// Has the button been pressed
	var/pressed = FALSE

/obj/machinery/computer/outbound_gateway/Initialize(mapload, obj/item/circuitboard/C)
	. = ..()
	AddComponent(/datum/component/gps, "High Energy Signal")

/obj/machinery/computer/outbound_gateway/Destroy()
	QDEL_NULL(gate_controller)
	return ..()

/obj/machinery/computer/outbound_gateway/screwdriver_act(mob/living/user, obj/item/tool)
	return TOOL_ACT_SIGNAL_BLOCKING

/obj/machinery/computer/outbound_gateway/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!pressed)
		confirm_beginning(user)

/obj/machinery/computer/outbound_gateway/proc/confirm_beginning(mob/living/user)
	to_chat(user, span_boldnotice("You start readying yourself to hit the button..."))
	if(!do_after(user, 5 SECONDS, src))
		return
	to_chat(user, span_boldwarning("You hope that you're ready for this..."))
	if(!do_after(user, 3 SECONDS, src))
		return
	start_the_end()
	user.visible_message(span_danger("[user] presses the button on [src]!"), span_danger("You press the button on [src]!"))
	pressed = TRUE
	say("Gateway initialization started.")
	sleep(2 SECONDS)
	say("ETA: 10 minutes.")
	sleep(2 SECONDS)
	say("SIGNAL BROADCASTING...")

/obj/machinery/computer/outbound_gateway/proc/start_the_end()
	addtimer(CALLBACK(src, .proc/open_gateway), 10 MINUTES)
	gate_controller = new
	var/area/loaded_area = GLOB.areas_by_type[/area/awaymission/outbound_expedition/ruin/gateway_ruin]
	for(var/obj/effect/landmark/outbound/gateway_space_edge/space_edge in loaded_area.contents)
		var/turf/landmark_turf = get_turf(space_edge)
		landmark_turf.ChangeTurf(/turf/open/space/no_travel/see_through)
		qdel(space_edge)

/obj/machinery/computer/outbound_gateway/proc/open_gateway()
	addtimer(CALLBACK(src, .proc/far_too_late), 2 MINUTES)
	say("Gateway initialization complete, doors opening.")
	sleep(2 SECONDS)
	say("WARNING: Gateway casuality unstable. Unexpected Gateway collapse may occur.")
	var/area/the_area = GLOB.areas_by_type[/area/awaymission/outbound_expedition/ruin/gateway_ruin]
	for(var/obj/machinery/door/airlock/vault/gateway/solid_door in the_area.contents)
		solid_door.unbolt()
		solid_door.open(TRUE)

/obj/machinery/computer/outbound_gateway/proc/far_too_late() //https://www.youtube.com/watch?v=R2BjRgRU_ig
	say("WARNING: GATEWAY CASUALITY COLLAPSING. COMMENCING IMMEDIATE SHUTDOWN.")
	sleep(2 SECONDS)
	say("Gateway will be ready for reuse in: 32J@D(@KA)KS")
	var/area/the_area = GLOB.areas_by_type[/area/awaymission/outbound_expedition/ruin/gateway_ruin]
	for(var/obj/machinery/gateway/our_gateway in the_area.contents)
		our_gateway.deactivate()
		our_gateway.requires_key = TRUE
		break
	gate_controller.tick_time = initial(gate_controller.tick_time) / 2
	gate_controller.earned_threat = 25
	gate_controller.event_datums.Cut()
	gate_controller.event_datums += new /datum/outbound_gateway_event/portal/syndicate/lone_wolf
	addtimer(CALLBACK(src, .proc/stop_event_ticking), 5 MINUTES)

/obj/machinery/computer/outbound_gateway/proc/stop_event_ticking()
	gate_controller.enabled = FALSE
