/datum/dna
	var/list/mutant_bodyparts = list()
	features = list("#FFF", "#FFF", "#FFF")

/datum/dna/proc/initialize_dna(newblood_type, skip_index = FALSE)
	if(newblood_type)
		blood_type = newblood_type
	unique_enzymes = generate_unique_enzymes()
	uni_identity = generate_uni_identity()
	if(!skip_index) //I hate this
		generate_dna_blocks()
	//features = random_features()
