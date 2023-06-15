#define MAXIMUM_THREAT 100
#define CHANCE_PER_TICK 25

/datum/outbound_gateway_controller
	/// How much threat budget we currently have
	var/current_threat = 0
	/// How much threat we earn per tick
	var/earned_threat = 12
	/// List of event datums to choose from
	var/list/event_datums = list()
	/// Are we still going
	var/enabled = TRUE
	/// How often we "tick"
	var/tick_time = 16 SECONDS
	/// Events not to use
	var/static/list/event_blacklist = list(
		/datum/outbound_gateway_event/portal/syndicate/lone_wolf,
	)

/datum/outbound_gateway_controller/New()
	. = ..()
	for(var/path in subtypesof(/datum/outbound_gateway_event))
		if(path in event_blacklist)
			continue
		event_datums += new path
	tick()

/datum/outbound_gateway_controller/Destroy(force, ...)
	for(var/datum/event as anything in event_datums)
		QDEL_NULL(event)
	return ..()

/datum/outbound_gateway_controller/proc/tick()
	if(!enabled)
		return
	current_threat = clamp(current_threat + earned_threat, 0, MAXIMUM_THREAT)
	if(prob(CHANCE_PER_TICK) || current_threat >= MAXIMUM_THREAT)
		try_event()
	addtimer(CALLBACK(src, PROC_REF(tick)), tick_time)

/datum/outbound_gateway_controller/proc/try_event()
	var/datum/outbound_gateway_event/picked_event = pick(event_datums)
	if(picked_event.threat > current_threat)
		return FALSE
	picked_event.on_event()
	current_threat -= picked_event.threat

#undef MAXIMUM_THREAT
#undef CHANCE_PER_TICK
