#define PARTY_COOLDOWN_LENGTH_MIN (6 MINUTES)
#define PARTY_COOLDOWN_LENGTH_MAX (12 MINUTES)

/datum/station_trait/lucky_winner
	name = "Lucky winner"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 1
	show_in_report = TRUE
	report_message = "Your station has won the grand prize of the annual station charity event. Free snacks will be delivered to the bar every now and then."
	trait_processes = TRUE
	COOLDOWN_DECLARE(party_cooldown)

/datum/station_trait/lucky_winner/on_round_start()
	. = ..()
	COOLDOWN_START(src, party_cooldown, rand(PARTY_COOLDOWN_LENGTH_MIN, PARTY_COOLDOWN_LENGTH_MAX))

/datum/station_trait/lucky_winner/process(seconds_per_tick)
	if(!COOLDOWN_FINISHED(src, party_cooldown))
		return

	COOLDOWN_START(src, party_cooldown, rand(PARTY_COOLDOWN_LENGTH_MIN, PARTY_COOLDOWN_LENGTH_MAX))

	var/area/area_to_spawn_in = pick(GLOB.bar_areas)
	var/turf/T = pick(area_to_spawn_in.contents)

	var/obj/structure/closet/supplypod/centcompod/toLaunch = new()
	var/obj/item/pizzabox/pizza_to_spawn = pick(list(/obj/item/pizzabox/margherita, /obj/item/pizzabox/mushroom, /obj/item/pizzabox/meat, /obj/item/pizzabox/vegetable, /obj/item/pizzabox/pineapple))
	new pizza_to_spawn(toLaunch)
	for(var/i in 1 to 6)
		new /obj/item/reagent_containers/cup/glass/bottle/beer(toLaunch)
	new /obj/effect/pod_landingzone(T, toLaunch)

#undef PARTY_COOLDOWN_LENGTH_MIN
#undef PARTY_COOLDOWN_LENGTH_MAX

/datum/station_trait/galactic_grant
	name = "Galactic grant"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Your station has been selected for a special grant. Some extra funds has been made available to your cargo department."

/datum/station_trait/galactic_grant/on_round_start()
	var/datum/bank_account/cargo_bank = SSeconomy.get_dep_account(ACCOUNT_CAR)
	cargo_bank.adjust_money(rand(2000, 5000))

/datum/station_trait/premium_internals_box
	name = "Premium internals boxes"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "The internals boxes for your crew have been upsized and filled with bonus equipment."
	trait_to_give = STATION_TRAIT_PREMIUM_INTERNALS

/datum/station_trait/bountiful_bounties
	name = "Bountiful bounties"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE
	report_message = "It seems collectors in this system are extra keen to on bounties, and will pay more to see their completion."

/datum/station_trait/bountiful_bounties/on_round_start()
	SSeconomy.bounty_modifier *= 1.2

/datum/station_trait/strong_supply_lines
	name = "Strong supply lines"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Prices are low in this system, BUY BUY BUY!"
	blacklist = list(/datum/station_trait/distant_supply_lines)

/datum/station_trait/strong_supply_lines/on_round_start()
	SSeconomy.pack_price_modifier *= 0.8

/datum/station_trait/filled_maint
	name = "Filled up maintenance"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE
	report_message = "Our workers accidentally forgot more of their personal belongings in the maintenace areas."
	blacklist = list(/datum/station_trait/empty_maint)
	trait_to_give = STATION_TRAIT_FILLED_MAINT

	// This station trait is checked when loot drops initialize, so it's too late
	can_revert = FALSE

/datum/station_trait/quick_shuttle
	name = "Quick Shuttle"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Due to proximity to our supply station, the cargo shuttle will have a quicker flight time to your cargo department."
	blacklist = list(/datum/station_trait/slow_shuttle)

/datum/station_trait/quick_shuttle/on_round_start()
	. = ..()
	SSshuttle.supply.callTime *= 0.5

/datum/station_trait/deathrattle_department
	name = "deathrattled department"
	trait_type = STATION_TRAIT_POSITIVE
	show_in_report = TRUE
	abstract_type = /datum/station_trait/deathrattle_department
	blacklist = list(/datum/station_trait/deathrattle_all)

	var/department_to_apply_to
	var/department_name = "department"
	var/datum/deathrattle_group/deathrattle_group

/datum/station_trait/deathrattle_department/New()
	. = ..()
	deathrattle_group = new("[department_name] group")
	blacklist += subtypesof(/datum/station_trait/deathrattle_department) - type //All but ourselves
	report_message = "All members of [department_name] have received an implant to notify each other if one of them dies. This should help improve job-safety!"
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))


/datum/station_trait/deathrattle_department/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	if(!(job.departments_bitflags & department_to_apply_to))
		return

	var/obj/item/implant/deathrattle/implant_to_give = new()
	deathrattle_group.register(implant_to_give)
	implant_to_give.implant(spawned, spawned, TRUE, TRUE)


/datum/station_trait/deathrattle_department/service
	name = "Deathrattled Service"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_SERVICE
	department_name = "Service"

/datum/station_trait/deathrattle_department/cargo
	name = "Deathrattled Cargo"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_CARGO
	department_name = "Cargo"

/datum/station_trait/deathrattle_department/engineering
	name = "Deathrattled Engineering"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_ENGINEERING
	department_name = "Engineering"

/datum/station_trait/deathrattle_department/command
	name = "Deathrattled Command"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_COMMAND
	department_name = "Command"

/datum/station_trait/deathrattle_department/science
	name = "Deathrattled Science"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_SCIENCE
	department_name = "Science"

/datum/station_trait/deathrattle_department/security
	name = "Deathrattled Security"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_SECURITY
	department_name = "Security"

/datum/station_trait/deathrattle_department/medical
	name = "Deathrattled Medical"
	weight = 1
	department_to_apply_to = DEPARTMENT_BITFLAG_MEDICAL
	department_name = "Medical"

/datum/station_trait/deathrattle_all
	name = "Deathrattled Station"
	trait_type = STATION_TRAIT_POSITIVE
	show_in_report = TRUE
	weight = 1
	report_message = "All members of the station have received an implant to notify each other if one of them dies. This should help improve job-safety!"
	var/datum/deathrattle_group/deathrattle_group

/datum/station_trait/deathrattle_all/New()
	. = ..()
	deathrattle_group = new("station group")
	blacklist = subtypesof(/datum/station_trait/deathrattle_department)
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/datum/station_trait/deathrattle_all/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	var/obj/item/implant/deathrattle/implant_to_give = new()
	deathrattle_group.register(implant_to_give)
	implant_to_give.implant(spawned, spawned, TRUE, TRUE)

/datum/station_trait/cybernetic_revolution
	name = "Cybernetic Revolution"
	trait_type = STATION_TRAIT_POSITIVE
	show_in_report = TRUE
	weight = 1
	report_message = "The new trends in cybernetics have come to the station! Everyone has some form of cybernetic implant."
	trait_to_give = STATION_TRAIT_CYBERNETIC_REVOLUTION
	/// List of all job types with the cybernetics they should receive.
	var/static/list/job_to_cybernetic = list(
		/datum/job/assistant = /obj/item/organ/internal/heart/cybernetic, //real cardiac
		/datum/job/atmospheric_technician = /obj/item/organ/internal/cyberimp/mouth/breathing_tube,
		/datum/job/bartender = /obj/item/organ/internal/liver/cybernetic/tier3,
		/datum/job/bitrunner = /obj/item/organ/internal/eyes/robotic/thermals,
		/datum/job/botanist = /obj/item/organ/internal/cyberimp/chest/nutriment,
		/datum/job/captain = /obj/item/organ/internal/heart/cybernetic/tier3,
		/datum/job/cargo_technician = /obj/item/organ/internal/stomach/cybernetic/tier2,
		/datum/job/chaplain = /obj/item/organ/internal/cyberimp/brain/anti_drop,
		/datum/job/chemist = /obj/item/organ/internal/liver/cybernetic/tier2,
		/datum/job/chief_engineer = /obj/item/organ/internal/cyberimp/chest/thrusters,
		/datum/job/chief_medical_officer = /obj/item/organ/internal/cyberimp/chest/reviver,
		/datum/job/clown = /obj/item/organ/internal/cyberimp/brain/anti_stun, //HONK!
		/datum/job/cook = /obj/item/organ/internal/cyberimp/chest/nutriment/plus,
		/datum/job/coroner = /obj/item/organ/internal/tongue/bone, //hes got a bone to pick with you
		/datum/job/curator = /obj/item/organ/internal/eyes/robotic/glow,
		/datum/job/detective = /obj/item/organ/internal/lungs/cybernetic/tier3,
		/datum/job/doctor = /obj/item/organ/internal/cyberimp/arm/surgery,
		/datum/job/geneticist = /obj/item/organ/internal/fly, //we don't care about implants, we have cancer.
		/datum/job/head_of_personnel = /obj/item/organ/internal/eyes/robotic,
		/datum/job/head_of_security = /obj/item/organ/internal/eyes/robotic/thermals,
		/datum/job/human_ai = /obj/item/organ/internal/brain/cybernetic,
		/datum/job/janitor = /obj/item/organ/internal/eyes/robotic/xray,
		/datum/job/lawyer = /obj/item/organ/internal/heart/cybernetic/tier2,
		/datum/job/mime = /obj/item/organ/internal/tongue/robot, //...
		/datum/job/paramedic = /obj/item/organ/internal/cyberimp/eyes/hud/medical,
		/datum/job/prisoner = /obj/item/organ/internal/eyes/robotic/shield,
		/datum/job/psychologist = /obj/item/organ/internal/ears/cybernetic/whisper,
		/datum/job/quartermaster = /obj/item/organ/internal/stomach/cybernetic/tier3,
		/datum/job/research_director = /obj/item/organ/internal/cyberimp/bci,
		/datum/job/roboticist = /obj/item/organ/internal/cyberimp/eyes/hud/diagnostic,
		/datum/job/scientist = /obj/item/organ/internal/ears/cybernetic,
		/datum/job/security_officer = /obj/item/organ/internal/cyberimp/arm/flash,
		/datum/job/shaft_miner = /obj/item/organ/internal/monster_core/rush_gland,
		/datum/job/station_engineer = /obj/item/organ/internal/cyberimp/arm/toolset,
		/datum/job/warden = /obj/item/organ/internal/cyberimp/eyes/hud/security,
		// SKYRAT EDIT ADDITION START - MODULAR JOBS
		/datum/job/blueshield = /obj/item/organ/internal/cyberimp/brain/anti_stun,
		/datum/job/nanotrasen_consultant = /obj/item/organ/internal/heart/cybernetic/tier3,
		/datum/job/barber = /obj/item/organ/internal/ears/cybernetic/whisper,
		/datum/job/corrections_officer = /obj/item/organ/internal/cyberimp/arm/flash,
		/datum/job/orderly = /obj/item/organ/internal/cyberimp/brain/anti_drop,
		/datum/job/science_guard = /obj/item/organ/internal/cyberimp/arm/flash,
		/datum/job/customs_agent = /obj/item/organ/internal/cyberimp/eyes/hud/security,
		/datum/job/bouncer = /obj/item/organ/internal/cyberimp/arm/muscle,
		/datum/job/engineering_guard = /obj/item/organ/internal/cyberimp/arm/flash,
		/datum/job/telecomms_specialist = /obj/item/organ/internal/ears/cybernetic/xray,
		// SKYRAT EDIT END
	)

/datum/station_trait/cybernetic_revolution/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(on_job_after_spawn))

/datum/station_trait/cybernetic_revolution/proc/on_job_after_spawn(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER

	var/datum/quirk/body_purist/body_purist = /datum/quirk/body_purist
	if(initial(body_purist.name) in player_client.prefs.all_quirks)
		return
	var/cybernetic_type = job_to_cybernetic[job.type]
	if(!cybernetic_type)
		if(isAI(spawned))
			var/mob/living/silicon/ai/ai = spawned
			ai.eyeobj.relay_speech = TRUE //surveillance upgrade. the ai gets cybernetics too.
		return
	var/obj/item/organ/internal/cybernetic = new cybernetic_type()
	cybernetic.Insert(spawned, special = TRUE, movement_flags = DELETE_IF_REPLACED)

/datum/station_trait/luxury_escape_pods
	name = "Luxury Escape Pods"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	report_message = "Due to good performance, we've provided your station with luxury escape pods."
	trait_to_give = STATION_TRAIT_BIGGER_PODS
	blacklist = list(/datum/station_trait/cramped_escape_pods)

/datum/station_trait/medbot_mania
	name = "Advanced Medbots"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE
	report_message = "Your station's medibots have received a hardware upgrade, enabling expanded healing capabilities."
	trait_to_give = STATION_TRAIT_MEDBOT_MANIA

/datum/station_trait/random_event_weight_modifier/shuttle_loans
	name = "Loaner Shuttle"
	report_message = "Due to an uptick in pirate attacks around your sector, there are few supply vessels in nearby space willing to assist with special requests. Expect to receive more shuttle loan opportunities, with slightly higher payouts."
	trait_type = STATION_TRAIT_POSITIVE
	weight = 4
	event_control_path = /datum/round_event_control/shuttle_loan
	weight_multiplier = 2.5
	max_occurrences_modifier = 5 //All but one loan event will occur over the course of a round.
	trait_to_give = STATION_TRAIT_LOANER_SHUTTLE

/datum/station_trait/random_event_weight_modifier/wise_cows
	name = "Wise Cow Invasion"
	report_message = "Bluespace harmonic readings show unusual interpolative signals between your sector and agricultural sector MMF-D-02. Expect an increase in cow encounters. Encownters, if you will."
	trait_type = STATION_TRAIT_POSITIVE
	weight = 1
	event_control_path = /datum/round_event_control/wisdomcow
	weight_multiplier = 3
	max_occurrences_modifier = 10 //lotta cows

/datum/station_trait/random_event_weight_modifier/wise_cows/get_pulsar_message()
	var/advisory_string = "Advisory Level: <b>Cow Planet</b></center><BR>" //We're gonna go fast and we're gonna go far.
	advisory_string += "Your sector's advisory level is Cow Planet. We don't really know what this one means -- the model we use to create these threat reports hasn't produced this result before. Watch out for cows, I guess? Good luck!"
	return advisory_string

/datum/station_trait/bright_day
	name = "Bright Day"
	report_message = "The stars shine bright and the clouds are scarcer than usual. It's a bright day here on the Ice Moon's surface."
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	show_in_report = TRUE
	trait_flags = STATION_TRAIT_PLANETARY
	trait_to_give = STATION_TRAIT_BRIGHT_DAY

/datum/station_trait/shuttle_sale
	name = "Shuttle Firesale"
	report_message = "The Nanotrasen Emergency Dispatch team is celebrating a record number of shuttle calls in the recent quarter. Some of your emergency shuttle options have been discounted!"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 4
	trait_to_give = STATION_TRAIT_SHUTTLE_SALE
	show_in_report = TRUE

/datum/station_trait/missing_wallet
	name = "Misplaced Wallet"
	report_message = "A repair technician left their wallet in a locker somewhere. They would greatly appreciate if you could locate and return it to them when the shift has ended."
	trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_LOW
	show_in_report = TRUE

/datum/station_trait/missing_wallet/on_round_start()
	. = ..()

	var/obj/structure/closet/locker_to_fill = pick(GLOB.roundstart_station_closets)

	var/obj/item/storage/wallet/new_wallet = new(locker_to_fill)

	new /obj/item/stack/spacecash/c500(new_wallet)
	if(prob(25)) //Jackpot!
		new /obj/item/stack/spacecash/c1000(new_wallet)

	new /obj/item/card/id/advanced/technician_id(new_wallet)
	new_wallet.refreshID()

	if(prob(35))
		report_message += " The technician reports they last remember having their wallet around [get_area_name(new_wallet)]."

	message_admins("A missing wallet has been placed in the [locker_to_fill] locker, in the [get_area_name(locker_to_fill)] area.")

/obj/item/card/id/advanced/technician_id
	name = "Repair Technician ID"
	desc = "Repair Technician? We don't have those in this sector, just a bunch of lazy engineers! This must have been from the between-shift crew..."
	registered_name = "Pluoxium LXVII"
	registered_age = 67
	trim = /datum/id_trim/technician_id

/datum/id_trim/technician_id
	access = list(ACCESS_EXTERNAL_AIRLOCKS, ACCESS_MAINT_TUNNELS)
	assignment = "Repair Technician"
	trim_state = "trim_stationengineer"
	department_color = COLOR_ASSISTANT_GRAY

/// Spawns assistants with some gear, either gimmicky or functional. Maybe, one day, it will inspire an assistant to do something productive or fun
/datum/station_trait/assistant_gimmicks
	name = "Geared Assistants Pilot"
	report_message = "The Nanotrassen Assistant Affairs division is performing a pilot to see if different assistant equipment helps improve productivity!"
	trait_type = STATION_TRAIT_POSITIVE
	weight = 3
	trait_to_give = STATION_TRAIT_ASSISTANT_GIMMICKS
	show_in_report = TRUE
	blacklist = list(/datum/station_trait/colored_assistants)

/datum/station_trait/random_event_weight_modifier/assistant_gimmicks/get_pulsar_message()
	var/advisory_string = "Advisory Level: <b>Grey Sky</b></center><BR>"
	advisory_string += "Your sector's advisory level is Grey Sky. Our sensors detect abnormal activity among the assistants assigned to your station. We advise you to closely monitor the Tool Storage, Bridge, Tech Storage, and Brig for gathering crowds or petty thievery."
	return advisory_string
