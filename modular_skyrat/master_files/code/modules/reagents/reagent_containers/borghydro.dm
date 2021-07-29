
/obj/item/reagent_containers/borghypo/hacked
	icon_state = "borghypo_s"
	reagent_ids = list (/datum/reagent/toxin/acid/fluacid, /datum/reagent/toxin/mutetoxin, /datum/reagent/toxin/cyanide, /datum/reagent/toxin/sodium_thiopental_lesser, /datum/reagent/toxin/heparin, /datum/reagent/toxin/lexorin)
	accepts_reagent_upgrades = FALSE

/obj/item/reagent_containers/borghypo/syndicate
	name = "syndicate cyborg hypospray"
	desc = "An experimental piece of Syndicate technology used to produce powerful restorative nanites used to very quickly restore injuries of all types. Also metabolizes potassium iodide for radiation poisoning, inacusiate for ear damage and morphine for offense."
	icon_state = "borghypo_s"
	charge_cost = 20
	recharge_time = 2
	reagent_ids = list(
		/datum/reagent/medicine/lesser_syndicate_nanites,
		/datum/reagent/medicine/inacusiate,
		/datum/reagent/medicine/potass_iodide,
		/datum/reagent/medicine/morphine,
	)
	bypass_protection = TRUE
	accepts_reagent_upgrades = FALSE
