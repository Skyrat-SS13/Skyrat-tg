/// The non gender specific list that we get from init_sprite_accessory_subtypes()
#define DEFAULT_SPRITE_LIST "default_sprites"
/// The male specific list that we get from init_sprite_accessory_subtypes()
#define MALE_SPRITE_LIST "male_sprites"
/// The female specific list that we get from init_sprite_accessory_subtypes()
#define FEMALE_SPRITE_LIST "female_sprites"

/// subsystem that just holds lists of sprite accessories for accession in generating said sprites.
/// A sprite accessory is something that we add to a human sprite to make them look different. This is hair, facial hair, underwear, mutant bits, etc.
SUBSYSTEM_DEF(accessories) // just 'accessories' for brevity
	name = "Sprite Accessories"
	flags = SS_NO_FIRE | SS_NO_INIT

	//Hairstyles
	var/list/hairstyles_list //! stores /datum/sprite_accessory/hair indexed by name
	var/list/hairstyles_male_list //! stores only hair names
	var/list/hairstyles_female_list //! stores only hair names
	var/list/facial_hairstyles_list //! stores /datum/sprite_accessory/facial_hair indexed by name
	var/list/facial_hairstyles_male_list //! stores only hair names
	var/list/facial_hairstyles_female_list //! stores only hair names
	var/list/hair_gradients_list //! stores /datum/sprite_accessory/hair_gradient indexed by name
	var/list/facial_hair_gradients_list //! stores /datum/sprite_accessory/facial_hair_gradient indexed by name

	//Underwear
	var/list/underwear_list //! stores /datum/sprite_accessory/underwear indexed by name
	var/list/underwear_m //! stores only underwear name
	var/list/underwear_f //! stores only underwear name

	//Undershirts
	var/list/undershirt_list //! stores /datum/sprite_accessory/undershirt indexed by name
	var/list/undershirt_m //! stores only undershirt name
	var/list/undershirt_f //! stores only undershirt name

	// SKYRAT EDIT ADDITION START - Underwear/bra split
	var/list/bra_list
	var/list/bra_m
	var/list/bra_f
	// SKYRAT EDIT ADDITION END

	//Socks
	var/list/socks_list //! stores /datum/sprite_accessory/socks indexed by name

	/* SKYRAT EDIT REMOVAL START - Customization - Moved to sprite_accessories var
	//Lizard Bits (all datum lists indexed by name)
	var/list/lizard_markings_list
	var/list/snouts_list
	var/list/horns_list
	var/list/frills_list
	var/list/spines_list
	var/list/legs_list
	var/list/tail_spines_list

	//Mutant Human bits
	var/list/tails_list_human
	var/list/tails_list_lizard
	var/list/tails_list_monkey
	var/list/ears_list
	var/list/wings_list
	var/list/wings_open_list
	var/list/moth_wings_list
	var/list/moth_antennae_list
	*/ //SKYRAT EDIT REMOVAL END
	var/list/moth_markings_list
	var/list/pod_hair_list

	// SKYRAT EDIT ADDITION START - Customization
	var/list/lizard_markings_list
	var/list/tails_list_monkey
	var/list/caps_list
	var/list/moth_wings_list

	var/list/sprite_accessories = list()
	var/list/genetic_accessories = list()
	var/list/generic_accessories = list()

	var/list/cached_mutant_icon_files = list()

	// we are loading them along with sprite_accessories, so they can't be GLOB :(
	var/dna_total_feature_blocks = DNA_MANDATORY_COLOR_BLOCKS
	var/list/dna_mutant_bodypart_blocks = list()
	var/list/features_block_lengths = list()
	// SKYRAT EDIT ADDITION END

/datum/controller/subsystem/accessories/PreInit() // this stuff NEEDS to be set up before GLOB for preferences and stuff to work so this must go here. sorry
	setup_lists()
	init_hair_gradients()
	make_sprite_accessory_references() // SKYRAT EDIT ADDITION - Customization

/// Sets up all of the lists for later utilization in the round and building sprites.
/// In an ideal world we could tack everything that just needed `DEFAULT_SPRITE_LIST` into static variables on the top, but due to the initialization order
/// where this subsystem will initialize BEFORE statics, it's just not feasible since this all needs to be ready for actual subsystems to use.
/// Sorry.
/datum/controller/subsystem/accessories/proc/setup_lists()
	var/hair_lists = init_sprite_accessory_subtypes(/datum/sprite_accessory/hair)
	hairstyles_list = hair_lists[DEFAULT_SPRITE_LIST]
	hairstyles_male_list = hair_lists[MALE_SPRITE_LIST]
	hairstyles_female_list = hair_lists[FEMALE_SPRITE_LIST]

	var/facial_hair_lists = init_sprite_accessory_subtypes(/datum/sprite_accessory/facial_hair)
	facial_hairstyles_list = facial_hair_lists[DEFAULT_SPRITE_LIST]
	facial_hairstyles_male_list = facial_hair_lists[MALE_SPRITE_LIST]
	facial_hairstyles_female_list = facial_hair_lists[FEMALE_SPRITE_LIST]

	var/underwear_lists = init_sprite_accessory_subtypes(/datum/sprite_accessory/underwear)
	underwear_list = underwear_lists[DEFAULT_SPRITE_LIST]
	underwear_m = underwear_lists[MALE_SPRITE_LIST]
	underwear_f = underwear_lists[FEMALE_SPRITE_LIST]

	var/undershirt_lists = init_sprite_accessory_subtypes(/datum/sprite_accessory/undershirt)
	undershirt_list = undershirt_lists[DEFAULT_SPRITE_LIST]
	undershirt_m = undershirt_lists[MALE_SPRITE_LIST]
	undershirt_f = undershirt_lists[FEMALE_SPRITE_LIST]

	// SKYRAT EDIT ADDITION START - Underwear/bra split
	var/bra_lists = init_sprite_accessory_subtypes(/datum/sprite_accessory/bra)
	bra_list = bra_lists[DEFAULT_SPRITE_LIST]
	bra_m = bra_lists[MALE_SPRITE_LIST]
	bra_f = bra_lists[FEMALE_SPRITE_LIST]
	// SKYRAT EDIT ADDITION END

	socks_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/socks)[DEFAULT_SPRITE_LIST]

	/* //SKYRAT EDIT REMOVAL - CUSTOMIZATION
	lizard_markings_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/lizard_markings)[DEFAULT_SPRITE_LIST]
	tails_list_human = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/human, add_blank = TRUE)[DEFAULT_SPRITE_LIST]
	tails_list_lizard = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/lizard, add_blank = TRUE)[DEFAULT_SPRITE_LIST]
	tails_list_monkey = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/monkey, add_blank = TRUE)[DEFAULT_SPRITE_LIST]
	snouts_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/snouts)[DEFAULT_SPRITE_LIST]
	horns_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/horns)[DEFAULT_SPRITE_LIST]
	ears_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/ears)[DEFAULT_SPRITE_LIST]
	wings_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/wings)[DEFAULT_SPRITE_LIST]
	wings_open_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/wings_open)[DEFAULT_SPRITE_LIST]
	frills_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/frills)[DEFAULT_SPRITE_LIST]
	spines_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/spines)[DEFAULT_SPRITE_LIST]
	tail_spines_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/tail_spines)[DEFAULT_SPRITE_LIST]
	legs_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/legs)[DEFAULT_SPRITE_LIST]
	caps_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/caps)[DEFAULT_SPRITE_LIST]
	moth_wings_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/moth_wings)[DEFAULT_SPRITE_LIST]
	moth_antennae_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/moth_antennae)[DEFAULT_SPRITE_LIST]
	moth_markings_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/moth_markings)[DEFAULT_SPRITE_LIST]
	*/ // SKYRAT EDIT REMOVAL END
	pod_hair_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/pod_hair)[DEFAULT_SPRITE_LIST]
	// SKYRAT EDIT ADDITION START - Customization
	tails_list_monkey = init_sprite_accessory_subtypes(/datum/sprite_accessory/tails/monkey, add_blank = TRUE)[DEFAULT_SPRITE_LIST]
	caps_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/caps, add_blank = TRUE)[DEFAULT_SPRITE_LIST]
	moth_wings_list = init_sprite_accessory_subtypes(/datum/sprite_accessory/moth_wings)[DEFAULT_SPRITE_LIST]

	features_block_lengths = list(
		"[DNA_MUTANT_COLOR_BLOCK]" = DNA_BLOCK_SIZE_COLOR,
		"[DNA_MUTANT_COLOR_2_BLOCK]" = DNA_BLOCK_SIZE_COLOR,
		"[DNA_MUTANT_COLOR_3_BLOCK]" = DNA_BLOCK_SIZE_COLOR,
		"[DNA_ETHEREAL_COLOR_BLOCK]" = DNA_BLOCK_SIZE_COLOR,
		"[DNA_SKIN_COLOR_BLOCK]" = DNA_BLOCK_SIZE_COLOR,
	)
	// SKYRAT EDIT ADDITION END

/// This proc just intializes all /datum/sprite_accessory/hair_gradient into an list indexed by gradient-style name
/datum/controller/subsystem/accessories/proc/init_hair_gradients()
	hair_gradients_list = list()
	facial_hair_gradients_list = list()
	for(var/path in subtypesof(/datum/sprite_accessory/gradient))
		var/datum/sprite_accessory/gradient/gradient = new path
		if(gradient.gradient_category & GRADIENT_APPLIES_TO_HAIR)
			hair_gradients_list[gradient.name] = gradient
		if(gradient.gradient_category & GRADIENT_APPLIES_TO_FACIAL_HAIR)
			facial_hair_gradients_list[gradient.name] = gradient

/// This reads the applicable sprite accessory datum's subtypes and adds it to the subsystem's list of sprite accessories.
/// The boolean `add_blank` argument just adds a "None" option to the list of sprite accessories, like if a felinid doesn't want a tail or something, typically good for gated-off things.
/datum/controller/subsystem/accessories/proc/init_sprite_accessory_subtypes(prototype, add_blank = FALSE)
	RETURN_TYPE(/list)
	var/returnable_list = list(
		DEFAULT_SPRITE_LIST = list(),
		MALE_SPRITE_LIST = list(),
		FEMALE_SPRITE_LIST = list(),
	)

	for(var/path in subtypesof(prototype))
		var/datum/sprite_accessory/accessory = new path

		if(accessory.icon_state)
			returnable_list[DEFAULT_SPRITE_LIST][accessory.name] = accessory
		else
			returnable_list[DEFAULT_SPRITE_LIST] += accessory.name

		switch(accessory.gender)
			if(MALE)
				returnable_list[MALE_SPRITE_LIST] += accessory.name
			if(FEMALE)
				returnable_list[FEMALE_SPRITE_LIST] += accessory.name
			else
				returnable_list[MALE_SPRITE_LIST] += accessory.name
				returnable_list[FEMALE_SPRITE_LIST] += accessory.name

	if(add_blank)
		returnable_list[DEFAULT_SPRITE_LIST][SPRITE_ACCESSORY_NONE] = new /datum/sprite_accessory/blank

	return returnable_list

#undef DEFAULT_SPRITE_LIST
#undef MALE_SPRITE_LIST
#undef FEMALE_SPRITE_LIST
