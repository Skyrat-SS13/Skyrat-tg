/datum/reagent/medicine/syndicate_nanites //Used exclusively by Syndicate medical cyborgs
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Let's not cripple synth ops

/datum/reagent/medicine/lesser_syndicate_nanites
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/medicine/stimulants
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Syndicate developed 'accelerants' for synths?

/datum/reagent/medicine/neo_jelly
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC //Should synthetic miners not be able to use pens? Up for a debate probably but for now lets leave their contents in

/datum/reagent/medicine/lavaland_extract
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

/datum/reagent/medicine/leporazine
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC

//REAGENTS FOR SYNTHS
/datum/reagent/medicine/system_cleaner
	name = "System Cleaner"
	description = "Neutralizes harmful chemical compounds inside synthetic systems."
	reagent_state = LIQUID
	color = "#F1C40F"
	taste_description = "ethanol"
	metabolization_rate = 2 * REAGENTS_METABOLISM
	process_flags = REAGENT_SYNTHETIC

/datum/reagent/medicine/system_cleaner/on_mob_life(mob/living/carbon/M, delta_time, times_fired)
	M.adjustToxLoss(-2*REM, 0)
	. = 1
	for(var/A in M.reagents.reagent_list)
		var/datum/reagent/R = A
		if(R != src)
			M.reagents.remove_reagent(R.type, 1 * REM * delta_time)
	..()

/datum/reagent/medicine/liquid_solder
	name = "Liquid Solder"
	description = "Repairs brain damage in synthetics."
	color = "#727272"
	taste_description = "metal"
	process_flags = REAGENT_SYNTHETIC

/datum/reagent/medicine/liquid_solder/on_mob_life(mob/living/carbon/C)
	C.adjustOrganLoss(ORGAN_SLOT_BRAIN, -3*REM)
	if(prob(10))
		C.cure_trauma_type(resilience = TRAUMA_RESILIENCE_BASIC)
	..()

/datum/reagent/medicine/nanite_slurry
	name = "Nanite Slurry"
	description = "A localized swarm of nanomachines specialized in repairing mechanical parts. Due to the nanites needing to interface with the host's systems to repair them, a surplus of them will cause them to overheat, or for the swarm to eject out of the mouth for safety."
	reagent_state = LIQUID
	color = "#cccccc"
	overdose_threshold = 20
	metabolization_rate = 1.25 * REAGENTS_METABOLISM
	process_flags = REAGENT_SYNTHETIC | REAGENT_ORGANIC
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	/// How much brute and burn individually is healed per tick
	var/healing = 1
	/// How much body temperature is adjusted by per tick
	var/temperature_change = 50


/datum/reagent/medicine/nanite_slurry/on_mob_life(mob/living/carbon/affected_mob)
	M.heal_bodypart_damage(healing*REM, healing*REM, required_status = BODYPART_ROBOTIC)
	..()
	. = 1

/datum/reagent/medicine/nanite_slurry/overdose_process(mob/living/carbon/affected_mob, delta_time, times_fired)
	if(!(M.mob_biotypes & MOB_ROBOTIC))
		M.reagents.remove_reagent(type, 3.6) //gets removed from organics very fast
		if(prob(25))
			M.vomit(vomit_type = VOMIT_NANITE)
		return ..()
	else if(M.mob_biotypes & MOB_ROBOTIC)
		M.adjust_bodytemperature(burning * REM * delta_time)
		return ..()
	..()
	. = 1
