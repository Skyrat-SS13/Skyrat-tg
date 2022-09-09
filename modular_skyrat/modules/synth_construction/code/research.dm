/datum/experiment/scanning/points/sapient_machine_intelligence
	name = "Sapient Machine Intelligence"
	description = "Our sapient machines request for research towards their reproduction."
	required_points = 10
	required_atoms = list(
		/mob/living/carbon/human = 5,
		/mob/living/silicon/robot = 2,
		/mob/living/silicon/ai = 8,
		/mob/living/simple_animal/bot/cleanbot = 1,
		/mob/living/simple_animal/bot/firebot = 1,
		/mob/living/simple_animal/bot/floorbot = 1,
		/mob/living/simple_animal/bot/hygienebot = 1,
		/mob/living/simple_animal/bot/medbot = 1,
		/mob/living/simple_animal/bot/mulebot = 1,
		/mob/living/simple_animal/bot/secbot/beepsky = 1,
		/mob/living/simple_animal/bot/vibebot = 1,
	)

// Filters the human mob in the scan to be just robotic.
/datum/experiment/scanning/points/sapient_machine_intelligence/final_contributing_index_checks(atom/target, typepath)
	if(istype(target, /mob/living/carbon/human))
		var/mob/living/carbon/human/human = target
		if(!istype(human.dna.species, /datum/species/robotic))
			return FALSE
	return TRUE

/datum/techweb_node/ipc_construction
	id = "ipc_construction"
	display_name = "Sapient Synthetic Fabrication"
	description = "With enhanced artificial intelligence and mechatronic technology, we are able to build sapient synthetics from scratch."
	prereq_ids = list("ai_basic", "adv_robotics", "mmi", "cyborg")
	design_ids = list("ipc_chassis", "synthliz_chassis", "synth_chassis", "synthmammal_chassis", "ipc_heart", "ipc_lungs", "ipc_tongue", "ipc_stomach", "ipc_liver", "ipc_eyes", "ipc_ears")
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 8000)
	discount_experiments = list(/datum/experiment/scanning/points/sapient_machine_intelligence = 4500)
