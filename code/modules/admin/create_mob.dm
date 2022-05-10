
/datum/admins/proc/create_mob(mob/user)
	var/static/create_mob_html
	if (!create_mob_html)
		var/mobjs = null
		mobjs = jointext(typesof(/mob), ";")
		create_mob_html = file2text('html/create_object.html')
		create_mob_html = replacetext(create_mob_html, "Create Object", "Create Mob")
		create_mob_html = replacetext(create_mob_html, "null /* object types */", "\"[mobjs]\"")

	user << browse(create_panel_helper(create_mob_html), "window=create_mob;size=425x475")

/proc/randomize_human(mob/living/carbon/human/human)
	human.gender = pick(MALE, FEMALE)
	human.physique = human.gender
	human.real_name = random_unique_name(human.gender)
	human.name = human.real_name
	human.underwear = random_underwear(human.gender)
	human.underwear_color = "#[random_color()]"
	human.skin_tone = random_skin_tone()
	human.hairstyle = random_hairstyle(human.gender)
	human.facial_hairstyle = random_facial_hairstyle(human.gender)
	human.hair_color = "#[random_color()]"
	human.facial_hair_color = human.hair_color
	var/random_eye_color = random_eye_color()
	human.eye_color_left = random_eye_color
	human.eye_color_right = random_eye_color
	human.dna.blood_type = random_blood_type()

	// Mutant randomizing, doesn't affect the mob appearance unless it's the specific mutant.
<<<<<<< HEAD
	//SKYRAT EDIT REMOVAL BEGIN - CUSTOMIZATION
	/*
	H.dna.features["mcolor"] = "#[random_color()]"
	H.dna.features["ethcolor"] = GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)]
	H.dna.features["tail_lizard"] = pick(GLOB.tails_list_lizard)
	H.dna.features["snout"] = pick(GLOB.snouts_list)
	H.dna.features["horns"] = pick(GLOB.horns_list)
	H.dna.features["frills"] = pick(GLOB.frills_list)
	H.dna.features["spines"] = pick(GLOB.spines_list)
	H.dna.features["body_markings"] = pick(GLOB.body_markings_list)
	H.dna.features["moth_wings"] = pick(GLOB.moth_wings_list)
	H.dna.features["moth_antennae"] = pick(GLOB.moth_antennae_list)
	*/
	//SKYRAT EDIT REMOVAL END
	//SKYRAT EDIT ADDITION BEGIN - CUSTOMIZATION
	H.dna.features = H.dna.species.get_random_features()
	H.dna.mutant_bodyparts = H.dna.species.get_random_mutant_bodyparts(H.dna.features)
	H.dna.body_markings = H.dna.species.get_random_body_markings(H.dna.features)
	H.dna.species.mutant_bodyparts = H.dna.mutant_bodyparts.Copy()
	H.dna.species.body_markings = H.dna.body_markings.Copy()
	//SKYRAT EDIT ADDITION END
	H.dna.features["pod_hair"] = pick(GLOB.pod_hair_list)
=======
	human.dna.features["mcolor"] = "#[random_color()]"
	human.dna.features["ethcolor"] = GLOB.color_list_ethereal[pick(GLOB.color_list_ethereal)]
	human.dna.features["tail_lizard"] = pick(GLOB.tails_list_lizard)
	human.dna.features["snout"] = pick(GLOB.snouts_list)
	human.dna.features["horns"] = pick(GLOB.horns_list)
	human.dna.features["frills"] = pick(GLOB.frills_list)
	human.dna.features["spines"] = pick(GLOB.spines_list)
	human.dna.features["body_markings"] = pick(GLOB.body_markings_list)
	human.dna.features["moth_wings"] = pick(GLOB.moth_wings_list)
	human.dna.features["moth_antennae"] = pick(GLOB.moth_antennae_list)
	human.dna.features["pod_hair"] = pick(GLOB.pod_hair_list)
>>>>>>> 6f58040394f (Fixes mulligan not randomizing ethereal color, removes default_color for every race except ethereals (#66229))

	human.update_body(is_creating = TRUE)
	human.update_hair(is_creating = TRUE)
	human.dna.species.spec_updatehealth(human)
