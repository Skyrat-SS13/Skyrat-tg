#define MAX_MOLD_FOAM_RANGE 7

/datum/mold
	name = "generic mold"
	/// The color of the mold structures
	var/color
	/// The examine text for structures
	var/examine_text
	/// The type of mobs the mold spawns
	var/mob_types = list()
	/// The cooldown between mob spawns
	var/spawn_cooldown = 12 SECONDS
	/// The maximum number of spawns
	var/max_spawns = 1
	/// The resistance flags for the mold type
	var/resistance_flags
	/// The mold type's preferred atmospheric conditions
	var/preferred_atmos_conditions

/datum/mold/proc/core_defense(obj/structure/mold/structure/core/core)
	return

/datum/mold/proc/bulb_discharge(obj/structure/mold/structure/bulb/bulb)
	bulb.visible_message(span_warning("[bulb] ruptures!"))
	return

/datum/mold/proc/spew_foam(source, range, reagent_capacity, reagent_to_add)
	source.visible_message(span_warning("[source] spews out foam!"))
	var/datum/reagents/spewed_reagents = new /datum/reagents(reagent_capacity)
	spewed_reagents.my_atom = source
	spewed_reagents.add_reagent(/datum/reagent/toxin, 30)
	var/datum/effect_system/fluid_spread/foam/foam = new
	var/source_turf = get_turf(source)
	foam.set_up(range, location = source_turf, carry = spewed_reagents)
	foam.start()


/**
 * Fire mold
 */
/datum/mold/fire
	name = "fire mold"
	color = "#e04000"
	examine_text = "It feels hot to the touch."
	mob_types = list(/mob/living/simple_animal/hostile/biohazard_blob/oil_shambler)
	preferred_atmos_conditions = "co2=30;TEMP=1000"
	resistance_flags = FIRE_PROOF

/datum/mold/fire/core_defense(obj/structure/mold/structure/core/core)
	core.visible_message(span_warning("The [core] puffs out a cloud of flames!"))
	spawn_atmos(core)

/datum/mold/fire/bulb_discharge(obj/structure/mold/structure/bulb/bulb)
	. = ..()
	spawn_atmos(bulb)

/datum/mold/fire/proc/spawn_atmos(source)
	var/source_turf = get_turf(source)
	source_turf.atmos_spawn_air("o2=20;plasma=20;TEMP=600")


/**
 * Fungal mold
 */
/datum/mold/fungal
	name = "fungal mold"
	color = "#6e5100"
	examine_text = "It looks like it's rotting."
	mob_types = list(/mob/living/simple_animal/hostile/biohazard_blob/diseased_rat)
	spawn_cooldown = 5 SECONDS
	preferred_atmos_conditions = "TEMP=312"

/datum/mold/fungal/core_defense(obj/structure/mold/structure/core/core)
	core.visible_message(span_warning("[core] emits a cloud!"))
	fungal_puff(core, 5)

/datum/mold/fungal/bulb_discharge(obj/sructure/mold/strucure/bulb/bulb)
	fungal_puff(bulb, 4)

/datum/mold/fungal/proc/fungal_puff(source, range)
	var/datum/reagents/reagents = new/datum/reagents(300)
	reagents.my_atom = source
	reagents.add_reagent(/datum/reagent/cryptococcus_spores, 50)
	var/datum/effect_system/fluid_spread/smoke/chem/smoke_machine/puff = new
	var/source_turf = get_turf(source)
	puff.set_up(range, location = source_turf, carry = reagents, efficiency = 24)
	puff.attach(source)
	puff.start()


/**
 * EMP mol
 */
/datum/mold/emp
	name = "emp mold"
	color = "#00caa5"
	examine_text = "You can notice small sparks travelling in the vines."
	mob_type = list(/mob/living/simple_animal/hostile/biohazard_blob/electric_mosquito)
	spawn_cooldown = 5 SECONDS
	preferred_atmos_conditions = "n2=30;TEMP=100"

/datum/mold/emp/core_defense(obj/structure/mold/structure/core/core)
	core.visible_message(span_warning("[core] sends out electrical discharges!"))
	electrical_discharge(
		source = bulb,
		heavy_emp_range = 5,
		light_emp_range = 7,
		guarantee_emp = TRUE,
		)

/datum/mold/emp/bulb_discharge(obj/sructure/mold/strucure/bulb/bulb)
	electrical_discharge(
		source = bulb,
		heavy_emp_range = 5,
		light_emp_range = 7,
		)

/datum/mold/emp/proc/electrical_discharge(source, heavy_emp_range, light_emp_range, guarantee_emp = FALSE)
	var/severe_effects = prob(50)
	if(guarantee_emp || severe_effects)
		source.empulse(source, heavy_emp_range, light_emp_range)
	if(severe_effects)
		for(var/mob/living/nearby_hearer in get_hearers_in_view(3, my_turf))
			if(nearby_hearer.flash_act(affect_silicon = TRUE))
				nearby_hearer.Paralyze(20)
				nearby_hearer.Knockdown(20)
			nearby_hearer.soundbang_act(1, 20, 10, 5)
		do_sparks(number = 3, cardinal_only = TRUE, source = source)
		return
	tesla_zap(source, zap_range = 4, power = 10000, zap_flags = ZAP_MOB_DAMAGE | ZAP_OBJ_DAMAGE)


/**
 * Toxic mold
 */
/datum/mold/toxic
	name = "toxic mold"
	color = "#5300a1"
	examine_text = "It feels damp and smells of rat poison."
	mob_type = list(/mob/living/simple_animal/hostile/biohazard_blob/giant_spider)
	preferred_atmos_conditions = "miasma=50;TEMP=296"
	resistance_flags = UNACIDABLE | ACID_PROOF

/datum/mold/toxic/core_defense(obj/structure/mold/structure/core/core)
	spew_foam(
		core,
		range = 4,
		reagent_capacity = 210,
		reagent_to_add = /datum/reagent/toxin,
		)

/datum/mold/toxic/bulb_discharge(obj/sructure/mold/strucure/bulb/bulb)
	spew_foam(
		bulb,
		range = MAX_MOLD_FOAM_RANGE,
		reagent_capacity = 300,
		reagent_to_add = /datum/reagent/toxin,
		)


/**
 * Radioactive mold
 */
/datum/mold/radioactive
	name = "radioactive mold"
	color = "#80ff00"
	examine_text = "It's glowing a soft green."
	mob_type = list(/mob/living/simple_animal/hostile/biohazard_blob/centaur)
	preferred_atmos_conditions = "tritium=5;TEMP=296"
	resistance_flags = ACID_PROOF | FIRE_PROOF

/datum/mold/radioactive/core_defense(obj/structure/mold/structure/core/core)
	core.visible_message(span_warning("[core] emits a strong radiation pulse!"))
	irradiate(core, threshold = 10)
	spew_foam(
		core,
		range = 4,
		reagent_capacity = 210,
		reagent_to_add = /datum/reagent/toxin/mutagen,
		)

/datum/mold/radioactive/bulb_discharge(obj/sructure/mold/strucure/bulb/bulb)
	irradiate(bulb, threshold = 15, fire_nuclear_particle = TRUE)
	spew_foam(
		bulb,
		range = MAX_MOLD_FOAM_RANGE,
		reagent_capacity = 300,
		reagent_to_add = /datum/reagent/toxin/mutagen,
		)

/datum/mold/radioactive/proc/irradiate(source, threshold, fire_nuclear_particle = FALSE)
	radiation_pulse(source, max_range = 1500, threshold = threshold, chance = FALSE, minimum_exposure_time = TRUE)
	if(fire_nuclear_particle)
		source.fire_nuclear_particle()

#undef MAX_MOLD_FOAM_RANGE
