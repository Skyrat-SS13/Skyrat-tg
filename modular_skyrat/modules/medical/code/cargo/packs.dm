/datum/supply_pack/science/chilled_hercuri
	name = "Chilled Hercuri Pack"
	desc = "Contains 2 pre-chilled bottles of hercuri, 100u each. Useful for dealing with severely burnt synthetics!"
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/reagent_containers/spray/hercuri/chilled = 2)

	crate_type = /obj/structure/closet/crate/medical
	crate_name = "chilled hercuri crate"

	access_view = FALSE
	access = FALSE
	access_any = FALSE

/datum/supply_pack/science/synth_treatment_kit
	name = "Synthetic Treatment Kit"
	desc = "Contains a treatment kit for synthetic lifeforms, filled to the brim with everything you need to treat an inorganic wound!"
	cost = CARGO_CRATE_VALUE * 5 // you pay a premium for getting everything all at once
	contains = list(/obj/item/storage/backpack/duffelbag/synth_treatment_kit = 1)

	crate_type = /obj/structure/closet/crate/medical
	crate_name = "synthetic trauma kit crate"

	access_view = FALSE
	access = FALSE
	access_any = FALSE

/datum/supply_pack/science/synth_healing_chems
	name = "Synthetic Medicine Pack"
	desc = "Contains a variety of synthetic-exclusive medicine. 2 pill bottles of liquid solder, 2 of nanite slurry, 2 of system cleaner."
	cost = CARGO_CRATE_VALUE * 7 // rarely made, so it should be expensive(?)
	contains = list(
		/obj/item/reagent_containers/pill/liquid_solder = 2,
		/obj/item/reagent_containers/pill/nanite_slurry = 2,
		/obj/item/reagent_containers/pill/system_cleaner = 2
	)

	crate_type = /obj/structure/closet/crate/medical
	crate_name = "synthetic medicine crate"

	access_view = FALSE
	access = FALSE
	access_any = FALSE
