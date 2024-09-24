/obj/item/hilbertshotel/ghostdojo
	name = "infinite dormitories"
	anchored = TRUE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND

/obj/item/hilbertshotel/ghostdojo/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	return promptAndCheckIn(user, user)

// borgos need love too
/obj/item/hilbertshotel/ghostdojo/attack_robot(mob/living/user)
	attack_hand(user)

/datum/map_template/ghost_cafe_rooms/apartment
	name = "Apartment"
	mappath = "modular_skyrat/modules/hotel_rooms/apartment.dmm"

/datum/map_template/ghost_cafe_rooms/beach_condo
	name = "Beach Condo"
	mappath = "modular_skyrat/modules/hotel_rooms/beach_condo.dmm"

/datum/map_template/ghost_cafe_rooms/stationside
	name = "Station Side"
	mappath = "modular_skyrat/modules/hotel_rooms/stationside.dmm"

/datum/map_template/ghost_cafe_rooms/library
	name = "Library"
	mappath = "modular_skyrat/modules/hotel_rooms/library.dmm"
