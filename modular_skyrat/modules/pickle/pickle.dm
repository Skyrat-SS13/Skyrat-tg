/mob/living/simple_animal/pickle
	name = "pickle"
	desc = "It's a pickle. It might just be the funniest thing you have ever seen."
	health = 100
	maxHealth = 100
	icon = 'modular_skyrat/modules/pickle/pickle.dmi'
	icon_state = "pickle"
	del_on_death = TRUE
	deathmessage = "The pickle implodes into its own existential dread and disappears!"
	friendly_verb_continuous = "tickles"
	friendly_verb_simple = "tickle"

/mob/living/simple_animal/pickle/UnarmedAttack(atom/A)
	..() //we want the tickle emote to go before the laugh
	if(ismob(A))
		var/mob/laugher = A
		laugher.emote("laugh")
