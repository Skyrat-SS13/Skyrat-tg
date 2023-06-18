// Slipping
#define MUTATION_SLIP_CHANCE 20

// Melee Reflect
#define MUTATION_REFLECT_CHANCE 10

// Seeding
#define MUTATION_SEED_CHANCE 10
#define MUTATION_POTENCY 50
#define MUTATION_PRODUCTION 5

// Electrify
#define MUTATION_ZAP_CHANCE 20
#define MUTATION_ZAP_DAMAGE 10

// EMP
#define MUTATION_EMP_HEAVY_RANGE 1
#define MUTATION_EMP_LIGHT_RANGE 2

// Random reagent
#define MUTATION_INJECT_CHANCE 10
#define MUTATION_INJECT_AMOUNT 10

// Radiation
#define MUTATION_PULSE_RANGE 5

// Flesh mending
#define MUTATION_HEAL_AMOUNT_CROSS 1
#define MUTATION_HEAL_AMOUNT_EAT 5

// Disease carrying
#define MUTATION_INFECT_CHANCE_HIT 20
#define MUTATION_INFECT_CHANCE_CROSS 10
#define MUTATION_MAX_SYMPTOMS 5
#define MUTATION_MAX_LEVEL 5


// Slips on cross
/datum/spacevine_mutation/slipping
	name = "Slipping"
	hue = "#97eaff"
	severity = SEVERITY_TRIVIAL
	quality = NEGATIVE

/datum/spacevine_mutation/slipping/on_cross(obj/structure/spacevine/vine_object, mob/living/crosser)
	if(!ishuman(crosser))
		return
	var/mob/living/carbon/human/living_crosser = crosser
	living_crosser.slip(MUTATION_SLIP_CHANCE)
	to_chat(living_crosser, span_warning("The vines slip you!"))


// Has a chance to reflect melee damage
/datum/spacevine_mutation/melee_reflect
	name = "Melee reflecting"
	hue = "#b6054f"
	severity = SEVERITY_ABOVE_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/melee_reflect/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/hitting_item, expected_damage)
	if(!isliving(hitter))
		return expected_damage

	var/mob/living/attacking_mob = hitter
	if(prob(MUTATION_REFLECT_CHANCE) && !isvineimmune(attacking_mob))
		attacking_mob.adjustBruteLoss(expected_damage)

	return expected_damage


// Has a chance to plant more kudzu when crossed or hit
/datum/spacevine_mutation/seeding
	name = "Seeding"
	hue = "#68b95d"
	severity = SEVERITY_MAJOR
	quality = NEGATIVE

/// Plants kudzu. To be used with vines with the seeding mutation
/mob/living/proc/plant_kudzu()
	var/turf/planted_turf = get_turf(src)
	var/list/added_mut_list = list()
	new /datum/spacevine_controller(planted_turf, added_mut_list, MUTATION_POTENCY, MUTATION_PRODUCTION)
	new /mob/living/simple_animal/hostile/venus_human_trap(planted_turf)

/datum/spacevine_mutation/seeding/on_cross(obj/structure/spacevine/vine_object, mob/crosser)
	if(!isliving(crosser))
		return
	var/mob/living/living_crosser = crosser
	if(isvineimmune(living_crosser) || living_crosser.stat == DEAD)
		return
	if(prob(MUTATION_SEED_CHANCE))
		addtimer(CALLBACK(living_crosser, /mob/living/proc/plant_kudzu), 1 MINUTES)

/datum/spacevine_mutation/seeding/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/weapon, expected_damage)
	if(!isliving(hitter))
		return expected_damage
	var/mob/living/living_hitter = hitter
	if(!isvineimmune(living_hitter) && prob(MUTATION_SEED_CHANCE))
		addtimer(CALLBACK(living_hitter, /mob/living/proc/plant_kudzu), 1 MINUTES)
	return expected_damage


// Has a chance to electrocute mobs that hit it
/datum/spacevine_mutation/electrify
	name = "Electrified"
	hue = "#f7eb86"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/electrify/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/hitting_item, expected_damage)
	if(!isliving(hitter))
		return expected_damage
	var/mob/living/living_hitter = hitter
	if(!isvineimmune(living_hitter) && prob(MUTATION_ZAP_CHANCE))
		living_hitter.electrocute_act(MUTATION_ZAP_DAMAGE, vine_object)
	return expected_damage


// EMP explosion on death
/datum/spacevine_mutation/emp
	name = "EMP"
	hue = "#ffffff"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/emp/on_death(obj/structure/spacevine/vine_object)
	empulse(vine_object, MUTATION_EMP_HEAVY_RANGE, MUTATION_EMP_LIGHT_RANGE)


// Has a chance to inject a random reagent into crossing mobs
/datum/spacevine_mutation/rand_reagent
	name = "Reagent injecting"
	hue = "#003cff"
	severity = SEVERITY_ABOVE_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/rand_reagent/on_cross(obj/structure/spacevine/vine_object, mob/crosser)
	if(!isliving(crosser))
		return
	var/mob/living/living_crosser = crosser
	if(isvineimmune(living_crosser))
		return
	if(prob(MUTATION_INJECT_CHANCE))
		var/choose_reagent = pick(subtypesof(/datum/reagent))
		living_crosser.reagents.add_reagent(choose_reagent, MUTATION_INJECT_AMOUNT)


// Pulses radiation on growth
/datum/spacevine_mutation/radiation
	name = "Radiation pulsing"
	hue = "#ffef62"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/radiation/on_grow(obj/structure/spacevine/vine_object)
	radiation_pulse(src, max_range = MUTATION_PULSE_RANGE, threshold = RAD_EXTREME_INSULATION)


// Generates miasma on growth
/datum/spacevine_mutation/miasma_generating
	name = "Miasma producing"
	hue = "#470566"
	severity = SEVERITY_ABOVE_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/miasma_generating/on_grow(obj/structure/spacevine/vine_object)
	var/turf/vine_object_turf = get_turf(vine_object)
	vine_object_turf.atmos_spawn_air("miasma=100;TEMP=[T20C]")


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
	vine_object.layer = TURF_LAYER
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


// Hitting/crossing has a chance to infect you with a disease
/datum/spacevine_mutation/disease_carrying
	name = "Disease carrying"
	hue = "#dcf597"
	severity = SEVERITY_MAJOR
	quality = NEGATIVE

/datum/spacevine_mutation/disease_carrying/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/item_used, expected_damage)
	if(!isliving(hitter))
		return expected_damage
	var/mob/living/living_hitter = hitter
	if(isvineimmune(living_hitter))
		return expected_damage
	if(prob(MUTATION_INFECT_CHANCE_HIT))
		var/datum/disease/new_disease = new /datum/disease/advance/random(MUTATION_MAX_SYMPTOMS, MUTATION_MAX_LEVEL)
		living_hitter.ForceContractDisease(new_disease, make_copy = FALSE, del_on_fail = TRUE)
	return expected_damage

/datum/spacevine_mutation/disease_carrying/on_cross(obj/structure/spacevine/vine_object, mob/crosser)
	if(!isliving(crosser))
		return
	var/mob/living/living_crosser = crosser
	if(isvineimmune(living_crosser))
		return
	if(prob(MUTATION_INFECT_CHANCE_CROSS))
		var/datum/disease/new_disease = new /datum/disease/advance/random(MUTATION_MAX_SYMPTOMS, MUTATION_MAX_LEVEL)
		living_crosser.ForceContractDisease(new_disease, make_copy = FALSE, del_on_fail = TRUE)


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

#undef MUTATION_SLIP_CHANCE
#undef MUTATION_REFLECT_CHANCE
#undef MUTATION_SEED_CHANCE
#undef MUTATION_POTENCY
#undef MUTATION_PRODUCTION
#undef MUTATION_ZAP_CHANCE
#undef MUTATION_ZAP_DAMAGE
#undef MUTATION_EMP_HEAVY_RANGE
#undef MUTATION_EMP_LIGHT_RANGE
#undef MUTATION_INJECT_CHANCE
#undef MUTATION_INJECT_AMOUNT
#undef MUTATION_PULSE_RANGE
#undef MUTATION_HEAL_AMOUNT_CROSS
#undef MUTATION_HEAL_AMOUNT_EAT
#undef MUTATION_INFECT_CHANCE_HIT
#undef MUTATION_INFECT_CHANCE_CROSS
#undef MUTATION_MAX_SYMPTOMS
#undef MUTATION_MAX_LEVEL
