/obj/item/hilbertshotel/ghostdojo
	name = "Infinite Dormitories"
	anchored = TRUE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND

/obj/item/hilbertshotel/ghostdojo/interact(mob/user)
	. = ..()
	promptAndCheckIn(user)
