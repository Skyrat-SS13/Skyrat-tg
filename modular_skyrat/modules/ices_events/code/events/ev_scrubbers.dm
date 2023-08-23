/datum/round_event_control/scrubber_overflow/ices
	name = "Scrubber Overflow: ICES"
	typepath = /datum/round_event/scrubber_overflow/ices
	weight = 10
	max_occurrences = 2
	earliest_start = 20 MINUTES
	description = "The scrubbers release a tide of moderately harmless froth, custom reagent set."
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 4

/datum/round_event/scrubber_overflow/ices
	danger_chance = 0
	reagents_amount = 40
	overflow_probability = 70

	/// Whitelist of reagents we want scrubbers to dispense
	var/static/list/reagent_whitelist = list(/datum/reagent/blood,
		/datum/reagent/bluespace,
		/datum/reagent/carbon,
		/datum/reagent/carpet/neon/simple_cyan,
		/datum/reagent/carpet/neon/simple_pink,
		/datum/reagent/carpet/neon/simple_white,
		/datum/reagent/carpet/neon/simple_yellow,
		/datum/reagent/colorful_reagent,
		/datum/reagent/consumable/astrotame,
		/datum/reagent/consumable/caramel,
		/datum/reagent/consumable/char,
		/datum/reagent/consumable/condensedcapsaicin,
		/datum/reagent/consumable/cream,
		/datum/reagent/consumable/ethanol/antifreeze,
		/datum/reagent/consumable/ethanol/beepsky_smash,
		/datum/reagent/consumable/ethanol/fernet_cola,
		/datum/reagent/consumable/ethanol/sugar_rush,
		/datum/reagent/consumable/doctor_delight,
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/hot_coco,
		/datum/reagent/consumable/laughter,
		/datum/reagent/consumable/nutriment,
		/datum/reagent/consumable/salt,
		/datum/reagent/consumable/sodawater,
		/datum/reagent/consumable/tinlux,
		/datum/reagent/consumable/yoghurt,
		/datum/reagent/cryptobiolin,
		/datum/reagent/eigenstate,
		/datum/reagent/glitter/blue,
		/datum/reagent/glitter/pink,
		/datum/reagent/glitter/white,
		/datum/reagent/gravitum,
		/datum/reagent/hair_dye,
		/datum/reagent/hydrogen_peroxide,
		/datum/reagent/lube,
		/datum/reagent/pax,
		/datum/reagent/plastic_polymers,
		/datum/reagent/space_cleaner,
		/datum/reagent/drug/space_drugs,
	)

/datum/round_event/scrubber_overflow/ices/setup()
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/temp_vent as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/atmospherics/components/unary/vent_scrubber))
		var/turf/scrubber_turf = get_turf(temp_vent)
		var/area/scrubber_area = get_area(temp_vent)
		if(!scrubber_turf)
			continue
		if(!is_station_level(scrubber_turf.z))
			continue
		if(temp_vent.welded)
			continue
		if(is_type_in_list(scrubber_area, list(/area/station/engineering/supermatter/room, /area/station/engineering/supermatter,)))
			continue
		if(!prob(overflow_probability))
			continue
		scrubbers += temp_vent

	if(!scrubbers.len)
		return kill()

/datum/round_event/scrubber_overflow/ices/start()
	for(var/obj/machinery/atmospherics/components/unary/vent_scrubber/vent as anything in scrubbers)
		if(!vent.loc)
			CRASH("SCRUBBER SURGE: [vent] has no loc somehow?")

		var/datum/reagents/dispensed_reagent = new /datum/reagents(reagents_amount)
		dispensed_reagent.my_atom = vent
		if (forced_reagent_type)
			dispensed_reagent.add_reagent(forced_reagent_type, reagents_amount)
		else
			dispensed_reagent.add_reagent(pick(reagent_whitelist), reagents_amount)

		dispensed_reagent.create_foam(/datum/effect_system/fluid_spread/foam/scrubber, reagents_amount)
