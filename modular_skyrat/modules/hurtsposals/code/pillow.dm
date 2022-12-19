// A trait which gets added when wearing the pillowsuit, so hurtsposals doesn't hurt
// Can be used for other bodypadding safety stuff
/obj/item/clothing/suit/pillow_suit/equipped(mob/user, slot)
	. = ..()
	ADD_TRAIT(user, TRAIT_PADDED, CLOTHING_TRAIT)

/obj/item/clothing/suit/pillow_suit/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(user, TRAIT_PADDED, CLOTHING_TRAIT)
