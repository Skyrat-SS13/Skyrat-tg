// Slips on cross
/datum/spacevine_mutation/slipping
	name = "Slipping"
	hue = "#97eaff"
	severity = SEVERITY_TRIVIAL
	quality = NEGATIVE

/datum/spacevine_mutation/slipping/on_cross(obj/structure/spacevine/vine_object, mob/living/crosser)
	if(issilicon(crosser))
		return
	if(ishuman(crosser))
		var/mob/living/carbon/human/living_crosser = crosser
		living_crosser.slip(20)
		to_chat(living_crosser, span_alert("The vines slip you!"))

// Has a chance to reflect melee damage
/datum/spacevine_mutation/melee_reflect
	name = "Melee reflecting"
	hue = "#b6054f"
	severity = SEVERITY_ABOVE_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/melee_reflect/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/hitting_item, expected_damage)
	if(isliving(hitter))
		var/mob/living/attacking_mob = hitter
		if(isvineimmune(attacking_mob))
			return
		if(prob(10))
			attacking_mob.adjustBruteLoss(expected_damage)
		else
			. = expected_damage

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
	new /datum/spacevine_controller(planted_turf, added_mut_list, 50, 5)
	new /mob/living/simple_animal/hostile/venus_human_trap(planted_turf)

/datum/spacevine_mutation/seeding/on_cross(obj/structure/spacevine/vine_object, mob/crosser)
	if(isliving(crosser))
		var/mob/living/living_crosser = crosser
		if(isvineimmune(living_crosser) || living_crosser.stat == DEAD)
			return
		if(prob(10))
			addtimer(CALLBACK(living_crosser, /mob/living/proc/plant_kudzu), 1 MINUTES)

/datum/spacevine_mutation/seeding/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/weapon, expected_damage)
	if(isliving(hitter))
		var/mob/living/living_hitter = hitter
		if(isvineimmune(living_hitter))
			return
		if(prob(10))
			addtimer(CALLBACK(living_hitter, /mob/living/proc/plant_kudzu), 1 MINUTES)
	. = expected_damage

// Has a chance to electrocute mobs that hit it
/datum/spacevine_mutation/electrify
	name = "Electrified"
	hue = "#f7eb86"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/electrify/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/hitting_item, expected_damage)
	if(isliving(hitter))
		var/mob/living/living_hitter = hitter
		if(isvineimmune(living_hitter))
			return
		if(prob(20))
			living_hitter.electrocute_act(10, vine_object)
	. = expected_damage

// EMP explosion on death
/datum/spacevine_mutation/emp
	name = "EMP"
	hue = "#ffffff"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/emp/on_death(obj/structure/spacevine/vine_object)
	empulse(vine_object, 1, 2)

// Has a chance to inject a random reagent into crossing mobs
/datum/spacevine_mutation/rand_reagent
	name = "Reagent injecting"
	hue = "#003cff"
	severity = SEVERITY_ABOVE_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/rand_reagent/on_cross(obj/structure/spacevine/vine_object, mob/crosser)
	if(isliving(crosser))
		var/mob/living/living_crosser = crosser
		if(isvineimmune(living_crosser))
			return
		if(prob(10))
			var/choose_reagent = pick(subtypesof(/datum/reagent))
			living_crosser.reagents.add_reagent(choose_reagent, 10)

// Pulses radiation on growth
/datum/spacevine_mutation/radiation
	name = "Radiation pulsing"
	hue = "#ffef62"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/radiation/on_grow(obj/structure/spacevine/vine_object)
	radiation_pulse(src, max_range = 5, threshold = RAD_EXTREME_INSULATION)

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
	if(isliving(crosser))
		var/mob/living/living_crosser = crosser
		living_crosser.adjustBruteLoss(-1)
		living_crosser.adjustFireLoss(-1)
		living_crosser.adjustToxLoss(-1)

/datum/spacevine_mutation/flesh_mending/on_eat(obj/structure/spacevine/vine_object, mob/living/eater)
	if(isliving(eater))
		var/mob/living/living_eater = eater
		living_eater.adjustBruteLoss(-5)
		living_eater.adjustFireLoss(-5)
		living_eater.adjustToxLoss(-5)

// Allows the vine to walk 1 tile away from turfs
/datum/spacevine_mutation/space_walking
	name = "Space walking"
	hue = "#0a1330"
	severity = SEVERITY_MAJOR
	quality = NEGATIVE

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

// Hitting/crossing has a chance to infect you with a disease
/datum/spacevine_mutation/disease_carrying
	name = "Disease carrying"
	hue = "#dcf597"
	severity = SEVERITY_MAJOR
	quality = NEGATIVE

/datum/spacevine_mutation/disease_carrying/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/item_used, expected_damage)
	if(isliving(hitter))
		var/mob/living/living_hitter = hitter
		if(isvineimmune(living_hitter))
			return
		if(prob(20))
			var/datum/disease/new_disease = new /datum/disease/advance/random(5, 5)
			living_hitter.ForceContractDisease(new_disease, FALSE, TRUE)
	. = expected_damage

/datum/spacevine_mutation/disease_carrying/on_cross(obj/structure/spacevine/vine_object, mob/crosser)
	if(isliving(crosser))
		var/mob/living/living_crosser = crosser
		if(isvineimmune(living_crosser))
			return
		if(prob(10))
			var/datum/disease/new_disease = new /datum/disease/advance/random(5, 5)
			living_crosser.ForceContractDisease(new_disease, FALSE, TRUE)

/turf/open/floor/plating/kudzu
	name = "vine flooring"
	icon = 'modular_skyrat/modules/aesthetics/floors/icons/floors.dmi'
	icon_state = "vinefloor"

/turf/open/floor/plating/kudzu/attacked_by(obj/item/attacking_item, mob/living/user)
	if(istype(attacking_item, /obj/item/wirecutters))
		ChangeTurf(/turf/open/space)
	else
		return ..()

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
	var/moles_to_replace = GAS_MUTATION_REMOVAL_MULTIPLIER * vine_object.energy
	gas_mix.gases[/datum/gas/carbon_dioxide][MOLES] = max(gas_mix.gases[/datum/gas/carbon_dioxide][MOLES] - moles_to_replace, 0)
	gas_mix.garbage_collect()

	var/happy_atmos = "oxygen=[moles_to_replace];TEMP=296"
	current_turf.atmos_spawn_air(happy_atmos)
