//Cactus, Speedbird, Dynasty, oh my	//I still dont know what this means. Are they credits?

var/datum/lore/atc_controller/atc = new/datum/lore/atc_controller

/datum/lore/atc_controller
	///How long between ATC traffic, maximum.  Default is 40 mins.
	var/delay_max = 1 MINUTES
	///How long between ATC traffic, minimum.  Default is 25 mins.
	var/delay_min = 2 MINUTES
	///How long to back off if we can't talk and want to.  Default is 5 mins. (How long between checks if the system is offline).
	var/backoff_delay = 5 MINUTES
	///When the next message should happen in world.time
	var/next_message

	///Force a specific type of message
	var/force_chatter_type

	///Used to freeze the reroute_traffic() proc so people can't spam the toggle messages
	var/spam_check = FALSE
	///If ATC messages are coming thru; wont affect ERT/Arrivals/Evac, toggled in reroute_traffic()
	var/atcOnline = TRUE

/datum/lore/atc_controller/New(msg)
	//RegisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING, /datum/station_trait/proc/on_round_start)
	msg("New shift beginning, resuming traffic control.")
	next_message = world.time + rand(delay_min,delay_max)
	process()

/datum/lore/atc_controller/process()
	if(world.time >= next_message)
		if(!atcOnline)
			next_message = world.time + backoff_delay
		else
			next_message = world.time + rand(delay_min,delay_max)
			random_convo()
	spawn(1 MINUTES)
		process()

/datum/lore/atc_controller/proc/msg(var/message,var/sender)
	ASSERT(message)
	if(!sender)
		sender = "Airspace Announcements"
	atc_announce("[message]", title = "[sender]", sound = 'sound/misc/compiler-stage2.ogg')

/datum/lore/atc_controller/proc/reroute_traffic(var/spammer)
	if(spam_check == TRUE)
		to_chat(spammer, "Slow down, you can't spam the system like that!")
		return
	atcOnline = !atcOnline
	spam_check = TRUE
	addtimer(CALLBACK(src, .proc/submit_again), 10 SECONDS)
	msg("[atcOnline ? "Resuming normal traffic routing around" : "Rerouting traffic away from"] Layenia.")

/datum/lore/atc_controller/proc/submit_again()
	spam_check = FALSE

///Generates our random messages as time goes on; uses lore from organizations.dm
/datum/lore/atc_controller/proc/random_convo()
	var/one = pick(loremaster.organizations) //These will pick an index, not an instance
	var/two = pick(loremaster.organizations)

	var/datum/lore/organization/source = loremaster.organizations[one] //Resolve to the instances
	var/datum/lore/organization/dest = loremaster.organizations[two]

	//Let's get some mission parameters
	var/owner = source.short_name					//Use the short name
	var/prefix = pick(source.ship_prefixes)			//Pick a random prefix
	var/mission = source.ship_prefixes[prefix]		//The value of the prefix is the mission type that prefix does
	var/shipname = pick(source.ship_names)			//Pick a random ship name to go with it
	var/destname = pick(dest.destination_names)			//Pick a random holding from the destination

	var/combined_name = "[owner] [prefix] [shipname]"
	var/alt_atc_names = list("Layenia TraCon", "Layenia Control", "Layenia STC", "Layenia Airspace")
	var/wrong_atc_names = list("Hyperion Gridlock", "Dzar StarCon", "Layenia TraCon", "Kinaris SC", "Tavros Station")
	var/mission_noun = list("flight", "mission", "route", "pass")
	var/request_verb = list("requesting", "calling for", "asking for")

	//First response is 'yes', second is 'no'
	var/requests = list("Kinaris Sector Command transit clearance" = list("permission for transit granted", "permission for transit denied, contact regional on 953.5"),
						"planetary flight rules" = list("authorizing planetary flight rules", "denying planetary flight rules right now due to traffic"),
						"special flight rules" = list("authorizing special flight rules", "denying special flight rules, not allowed for your traffic class"),
						"current solar weather info" = list("sending you the relevant information via tightbeam", "cannot fulfill your request at the moment"),
						"nearby traffic info" = list("sending you current traffic info", "no available info in your area"),
						"remote telemetry data" = list("sending telemetry now", "no uplink from your ship, recheck your uplink and ask again"),
						"refueling information" = list("sending refueling information now", "no fuel for your ship class in this sector"),
						"a current system time sync" = list("sending time sync ping to you now", "your ship isn't compatible with our time sync, set time manually"),
						"current system starcharts" = list("transmitting current starcharts", "your request is queued, overloaded right now"),
						"permission to engage FTL" = list("permission to engage FTL granted, good day", "permission denied, wait for current traffic to pass"),
						"permission to transit system" = list("permission to transit granted, good day", "permission denied, wait for current traffic to pass"),
						"permission to depart system" = list("permission to depart granted, good day", "permission denied, wait for current traffic to pass"),
						"permission to enter system" = list("good day, permission to enter granted", "permission denied, wait for current traffic to pass"),
						)

	//Random chance things for variety
	var/chatter_type = "normal"
	if(force_chatter_type)
		chatter_type = force_chatter_type
	else
		chatter_type = pick(2;"emerg", 5;"wrong_freq", "normal")	//TODO: 5;"wrong_lang",

	var/yes = prob(85) //Chance for them to say yes vs no

	var/request = pick(requests)
	var/callname = pick(alt_atc_names)
	var/response = requests[request][yes ? 1 : 2] //1 is yes, 2 is no

	var/full_request
	var/full_response
	var/full_closure

	switch(chatter_type)
		if("wrong_freq")
			callname = pick(wrong_atc_names)
			full_request = "[callname], this is [combined_name] on a [mission] [pick(mission_noun)] to [destname], [pick(request_verb)] [request]."
			full_response = "[combined_name], this is Layenia TraCon, wrong frequency. Switch to [rand(700,999)].[rand(1,9)]."
			full_closure = "Layenia TraCon, understood, apologies."
		if("wrong_lang")
			//TO-DO
		if("emerg")
			var/problem = pick("hull breaches on multiple decks","unknown life forms on board","a drive about to go critical","asteroids impacting the hull","a total loss of engine power","people trying to board the ship")
			full_request = "This is [combined_name] declaring an emergency! We have [problem]!"
			full_response = "[combined_name], this is Layenia TraCon, copy. Switch to emergency responder channel [rand(700,999)].[rand(1,9)]."
			full_closure = "Layenia TraCon, okay, switching now."
		else
			full_request = "[callname], this is [combined_name] on a [mission] [pick(mission_noun)] to [destname], [pick(request_verb)] [request]."
			full_response = "[combined_name], this is Layenia TraCon, [response]." //Station TraCon always calls themselves TraCon
			full_closure = "Layenia TraCon, [yes ? "thank you" : "understood"], good day." //They always copy what TraCon called themselves in the end when they realize they said it wrong

	//Ship sends request to ATC
	msg(full_request,"[prefix] [shipname]")
	sleep(5 SECONDS)
	//ATC sends response to ship
	msg(full_response)
	sleep(5 SECONDS)
	//Ship sends response to ATC
	msg(full_closure,"[prefix] [shipname]")
	return
