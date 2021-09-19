/*
Due to how our current mutant bodypart system works we are required to individually
process each and every single key in sprite_accessories into the TGUI preference menu.

Currently this is the only way we can do it, until we make some kind of dynamic feature
population system.

If you are adding a new type of mutant bodypart, you MUST add it here in order for it to be present on the character creator.

* savefile_key - Must be unique, and relevant to the new mutant bodypart.
* savefile_identifier - Do not change.
* category - Dependant on if your mutant choice has icons, you will either choose PREFERENCE_CATEGORY_FEATURES, or if it is
	a text type selection, you would choose PREFERENCE_CATEGORY_SECONDARY_FEATURES
* relevant_mutant_bodypart - This is very important, you must set this to the corresponding bodypart name, if you get this wrong
	it will not work and you will fuck shit up. Make sure it's correct.
* should_generate_icons - This is required if you are returning a list of icons and values in init_possible_values, and gives
	you a fancy looking dropdown box. Failure to include this correctly will result in cascade failure.
* main_feature_name - You MUST include this if you are adding a choice that has icons, as this is how it is identified in
	text. Failure to include this correctly will result in cascade failure.

IMPORTANT NOTES:
//The issue is we now need to somehow pass through color
//the value being returned can be an associative list of name and color
//THe UI doesn't have this support right now, we need to add it
//Below is an example of one color support, we need to modify it to support three colors, maybe three individual SUPPLIMENTAL data keys
//problem is this only supports one supplemental feature
//I will have to make a new component to use that is just 3 color boxes.
*/

/// A preference that is a choice of one option among a fixed set, which supports mutant bodyparts.
/// Used for preferences such as tails, ears, wings.
/datum/preference/choiced_mutant
	/// If this is TRUE, icons will be generated.
	/// This is necessary for if your `init_possible_values()` override
	/// returns an assoc list of names to atoms/icons.
	var/should_generate_icons = FALSE

	var/list/cached_values

	/// If the preference is a main feature (PREFERENCE_CATEGORY_FEATURES or PREFERENCE_CATEGORY_CLOTHING)
	/// this is the name of the feature that will be presented.
	var/main_feature_name

	abstract_type = /datum/preference/choiced_mutant

	/// This determines, when generating side sprites, what direction the sprite is set.
	var/direction = EAST

	/// This determines, when generating side sprites, what position is set.
	var/layer = BODY_FRONT_LAYER

	priority = PREFERENCE_PRIORITY_MUTANT_PARTS

	main_feature_name = "Mutant Part"

/// Returns a list of every possible value.
/// The first time this is called, will run `init_values()`.
/// Return value can be in the form of:
/// - A flat list of raw values, such as list(MALE, FEMALE, PLURAL).
/// - An assoc list of raw values to atoms/icons.
/datum/preference/choiced_mutant/proc/get_choices()
	// Override `init_values()` instead.
	SHOULD_NOT_OVERRIDE(TRUE)

	if (isnull(cached_values))
		cached_values = init_possible_values()
		ASSERT(cached_values.len)

	return cached_values

/// Returns a list of every possible value, serialized.
/// Return value can be in the form of:
/// - A flat list of serialized values, such as list(MALE, FEMALE, PLURAL).
/// - An assoc list of serialized values to atoms/icons.
/datum/preference/choiced_mutant/proc/get_choices_serialized()
	// Override `init_values()` instead.
	SHOULD_NOT_OVERRIDE(TRUE)

	var/list/serialized_choices = list()
	var/choices = get_choices()

	if (should_generate_icons)
		for (var/choice in choices)
			serialized_choices[serialize(choice)] = choices[choice]
	else
		for (var/choice in choices)
			serialized_choices += serialize(choice)

	return serialized_choices

/// Returns a list of every possible value.
/// This must be overriden by `/datum/preference/choiced` subtypes.
/// Return value can be in the form of:
/// - A flat list of raw values, such as list(MALE, FEMALE, PLURAL).
/// - An assoc list of raw values to atoms/icons, in which case
/// icons will be generated.
/datum/preference/choiced_mutant/proc/init_possible_values()
	SHOULD_CALL_PARENT(TRUE)

	if(should_generate_icons)
		main_feature_name = relevant_mutant_bodypart
		. = generate_mutant_accessory_icons(GLOB.sprite_accessories[relevant_mutant_bodypart], relevant_mutant_bodypart, direction, layer)
	else
		. = GLOB.sprite_accessories[relevant_mutant_bodypart]

/datum/preference/choiced_mutant/is_valid(value)
	return value in get_choices()

/datum/preference/choiced_mutant/deserialize(input, datum/preferences/preferences)
	return sanitize_inlist(input, get_choices(), create_default_value())

/datum/preference/choiced_mutant/create_default_value()
	return pick(get_choices())

/datum/preference/choiced_mutant/compile_constant_data()
	var/list/data = list()

	var/list/choices = list()

	for (var/choice in get_choices())
		choices += choice

	data["choices"] = choices

	if (should_generate_icons)
		var/list/icons = list()

		for (var/choice in choices)
			icons[choice] = get_spritesheet_key(choice)

		data["icons"] = icons

	if (!isnull(main_feature_name))
		data["name"] = main_feature_name

	return data

/datum/preference/choiced_mutant/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.species.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.species.mutant_bodyparts[relevant_mutant_bodypart] = list()
	target.dna.species.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_NAME] = value

// LEG TYPE, NO ICONS
/datum/preference/choiced_mutant/leg_type
	savefile_key = "feature_leg_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "legs"
	should_generate_icons = FALSE

/datum/preference/choiced_mutant/leg_type/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list()
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_NAME] = value

// SNOUTS
/datum/preference/choiced_mutant/snout
	savefile_key = "feature_snout"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	relevant_mutant_bodypart = "snout"
	should_generate_icons = TRUE

// HORNS
/datum/preference/choiced_mutant/horns
	savefile_key = "feature_horns"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	relevant_mutant_bodypart = "horns"
	should_generate_icons = TRUE

/*
//MUTANT CHOICES WITH NO ICONS - Legs are standard
/datum/preference/choiced/mutant_choice
	savefile_key = "feature_leg_type"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "legs"

/datum/preference/choiced/mutant_choice/init_possible_values()
	return GLOB.sprite_accessories[relevant_mutant_bodypart]

/datum/preference/choiced/mutant_choice/apply_to_human(mob/living/carbon/human/target, value)
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list()
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_NAME] = value


//HEAD SIDESHOTS(use this for any choices that require a head sideshot icon) - Standard is snout
/datum/preference/choiced/mutant_choice/head
	savefile_key = "feature_snout"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	should_generate_icons = TRUE
	relevant_mutant_bodypart = "snout"
	main_feature_name = "Snout"


/datum/preference/choiced/mutant_choice/head/init_possible_values()
	return generate_head_side_shots(GLOB.sprite_accessories[relevant_mutant_bodypart], relevant_mutant_bodypart, include_snout)

//EARS
/datum/preference/choiced/mutant_choice/head/ears
	savefile_key = "feature_ears"
	relevant_mutant_bodypart = "ears"
	main_feature_name = "Ears"
	position = "FRONT"
	include_snout = TRUE

//HORNS
/datum/preference/choiced/mutant_choice/head/horns
	savefile_key = "feature_horns"
	relevant_mutant_bodypart = "horns"
	main_feature_name = "Horns"
	position = "FRONT"
	include_snout = TRUE

//BODY SIDESHOTS(use this for any choices that require a body sideshot icon) - Standard is wings
/datum/preference/choiced/mutant_choice/body
	savefile_key = "feature_wings"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	should_generate_icons = TRUE
	relevant_mutant_bodypart = "wings"
	main_feature_name = "Wings"
	/// This determines, when generating side sprites, if we should include a body.
	var/include_body = FALSE
	/// This determines, when generating side sprites, what direction the sprite is set.
	var/direction = EAST
	/// This determines, when generating side sprites, what position is set.
	var/position = "BEHIND"

/datum/preference/choiced/mutant_choice/body/init_possible_values()
	return generate_body_side_shots(GLOB.sprite_accessories[relevant_mutant_bodypart], relevant_mutant_bodypart, include_body, direction, position)

//TAILS
/datum/preference/choiced/mutant_choice/body/tail
	savefile_key = "feature_tail"
	relevant_mutant_bodypart = "tail"
	main_feature_name = "Tail"
*/
