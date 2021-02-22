/datum/reagent/nutriment/biomass
	name = "Purified Biomass"
	description = "A pasteurised organic soup for providing nutrition to growth tanks in clinical settings. \
	Technically safe for human consumption, but the taste is horrible."
	taste_mult = 10
	reagent_state = LIQUID
	metabolism = REM * 4
	nutriment_factor = 0.1 // Per unit
	injectable = 0
	color = COLOR_BIOMASS_GREEN


/datum/reagent/nutriment/stemcells
	name = "Stem Cells"
	description = "Partially differentiated cells that can be used as a baseline to grow various limbs and organs"
	taste_mult = 10
	reagent_state = LIQUID
	metabolism = REM * 4
	nutriment_factor = 0.1 // Per unit
	injectable = 0
	color = COLOR_PINK


/obj/item/weapon/reagent_containers/glass/bottle/stemcells
	name = "Stem Cell Clinical Sample"
	desc = "The essence of life"
	icon_state = "bottle-4"
	New()
		..()
		reagents.add_reagent(/datum/reagent/nutriment/stemcells, 10)