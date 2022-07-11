/obj/item/bloodcrawlbottle
	name = "bloodlust in a bottle"
	desc = "Drinking this will give you unimaginable powers... and mildly disgust you because of it's metallic taste."
	icon = 'icons/obj/wizard.dmi'
	icon_state = "vial"

/obj/item/bloodcrawlbottle/attack_self(mob/user)
	to_chat(user, span_notice("You drink the bottle's contents."))
	var/datum/action/cooldown/spell/jaunt/bloodcrawl/new_spell =  new ()
	new_spell.Grant(user)
	user.log_message("learned the spell bloodcrawl ([new_spell])", LOG_ATTACK, color="orange")
	qdel(src)
