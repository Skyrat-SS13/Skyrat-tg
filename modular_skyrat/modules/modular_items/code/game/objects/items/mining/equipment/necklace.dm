//ASHWALKER TRANSLATOR NECKLACE//
/obj/item/clothing/neck/necklace/ashwalker
	name = "Draconic Necklace"
	desc = "A necklace forged in the raging fires of lavaland, grants the ability to speak Dracnoic while worn or held."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "ashnecklace"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "ashnecklace"
	w_class = WEIGHT_CLASS_SMALL //allows this to fit inside of pockets.

/obj/item/clothing/neck/necklace/ashwalker/equipped(mob/user, slot)
	user.grant_language(/datum/language/draconic)
/obj/item/clothing/neck/necklace/ashwalker/dropped(mob/user, slot)
	user.remove_language(/datum/language/draconic)
//ASHWALKER TRANSLATOR NECKLACE END//
