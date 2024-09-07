/obj/item/clothing/shoes/cult
<<<<<<< HEAD
	name = "\improper Nar'Sien invoker boots"
=======
	name = "\improper Nar'Sian boots"
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	desc = "A pair of boots worn by the followers of Nar'Sie."
	icon_state = "cult"
	inhand_icon_state = null
	cold_protection = FEET
	min_cold_protection_temperature = SHOES_MIN_TEMP_PROTECT
	heat_protection = FEET
	max_heat_protection_temperature = SHOES_MAX_TEMP_PROTECT
	lace_time = 10 SECONDS

/obj/item/clothing/shoes/cult/alt
<<<<<<< HEAD
	name = "cultist boots"
=======
	name = "\improper Nar'Sian invoker boots"
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	icon_state = "cultalt"

/obj/item/clothing/shoes/cult/alt/ghost
	item_flags = DROPDEL

/obj/item/clothing/shoes/cult/alt/ghost/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CULT_TRAIT)
