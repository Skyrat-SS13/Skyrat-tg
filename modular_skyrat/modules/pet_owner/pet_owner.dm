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
	customization_options = list(/datum/preference/choiced/pet_owner)

/datum/quirk/item_quirk/pet_owner/add_unique(client/client_source)
	var/desired_pet = client_source?.prefs.read_preference(/datum/preference/choiced/pet_owner) || "Random"

	if(desired_pet != "Random")
		pet_type = GLOB.possible_player_pet[desired_pet]

	if(pet_type == NONE) // Pet not set, we're picking one for them.
		pet_type = pick(flatten_list(GLOB.possible_player_pet))

	var/obj/item/pet_carrier/carrier = new /obj/item/pet_carrier/pet_owner
	var/mob/living/simple_animal/pet/pet = new pet_type(carrier)
	carrier.add_occupant(pet)
	give_item_to_holder(
		carrier,
		list(
			LOCATION_HANDS = ITEM_SLOT_HANDS,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
		),
		flavour_text = "Looks tightly packed - you might not be able to put the pet back in once they're out.",
	)

/datum/preference/choiced/pet_owner
	category = PREFERENCE_CATEGORY_MANUALLY_RENDERED
	savefile_key = "pet_owner"
	savefile_identifier = PREFERENCE_CHARACTER
	can_randomize = FALSE

GLOBAL_LIST_INIT(possible_player_pet, list(
	"Cat" = /mob/living/simple_animal/pet/cat,
	"Space cat" = /mob/living/simple_animal/pet/cat/space,
	"Bread cat" = /mob/living/simple_animal/pet/cat/breadcat,
	"Kitten" = /mob/living/simple_animal/pet/cat/kitten,
	"Cake cat" = /mob/living/simple_animal/pet/cat/cak,
	"Parrot" = /mob/living/simple_animal/parrot/natural,
	"Corgi puppy" = /mob/living/basic/pet/dog/corgi/puppy,
	"Void puppy" = /mob/living/basic/pet/dog/corgi/puppy/void,
	"Corgi" = /mob/living/basic/pet/dog/corgi,
	"Pug" = /mob/living/basic/pet/dog/pug,
	"Bull terrier" = /mob/living/basic/pet/dog/bullterrier,
	"Dobermann" = /mob/living/basic/pet/dog/dobermann,
	"Fox" = /mob/living/basic/pet/fox/docile,
	"Penguin" = /mob/living/basic/pet/penguin/emperor/neuter,
	"Baby Penguin" = /mob/living/basic/pet/penguin/baby/permanent,
	"White chinchilla" = /mob/living/basic/pet/chinchilla/white,
	"Dark chinchilla" = /mob/living/basic/pet/chinchilla/black,
	"Deer" = /mob/living/basic/deer,
	"Pig" = /mob/living/basic/pig,
	"Rabbit" = /mob/living/basic/rabbit,
	"Chick" = /mob/living/basic/chick/permanent,
	"Chicken" = /mob/living/basic/chicken,
	"Sloth" = /mob/living/basic/sloth,
	"Giant ant" = /mob/living/basic/ant,
	"Space carp" = /mob/living/basic/carp/pet,
	"Snake" = /mob/living/basic/snake,
	"Spider" = /mob/living/basic/spider/maintenance,
	"Axolotl" = /mob/living/basic/axolotl,
	"Butterfly" = /mob/living/basic/butterfly,
	"Cockroach" = /mob/living/basic/cockroach,
	"Crab" = /mob/living/basic/crab,
	"Frog" = /mob/living/basic/frog,
	"Space lizard" = /mob/living/basic/lizard/space,
	"Tegu" = /mob/living/basic/lizard/tegu,
	"Mothroach" = /mob/living/basic/mothroach,
	"White mouse" = /mob/living/basic/mouse/white,
	"Gray mouse" = /mob/living/basic/mouse/gray,
	"Brown mouse" = /mob/living/basic/mouse/brown,
	"Bat" = /mob/living/basic/bat,
	"Kiwi" = /mob/living/basic/kiwi,
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

/obj/item/pet_carrier/pet_owner
	name = "miniature pet carrier"
	desc = "A small white-and-blue pet carrier, made for transporting pets on shuttles."
	w_class = WEIGHT_CLASS_NORMAL
	max_occupants = 1 //Quirk pet carriers only get one pet.
