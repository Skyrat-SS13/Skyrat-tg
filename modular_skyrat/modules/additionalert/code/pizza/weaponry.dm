/obj/item/knife/hotknife
	name = "thousand degree knife"
	icon = 'modular_skyrat/modules/additionalert/icons/pizza/hotknife.dmi'
	icon_state = "hotknife"
	inhand_icon_state = "hotknife"
	desc = "Once upon a time known as Lightbringer, this sword has been demoted to a simple pizza cutting knife...It may still have it's fire attack powers."
	righthand_file = 'modular_skyrat/modules/additionalert/icons/pizza/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/additionalert/icons/pizza/lefthand.dmi'

/obj/item/knife/hotknife/attack(mob/living/victim, mob/living/attacker, params)
	victim.adjust_fire_stacks(4)
	victim.IgniteMob()
	return ..()



