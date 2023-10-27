/obj/item/hilbertshotel/ghostdojo
	name = "infinite dormitories"
	anchored = TRUE

/obj/item/hilbertshotel/ghostdojo/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	return promptAndCheckIn(user, user)

// borgos need love too
/obj/item/hilbertshotel/ghostdojo/attack_robot(mob/living/user)
	attack_hand(user)

/datum/map_template/ghost_cafe_rooms
	name = "Apartment"
	mappath = "modular_skyrat/modules/hotel_rooms/apartment.dmm"
