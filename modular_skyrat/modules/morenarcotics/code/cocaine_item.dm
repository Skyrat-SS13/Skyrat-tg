/obj/item/food/drug/puffpowder
	name = "odious puffpowder"
	desc = "The cap of an odious puffball with a cocktail of other chemicals mixed into it.\nWhile the powder could be consumed for its slight medicinal properties, its usual use comes from baking it, but you'd never do that right?"
	icon = 'modular_skyrat/modules/morenarcotics/icons/drug_items.dmi'
	icon_state = "puffball_powder"
	food_reagents = list(
		/datum/reagent/toxin/spore = 10,
		/datum/reagent/impurity/healing/medicine_failure = 10,
		/datum/reagent/toxin/heparin = 5,
	)
	tastes = list("rotting mushroom" = 3, "chalk" = 2)

/obj/item/food/drug/puffpowder/MakeBakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/drug/smarts, rand(45 SECONDS, 2 MINUTES), TRUE, TRUE)

/obj/item/food/drug/puffpowder/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if (..()) // was it caught by a mob?
		return

	var/turf/hit_turf = get_turf(hit_atom)
	new /obj/effect/decal/cleanable/food/flour(hit_turf) // No, flour

	var/datum/effect_system/fluid_spread/smoke/chem/smoke = new ()
	var/poof_location = get_turf(hit_turf)
	smoke.attach(poof_location)
	smoke.set_up(range = 2, holder = src, location = poof_location, carry = src.reagents, silent = FALSE)
	smoke.start(log = TRUE)

	qdel(src)

/datum/chemical_reaction/puffpowder
	required_reagents = list(/datum/reagent/toxin/spore = 10, /datum/reagent/lye = 5)
	mob_react = FALSE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING

/datum/chemical_reaction/puffpowder/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/iteration in 1 to created_volume)
		var/obj/item/food/drug/puffpowder/new_powda = new(location)
		new_powda.pixel_x = rand(-6, 6)
		new_powda.pixel_y = rand(-6, 6)

// Refined version of odious puffpowder

/obj/item/food/drug/smarts
	name = "SMARTs brick"
	desc = "A condensed brick of SMARTs, a drug capable of vastly increasing the learning skills of whoever takes it.\nThough, you should probably cut it into smaller pieces first."
	icon = 'modular_skyrat/modules/morenarcotics/icons/drug_items.dmi'
	icon_state = "smarts_block"
	food_reagents = list(
		/datum/reagent/toxin/spore = 20,
		/datum/reagent/impurity/healing/medicine_failure = 20,
		/datum/reagent/toxin/heparin = 20,
		/datum/reagent/drug/maint/powder = 20, // If you eat the entire brick you WILL overdose
	)
	tastes = list("burnt mushroom" = 7, "chalk" = 3, "regret" = 2)

/obj/item/food/drug/smarts/MakeProcessable()
	AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, yield, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")
	AddElement(/datum/element/processable, TOOL_SAW, slice_type, yield, 4 SECONDS, table_required = TRUE, screentip_verb = "Slice")

/obj/item/food/drug/smarts/slice
	name = "SMARTs slice"
	desc = "A thin slice of SMARTs, a drug capable of vastly increasing the learning skills of whoever takes it."
	icon_state = "smarts_slice"
	food_reagents = list(
		/datum/reagent/toxin/spore = 5,
		/datum/reagent/impurity/healing/medicine_failure = 5,
		/datum/reagent/toxin/heparin = 5,
		/datum/reagent/drug/maint/powder = 5,
	)
	tastes = list("burnt mushroom" = 3, "chalk" = 1)
