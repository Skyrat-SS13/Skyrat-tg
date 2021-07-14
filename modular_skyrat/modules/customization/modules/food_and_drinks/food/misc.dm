//For miscellaneous foods

//cytology mobs butcher results
/obj/item/food/grown/grapes/ooze
	seed = /obj/item/seeds/grape/green
	name = "bunch of oozing grapes"
	icon_state = "greengrapes"
	bite_consumption_mod = 3
	tastes = list("gelatinous grape" = 1)
	distill_reagent = /datum/reagent/toxin/slimejelly

/obj/item/food/octopusrings
	name = "tentacle rings"
	desc = "tentacle slices coated in batter."
	icon_state = "onionrings"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/virus_food = 1)
	gender = PLURAL
	tastes = list("batter" = 3, "viscous tentacle" = 1)
	foodtypes = MEAT | TOXIC
	w_class = WEIGHT_CLASS_SMALL
//
