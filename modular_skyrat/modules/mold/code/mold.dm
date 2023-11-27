#define MAX_MOLD_FOAM_RANGE_BULB 7
#define MAX_MOLD_FOAM_RANGE_CORE 4

#define TEMP_REAGENT_HOLDER_CAPACITY_LARGE 300
#define TEMP_REAGENT_HOLDER_CAPACITY_SMALL 210

// Disease
#define DISEASE_PUFF_RANGE_BULB 4
#define DISEASE_PUFF_RANGE_CORE 5

#define PUFF_REAGENT_AMOUNT 50
#define PUFF_REAGENT_EFFICIENCY 24

// EMP
#define ELECTRICAL_DISCHARGE_HEAVY_RANGE 5
#define ELECTRICAL_DISCHARGE_LIGHT_RANGE 7
#define ELECTRICAL_DISCHARGE_SPARKS_AMOUNT 3

#define EMP_SEVERE_EFFECT_CHANCE 50
#define EMP_ZAP_RANGE 4
#define EMP_ZAP_POWER 10000

#define EMP_STUN_LENGTH 2 SECONDS
#define EMP_STUN_RANGE 3
#define EMP_SOUNDBANG_INTENSITY 1
#define EMP_SOUNDBANG_STUN_POWER 20
#define EMP_SOUNDBANG_DAMAGE_POWER 10
#define EMP_SOUNDBANG_DEAFEN_POWER 5

// Radiation
#define RAD_PULSE_RANGE 1500
#define RAD_IRRADIATE_THRESHOLD_BULB 15
#define RAD_IRRADIATE_THRESHOLD_CORE 10


/datum/mold_type
	var/name = "debug"
	/// The tier of the mold, used to decide whether it can spawn on lowpop
	var/tier = MOLD_TIER_LOW_THREAT
	/// The color of the mold structures
	var/mold_color = "#ff00ff"
	/// The color of the light emitted by some of the mold structures
	var/structure_light_color = LIGHT_COLOR_DEFAULT
	/// The examine text for structures
	var/examine_text = "Debug mold. You should report seeing this."
	/// The type of mobs the mold spawns
	var/list/mob_types = list()
	/// The cooldown between mob spawns
	var/spawn_cooldown = 12 SECONDS
	/// The maximum number of mobs we can have at once, per spawner
	var/max_spawns = 1
	/// The resistance flags for the mold type
	var/resistance_flags
	/// The mold type's preferred atmospheric conditions
	var/preferred_atmos_conditions


/**
 * What happens when the core is attacked.
 *
 * When the core is hit, each type of mold has a defense mechanism, ranging from creating hot
 * gas, to toxic foam spills, and anything else. This is called in run_atom_armor, a proc on
 * the mold core the datum refers to.
 *
 * * core - the core that is being triggered.
 */
/datum/mold_type/proc/core_defense(obj/structure/mold/structure/core/core)
	return


/**
 * What happens when a bulb discharges.
 *
 * The defense mechanism of the bulbs, this can be run either when the bulb is attacked, be it
 * directly, when it's shot, or when a mob comes into proximity of the bulb. It'll then be on
 * cooldown for a while until it recharges. This is usually a pretty similar effect to the
 * core defense, though it doesn't have to be.
 *
 * * bulb - the bulb that is being triggered.
 */
/datum/mold_type/proc/bulb_discharge(obj/structure/mold/structure/bulb/bulb)
	SHOULD_CALL_PARENT(TRUE) //  don't skip the message brah...
	bulb.visible_message(span_warning("[bulb] ruptures!"))
	return


/**
 * The optional bonus effect alongside conditioner's puff of atmos.
 *
 * Mold conditioners have a possibility to have a bonus effect on process. This will trigger
 * whenever the conditioner's regular puff of atmos is released, aka when its cooldown is up.
 *
 * * conditioner - the conditioner that is being triggered.
 */
/datum/mold_type/proc/bonus_conditioner_effects(obj/structure/mold/structure/conditioner/conditioner)
	return


/**
 * A release of foam from a mold structure.
 *
 * Some mold defenses include spilling foam. This is handled here, where on trigger some foam
 * will spread from the structure that is designated as its source. Different mold structures
 * and mold types have different reagent amounts and reagent types, respectively.
 *
 * * source - the structure the foam spawns from.
 * * range - the number of tiles the foam will spread.
 * * reagent_capacity - the capacity of the reagents datum, NOT the amount of the chemical being added.
 * * reagent_to_add - the reagent the foam contains
 * * amount_of_reagent - how much of the reagent to add to the reagents datum. Defaults to 30.
 */
/datum/mold_type/proc/spew_foam(obj/structure/mold/structure/source, range, reagent_capacity, reagent_to_add, amount_of_reagent = 30)
	source.visible_message(span_warning("[source] spews out foam!"))
	var/datum/reagents/spewed_reagents = new /datum/reagents(reagent_capacity)
	spewed_reagents.my_atom = source
	spewed_reagents.add_reagent(reagent_to_add, amount_of_reagent)
	var/datum/effect_system/fluid_spread/foam/foam = new
	var/turf/source_turf = get_turf(source)
	foam.set_up(range, location = source_turf, carry = spewed_reagents)
	foam.start()


/**
 * Fire mold
 *
 * A mold type that is based around a fire theme. It's the colour of fire, prefers hotter
 * temperatures, spawns a burn mix from its conditioners. The whole shebang. The mobs it
 * spawns are oil shamblers, a humanoid figure that can set fire to people on hit.
 * Probably the most simple mold type.
 */
/datum/mold_type/fire
	name = "fire"
	mold_color = "#e04000"
	structure_light_color = LIGHT_COLOR_FIRE
	examine_text = "It feels hot to the touch."
	mob_types = list(/mob/living/basic/mold/oil_shambler)
	preferred_atmos_conditions = "co2=30;TEMP=1000"
	resistance_flags = FIRE_PROOF

/datum/mold_type/fire/core_defense(obj/structure/mold/structure/core/core)
	core.visible_message(span_warning("[core] puffs out a cloud of flames!"))
	spawn_atmos(core)

/datum/mold_type/fire/bulb_discharge(obj/structure/mold/structure/bulb/bulb)
	. = ..()
	spawn_atmos(bulb)

/datum/mold_type/fire/proc/spawn_atmos(obj/structure/mold/structure/source)
	var/turf/source_turf = get_turf(source)
	source_turf.atmos_spawn_air("o2=20;plasma=20;TEMP=600")


/**
 * Disease mold
 *
 * A mold type that centers around disease. It spawns rats that inject with disease, lets
 * out puffs of fungal smoke that spread disease.
 * It has its own custom disease, too. Fancy.
 */
/datum/mold_type/disease
	name = "fungal"
	tier = MOLD_TIER_HIGH_THREAT
	mold_color = "#6e5100"
	structure_light_color = LIGHT_COLOR_BROWN
	examine_text = "It looks like it's rotting."
	mob_types = list(/mob/living/basic/mold/diseased_rat)
	spawn_cooldown = 5 SECONDS
	preferred_atmos_conditions = "TEMP=312"

/datum/mold_type/disease/core_defense(obj/structure/mold/structure/core/core)
	core.visible_message(span_warning("[core] emits a cloud!"))
	fungal_puff(core, DISEASE_PUFF_RANGE_CORE)

/datum/mold_type/disease/bulb_discharge(obj/structure/mold/structure/bulb/bulb)
	. = ..()
	fungal_puff(bulb, DISEASE_PUFF_RANGE_BULB)

/datum/mold_type/disease/proc/fungal_puff(source, range)
	var/datum/reagents/reagents = new/datum/reagents(TEMP_REAGENT_HOLDER_CAPACITY_LARGE)
	reagents.my_atom = source
	reagents.add_reagent(/datum/reagent/cryptococcus_spores, PUFF_REAGENT_AMOUNT)
	var/datum/effect_system/fluid_spread/smoke/chem/smoke_machine/puff = new
	var/turf/source_turf = get_turf(source)
	puff.set_up(
		range,
		location = source_turf,
		carry = reagents,
		efficiency = PUFF_REAGENT_EFFICIENCY,
	)
	puff.attach(source)
	puff.start()


/**
 * EMP mold
 *
 * A mold type centered around electricity and EMPs. Its mobs, mosquitos, inject teslium on hit,
 * it lets out EMPs as a defense mechanism, and can tesla-zap people too. Spicy.
 */
/datum/mold_type/emp
	name = "EMP"
	mold_color = "#00caa5"
	structure_light_color = LIGHT_COLOR_ELECTRIC_CYAN
	examine_text = "You can notice small sparks travelling in the vines."
	mob_types = list(/mob/living/basic/mold/electric_mosquito)
	spawn_cooldown = 5 SECONDS
	preferred_atmos_conditions = "n2=30;TEMP=100"

/datum/mold_type/emp/core_defense(obj/structure/mold/structure/core/core)
	core.visible_message(span_warning("[core] sends out electrical discharges!"))
	electrical_discharge(
		source = core,
		heavy_emp_range = ELECTRICAL_DISCHARGE_HEAVY_RANGE,
		light_emp_range = ELECTRICAL_DISCHARGE_LIGHT_RANGE,
		guarantee_emp = TRUE,
		)


/datum/mold_type/emp/bulb_discharge(obj/structure/mold/structure/bulb/bulb)
	. = ..()
	electrical_discharge(
		source = bulb,
		heavy_emp_range = ELECTRICAL_DISCHARGE_HEAVY_RANGE,
		light_emp_range = ELECTRICAL_DISCHARGE_LIGHT_RANGE,
		)

/datum/mold_type/emp/proc/electrical_discharge(obj/structure/mold/structure/source, heavy_emp_range, light_emp_range, guarantee_emp = FALSE)
	var/severe_effects = prob(EMP_SEVERE_EFFECT_CHANCE)
	var/turf/source_turf = get_turf(source)

	if(guarantee_emp || severe_effects)
		empulse(source_turf, heavy_emp_range, light_emp_range)

	if(!severe_effects)
		tesla_zap(
			source,
			zap_range = EMP_ZAP_RANGE,
			power = EMP_ZAP_POWER,
			zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE,
		)
		return

	for(var/mob/living/nearby_hearer in get_hearers_in_view(3, source_turf))
		if(nearby_hearer.flash_act(affect_silicon = TRUE))
			nearby_hearer.Paralyze(EMP_STUN_LENGTH)
			nearby_hearer.Knockdown(EMP_STUN_LENGTH)

		nearby_hearer.soundbang_act(
			EMP_SOUNDBANG_INTENSITY,
			EMP_SOUNDBANG_STUN_POWER,
			EMP_SOUNDBANG_DAMAGE_POWER,
			EMP_SOUNDBANG_DEAFEN_POWER,
		)
	do_sparks(
		number = ELECTRICAL_DISCHARGE_SPARKS_AMOUNT,
		cardinal_only = TRUE,
		source = source,
	)


/**
 * Toxic mold
 *
 * A mold type based around toxins. It spawns spiders that inject toxins on hit, spews
 * toxin-filled foam, and is purple - which, as we all know, is the colour of the poison
 * in the poison flask Hearthstone card.
 */
/datum/mold_type/toxic
	name = "toxic"
	mold_color = "#cb37f5"
	structure_light_color = LIGHT_COLOR_LAVENDER
	examine_text = "It feels damp and smells of rat poison."
	mob_types = list(/mob/living/basic/spider/giant/hunter)
	preferred_atmos_conditions = "miasma=50;TEMP=296"
	resistance_flags = UNACIDABLE | ACID_PROOF

/datum/mold_type/toxic/core_defense(obj/structure/mold/structure/core/core)
	spew_foam(
		core,
		range = MAX_MOLD_FOAM_RANGE_CORE,
		reagent_capacity = TEMP_REAGENT_HOLDER_CAPACITY_SMALL,
		reagent_to_add = /datum/reagent/toxin,
		)

/datum/mold_type/toxic/bulb_discharge(obj/structure/mold/structure/bulb/bulb)
	. = ..()
	spew_foam(
		bulb,
		range = MAX_MOLD_FOAM_RANGE_BULB,
		reagent_capacity = TEMP_REAGENT_HOLDER_CAPACITY_LARGE,
		reagent_to_add = /datum/reagent/toxin,
		)


/**
 * Radioactive mold
 *
 * A mold type centered around radiation. Its mobs don't irradiate, rather being mutated abominations
 * themselves that have a very high chance to wound on hit. Additionally, the mold will spew
 * unstable mutagen foam as well as occasionally firing nuclear particles.
 */
/datum/mold_type/radioactive
	name = "radioactive"
	mold_color = "#80ff00"
	structure_light_color = LIGHT_COLOR_ELECTRIC_GREEN
	examine_text = "It's glowing a soft green."
	mob_types = list(/mob/living/basic/mold/centaur)
	preferred_atmos_conditions = "tritium=5;TEMP=296"
	resistance_flags = ACID_PROOF | FIRE_PROOF

/datum/mold_type/radioactive/core_defense(obj/structure/mold/structure/core/core)
	core.visible_message(span_warning("[core] emits a strong radiation pulse!"))
	irradiate(core, threshold = RAD_IRRADIATE_THRESHOLD_CORE)
	spew_foam(
		core,
		range = MAX_MOLD_FOAM_RANGE_CORE,
		reagent_capacity = TEMP_REAGENT_HOLDER_CAPACITY_SMALL,
		reagent_to_add = /datum/reagent/toxin/mutagen,
		)

/datum/mold_type/radioactive/bulb_discharge(obj/structure/mold/structure/bulb/bulb)
	. = ..()
	irradiate(bulb, threshold = RAD_IRRADIATE_THRESHOLD_BULB, fire_nuclear_particle = TRUE)
	spew_foam(
		bulb,
		range = MAX_MOLD_FOAM_RANGE_BULB,
		reagent_capacity = TEMP_REAGENT_HOLDER_CAPACITY_LARGE,
		reagent_to_add = /datum/reagent/toxin/mutagen,
		)

/datum/mold_type/radioactive/bonus_conditioner_effects(obj/structure/mold/structure/conditioner/conditioner)
	conditioner.fire_nuclear_particle()

/datum/mold_type/radioactive/proc/irradiate(obj/structure/mold/structure/source, threshold, fire_nuclear_particle = FALSE)
	radiation_pulse(
		source,
		max_range = RAD_PULSE_RANGE,
		threshold = threshold,
		chance = FALSE,
		minimum_exposure_time = TRUE,
	)

	if(fire_nuclear_particle)
		source.fire_nuclear_particle()


#undef MAX_MOLD_FOAM_RANGE_BULB
#undef MAX_MOLD_FOAM_RANGE_CORE
#undef TEMP_REAGENT_HOLDER_CAPACITY_LARGE
#undef TEMP_REAGENT_HOLDER_CAPACITY_SMALL
#undef DISEASE_PUFF_RANGE_BULB
#undef DISEASE_PUFF_RANGE_CORE
#undef PUFF_REAGENT_AMOUNT
#undef PUFF_REAGENT_EFFICIENCY
#undef ELECTRICAL_DISCHARGE_HEAVY_RANGE
#undef ELECTRICAL_DISCHARGE_LIGHT_RANGE
#undef ELECTRICAL_DISCHARGE_SPARKS_AMOUNT
#undef EMP_SEVERE_EFFECT_CHANCE
#undef EMP_ZAP_RANGE
#undef EMP_ZAP_POWER
#undef EMP_STUN_LENGTH
#undef EMP_STUN_RANGE
#undef EMP_SOUNDBANG_INTENSITY
#undef EMP_SOUNDBANG_STUN_POWER
#undef EMP_SOUNDBANG_DAMAGE_POWER
#undef EMP_SOUNDBANG_DEAFEN_POWER
#undef RAD_PULSE_RANGE
#undef RAD_IRRADIATE_THRESHOLD_BULB
#undef RAD_IRRADIATE_THRESHOLD_CORE
