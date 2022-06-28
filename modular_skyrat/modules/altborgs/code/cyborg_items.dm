/obj/item/katana/ninja_blade
	name = "energy katana"
	desc = "A katana infused with strong energy."
	force = 30
	icon_state = "energy_katana"
	inhand_icon_state = "energy_katana"
	worn_icon_state = "energy_katana"

/obj/item/shockpaddles/syndicate/cyborg/ninja
	name = "modified defibrillator paddles"
	icon = 'modular_skyrat/modules/altborgs/icons/robot_items.dmi'
	icon_state = "ninjapaddles0"
	base_icon_state = "ninjapaddles"

/obj/item/reagent_containers/borghypo/syndicate/ninja
	name = "modified cyborg hypospray"
	desc = "An experimental piece of technology used to produce powerful restorative nanites used to very quickly restore injuries of all types. metabolizes potassium iodide for radiation poisoning, inacusiate for ear damage and morphine for offense and nutriment for the operative in the field."
	icon = 'modular_skyrat/modules/altborgs/icons/robot_items.dmi'
	icon_state = "borghypo_n"
	charge_cost = 20
	recharge_time = 2
	default_reagent_types = list(
		/datum/reagent/medicine/syndicate_nanites,
		/datum/reagent/medicine/inacusiate,
		/datum/reagent/medicine/potass_iodide,
		/datum/reagent/medicine/morphine,
		/datum/reagent/consumable/nutriment //That is for Ninja.
	)
	bypass_protection = TRUE //They still wearing suits, don't they?

