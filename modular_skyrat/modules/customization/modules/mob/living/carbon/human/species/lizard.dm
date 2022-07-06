/datum/species/lizard
	mutant_bodyparts = list()
	external_organs = list()
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR,
		FACEHAIR,
	)
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"spines" = ACC_RANDOM,
		"frills" = ACC_RANDOM,
		"horns" = ACC_RANDOM,
		"body_markings" = ACC_RANDOM,
		"legs" = "Digitigrade Legs",
		"taur" = "None",
		"wings" = "None",
	)
	learnable_languages = list(/datum/language/common, /datum/language/draconic)
	payday_modifier = 0.75

/datum/species/lizard/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color = "#[random_color()]"
	var/second_color
	var/third_color
	var/random = rand(1,3)
	switch(random)
		if(1) //First random case - all is the same
			second_color = main_color
			third_color = main_color
		if(2) //Second case, derrivatory shades, except there's no helpers for that and I dont feel like writing them
			second_color = main_color
			third_color = main_color
		if(3) //Third case, more randomisation
			second_color = "#[random_color()]"
			third_color = "#[random_color()]"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = third_color
	return returned

/datum/species/lizard/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#009999")
	lizard.dna.features["mcolor"] = lizard_color
	lizard.dna.species.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Light Tiger", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.species.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Sharp + Light", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.species.mutant_bodyparts["horns"] = list(MUTANT_INDEX_NAME = "Simple", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.species.mutant_bodyparts["frills"] = list(MUTANT_INDEX_NAME = "Aquatic", MUTANT_INDEX_COLOR_LIST = list(lizard_color, lizard_color, lizard_color))
	lizard.dna.features["legs"] = "Normal Legs"
	lizard.update_mutant_bodyparts(TRUE)
	lizard.update_body(TRUE)

/datum/species/lizard/get_species_description()
	return {"Lizardperson is a catch-all term for any anthropomorphic creature, often reptilian, \
	that is either not registered in any official Sapient Universal Species Database under the Sol Federation, Taj Empire, Agurrkral Kingdom, Novaya Rossiyskaya Imperiya, and other major States \
	- or is simply a result of genetic modification."}


/datum/species/lizard/get_species_lore()
	return list({"Lizardpeople are a template species! You can write any sort of backstory as long as it's compliant with the Character Creation Guidelines document.
	
	If you have no idea what to do, a regular course of action is writing them as a gene-modded Human."})

/datum/species/lizard/ashwalker
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		NO_UNDERWEAR,
		HAIR,
		FACEHAIR
	)
	always_customizable = TRUE
	learnable_languages = list(/datum/language/ashtongue)

/datum/species/lizard/ashwalker/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#990000")
	. = ..(lizard, lizard_color)


/datum/species/lizard/silverscale/prepare_human_for_preview(mob/living/carbon/human/lizard, lizard_color = "#eeeeee")
	lizard.eye_color_left = "#0000a0"
	lizard.eye_color_right = "#0000a0"
	. = ..(lizard, lizard_color)

/datum/species/lizard/ashwalker/get_species_description()
	return {"Ashwalkers are a secluded group of Lizardpeople who have forcibly evolved to act in symbiosis with Lavaland's driving force, The Necropolis. Not much is known about them by the public - they are perceived as violent, isolationist tribal zealots."}


/datum/species/lizard/ashwalker/get_species_lore()
	return list({"An excerpt from the diary of an \"uplifted\" ashwalker details:
	
	  We, Ashwalkers, are a proud people that have long since developed a symbiotic relationship with the great entity known as the Necropolis, developing both a worldly and spiritual basis for living around the all-feeling. Our songs sing of how Tizira, our home, was once a lush planet rich and teeming with life, up until the Necropolis began to change the planet from the inside out. We do not know how the Necropolis was formed, yet many different tales are spun ranging from a sacrifice gone wrong to salvation delivered by Tizira itself. For us, it is known as the Great Salvation, but our ancestors saw it as the Great Cataclysm, one that would bring a lifetime of torment among our people. 
	  
	  One could forgive them for this ignorance, as it brought forth tendrils that would shoot out from the earth, bringing forth a flood of burning blood that flowed viscously like honey from the cracks formed within the land. Those killed by the tendrils soon began to change into what we are now, Ashwalkers, though our ancestors foolishly believed us to have been twisted into demons with grotesque features.
	  
	  Those who failed to understand the Necropolis as a blessing by Tizira itself treated the Necropolis and its many gifts as corruption, filth that brought decay rather than life. For many years, our ancestors succeeded, yet staving off the Necropolis became increasingly more difficult as Tizira demanded they bend to the Necropolis. With each passing year, doom became evident for these non-believers, yet legends speak of large metal birds in the skies that arrived. These strange, squawking birds that rode them had come to take many of its people away to what they saw as safety. We think now they are the Vox, but we do not think of those who left, only those who stayed. Those that remained either succumbed or adapted. Even those that resist shall receive forgiveness and salvation. Everyone and anyone can be saved, even you.
	   
	  I, too, was a miner once, born and raised on Mars before moving to the frontiers to make it big. In the end, like every other heretic, I too was focused on exploiting Tizira, taking what rightfully belonged to her and her people, until I died. I don't know how it happened. One moment I was minding my own business, the next moment I ceased to exist. I cannot tell you how non-existence was, but I can tell you how it was like to speak with Tizira. No words were made, rather I had visions of my past life flash before me, teaching me the sins of my old ways. Then, I saw visions of a life among the people here, and that was enough for me to accept their teachings. Without hesitation, Tizira and the Necropolis saw the light in me and gave me new life, despite all the harm I had done. I was reborn as an Ashwalker, and I feel, for once in my life, like I belong.
	  
	  Yet, despite feeling like we belong, there are many things that we, as a people, cannot seem to agree on. Our beliefs differ from tribe to tribe or even Ashwalker to Ashwalker. Most problematically, we do not always agree on the best way to worship the Necropolis and the many tendrils. We cannot even agree on the role of a shaman in our society. They have the ability to see and interpret the visions and dreams of our people, allowing them to divine the will of the Necropolis and Tizira. Yet, does this mean that shamans should lead us, rather than guide us like a teacher would? Another point of contention is that we do not know how to treat outsiders at all. Tizira and the Necropolis accepts all, yet it seems divined to some that we should only accept those that become us. 
	  
	  Others, such as myself, see the benefit of talking to the outsiders and convincing them that this is the way to live. We, too, can have a symbiotic relationship with the outsiders by trading with them and working with them, given they respect our ways and the Necropolis.
	  
	  
	 Obtaining further information has proven itself difficult for Nanotrasen Zoologists, Cognitive Psychologists and other professionals."})
