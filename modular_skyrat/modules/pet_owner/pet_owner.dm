/datum/quirk/item_quirk/pet_owner
	name = "Pet Owner"
	desc = "You bring your pet to work with you so that it, too, can experience the dangers of station life."
	icon = FA_ICON_HORSE
	value = 4
	mob_trait = TRAIT_PET_OWNER
	veteran_only = TRUE
	gain_text = span_notice("You brought your pet with you to work.")
	lose_text = span_danger("You feel lonely, as if leaving somebody behind...")
	medical_record_text = "Patient mentions their fondness for their pet."
	mail_goodies = list(
		/obj/item/clothing/neck/petcollar
	)
	var/pet_type = NONE

/datum/quirk_constant_data/pet_owner
	associated_typepath = /datum/quirk/item_quirk/pet_owner
	customization_options = list(/datum/preference/choiced/pet_owner, /datum/preference/text/pet_name, /datum/preference/text/pet_desc)

/datum/quirk/item_quirk/pet_owner/add_unique(client/client_source)
	var/desired_pet = client_source?.prefs.read_preference(/datum/preference/choiced/pet_owner) || "Random"

	if(desired_pet != "Random")
		pet_type = GLOB.possible_player_pet[desired_pet]

	if(pet_type == NONE) // Pet not set, we're picking one for them.
		pet_type = pick(flatten_list(GLOB.possible_player_pet))

	var/obj/item/pet_carrier/carrier = new /obj/item/pet_carrier(get_turf(quirk_holder))
	var/mob/living/basic/pet/pet = new pet_type(carrier)
	var/new_name = client_source?.prefs.read_preference(/datum/preference/text/pet_name)
	if (new_name)
		pet.name = new_name
	var/new_desc = client_source?.prefs.read_preference(/datum/preference/text/pet_desc)
	if (new_desc)
		pet.desc = new_desc
	carrier.add_occupant(pet)
	give_item_to_holder(
		carrier,
		list(
			LOCATION_HANDS = ITEM_SLOT_HANDS
		),
		flavour_text = "Looks tightly packed - you might not be able to put the pet back in once they're out.",
	)

/datum/preference/choiced/pet_owner
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "pet_owner"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

GLOBAL_LIST_INIT(possible_player_pet, list(
	"Axolotl" = /mob/living/basic/axolotl,
	"Baby Penguin" = /mob/living/basic/pet/penguin/baby/permanent,
	"Bat" = /mob/living/basic/bat,
	"Bull terrier" = /mob/living/basic/pet/dog/bullterrier,
	"Butterfly" = /mob/living/basic/butterfly,
	"Cat" = /mob/living/basic/pet/cat,
	"Cat (Clown)" = /mob/living/basic/pet/cat/clown,
	"Cat (Mime)" = /mob/living/basic/pet/cat/mime,
	"Carp" = /mob/living/basic/carp/petcarp,
	"Carp (Clown)" = /mob/living/basic/carp/clarp,
	"Chick" = /mob/living/basic/chick/permanent,
	"Chicken" = /mob/living/basic/chicken,
	"Chinchilla (dark)" = /mob/living/basic/pet/chinchilla/black,
	"Chinchilla (white)" = /mob/living/basic/pet/chinchilla/white,
	"Corgi" = /mob/living/basic/pet/dog/corgi,
	"Corgi puppy" = /mob/living/basic/pet/dog/corgi/puppy,
	"Cockroach" = /mob/living/basic/cockroach,
	"Crab" = /mob/living/basic/crab,
	"Deer" = /mob/living/basic/deer,
	"Dobermann" = /mob/living/basic/pet/dog/dobermann,
	"Fennec" = /mob/living/basic/pet/cat/fennec,
	"Fox" = /mob/living/basic/pet/fox/docile,
	"Frog" = /mob/living/basic/frog,
	"Giant ant" = /mob/living/basic/ant,
	"Kitten" = /mob/living/basic/pet/cat/kitten,
	"Kiwi" = /mob/living/basic/kiwi,
	"Mothroach" = /mob/living/basic/mothroach,
	"Mouse (white)" = /mob/living/basic/mouse/white,
	"Mouse (gray)" = /mob/living/basic/mouse/gray,
	"Mouse (brown)" = /mob/living/basic/mouse/brown,
	"Penguin" = /mob/living/basic/pet/penguin/emperor/neuter,
	"Pitbull" = /mob/living/basic/pet/dog/pitbull,
	"Pig" = /mob/living/basic/pig,
	"Pug" = /mob/living/basic/pet/dog/pug,
	"Rabbit" = /mob/living/basic/rabbit,
	"Red Panda" = /mob/living/basic/pet/fox/redpanda,
	"Sloth" = /mob/living/basic/sloth,
	"Snake" = /mob/living/basic/snake,
	"Spider" = /mob/living/basic/spider/maintenance,
	"Tegu" = /mob/living/basic/lizard/tegu,
	"Tiger" = /mob/living/basic/pet/cat/tiger,
)) //some of these are too big to be put back into the pet carrier once taken out, so I put a warning on the carrier.

/datum/preference/choiced/pet_owner/init_possible_values()
	return list("Random") + assoc_to_keys(GLOB.possible_player_pet)

/datum/preference/choiced/pet_owner/create_default_value()
	return "Random"

/datum/preference/choiced/pet_owner/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Pet Owner" in preferences.all_quirks

/datum/preference/choiced/pet_owner/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/text/pet_name
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "pet_name"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE
	maximum_value_length = 32

/datum/preference/text/pet_name/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Pet Owner" in preferences.all_quirks

/datum/preference/text/pet_name/serialize(input)
	return htmlrendertext(input)

/datum/preference/text/pet_name/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/text/pet_desc
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "pet_desc"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

/datum/preference/text/pet_desc/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	return "Pet Owner" in preferences.all_quirks

/datum/preference/text/pet_desc/serialize(input)
	return htmlrendertext(input)

/datum/preference/text/pet_desc/apply_to_human(mob/living/carbon/human/target, value)
	return
