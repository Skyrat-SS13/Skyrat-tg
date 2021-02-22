/obj/structure/reagent_dispensers/biomass
	name = "biomass storage"
	desc = "It is every citizen's final duty to go into the tanks, and to become one with all the people."
	icon = 'icons/obj/machines/ds13/bpl.dmi'
	icon_state = "tank"
	initial_capacity = 10000	//Approximately 100 litres capacity, based on 1u = 10ml = 0.01 litre
	initial_reagent_types = list(/datum/reagent/nutriment/biomass = 0.01)

	density = TRUE
	anchored = TRUE

//Can only absorb what biomass is within it
/obj/structure/reagent_dispensers/biomass/can_harvest_biomass()
	if (reagents.get_reagent_amount(/datum/reagent/nutriment/biomass) > 0)
		return MASS_ACTIVE
	else
		return MASS_FAIL

/obj/structure/reagent_dispensers/biomass/harvest_biomass(var/ticks = 1)
	var/target_biomass = ticks * BIOMASS_HARVEST_ACTIVE
	var/target_reagent = target_biomass * BIOMASS_TO_REAGENT
	var/amount_removed = reagents.remove_reagent(/datum/reagent/nutriment/biomass, target_reagent)
	return amount_removed * REAGENT_TO_BIOMASS