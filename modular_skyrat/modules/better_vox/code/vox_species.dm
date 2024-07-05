/datum/species/vox_primalis
	name = "Vox Primalis"
	id = SPECIES_VOX_PRIMALIS
	eyes_icon = 'modular_skyrat/modules/better_vox/icons/bodyparts/vox_eyes.dmi'
	can_augment = FALSE
	body_size_restricted = TRUE
	digitigrade_customization = DIGITIGRADE_NEVER // We have our own unique sprites!
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC | MOB_HUMANOID
	mutantlungs = /obj/item/organ/internal/lungs/nitrogen/vox
	mutantbrain = /obj/item/organ/internal/brain/vox
	breathid = "n2"
	mutant_bodyparts = list()
	meat = /obj/item/food/meat/slab/chicken/human //item file in teshari module
	mutanttongue = /obj/item/organ/internal/tongue/vox
	payday_modifier = 1.0
	outfit_important_for_life = /datum/outfit/vox
	species_language_holder = /datum/language_holder/vox
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT

	// Vox are cold resistant, but also heat sensitive
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT - 15) // being cold resistant, should make you heat sensitive actual effect ingame isn't much
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT - 30)

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/vox_primalis,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/vox_primalis,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/vox_primalis,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/vox_primalis,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/vox_primalis,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/vox_primalis,
	)
	custom_worn_icons = list(
		OFFSET_HEAD = VOX_PRIMALIS_HEAD_ICON,
		OFFSET_FACEMASK = VOX_PRIMALIS_MASK_ICON,
		OFFSET_SUIT = VOX_PRIMALIS_SUIT_ICON,
		OFFSET_UNIFORM = VOX_PRIMALIS_UNIFORM_ICON,
		OFFSET_GLOVES =  VOX_PRIMALIS_GLOVES_ICON,
		OFFSET_SHOES = VOX_PRIMALIS_FEET_ICON,
		OFFSET_GLASSES = VOX_PRIMALIS_EYES_ICON,
		OFFSET_BELT = VOX_PRIMALIS_BELT_ICON,
		OFFSET_BACK = VOX_PRIMALIS_BACK_ICON,
		OFFSET_EARS = VOX_PRIMALIS_EARS_ICON,
	)

/datum/species/vox_primalis/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Vox Primalis Tail", FALSE),
	)

/datum/species/vox_primalis/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only)
	. = ..()
	if(job?.vox_outfit)
		equipping.equipOutfit(job.vox_outfit, visuals_only)
	else
		give_important_for_life(equipping)

/datum/species/vox_primalis/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_better_vox

/datum/species/vox_primalis/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_better_vox = icon

/datum/species/vox_primalis/get_species_description()
	return "The Vox seem to be nomadic, bio-engineered alien creatures that operate in and around human space at the behest of crazed and dreaming gods. \
		In reality, we know them to be originally designed by the Vox Auralis, a wholly-reclusive variety of powerful psychics, and present a cold shoulder to all other known cultures, and generally their only visible role on the galactic stage is to act as auxiliary workforce of which they are functionally suited for. \
		The massive moon-sized arkships that serve as their homes travel meandering and convoluted migratory trails through the Milky Way, and the appearance of their looted and repurposed ships is almost always a cause for alarm."

/datum/species/vox_primalis/get_species_lore()
	return list(
		"Designed and grown by the Apex, biocomputers the size of massive willow trees, the average Vox is a digitigrade, reptilian biped with stiff, semi-rigid keratin quills on their head, a long prehensile tail, and a teethed and bilaterally-split jaw. \
		They have a flexible and lightweight skeleton and a two-channel redundant nervous system. They generally stand anywhere from 1.3 to 2 meters tall, averaging at 1.5 for most Vox, taller for Armalis, with a primarily green and brown coloration, but can have different colored quills and body markings. \
		Their bodies are scaled with rigid, nonconducting plates in overlapping rows, which can be bristled or flattened at will to optimize cooling or form interior seals as to retain heat. \
		Their aforementioned quills act as a supplementary cooling system, with tiny capillaries allowing bloodflow into the hollow recesses inside of the quills, which they may often violently shake to produce a cooling effect with the air; this also functions as a threat display, as many Vox will attempt to cool themselves down before engaging in a fight as to regulate their body-temperature though exertion. \
		They do not respirate as humans do, but they do require a nitrogen-rich atmosphere to 'breathe', and suffer badly in the presence of oxygen. \
		Their musculature is geared towards sudden bursts of rapid movement, with a vulnerability to lactic acid buildup as a result.",

		"While the brain of any sort of Vox up to the Auralis are certainly present, a Vox is not considered 'alive' without the Cortical Stack. This mechanical brain is installed the minute a Vox is produced by the Apex, mind uploading being one of the oldest disciplines of the Vox, and it holds their memories, personality, and body information. \
		These machines also hold their genetic information, a newly 'resleeved' Vox physically mutating into the parameters set by their stack. A Vox is not considered 'dead' as long as their stack can be put in a new body, and this process affords them functional immortality. \
		However, no other beings are considered 'alive' either due to their lack of one; their absence of the divine spark of the Auralis. They feel neither empathy nor hatred towards aliens, their short, violent and ephemeral existences ultimately meaning as little as furniture to the Vox.",

		"Artificially made by the Apex, Vox Primalis are grown for a purpose, their personalities and duties sourced by the cortical stacks installed in their heads. \
		The exact specifications and duties of a Primalis may change throughout their life according to the enigmatic will of the biocomputers fabricating them, and their duties may be oddly specific at times; \
		but seven core 'groups' of jobs are known by humans, signified by a series of neck, throat, facial, and back markings encoded with their role, genetic lineage, notable deeds, and arkship of origin.",

		"'Drones' are the engineers, technicians, and builders of the Primalis. Their duties revolve around the upkeep of the Arkships themselves, and the operation of technologies new and old. \
		'Servitors' are in charge of biological affairs; making sure stocks are full, meals are made, and Vox are healthy. They typically share work with Drones due to Vox technology being both synthetic and organic.",

		"'Raiders' are those combat-focused Primalis sent on excursion teams from the ships to plunder goods, people, and other wares from aliens. \
		'Scavengers' work alongside Raiders, pulling stations and ships apart to find anything even remotely valuable, down to the scrap metal and copper wiring in an outpost.",

		"'Reavers' are essentially the white blood cells of an Arkship. Rarely seen but always around, these Vox are dedicated to expunging threats and ensuring that individuals in need of 'pruning' are brought in swiftly to the Armalis and Apex. \
		If ever seen outside an Arkship, it's typically for the purpose of overseeing other Primalis in place of a proper Armalis.",

		"'Leaders' are those that are in charge of a crew. Acting like a tightly-knit family, these work crews are kept in line not only by the Armalis, but by these typically very old Vox. \
		These magnanimous (for a Primalis) individuals are very, very rarely seen outside of an Arkship due to their assignments requiring 'active duty'. \
		To see a 'Leader,' in a place of aliens is to know that they are almost assuredly an exile, and shunned by all varieties of Vox. The Vox consider 'drains on resources' as inexcusable, and to be one is an act to be shunned upon.",

		"'Larva' are not Primalis children, as they'd be less than a few months old at youngest, but a denigrating term for Vox that either have not yet been assigned a duty, or those currently inbetween them. \
		While these Vox are often pushed by other Primalis to 'hurry up already,' it is the wide consensus of Vox that 'A lone leader is worse than a larva, for while even a larva has a future, all the leader has is a disgraced past.'"
	)

/datum/species/vox_primalis/on_species_gain(mob/living/carbon/human/transformer)
	. = ..()
	var/vox_color = transformer.dna.features["vox_bodycolor"]
	if(!vox_color || vox_color == "default")
		return
	for(var/obj/item/bodypart/limb as anything in transformer.bodyparts)
		limb.limb_id = "[SPECIES_VOX_PRIMALIS]_[vox_color]"
	transformer.update_body()
