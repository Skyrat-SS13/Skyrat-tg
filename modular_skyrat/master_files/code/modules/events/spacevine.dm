/// Determines brightness of the light emitted by kudzu with the light mutation
#define LIGHT_MUTATION_BRIGHTNESS 4
/// Determines the probability that the toxicity mutation will harm someone who passes through it
#define TOXICITY_MUTATION_PROB 10
/// Determines the impact radius of kudzu's explosive mutation
#define EXPLOSION_MUTATION_IMPACT_RADIUS 2
/// Determines the scale factor for the amount of gas removed by kudzu with a gas removal mutation, which is this scale factor * the kudzu's energy level
#define GAS_MUTATION_REMOVAL_MULTIPLIER 3
/// Determines the probability that the thorn mutation will harm someone who passes through or attacks it
#define THORN_MUTATION_CUT_PROB 10
/// Determines the probability that a kudzu plant with the flowering mutation will spawn a venus flower bud
#define FLOWERING_MUTATION_SPAWN_PROB 10

/// Temperature below which the kudzu can't spread
#define VINE_FREEZING_POINT 100

/// Kudzu severity values for traits, based on severity in terms of how severely it impacts the game, the lower the severity, the more likely it is to appear
#define SEVERITY_TRIVIAL 1
#define SEVERITY_MINOR 2
#define SEVERITY_AVERAGE 4
#define SEVERITY_ABOVE_AVERAGE 7
#define SEVERITY_MAJOR 10

/// Kudzu mutativeness is based on a scale factor * potency
#define MUTATIVENESS_SCALE_FACTOR 0.1

/// Kudzu maximum mutation severity is a linear function of potency
#define MAX_SEVERITY_LINEAR_COEFF 0.1
#define MAX_SEVERITY_CONSTANT_TERM 10

/// The maximum possible productivity value of a (normal) kudzu plant, used for calculating a plant's spread cap and multiplier
#define MAX_POSSIBLE_PRODUCTIVITY_VALUE 10

/// Kudzu spread cap is a scaled version of production speed, such that the better the production speed, ie. the lower the speed value is, the faster is spreads
#define SPREAD_CAP_SCALE_FACTOR 4
/// Kudzu spread multiplier is a reciporal function of production speed, such that the better the production speed, ie. the lower the speed value is, the faster it spreads
#define SPREAD_MULTIPLIER_MAX 50

/datum/round_event_control/spacevine
	name = "Space Vines"
	typepath = /datum/round_event/spacevine
	weight = 10
	max_occurrences = 1
	min_players = 60

/datum/round_event/spacevine
	fakeable = FALSE

/datum/round_event/spacevine/start()
	// list of all the empty floor turfs in the hallway areas
	var/list/turfs = list()

	var/obj/structure/spacevine/vine = new()

	for(var/area/station/maintenance/maint_area in world)
		for(var/turf/floor in maint_area)
			if(floor.Enter(vine))
				turfs += floor

	qdel(vine)

	// Pick a turf to spawn at if we can
	if(length(turfs))
		var/turf/floor = pick(turfs)
		// spawn a controller at turf with randomized stats and a single random mutation
		new /datum/spacevine_controller(floor, list(pick(subtypesof(/datum/spacevine_mutation))), rand(10, 100), rand(1, 6), src)
		for(var/spawn_venus in 1 to 2)
			new /mob/living/simple_animal/hostile/venus_human_trap(floor)

/datum/spacevine_mutation
	/// The name of the mutation, it will be displayed in the examine of any vine objects.
	var/name = ""
	/// How severe the plant it, think of it as the usefullness. Used in probability calculations.
	var/severity = 1
	/// The hue of the plant
	var/hue
	/// What kind of mutation is it, good, bad, really bad?
	var/quality

/datum/spacevine_mutation/proc/add_mutation_to_vinepiece(obj/structure/spacevine/vine_object)
	vine_object.mutations |= src
	vine_object.add_atom_colour(hue, FIXED_COLOUR_PRIORITY)

/datum/spacevine_mutation/proc/process_mutation(obj/structure/spacevine/vine_object)
	return

/datum/spacevine_mutation/proc/process_temperature(obj/structure/spacevine/vine_object, temp, volume)
	return

/datum/spacevine_mutation/proc/on_birth(obj/structure/spacevine/vine_object)
	return

/datum/spacevine_mutation/proc/on_grow(obj/structure/spacevine/vine_object)
	return

/datum/spacevine_mutation/proc/on_death(obj/structure/spacevine/vine_object)
	return

/datum/spacevine_mutation/proc/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/item_used, expected_damage)
	. = expected_damage

/datum/spacevine_mutation/proc/on_cross(obj/structure/spacevine/vine_object, mob/crosser)
	return

/datum/spacevine_mutation/proc/on_chem(obj/structure/spacevine/vine_object, datum/reagent/reagent_applied)
	return

/datum/spacevine_mutation/proc/on_eat(obj/structure/spacevine/vine_object, mob/living/eater)
	return

/datum/spacevine_mutation/proc/on_spread(obj/structure/spacevine/vine_object, turf/target)
	return

/datum/spacevine_mutation/proc/on_buckle(obj/structure/spacevine/vine_object, mob/living/buckled)
	return

/datum/spacevine_mutation/proc/on_explosion(severity, target, obj/structure/spacevine/vine_object)
	return

/datum/spacevine_mutation/aggressive_spread/proc/aggrospread_act(obj/structure/spacevine/spreading_vine, mob/living/buckled_mob)
	return

// Creates light
/datum/spacevine_mutation/light
	name = "Light"
	hue = "#B2EA70"
	quality = POSITIVE
	severity = SEVERITY_TRIVIAL

/datum/spacevine_mutation/light/on_grow(obj/structure/spacevine/vine_object)
	if(vine_object.energy)
		vine_object.set_light(LIGHT_MUTATION_BRIGHTNESS, 0.3)


// Deals toxin damage when crossed or eaten
/datum/spacevine_mutation/toxicity
	name = "Toxic"
	hue = "#9B3675"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/toxicity/on_cross(obj/structure/spacevine/vine_object, mob/living/crosser)
	if(issilicon(crosser))
		return
	if(prob(TOXICITY_MUTATION_PROB) && istype(crosser) && !isvineimmune(crosser))
		to_chat(crosser, span_alert("You accidentally touch the vine and feel a strange sensation."))
		crosser.adjustToxLoss(5)

/datum/spacevine_mutation/toxicity/on_eat(obj/structure/spacevine/vine_object, mob/living/eater)
	if(!isvineimmune(eater))
		eater.adjustToxLoss(5)


// Explodes - chain reaction, or on death
/datum/spacevine_mutation/explosive
	name = "Explosive"
	hue = "#D83A56"
	quality = NEGATIVE
	severity = SEVERITY_ABOVE_AVERAGE

/datum/spacevine_mutation/explosive/on_explosion(explosion_severity, target, obj/structure/spacevine/vine_object)
	if(explosion_severity < 3)
		qdel(vine_object)
	else
		. = 1
		QDEL_IN(vine_object, 5)

/datum/spacevine_mutation/explosive/on_death(obj/structure/spacevine/vine_object, mob/hitter, obj/item/hitting_item)
	explosion(vine_object, light_impact_range = EXPLOSION_MUTATION_IMPACT_RADIUS, adminlog = FALSE)


// Immune to fire and fire damage
/datum/spacevine_mutation/fire_proof
	name = "Fire proof"
	hue = "#FF616D"
	quality = MINOR_NEGATIVE
	severity = SEVERITY_ABOVE_AVERAGE

/datum/spacevine_mutation/fire_proof/process_temperature(obj/structure/spacevine/vine_object, temp, volume)
	return 1

/datum/spacevine_mutation/fire_proof/on_hit(obj/structure/spacevine/vine_object, mob/hitter, obj/item/weapon_used, expected_damage)
	if(weapon_used && weapon_used.damtype == BURN)
		. = 0
	else
		. = expected_damage


// Overrides existing vines when spreading to a tile
/datum/spacevine_mutation/vine_eating
	name = "Vine eating"
	hue = "#F4A442"
	quality = MINOR_NEGATIVE
	severity = SEVERITY_MINOR

/// Destroys any vine on spread-target's tile. The checks for if this should be done are in the spread() proc.
/datum/spacevine_mutation/vine_eating/on_spread(obj/structure/spacevine/vine_object, turf/target)
	for(var/obj/structure/spacevine/prey in target)
		qdel(prey)


// Hurts mobs when interacting with a mob - either on spread or buckle
/datum/spacevine_mutation/aggressive_spread  // very OP, but im out of other ideas currently
	name = "Agressive spreading"
	hue = "#316b2f"
	severity = SEVERITY_MAJOR
	quality = NEGATIVE

/// Checks mobs on spread-target's turf to see if they should be hit by a damaging proc or not.
/datum/spacevine_mutation/aggressive_spread/on_spread(obj/structure/spacevine/vine_object, turf/target, mob/living)
	for(var/mob/living/damaged_mob in target)
		if(!isvineimmune(damaged_mob) && damaged_mob.stat != DEAD) // Don't kill immune creatures. Dead check to prevent log spam when a corpse is trapped between vine eaters.
			aggrospread_act(vine_object, damaged_mob)

/// What happens if an aggr spreading vine buckles a mob.
/datum/spacevine_mutation/aggressive_spread/on_buckle(obj/structure/spacevine/vine_object, mob/living/buckled)
	aggrospread_act(vine_object, buckled)

/// Hurts mobs. To be used when a vine with aggressive spread mutation spreads into the mob's tile or buckles them.
/datum/spacevine_mutation/aggressive_spread/aggrospread_act(obj/structure/spacevine/attacking_vine, mob/living/hit_mob)
	var/mob/living/carbon/hit_carbon = hit_mob // If the mob is carbon then it now also exists as hit_carbon, and not just hit_mob.
	if(!istype(hit_carbon)) // Living but not a carbon? Maybe a silicon? Can't be wounded so have a big chunk of simple bruteloss with no special effects. They can be entangled.
		hit_mob.adjustBruteLoss(75)
		playsound(hit_mob, 'sound/weapons/whip.ogg', 50, TRUE, -1)
		hit_mob.visible_message(span_danger("[hit_mob] is brutally threshed by [attacking_vine]!"), span_userdanger("You are brutally threshed by [attacking_vine]!"))
		log_combat(attacking_vine, hit_mob, "aggressively spread into") // You aren't being attacked by the vines. You just happen to stand in their way.
		return

	// If hit_mob IS a carbon subtype (hit_carbon) we move on to pick a more complex damage proc, with damage zones, wounds and armor mitigation.
	var/obj/item/bodypart/limb = pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG, BODY_ZONE_HEAD, BODY_ZONE_CHEST) // Picks a random bodypart. Does not runtime even if it's missing.
	var/armor = hit_carbon.run_armor_check(limb, MELEE, null, null) // armor = the armor value of that randomly chosen bodypart. Nulls to not print a message, because it would still print on pierce.
	var/datum/spacevine_mutation/thorns/has_thorns = locate() in attacking_vine.mutations // Searches for the thorns mutation in the "mutations"-list inside obj/structure/spacevine, and defines T if it finds it.
	if(has_thorns && (prob(40))) // If we found the thorns mutation there is now a chance to get stung instead of lashed or smashed.
		hit_carbon.apply_damage(50, BRUTE, def_zone = limb, wound_bonus = rand(-20, 10), sharpness = SHARP_POINTY) // This one gets a bit lower damage because it ignores armor.
		hit_carbon.Stun(1 SECONDS) // Stopped in place for a moment.
		playsound(hit_mob, 'sound/weapons/pierce.ogg', 50, TRUE, -1)
		hit_mob.visible_message(span_danger("[hit_mob] is nailed by a sharp thorn!"), span_userdanger("You are nailed by a sharp thorn!"))
		log_combat(attacking_vine, hit_mob, "aggressively pierced") // "Aggressively" for easy ctrl+F'ing in the attack logs.
	else
		if(prob(80))
			hit_carbon.apply_damage(60, BRUTE, def_zone = limb, blocked = armor, wound_bonus = rand(-20, 10), sharpness = SHARP_EDGED)
			hit_carbon.Knockdown(2 SECONDS)
			playsound(hit_mob, 'sound/weapons/whip.ogg', 50, TRUE, -1)
			hit_mob.visible_message(span_danger("[hit_mob] is lacerated by an outburst of vines!"), span_userdanger("You are lacerated by an outburst of vines!"))
			log_combat(attacking_vine, hit_mob, "aggressively lacerated")
		else
			hit_carbon.apply_damage(60, BRUTE, def_zone = limb, blocked = armor, wound_bonus = rand(-20, 10), sharpness = NONE)
			hit_carbon.Knockdown(3 SECONDS)
			var/atom/throw_target = get_edge_target_turf(hit_carbon, get_dir(attacking_vine, get_step_away(hit_carbon, attacking_vine)))
			hit_carbon.throw_at(throw_target, 3, 6)
			playsound(hit_mob, 'sound/effects/hit_kick.ogg', 50, TRUE, -1)
			hit_mob.visible_message(span_danger("[hit_mob] is smashed by a large vine!"), span_userdanger("You are smashed by a large vine!"))
			log_combat(attacking_vine, hit_mob, "aggressively smashed")


// See-through
/datum/spacevine_mutation/transparency
	name = "Transparent"
	hue = ""
	quality = POSITIVE
	severity = SEVERITY_TRIVIAL

/datum/spacevine_mutation/transparency/on_grow(obj/structure/spacevine/vine_object)
	vine_object.set_opacity(0)
	vine_object.alpha = 125


// Consumes oxygen gas on process
/datum/spacevine_mutation/oxy_eater
	name = "Oxygen consuming"
	hue = "#28B5B5"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/oxy_eater/process_mutation(obj/structure/spacevine/vine_object)
	var/turf/open/floor/current_turf = vine_object.loc
	if(!istype(current_turf))
		return
	var/datum/gas_mixture/gas_mix = current_turf.air
	if(!gas_mix.gases[/datum/gas/oxygen])
		return
	gas_mix.gases[/datum/gas/oxygen][MOLES] = max(gas_mix.gases[/datum/gas/oxygen][MOLES] - GAS_MUTATION_REMOVAL_MULTIPLIER * vine_object.energy, 0)
	gas_mix.garbage_collect()


// Consumes nitrogen gas on process
/datum/spacevine_mutation/nitro_eater
	name = "Nitrogen consuming"
	hue = "#FF7B54"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/nitro_eater/process_mutation(obj/structure/spacevine/vine_object)
	var/turf/open/floor/current_turf = vine_object.loc
	if(!istype(current_turf))
		return
	var/datum/gas_mixture/gas_mix = current_turf.air
	if(!gas_mix.gases[/datum/gas/nitrogen])
		return
	gas_mix.gases[/datum/gas/nitrogen][MOLES] = max(gas_mix.gases[/datum/gas/nitrogen][MOLES] - GAS_MUTATION_REMOVAL_MULTIPLIER * vine_object.energy, 0)
	gas_mix.garbage_collect()


// Consumes carbon dioxide gas on process
/datum/spacevine_mutation/carbondioxide_eater
	name = "CO2 consuming"
	hue = "#798777"
	severity = SEVERITY_MINOR
	quality = POSITIVE

/datum/spacevine_mutation/carbondioxide_eater/process_mutation(obj/structure/spacevine/vine_object)
	var/turf/open/floor/current_turf = vine_object.loc
	if(!istype(current_turf))
		return
	var/datum/gas_mixture/gas_mix = current_turf.air
	if(!gas_mix.gases[/datum/gas/carbon_dioxide])
		return
	gas_mix.gases[/datum/gas/carbon_dioxide][MOLES] = max(gas_mix.gases[/datum/gas/carbon_dioxide][MOLES] - GAS_MUTATION_REMOVAL_MULTIPLIER * vine_object.energy, 0)
	gas_mix.garbage_collect()


// Consumes plasma gas on process
/datum/spacevine_mutation/plasma_eater
	name = "Plasma consuming"
	hue = "#9074b6"
	severity = SEVERITY_AVERAGE
	quality = POSITIVE

/datum/spacevine_mutation/plasma_eater/process_mutation(obj/structure/spacevine/vine_object)
	var/turf/open/floor/current_turf = vine_object.loc
	if(!istype(current_turf))
		return
	var/datum/gas_mixture/gas_mix = current_turf.air
	if(!gas_mix.gases[/datum/gas/plasma])
		return
	gas_mix.gases[/datum/gas/plasma][MOLES] = max(gas_mix.gases[/datum/gas/plasma][MOLES] - GAS_MUTATION_REMOVAL_MULTIPLIER * vine_object.energy, 0)
	gas_mix.garbage_collect()


// Deals damage to mobs that cross or attack it
/datum/spacevine_mutation/thorns
	name = "Thorny"
	hue = "#9ECCA4"
	severity = SEVERITY_AVERAGE
	quality = NEGATIVE

/datum/spacevine_mutation/thorns/on_cross(obj/structure/spacevine/vine_object, mob/living/crosser)
	if(prob(THORN_MUTATION_CUT_PROB) && istype(crosser) && !isvineimmune(crosser))
		var/mob/living/living_crosser = crosser
		living_crosser.adjustBruteLoss(5)
		to_chat(living_crosser, span_alert("You cut yourself on the thorny vines."))

/datum/spacevine_mutation/thorns/on_hit(obj/structure/spacevine/vine_object, mob/living/hitter, obj/item/hitting_item, expected_damage)
	if(prob(THORN_MUTATION_CUT_PROB) && istype(hitter) && !isvineimmune(hitter))
		var/mob/living/attacking_mob = hitter
		attacking_mob.adjustBruteLoss(5)
		to_chat(attacking_mob, span_alert("You cut yourself on the thorny vines."))
	. = expected_damage


// Dense, with reduced damage from sharp weapons
/datum/spacevine_mutation/woodening
	name = "Hardened"
	hue = "#997700"
	quality = NEGATIVE
	severity = SEVERITY_ABOVE_AVERAGE

/datum/spacevine_mutation/woodening/on_grow(obj/structure/spacevine/vine_object)
	if(vine_object.energy)
		vine_object.density = TRUE
	vine_object.modify_max_integrity(100)

/datum/spacevine_mutation/woodening/on_hit(obj/structure/spacevine/vine_object, mob/living/hitter, obj/item/weapon, expected_damage)
	if(weapon?.get_sharpness())
		. = expected_damage * 0.5
	else
		. = expected_damage


// Creates flower buds on growth - these spawn venus human traps
/datum/spacevine_mutation/flowering
	name = "Flowering"
	hue = "#66DE93"
	quality = NEGATIVE
	severity = SEVERITY_MAJOR

/datum/spacevine_mutation/flowering/on_grow(obj/structure/spacevine/vine_object)
	if(vine_object.energy == 2 && prob(FLOWERING_MUTATION_SPAWN_PROB) && !locate(/obj/structure/alien/resin/flower_bud) in range(5, vine_object))
		new/obj/structure/alien/resin/flower_bud(get_turf(vine_object))

/datum/spacevine_mutation/flowering/on_cross(obj/structure/spacevine/vine_object, mob/living/crosser)
	if(prob(25))
		vine_object.entangle(crosser)


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

// SPACE VINES (Note that this code is very similar to Biomass code)
/obj/structure/spacevine
	name = "space vines"
	desc = "An extremely expansionistic species of vine."
	icon = 'icons/effects/spacevines.dmi'
	icon_state = "Light1"
	anchored = TRUE
	density = FALSE
	layer = SPACEVINE_LAYER
	mouse_opacity = MOUSE_OPACITY_OPAQUE // Clicking anywhere on the turf is good enough
	pass_flags = PASSTABLE | PASSGRILLE
	max_integrity = 50
	/// The amount of energy it has to grow/spread
	var/energy = 0
	/// The controller that controls this vine
	var/datum/spacevine_controller/master = null
	/// List of mutations that the vine currently has
	var/list/mutations = list()
	/// If true, is resistant to being killed by plant-b-gone
	var/plantbgone_resist = FALSE

/obj/structure/spacevine/Initialize(mapload)
	. = ..()
	add_atom_colour("#ffffff", FIXED_COLOUR_PRIORITY)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	AddElement(/datum/element/atmos_sensitive, mapload)

/obj/structure/spacevine/examine(mob/user)
	. = ..()
	if(!length(mutations))
		. += "This vine has no mutations."
		return
	var/text = "This vine has the following mutations:\n"
	for(var/datum/spacevine_mutation/mutation as anything in mutations)
		if(mutation.name == "transparent") /// Transparent has no hue
			text += "<font color='#346751'>Transparent</font> "
		else
			text += "<font color='[mutation.hue]'>[mutation.name]</font> "
	. += text

/obj/structure/spacevine/Destroy()
	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		vine_mutation.on_death(src)
	if(master)
		master.VineDestroyed(src)
	mutations = list()
	set_opacity(0)
	if(has_buckled_mobs())
		unbuckle_all_mobs(force = 1)
	return ..()


/// Checks for chemical resistant mutations and applied chemicals to see if it should be destroyed
/obj/structure/spacevine/proc/on_chem_effect(datum/reagent/applied_reagent)
	var/override = 0
	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		override += vine_mutation.on_chem(src, applied_reagent)
	if(!override && istype(applied_reagent, /datum/reagent/toxin/plantbgone) && !plantbgone_resist && prob(50))
		qdel(src)


/// Checks for eating-resistant mutations to see if it should be destroyed
/obj/structure/spacevine/proc/eat(mob/eater)
	var/override = 0
	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		override += vine_mutation.on_eat(src, eater)
	if(!override)
		qdel(src)

// Take extra damage from weapons that are sharp or do burn damage, unless resistant through mutations
/obj/structure/spacevine/attacked_by(obj/item/weapon, mob/living/user)
	var/damage_dealt = weapon.force
	if(weapon.get_sharpness())
		damage_dealt *= 4
	if(weapon.damtype == BURN)
		damage_dealt *= 4

	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		damage_dealt = vine_mutation.on_hit(src, user, weapon, damage_dealt) // on_hit now takes override damage as arg and returns new value for other mutations to permutate further
	take_damage(damage_dealt, weapon.damtype, MELEE, 1)

/obj/structure/spacevine/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(src, 'sound/weapons/slash.ogg', 50, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			playsound(src.loc, 'sound/items/welder.ogg', 100, TRUE)

/// Applies effects when a mob enters the same turf as a vine
/obj/structure/spacevine/proc/on_entered(datum/source, atom/movable/moving_atom)
	SIGNAL_HANDLER
	if(!isliving(moving_atom))
		return
	for(var/datum/spacevine_mutation/mutation in mutations)
		mutation.on_cross(src, moving_atom)
	// Venus Human Traps will heal for 5 percent of their max health
	if(istype(moving_atom, /mob/living/simple_animal/hostile/venus_human_trap))
		var/mob/living/simple_animal/hostile/venus_human_trap/healing_trap = moving_atom
		healing_trap.adjustHealth(-(healing_trap.maxHealth * 0.05))

// ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/structure/spacevine/attack_hand(mob/user, list/modifiers)
	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		vine_mutation.on_hit(src, user)
	user_unbuckle_mob(user, user)
	. = ..()

/obj/structure/spacevine/attack_paw(mob/living/user, list/modifiers)
	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		vine_mutation.on_hit(src, user)
	user_unbuckle_mob(user, user)

/obj/structure/spacevine/attack_alien(mob/living/user, list/modifiers)
	eat(user)

/datum/spacevine_controller
	/// A hard referenced list of all of the current vines...
	var/list/obj/structure/spacevine/vines
	/// The queue relating to what is to be grown next
	var/list/growth_queue
	/// List of currently processed vines, on this level to prevent runtime tomfoolery
	var/list/obj/structure/spacevine/queue_end
	/// How quickly it spreads
	var/spread_multiplier = 5
	/// The actual cap to how quickly it spreads.
	var/spread_cap = 30
	/// A referenced list to all of the current mutations the vine has!
	var/list/vine_mutations_list
	/// How likely it is to mutate!
	var/mutativeness = 1

/datum/spacevine_controller/New(turf/location, list/muts, potency, production, datum/round_event/event = null)
	vines = list()
	growth_queue = list()
	queue_end = list()
	var/obj/structure/spacevine/spawned_vine = spawn_spacevine_piece(location, null, muts)
	if (event)
		event.announce_to_ghosts(spawned_vine)
	START_PROCESSING(SSobj, src)
	vine_mutations_list = list()
	init_subtypes(/datum/spacevine_mutation/, vine_mutations_list)
	if(potency != null)
		mutativeness = potency / 10
	if(production != null && production <= 10) // Prevents runtime in case production is set to 11.
		spread_cap *= (11 - production) / 5 // Best production speed of 1 doubles spread_cap to 60 while worst speed of 10 lowers it to 6. Even distribution.
		spread_multiplier /= (11 - production) / 5

/datum/spacevine_controller/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_SPACEVINE_PURGE, "Delete Vines")

/datum/spacevine_controller/vv_do_topic(href_list)
	. = ..()
	if(href_list[VV_HK_SPACEVINE_PURGE])
		if(tgui_alert(usr, "Are you sure you want to delete this spacevine cluster?", "Delete Vines", list("Yes", "No")) == "Yes")
			DeleteVines()

/datum/spacevine_controller/proc/DeleteVines() // this is kill
	QDEL_LIST(vines) // this will also qdel us

/datum/spacevine_controller/Destroy()
	STOP_PROCESSING(SSobj, src)
	vines.Cut()
	growth_queue.Cut()
	queue_end.Cut()
	return ..()

/datum/spacevine_controller/proc/spawn_spacevine_piece(turf/location, obj/structure/spacevine/parent, list/muts)
	var/obj/structure/spacevine/current_vine = new(location)
	growth_queue += current_vine
	vines += current_vine
	current_vine.master = src
	for(var/datum/spacevine_mutation/chosen_mutation in muts)
		chosen_mutation.add_mutation_to_vinepiece(current_vine)
	if(parent)
		current_vine.mutations |= parent.mutations
		var/parent_color = parent.atom_colours[FIXED_COLOUR_PRIORITY]
		current_vine.add_atom_colour(parent_color, FIXED_COLOUR_PRIORITY)
		if(prob(mutativeness))
			var/datum/spacevine_mutation/random_mutate = pick(vine_mutations_list - current_vine.mutations)
			random_mutate.add_mutation_to_vinepiece(current_vine)

	for(var/datum/spacevine_mutation/vine_mutation in current_vine.mutations)
		vine_mutation.on_birth(current_vine)
	location.Entered(current_vine, null)
	return current_vine

/datum/spacevine_controller/proc/VineDestroyed(obj/structure/spacevine/destroyed_vine)
	destroyed_vine.master = null
	vines -= destroyed_vine
	growth_queue -= destroyed_vine
	queue_end -= destroyed_vine
	if(length(vines))
		return
	var/obj/item/seeds/kudzu/kudzu_seed = new(destroyed_vine.loc)
	kudzu_seed.mutations |= destroyed_vine.mutations
	kudzu_seed.set_potency(mutativeness * 10)
	kudzu_seed.set_production(11 - (spread_cap / initial(spread_cap)) * 5) // Reverts spread_cap formula so resulting seed gets original production stat or equivalent back.
	qdel(src)

/datum/spacevine_controller/process(delta_time)
	var/vine_count = length(vines)
	if(!vine_count)
		qdel(src) // space vines exterminated. Remove the controller
		return

	var/spread_max = round(clamp(delta_time * 0.5 * vine_count / spread_multiplier, 1, spread_cap))
	var/amount_processed = 0
	for(var/obj/structure/spacevine/current_vine as anything in growth_queue)
		if(!current_vine)
			continue
		growth_queue -= current_vine
		queue_end += current_vine
		for(var/datum/spacevine_mutation/mutation in current_vine.mutations)
			mutation.process_mutation(current_vine)

		if(current_vine.energy >= 2) // If tile is fully grown
			current_vine.entangle_mob()
		else if(DT_PROB(10, delta_time)) // If tile isn't fully grown
			current_vine.grow()

		current_vine.spread()

		amount_processed++
		if(amount_processed >= spread_max)
			break

	// We can only do so much work per process, but we still want to process everything at some point
	// So we shift the queue a bit
	growth_queue += queue_end
	queue_end = list()

/obj/structure/spacevine/proc/grow()
	if(!energy)
		src.icon_state = pick("Med1", "Med2", "Med3")
		energy = 1
		set_opacity(1)
	else
		src.icon_state = pick("Hvy1", "Hvy2", "Hvy3")
		energy = 2

	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		vine_mutation.on_grow(src)

/obj/structure/spacevine/proc/entangle_mob()
	var/datum/spacevine_mutation/domesticated/domesticated = locate() in mutations
	if(!has_buckled_mobs() && prob(25) && !domesticated)
		for(var/mob/living/entangled_mob in src.loc)
			entangle(entangled_mob)
			if(has_buckled_mobs())
				break // only capture one mob at a time

/obj/structure/spacevine/proc/entangle(mob/living/entangled_mob)
	if(!entangled_mob || isvineimmune(entangled_mob))
		return
	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		vine_mutation.on_buckle(src, entangled_mob)
	if((entangled_mob.stat != DEAD) && (entangled_mob.buckled != src) && ishuman(entangled_mob)) // not dead or captured
		to_chat(entangled_mob, span_danger("The vines [pick("wind", "tangle", "tighten")] around you!"))
		buckle_mob(entangled_mob, 1)

/// Finds a target tile to spread to. If checks pass it will spread to it and also proc on_spread on target.
/obj/structure/spacevine/proc/spread()
	var/direction = pick(GLOB.cardinals)
	var/turf/stepturf = get_step(src, direction)
	if(!stepturf)
		return
	// Domesticated removes its ability to open doors
	var/datum/spacevine_mutation/domesticated/domesticated = locate() in mutations
	if(!domesticated)
		for(var/obj/machinery/door/target_door in stepturf.contents)
			if(prob(50))
				target_door.open()
	// Space walking allows it to spread into space under conditions
	var/datum/spacevine_mutation/space_walking/space_mutation = locate() in mutations
	if(!isspaceturf(stepturf) && stepturf.Enter(src))
		spread_two(stepturf, direction)
	else if(space_mutation && isspaceturf(stepturf) && stepturf.Enter(src))
		var/turf/closed/wall/find_wall = locate() in range(2, src)
		var/turf/open/floor/find_floor = locate() in range(2, src)
		if(find_floor || find_wall)
			spread_two(stepturf, direction)

/obj/structure/spacevine/proc/spread_two(turf/target_turf, target_dir)
	// Locates any vine on target turf. Calls that vine "spot_taken".
	var/obj/structure/spacevine/spot_taken = locate() in target_turf

	// Locates the vine eating trait in our own seed and calls it eating_mutation.
	var/datum/spacevine_mutation/vine_eating/eating_mutation = locate() in mutations

	// Proceed if there isn't a vine on the target turf, OR we have vine eater AND target vine is from our seed and doesn't. Vines from other seeds are eaten regardless.
	if(!spot_taken || (eating_mutation && (spot_taken && !spot_taken.mutations.Find(eating_mutation))))
		if(!master)
			return
		for(var/datum/spacevine_mutation/vine_mutation in mutations)
			vine_mutation.on_spread(src, target_turf) // Only do the on_spread proc if it actually spreads.
			target_turf = get_step(src, target_dir) // in case turf changes, to make sure no runtimes happen
		var/obj/structure/spacevine/spawning_vine = master.spawn_spacevine_piece(target_turf, src) // Let's do a cool little animate
		if(NSCOMPONENT(target_dir))
			spawning_vine.pixel_y = target_dir == NORTH ? -32 : 32
			animate(spawning_vine, pixel_y = 0, time = 1 SECONDS)
		else
			spawning_vine.pixel_x = target_dir == EAST ? -32 : 32
			animate(spawning_vine, pixel_x = 0, time = 1 SECONDS)

/obj/structure/spacevine/ex_act(severity, target)
	var/i
	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		i += vine_mutation.on_explosion(severity, target, src)
	if(!i && prob(34 * severity))
		qdel(src)

/obj/structure/spacevine/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return exposed_temperature > FIRE_MINIMUM_TEMPERATURE_TO_SPREAD // if you're cold you're safe

/obj/structure/spacevine/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	var/volume = air.return_volume()
	for(var/datum/spacevine_mutation/vine_mutation in mutations)
		if(vine_mutation.process_temperature(src, exposed_temperature, volume)) // If it's ever true we're safe
			return
	qdel(src)

/obj/structure/spacevine/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	if(isvineimmune(mover))
		return TRUE

/proc/isvineimmune(atom/checked_atom)
	if(isliving(checked_atom))
		var/mob/living/checked_living = checked_atom
		if(("vines" in checked_living.faction) || ("plants" in checked_living.faction))
			return TRUE
	return FALSE

#undef LIGHT_MUTATION_BRIGHTNESS
#undef TOXICITY_MUTATION_PROB
#undef EXPLOSION_MUTATION_IMPACT_RADIUS
#undef GAS_MUTATION_REMOVAL_MULTIPLIER
#undef THORN_MUTATION_CUT_PROB
#undef FLOWERING_MUTATION_SPAWN_PROB
#undef VINE_FREEZING_POINT
#undef SEVERITY_TRIVIAL
#undef SEVERITY_MINOR
#undef SEVERITY_AVERAGE
#undef SEVERITY_ABOVE_AVERAGE
#undef SEVERITY_MAJOR
