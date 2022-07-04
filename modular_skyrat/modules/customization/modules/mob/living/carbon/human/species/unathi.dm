/datum/species/unathi
	name = "Unathi"
	id = SPECIES_UNATHI
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
		"spines" = "None",
		"frills" = "None",
		"horns" = ACC_RANDOM,
		"body_markings" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	attack_verb = "slash"
	attack_effect = ATTACK_EFFECT_CLAW
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	disliked_food = GRAIN | DAIRY | CLOTH
	liked_food = GROSS | MEAT | SEAFOOD | NUTS
	toxic_food = TOXIC
	payday_modifier = 0.75
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_LIZARD
	ass_image = 'icons/ass/asslizard.png'

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard,
		BODY_ZONE_L_ARM = /obj/item/bodypart/l_arm/lizard,
		BODY_ZONE_R_ARM = /obj/item/bodypart/r_arm/lizard,
		BODY_ZONE_L_LEG = /obj/item/bodypart/l_leg/lizard,
		BODY_ZONE_R_LEG = /obj/item/bodypart/r_leg/lizard,
	)

/datum/species/unathi/get_random_features()
	var/list/returned = MANDATORY_FEATURE_LIST
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of green or brown colors, with a darker secondary and tertiary
	switch(random)
		if(1)
			main_color = "#11CC00"
			second_color = "#118800"
		if(2)
			main_color = "#55CC11"
			second_color = "#55AA11"
		if(3)
			main_color = "#77AA11"
			second_color = "#668811"
		if(4)
			main_color = "#886622"
			second_color = "#774411"
		if(5)
			main_color = "#33BB11"
			second_color = "#339911"
	returned["mcolor"] = main_color
	returned["mcolor2"] = second_color
	returned["mcolor3"] = second_color
	return returned

/datum/species/unathi/get_species_description()
	return {"The Unathi are one of several sapient species of humanoids in current-day charted space. Their physiology is extremely reptile-like and generally proves quite cooperative with their \"brutish\" way of life.
	
	Among some of their primary distinctive features is a very dense bone structure, ocular nictitating membranes purpose-built for resisting sandstorms and the tough, large crocodilian-like scutes that protect their back.
	
	As Unathi have a high amount of genetical instability and physiological differences best suited for their region of birth, one may find that this is not always the case and rather a generalization.
	
	They can posess horns, frills, or spines - a combination of the three - or none of them, up to the point where hair, fur and feathers are not out of the picture (Though they can be artificial genemods)."}

/datum/species/unathi/get_species_lore()
	return list({"Quoted from Sol Federation Expeditionary Corps LtG. Alexander Tuah: 
	
	\"The situation in Moghes is not something that is easy for the average Sol Federation citizen to wrap their head around. Most of us tend to worry about what we will have for dinner tonight, but we never ask ourselves whether we will get to eat at all. That thought never crosses our mind, but it does for the Unathi every single night. Hunger, ignorance, and a desperation to survive is what makes Moghes a dangerous place.
	
	I have spent decades on anti-piracy campaigns all across the frontiers of our country. I have personally met with survivors from raided settlements and outposts. While their bravery is to be commended, their extraordinary tales of their survival, while striking, would be considered quite ordinary for your average Unathi. We are talking about individuals who have grown accustomed to playing dead for several days yet are perfectly willing to fight to the death.
	
	Their value systems, which would be considered alien and barbaric by our standards, have no room for moral calculus when it comes to outsiders. What I am saying, is that the concept of a civilian does not exist in Moghes. There is no such thing as an Unathi civilian. To them, every unarmed man or woman they kill is a warrior that has been caught unprepared.
	
	That is how we ended up with Paradigm. The Unathi near Paradigm believed the colony was there to take away their only source of freshwater as other rival tribes had for centuries. The thought of conducting dialogue or diplomacy never occurred to them, because such an act would get them killed. This is what we are dealing with, senator. This is the gap we must overcome.\"
	
	General Tuah's quote during a senate hearing on Agurkrral's role in the massacre of Paradigm captures an accurate snapshot of the Unathi as a people who are a victim of circumstance. No one can deny that the Unathi have embraced a distinct \"warrior culture\" that is utterly ruthless to its core, but to think of them as nothing more than warmongering, blood-thirsty brutes fail to adequately account for the dire situation the Unathi have faced for the large part of the millennium. 
	
	Much like how General Tuah's quote has often been twisted by the White Dove Party to make the mal-aligned general look as if he is justifying Sol Federation war crimes on Moghes, the Unathi appear blood-thirsty by the virtue of utter desperation, and certain pro-labor movements have seized on it to push a racist anti-Unathi agenda to keep labor costs high. To focus solely on Unathi's brutality is to miss out on the larger context.
	
	Contrary to popular belief, Moghes is not a desert planet, rather it is a temperate planet much like ours that has been turned into a nuclear wasteland and is practically a post-apocalyptic state. Nuclear armageddon has made ordinary resources like food and water rare luxuries, while beneficial geographic terrain such as freshwater rivers and the stilt around them as lands to be fought for in a perpetual battleground. At the end of the day, every Unathi fights to see which tribe eats or starves that day.
	
	Despite living in a post-apocalyptic warrior state, the Unathi also possess several distinct and vibrant cultures all with their own unique ceremonies, rituals, mannerisms, religions, and so forth that are reminiscent of the stories shared by Greek philosophers and storytellers, one rich with history, allegories, and lessons. They trade freely with others, and they create generational wealth based on their family's specialization. 

	When not at war, they appear to be simple, hardworking agrarian people that strive to make the next generation's life a little less miserable.
	
	While it's known that some sort of nuclear catastrophe had taken place on Moghes, it is unknown how the Unathi are tied to the cataclysmic event despite what some may claim. It is not known whether they had initiated a nuclear war among themselves, whether they were mutants that arose out of the radioactive wastes, or if they were lab experiments that were the only sapient being to survive the apocalyptic war. Whatever the case, when the radiation settled, a strong, resilient people arose to dominate the wasteland. 
	
	It's unknown if there were the only ones or if there were others that were gradually wiped out in the culling that began through the form of accelerated natural selection. However, it's known that the Unathi are considered by some to be one of the few people that have fully embraced a so-called \"warrior culture\".

	Due to the constant competition for limited resources, their planet is dominated by various tribes and warlords that engage in constant skirmishes and battles with each other. This has led to many Unathi being hardy in nature with an emphasis placed on strength and size. As a result, they are typically sought after by corporations for cheap labor, filling in a void that the Silicons had left behind. However, many Unathi that come to work for those in the Sol Federation tend to be those that were unfit for survival on Moghes, while others simply seek a better life that is not filled with constant turmoil and warfare. 
	
	They do not have the same caliber of hardiness as their counterparts, however, they are hard workers that are quite keen to assimilate.
	
	For all their strengths, many in the Sol Federation see them as a crude, backwards people, unable to match the ideals of the burgeoning interstellar nation. It is true that many Unathi are known to be extremely sexist, so much so that corporations ensure that any female employees on Moghes are accompanied by a male co-worker. Yet, despite this alleged incompatibility, many Unathi have learned to keep uncouth remarks and hands to themselves, and there are many more that never engaged in that sort of behavior to begin with."})
