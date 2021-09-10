/obj/item/storage/fancy/cigarettes/cigars/lyricalpaws
	name = "Bright Cosmos cigar case"
	desc = "A case of imported Bright Cosmos cigars, very hard to find usually. Renowned for their quick dispersal smoke, strong taste, and \"bigger on the inside\" cases."
	icon_state = "cohibacase"
	base_icon_state = "cohibacase"
	spawn_type = /obj/item/clothing/mask/cigarette/cigar/lyricalpaws
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/cigarette/cigar/lyricalpaws
	name = "Bright Cosmos cigar"
	desc = "Per aspera ad astra."
	icon_state = "cigar2off"
	icon_on = "cigar2on"
	icon_off = "cigar2off"
	smoketime = 30 MINUTES
	chem_volume = 50
	list_reagents =list(/datum/reagent/drug/nicotine = 15, /datum/reagent/consumable/menthol = 7)
	pollution_type = /datum/pollutant/bright_cosmos
	lung_harm = 0
