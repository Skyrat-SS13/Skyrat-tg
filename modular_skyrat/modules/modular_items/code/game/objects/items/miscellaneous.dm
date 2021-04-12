/obj/item/hammer/makeshift
	name = "makeshift hammer"
	desc = "A makeshift hammer, flimsily constructed with miscellaneous parts."
	icon = 'modular_skyrat/modules/modular_items/icons/obj/items/tools.dmi'
	icon_state = "makeshift_hammer"
	force = 2
	throwforce = 3
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/food/monkeycube/beno
	name = "alien cube"
	desc = "Don't let corporate crooks slip this into your lunch."
	tastes = list("the jungle" = 1, "acid" = 1)
	spawned_mob = /mob/living/carbon/alien/humanoid/hunter //This is catatonic.

/obj/item/skillchip/fastclimb
	name = "Ladder Lover skillchip"
	auto_traits = list(TRAIT_FASTCLIMB)
	skill_name = "FastClimbing"
	skill_description = "Allows you to accend and decend at speeds never known before! Impress your slower friends!."
	skill_icon = "swimming-pool"
	activate_message = "<span class='notice'>You feel like you can take it two rungs at a time!.</span>"
	deactivate_message = "<span class='notice'>You give up on your dreams of being a fireman.</span>"
