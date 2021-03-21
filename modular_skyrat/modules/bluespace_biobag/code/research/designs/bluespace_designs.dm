/datum/design/biobag_holding
	name = "Bio Bag of Holding"
	desc = "A bag for the safe transportation and disposal of biowaste and other biological materials."
	id = "biobag_holding"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/gold = 250, /datum/material/uranium = 500) //quite cheap, for more convenience
	build_path = /obj/item/storage/bag/bio/bluespace
	category = list("Bluespace Designs")
	departmental_flags = DEPARTMENTAL_FLAG_SCIENCE
