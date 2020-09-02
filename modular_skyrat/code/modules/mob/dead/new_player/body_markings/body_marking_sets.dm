/datum/body_marking_set
	///The preview name of the body marking set. HAS to be unique
	var/name
	///List of the body markings in this set
	var/body_marking_list
	///Which species is this marking recommended to. Important for randomisations.
	var/recommended_species

/datum/body_marking_set/none
	name = "None"
	body_marking_list = list()

/datum/body_marking_set/tajaran
	name = "Tajaran"
	body_marking_list = list("Tajaran")

/datum/body_marking_set/sergal
	name = "Sergal"
	body_marking_list = list("Sergal")

/datum/body_marking_set/husky
	name = "Husky"
	body_marking_list = list("Husky")

/datum/body_marking_set/fennec
	name = "Fennec"
	body_marking_list = list("Fennec")

/datum/body_marking_set/redpanda
	name = "Red Panda"
	body_marking_list = list("Red Panda", "Red Panda Head")

/datum/body_marking_set/dalmatian
	name = "Dalmatian"
	body_marking_list = list("Dalmatian")

/datum/body_marking_set/shepherd
	name = "Shepherd"
	body_marking_list = list("Shepherd", "Shepherd Spot")

/datum/body_marking_set/wolf
	name = "Wolf"
	body_marking_list = list("Wolf", "Wolf Spot")

/datum/body_marking_set/raccoon
	name = "Raccoon"
	body_marking_list = list("Raccoon")

/datum/body_marking_set/bovine
	name = "Bovine"
	body_marking_list = list("Bovine", "Bovine Spot")

/datum/body_marking_set/possum
	name = "Possum"
	body_marking_list = list("Possum")
	
/datum/body_marking_set/corgi
	name = "Corgi"
	body_marking_list = list("Corgi")

/datum/body_marking_set/skunk
	name = "Skunk"
	body_marking_list = list("Skunk")

/datum/body_marking_set/panther
	name = "Panther"
	body_marking_list = list("Panther")

/datum/body_marking_set/tiger
	name = "Tiger"
	body_marking_list = list("Tiger Spot", "Tiger Stripe")
	
/datum/body_marking_set/otter
	name = "Otter"
	body_marking_list = list("Otter", "Otter Head")

/datum/body_marking_set/otie
	name = "Otie"
	body_marking_list = list("Otie", "Otie Spot")

/datum/body_marking_set/sabresune
	name = "Sabresune"
	body_marking_list = list("Sabresune")

/datum/body_marking_set/orca
	name = "Orca"
	body_marking_list = list("Orca")
	
/datum/body_marking_set/hawk
	name = "Hawk"
	body_marking_list = list("Hawk", "Hawk Talon")

/datum/body_marking_set/corvid
	name = "Corvid"
	body_marking_list = list("Corvid", "Corvid Talon")

/datum/body_marking_set/eevee
	name = "Eevee"
	body_marking_list = list("Eevee")

/datum/body_marking_set/deer
	name = "Deer"
	body_marking_list = list("Deer", "Deer Hoof")

/datum/body_marking_set/hyena
	name = "Hyena"
	body_marking_list = list("Hyena", "Hyena Side")

/datum/body_marking_set/dog
	name = "Dog"
	body_marking_list = list("Dog", "Dog Spot")

/datum/body_marking_set/bat
	name = "Bat"
	body_marking_list = list("Bat Mark", "Bat")

/datum/body_marking_set/goat
	name = "Goat"
	body_marking_list = list("Goat Hoof")
