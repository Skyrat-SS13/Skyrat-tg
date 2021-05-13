/obj/item/kitchen/knife/hotknife
	name = "thousand degree knife"
	icon = 'modular_skyrat/modules/additionalert/pizza/icons/obj/hotknife.dmi'
	icon_state = "hotknife"
	inhand_icon_state = "hotknife"
	desc = "Once upon a time known as Lightbringer, this sword has been demoted to a simple pizza cutting knife...It may still have it's fire attack powers."
	righthand_file = 'modular_skyrat/modules/additionalert/pizza/icons/obj/inhand/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/additionalert/pizza/icons/obj/inhand/lefthand.dmi'
/obj/item/kitchen/knife/hotknife/attack(mob/living/victim, mob/living/attacker, params)
	victim.adjust_fire_stacks(4)
	victim.IgniteMob()
	return ..()

/obj/item/choice_beacon/pizza
	name = "pizza delivery beacon"
	desc = "Summon a pizza box, service with a smile!"
	icon_state = "gangtool-white"

/obj/item/choice_beacon/pizza/generate_display_names()
	var/list/pizzabox = list()
	for(var/V in subtypesof(/obj/item/pizzabox))
		var/obj/item/pizzabox/A = V
		pizzabox[initial(A.theme_name)] = A
	return pizzabox

/obj/item/choice_beacon/pizza/spawn_option(obj/choice,mob/living/M)
	new choice(get_turf(M))
	to_chat(M, "<span class='hear'>You hear something crackle from the beacon for a moment before a voice speaks. \"Dogginos! Only the Barkiest of Pizza!</b> Message ends.\"</span>")

