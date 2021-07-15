//ASHWALKER TRANSLATOR NECKLACE//
#define LANGUAGE_TRANSLATOR "translator"
/obj/item/clothing/neck/necklace/ashwalker
	name = "Draconic Necklace"
	desc = "A necklace forged in the raging fires of lavaland, grants the ability to speak Dracnoic while worn"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	icon_state = "ashnecklace"
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "ashnecklace"
	var/innate = FALSE
	w_class = WEIGHT_CLASS_SMALL //allows this to fit inside of pockets.

//uses code from the pirate hat.
/obj/item/clothing/neck/necklace/ashwalker/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	if(slot == ITEM_SLOT_NECK)
		user.grant_language(/datum/language/draconic/, TRUE, TRUE, LANGUAGE_TRANSLATOR)
		to_chat(user, span_boldnotice("Knowledge of the Draconic language floods through your mind"))

/obj/item/clothing/neck/necklace/ashwalker/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(ITEM_SLOT_NECK) == src && !QDELETED(src)) //This can be called as a part of destroy
		user.remove_language(/datum/language/draconic/, TRUE, TRUE, LANGUAGE_TRANSLATOR)
		to_chat(user, span_boldnotice("You find your newly gained knowledge of Draconic tongue gone."))

//ASHWALKER TRANSLATOR NECKLACE END//
