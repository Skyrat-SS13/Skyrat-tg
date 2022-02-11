/obj/item/book/granter/martial/tribal_claw
	martial = /datum/martial_art/tribal_claw
	name = "old scroll"
	martialname = "tribal claw"
	desc = "A scroll filled with ancient draconic markings."
	greet = "<span class='sciradio'>You have learned the ancient martial art of the Tribal Claw! You are now able to use your tail and claws in a fight much better than before. \
	Check the combos you are now able to perform using the Recall Teachings verb in the Tribal Claw tab.</span>"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "scroll2"
	remarks = list("I must prove myself worthy to the masters of the Knoises clan...", "Use your tail to surprise any enemy...", "Your sharp claws can disorient them...", "I don't think this would combine with other martial arts...", "Ooga Booga...")

/obj/item/book/granter/martial/tribal_claw/onlearned(mob/living/carbon/user)
	..()
	if(!oneuse)
		return
	desc = "It's completely blank."
	name = "empty scroll"
	icon_state = "blankscroll"

/obj/item/book/granter/martial/tribal_claw/already_known(mob/user)
	if(islizard(user) || isunathi(user))
		return FALSE
	else
		to_chat(user, "<span class='warning'>You try to read the scroll but can't comprehend any of it.</span>")
		return TRUE
