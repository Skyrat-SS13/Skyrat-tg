
/datum/admins/proc/create_mob(mob/user)
	var/static/create_mob_html
	if (!create_mob_html)
		var/mobjs = null
		mobjs = jointext(typesof(/mob), ";")
		create_mob_html = file2text('html/create_object.html')
		create_mob_html = replacetext(create_mob_html, "Create Object", "Create Mob")
		create_mob_html = replacetext(create_mob_html, "null /* object types */", "\"[mobjs]\"")

	user << browse(create_panel_helper(create_mob_html), "window=create_mob;size=425x475")

/**
 * Randomizes everything about a human, including DNA and name
 */
/proc/randomize_human(mob/living/carbon/human/human, randomize_mutations = FALSE)
	human.gender = human.dna.species.sexes ? pick(MALE, FEMALE, PLURAL, NEUTER) : PLURAL
	human.physique = human.gender
	human.real_name = human.dna?.species.random_name(human.gender) || random_unique_name(human.gender)
<<<<<<< HEAD
	human.name = human.real_name
	human.hairstyle = random_hairstyle(human.gender)
	human.facial_hairstyle = random_facial_hairstyle(human.gender)
	human.hair_color = "#[random_color()]"
	human.facial_hair_color = human.hair_color
	var/random_eye_color = random_eye_color()
	human.eye_color_left = random_eye_color
	human.eye_color_right = random_eye_color
	human.dna.blood_type = random_blood_type()
	human.dna.features["mcolor"] = "#[random_color()]"
	human.dna.species.randomize_active_underwear_only(human)
	/*SKYRAT EDIT OLD
	for(var/datum/species/species_path as anything in subtypesof(/datum/species))
		var/datum/species/new_species = new species_path
		new_species.randomize_features(human)
	SKYRAT EDIT ADDITION BEGIN - CUSTOMIZATION*/
	human.dna.species.randomize_features(human)
	human.dna.mutant_bodyparts = human.dna.species.get_random_mutant_bodyparts(human.dna.features)
	human.dna.body_markings = human.dna.species.get_random_body_markings(human.dna.features)
	human.dna.species.mutant_bodyparts = human.dna.mutant_bodyparts.Copy()
	human.dna.species.body_markings = human.dna.body_markings.Copy()
	//SKYRAT EDIT ADDITION END
=======
	human.name = human.get_visible_name()
	human.set_hairstyle(random_hairstyle(human.gender), update = FALSE)
	human.set_facial_hairstyle(random_facial_hairstyle(human.gender), update = FALSE)
	human.set_haircolor("#[random_color()]", update = FALSE)
	human.set_facial_haircolor(human.hair_color, update = FALSE)
	human.eye_color_left = random_eye_color()
	human.eye_color_right = human.eye_color_left
	human.skin_tone = random_skin_tone()
	human.dna.species.randomize_active_underwear_only(human)
	// Needs to be called towards the end to update all the UIs just set above
	human.dna.initialize_dna(newblood_type = random_blood_type(), create_mutation_blocks = randomize_mutations, randomize_features = TRUE)
	// Snowflake stuff (ethereals)
>>>>>>> 9e1c71f794a (Reworks transformation sting to be temporarily in living mobs, forever in dead mobs (#78502))
	human.dna.species.spec_updatehealth(human)
	human.updateappearance(mutcolor_update = TRUE)
