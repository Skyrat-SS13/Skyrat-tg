/mob/living/carbon/human/species/proc/create_bodyparts_body_only()
	for(var/bodypart_path in bodyparts)
		bodyparts.Remove(bodypart_path)
		if(ispath(bodypart_path, /obj/item/bodypart/chest))
			var/obj/item/bodypart/bodypart_instance = new bodypart_path()
			bodypart_instance.set_owner(src)
			add_bodypart(bodypart_instance)
	hand_bodyparts = list(null, null) // Arm implant runtime prevention

/mob/living/carbon/human/species/proc/remove_all_organs()
	for(var/obj/item/organ/internal/organ in internal_organs)
		organ.Remove(src, TRUE)
		qdel(organ)

/mob/living/carbon/human/species/synthliz/chassis/Initialize(mapload)
	. = ..()
	remove_all_organs()
	death()

/mob/living/carbon/human/species/synthliz/chassis/create_bodyparts()
	create_bodyparts_body_only()

/mob/living/carbon/human/species/synthliz/chassis/setup_human_dna()
	create_dna(src)
	dna.initialize_dna()

/mob/living/carbon/human/species/ipc/chassis/Initialize(mapload)
	. = ..()
	remove_all_organs()
	death()

/mob/living/carbon/human/species/ipc/chassis/create_bodyparts()
	create_bodyparts_body_only()

/mob/living/carbon/human/species/ipc/chassis/setup_human_dna()
	create_dna(src)
	dna.initialize_dna()

/mob/living/carbon/human/species/synthetic_human
	race = /datum/species/robotic/synthetic_human

/mob/living/carbon/human/species/synthetic_human/chassis/Initialize(mapload)
	. = ..()
	remove_all_organs()
	death()

/mob/living/carbon/human/species/synthetic_human/chassis/create_bodyparts()
	create_bodyparts_body_only()

/mob/living/carbon/human/species/synthetic_human/chassis/setup_human_dna()
	create_dna(src)
	dna.initialize_dna()

/mob/living/carbon/human/species/synthetic_mammal
	race = /datum/species/robotic/synthetic_mammal

/mob/living/carbon/human/species/synthetic_mammal/chassis/Initialize(mapload)
	. = ..()
	remove_all_organs()
	death()

/mob/living/carbon/human/species/synthetic_mammal/chassis/create_bodyparts()
	create_bodyparts_body_only()

/mob/living/carbon/human/species/synthetic_mammal/chassis/setup_human_dna()
	create_dna(src)
	dna.initialize_dna()
