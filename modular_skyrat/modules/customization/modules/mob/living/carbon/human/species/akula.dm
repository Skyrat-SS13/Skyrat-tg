/datum/species/akula
	name = "Akula"
	id = SPECIES_AKULA
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		LIPS,
		HAS_FLESH,
		HAS_BONE,
		HAIR
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"ears" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	payday_modifier = 0.75
	liked_food = SEAFOOD | RAW
	disliked_food = CLOTH | DAIRY
	toxic_food = TOXIC
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/mutant/akula,
	)

/datum/species/akula/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of sharkish colors, with a whiter secondary and tertiary
	switch(random)
		if(1)
			main_color = "#668899"
			second_color = "#BBCCDD"
		if(2)
			main_color = "#334455"
			second_color = "#DDDDEE"
		if(3)
			main_color = "#445566"
			second_color = "#DDDDEE"
		if(4)
			main_color = "#666655"
			second_color = "#DDDDEE"
		if(5)
			main_color = "#444444"
			second_color = "#DDDDEE"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = second_color
	return returned

/datum/species/akula/get_random_body_markings(list/passed_features)
	var/name = "Shark"
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/akula/get_species_description()
	return {"The Azuleans, also widely known as Akula, are one of several sapient species of humanoids and make up one of four primary \"nations\" in current-day charted space. Their physiology is closely shark-like, yet posesses mammalian features that allow them to exist in both water and land without complication.
	They have a semi-rigid skeleton composed of tough and flexible cartilage and a nearly-identical organ structure to that of humans with the addition of gills and a buoyant liver.
	Among their most noticeable features is the abundant presence of small hydrodynamic feathers on their heads, looking exactly like hair at a first glance - and their webbed toes and fingers.
	All of these are often not completely granted, as Akula are close with genetical modification."}

/datum/species/akula/get_species_lore()
	return list({"The Kingdom of Agurkrral is the preeminent nation of the Azuleans, otherwise known as the Akulans. On the surface, Agurkrral appears to be a land of rigid if not stagnant traditionalists. However, it is a dynamic and relatively progressive nation fueled by a rigorous education system, structured reforms program, and polarizing open debates, using what it perceives as merit as a measure of advancement for all those that dwell within its borders. While appearing backwards initially to some in the Sol Federation may consider to be backwards, they enjoy a high degree of personal freedom and have outdone the Sol Federation when it comes to the creation of an arguably liberal and stable, multi-species empire, allowing any alien species to become a citizen while rigorously upholding the values of free speech, free press, free religion, and the right to life.
	
	However, many critics see the country as dangerously nationalist and socialist, despite the Akulans having no concept of socialism due to perceiving no difference between the government and its citizenry, as they offer free universal healthcare, free education, and a universal basic income for those that have earned citizenship through military or government service. More alarmingly, the Akulans openly practice eugenics, leveraging their expertise in genetics and their ability to bioengineer on a massive scale. While other nations have fanatics preaching their religion to convert non-believers, some Akulans pressure those around them to perfect themselves further mentally, physically, and genetically, even targeting species that are naturally shorter to coerce them to make themselves taller. It is said that anyone perceived to have a physical or mental defect are often sent to reformation camps where they undergo intensive and intrusive changes to their genetic makeup with some whispering that the Akulans are secretly conducting a slow genocide.
	
	To outsiders, Agurkrral appears like a nation that has never moved past the traditions of its own respective enlightenment age. Yet, despite its almost archaic if not naive belief in the fanciful concept of philosopher warrior-kings, it has managed to be innovative and adaptive throughout the ages, having built its foundation on the backbones of its highly educated citizenry and aristocracy. Through that way, the old way has kept itself strong for a thousand years, constantly rebuilding and restructuring itself over the years where anyone can become an aristocrat if they meet the rigorous standards. However, a sharp divide has formed in Agurkrral between the Old Principalities and the New Principalities which threatens the old order, dating back to the advent of the Akulan Colonization Age.
	
	The Akulans faced failure after failure, as their space program failed to colonize the stars beyond. Each setback proved to be costly, especially as dwindling resources brought forth lean times on their homeworld of Azulea. In the hopes of diversifying cost and risk, the Agurkrral government made the decision to privatize space colonization, granting charters to collections of large, self-organized denizens called "dulaks". These groups are described to consist mostly of underachievers that sought citizenship, namely non-citizen Akulans who failed to meet the threshold for citizenship. They were often led by a small collection of citizens who were looking for unorthodox ways of achieving the status of aristocrat outside exemplary government or military service often times due to anarchistic tendencies, although it was not uncommon for them to have a "princep" to lead the way with near dictatorial powers.  

	These charters granted the dulaks permission to colonize a world beyond its border with the promise of citizenship and aristocracy upon success. Those that were normally blacklisted from citizenship such as debt-holders, criminals, and deadbeats would have a shot at citizenship without having to undergo military or government service. Citizens could become aristocrats without having to wait for wars that would never come, nor would they have to spend decades of drilling and studying, giving up friends, family, and a personal life to become an aristocrat. While one could say only the most desperate would have embarked on such near suicidal expeditions, the most ambitious of them were ready to lead them, as they set out to leave their homes to travel the stars, never to return home.
	
	It was not uncommon for entire dulaks to go missing on their expeditionary. However, through hardship and pragmatism, they soon began to thrive and grow, especially in light of their contact with humans. It was here in their first contact with the founders of the Novaya Rossiyskaya Imperiya (NRI) that they came to be called "Akula". Mutual trade agreements proved to be profitable if not prosperous for both sides. However, some other dulaks began to resort to piracy to survive. In a world so far from home, they began to develop their own culture, one that promoted a \"might makes right\" approach where power could be obtained through personal armies and influence rather than the rule of law. To survive was to expand. Yet, all of that would change when the old world came for them, moving to integrate them properly under the fold of the old order, something that some of the princeps grew to detest thanks to their newfound authority.
	
	Conversely, many of those of the old order who came to bring the new worlds back into the fold were shocked by the disparity in culture and values. They had completely changed. Philosophers, bureaucrats, and citizen-soldiers were greeted by warlords, pirates, and renegades, much to their horror. Corruption and criminality was rampant, often encouraged to line up the pocket of those in power, an unthinkable crime in the old world. Furthermore, the colorful if not coarse personality of the new guard disgusted the old guard, as these rulers of the new world acted on personal influences rather than the rule of law, acting without decorum or respect for the rights of others. 
	
	Agurkrral aristocrats of the old guard ordered sweeping reforms to integrate the new world into the old while looking to choose the elector-princes among themselves that would have ultimate authority in the area. Unsurprisingly, the new guard interpreted the reforms as blatant power grabs. Who could blame them for thinking that? They were the ones that had conquered the flames of the new world, having fought off the ravenous aliens such as the Vox and having tamed the frontiers. Millions had perished, yet these boring, rigid men of the old world, who knew nothing of the frontiers, were now here to take the achievement of others for themselves. The old guard was corrupt, and it was up to the new guards to protect the interests of their people. Upon finding out, the new guards announced that they themselves were the legitimate source of authority of the new world, thus they would openly name themselves the prince-elector, a privilege only the king himself can grant. To them, the charter had granted them the right. They were the elector-prince, earned through sweat and blood. 
	
	Revolt may have seemed as if it was on the horizon, yet it appeared as if the new guard still maintained a fervid loyalty to the Agurkrral kings of current and old standing. Thus, no such large revolt materialized. However, it was clear they had their own interpretation of royal decrees and the royalty that issued them.
	
	This line of illegal assertions of power merely confirmed the beliefs of the old guard. These men were "Luikos'' in the making, a traitorous general that attempted to seize the throne illegally many centuries ago. They called the new guard \"border princes\", mocking them heavily. The rivalry would only intensify, as the cultural shock between the new and old world could not be reconciliated. Many of them were viewed with distaste by the established order, earning the derisive moniker of \"border princes\" or \"pretenders\". The unruly nature of the frontiers allegedly disgusted those on the \"Old Principalities\", as they claimed they saw the wanton criminality, corruption, and the constant in-fighting as a stain on Akulan honor, especially as these so-called \"border princes\" waged war among each other like warlords or raided others like common pirates. They saw it as their duty to civilize the frontiers and so, they began a campaign of stabilizing and integrating planets from the frontiers into the \"Old Principalities\" in the name of the king.
	
	However, to the Border Princes of the \"New Principalities\", this was nothing more than a blatant land and power grab. So, instead of waiting for new charters to be granted, they would expand outward in the name of the king, proclaiming their loyalty to him as they did so as they attempted to colonize new worlds in order to outpace the integration efforts of the Old Principalities. Over time, the culture between the two realms emerged with one side prizing honor, education, and integrity, while the other sought pragmatism, freedom, and opportunity. A \"big rip\" seemed inevitable, as one side sought to assimilate the other while the other sought to escape. Even the military became caught up in the political divide with the Royal Army aligning itself with the New Principalities, while the Royal Navy and Auxiliary Forces began to see their future with the Outer Principalities due to their reliance on them for protection."})
