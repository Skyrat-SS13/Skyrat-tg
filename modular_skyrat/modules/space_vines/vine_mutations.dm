// Flesh mending
#define MUTATION_HEAL_AMOUNT_CROSS 1
#define MUTATION_HEAL_AMOUNT_EAT 5

// Heals crossing or eating mobs
/datum/spacevine_mutation/flesh_mending
	name = "Flesh mending"
	hue = "#470566"
	severity = SEVERITY_TRIVIAL
	quality = POSITIVE

/datum/spacevine_mutation/flesh_mending/on_cross(obj/structure/spacevine/vine_object, mob/crosser)
	if(!isliving(crosser))
		return

	var/mob/living/living_crosser = crosser
	living_crosser.adjustBruteLoss(-MUTATION_HEAL_AMOUNT_CROSS)
	living_crosser.adjustFireLoss(-MUTATION_HEAL_AMOUNT_CROSS)
	living_crosser.adjustToxLoss(-MUTATION_HEAL_AMOUNT_CROSS)

/datum/spacevine_mutation/flesh_mending/on_eat(obj/structure/spacevine/vine_object, mob/living/eater)
	if(!isliving(eater))
		return

	var/mob/living/living_eater = eater
	living_eater.adjustBruteLoss(-MUTATION_HEAL_AMOUNT_EAT)
	living_eater.adjustFireLoss(-MUTATION_HEAL_AMOUNT_EAT)
	living_eater.adjustToxLoss(-MUTATION_HEAL_AMOUNT_EAT)


// Will prevent the vine from opening doors
/datum/spacevine_mutation/domesticated
	name = "Domesticated"
	hue = "#a9adb1"
	severity = SEVERITY_TRIVIAL
	quality = POSITIVE

/datum/spacevine_mutation/domesticated/on_spread(obj/structure/spacevine/vine_object, turf/target)
	vine_object.layer = LOW_FLOOR_LAYER
	vine_object.plane = FLOOR_PLANE


// Spawns kudzu flooring on spacetiles
/datum/spacevine_mutation/breach_fixing
	name = "Breach fixing"
	hue = "#43a1ff"
	severity = SEVERITY_MAJOR
	quality = POSITIVE

/datum/spacevine_mutation/breach_fixing/on_spread(obj/structure/spacevine/vine_object, turf/grown_turf)
	for(var/turf/open/space/space_turf in range(1, grown_turf))
		var/range_check = FALSE
		for(var/turf/locking_turf in range(2, space_turf))
			if(!istype(get_area(locking_turf), /area/space))
				range_check = TRUE

		if(!range_check)
			continue

		space_turf.ChangeTurf(/turf/open/floor/plating/kudzu)
		space_turf.color = hue
/turf/open/floor/plating/kudzu
	name = "vine flooring"
	icon = 'modular_skyrat/modules/aesthetics/floors/icons/floors.dmi'
	icon_state = "vinefloor"

/turf/open/floor/plating/kudzu/attacked_by(obj/item/attacking_item, mob/living/user)
	if(!istype(attacking_item, /obj/item/wirecutters))
		return ..()

	ChangeTurf(/turf/open/space)


// Turns CO2 into oxygen
/datum/spacevine_mutation/carbon_recycling
	name = "Carbon recycling"
	hue = "#008a50"
	severity = SEVERITY_TRIVIAL
	quality = POSITIVE

/datum/spacevine_mutation/carbon_recycling/process_mutation(obj/structure/spacevine/vine_object)
	var/turf/open/floor/current_turf = vine_object.loc
	if(!istype(current_turf))
		return

	var/datum/gas_mixture/gas_mix = current_turf.air
	if(!gas_mix.gases[/datum/gas/carbon_dioxide])
		return

	var/moles_to_replace = GAS_MUTATION_REMOVAL_MULTIPLIER * vine_object.growth_stage
	gas_mix.gases[/datum/gas/carbon_dioxide][MOLES] = max(gas_mix.gases[/datum/gas/carbon_dioxide][MOLES] - moles_to_replace, 0)
	gas_mix.garbage_collect()

	var/happy_atmos = "oxygen=[moles_to_replace];TEMP=296"
	current_turf.atmos_spawn_air(happy_atmos)

#undef MUTATION_HEAL_AMOUNT_CROSS
#undef MUTATION_HEAL_AMOUNT_EAT
