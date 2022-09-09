/mob/living/carbon/human/species/proc/create_bodyparts_body_only()
	for(var/bodypart_path in bodyparts)
		bodyparts.Remove(bodypart_path)
		if(ispath(bodypart_path, /obj/item/bodypart/chest))
			var/obj/item/bodypart/bodypart_instance = new bodypart_path()
			bodypart_instance.set_owner(src)
			add_bodypart(bodypart_instance)

/mob/living/carbon/human/species/synthliz/nugget/Initialize(mapload)
	. = ..()
	death()

/mob/living/carbon/human/species/synthliz/nugget/create_bodyparts()
	create_bodyparts_body_only()

/mob/living/carbon/human/species/synthliz/nugget/create_internal_organs()
	qdel(internal_organs)
	internal_organs = list()

/mob/living/carbon/human/species/synthliz/nugget/setup_human_dna()
	create_dna(src)
	dna.initialize_dna()

/mob/living/carbon/human/species/ipc/nugget/Initialize(mapload)
	. = ..()
	death()

/mob/living/carbon/human/species/ipc/nugget/create_bodyparts()
	create_bodyparts_body_only()

/mob/living/carbon/human/species/ipc/nugget/create_internal_organs()
	qdel(internal_organs)
	internal_organs = list()

/mob/living/carbon/human/species/ipc/nugget/setup_human_dna()
	create_dna(src)
	dna.initialize_dna()

/mob/living/carbon/human/species/synthetic_human
	race = /datum/species/robotic/synthetic_human

/mob/living/carbon/human/species/synthetic_human/nugget/Initialize(mapload)
	. = ..()
	death()

/mob/living/carbon/human/species/synthetic_human/nugget/create_bodyparts()
	create_bodyparts_body_only()

/mob/living/carbon/human/species/synthetic_human/nugget/create_internal_organs()
	qdel(internal_organs)
	internal_organs = list()

/mob/living/carbon/human/species/synthetic_human/nugget/setup_human_dna()
	create_dna(src)
	dna.initialize_dna()

/mob/living/carbon/human/species/synthetic_mammal
	race = /datum/species/robotic/synthetic_mammal

/mob/living/carbon/human/species/synthetic_mammal/nugget/Initialize(mapload)
	. = ..()
	death()

/mob/living/carbon/human/species/synthetic_mammal/nugget/create_bodyparts()
	create_bodyparts_body_only()

/mob/living/carbon/human/species/synthetic_mammal/nugget/create_internal_organs()
	qdel(internal_organs)
	internal_organs = list()

/mob/living/carbon/human/species/synthetic_mammal/nugget/setup_human_dna()
	create_dna(src)
	dna.initialize_dna()
