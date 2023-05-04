/datum/opposing_force_equipment/service
	category = OPFOR_EQUIPMENT_CATEGORY_SERVICES

/datum/opposing_force_equipment/service/rep
	name = "100 Reputation"
	description = "Grant your Syndicate uplink 100 reputation, should you have one."
	item_type = /obj/effect/gibspawner/generic
	var/rep_count = 100

/datum/opposing_force_equipment/service/rep/high
	name = "500 Reputation"
	description = "Grant your Syndicate uplink 500 reputation, should you have one."
	item_type = /obj/effect/gibspawner/generic
	rep_count = 500

/datum/opposing_force_equipment/service/rep/very_high
	name = "1000 Reputation"
	description = "Grant your Syndicate uplink 1000 reputation, should you have one."
	item_type = /obj/effect/gibspawner/generic
	rep_count = 1000

/datum/opposing_force_equipment/service/rep/on_issue(mob/living/target)
	var/datum/component/uplink/the_uplink = target.mind.find_syndicate_uplink()
	if(!the_uplink) //Why'd you even purchase this in the first place?
		return
	var/datum/uplink_handler/handler = the_uplink.uplink_handler
	if(!handler)
		return
	handler.progression_points += (rep_count * 60)

/datum/opposing_force_equipment/service/power_outage
	name = "Power Outage"
	description = "A virus will be uploaded to the engineering processing servers to force a routine power grid check, forcing all APCs on the station to be temporarily disabled."
	item_type = /obj/effect/gibspawner/generic
	admin_note = "Equivalent to the Grid Check random event."
	max_amount = 1

/datum/opposing_force_equipment/service/power_outage/on_issue()
	var/datum/round_event_control/event = locate(/datum/round_event_control/grid_check) in SSevents.control
	event.run_event()

/datum/opposing_force_equipment/service/telecom_outage
	name = "Telecomms Outage"
	description = "A virus will be uploaded to the telecommunication processing servers to temporarily disable themselves."
	item_type = /obj/effect/gibspawner/generic
	admin_note = "Equivalent to the Communications Blackout random event."
	max_amount = 1

/datum/opposing_force_equipment/service/telecom_outage/on_issue()
	var/datum/round_event_control/event = locate(/datum/round_event_control/communications_blackout) in SSevents.control
	event.run_event()

/datum/opposing_force_equipment/service/market_crash
	name = "Market Crash"
	description = "Some forged documents will be given to Nanotrasen, skyrocketing the price of all on-station vendors for a short while."
	item_type = /obj/effect/gibspawner/generic
	admin_note = "Equivalent to the Market Crash random event."
	max_amount = 1

/datum/opposing_force_equipment/service/market_crash/on_issue()
	var/datum/round_event_control/event = locate(/datum/round_event_control/market_crash) in SSevents.control
	event.run_event()

/datum/opposing_force_equipment/service/give_exploitables
	name = "Exploitables Access"
	description = "You will be given access to a network of exploitable information of certain crewmates, viewable using either a verb or on examine."
	item_type = /obj/effect/gibspawner/generic
	admin_note = "Same effect as using the traitor panel Toggle Exploitables Override button. Usually safe to give."

/datum/opposing_force_equipment/service/give_exploitables/on_issue(mob/living/target)
	target.mind.has_exploitables_override = TRUE
	target.mind.handle_exploitables()

/datum/opposing_force_equipment/service/fake_announcer
	name = "Fake Announcement"
	item_type = /obj/item/device/traitor_announcer
	description = "A one-use device that lets you make an announcement of your choice, sending it to the station under the guise of the captain's authority."

