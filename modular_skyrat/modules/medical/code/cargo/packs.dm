/datum/supply_pack/science/synthetic_burns
	name = "Synthetic Burns Kit"
	desc = "Contains bottles of pre-chilled hercuri and dinitrogen plasmide, perfect for treating synthetic burns!"
	cost = CARGO_CRATE_VALUE * 2.5
	contains = list(/obj/item/reagent_containers/spray/hercuri/chilled = 3, /obj/item/reagent_containers/spray/dinitrogen_plasmide = 3)
	crate_name = "chilled hercuri crate"

	access_view = FALSE
	access = FALSE
	access_any = FALSE

/datum/supply_pack/science/synth_treatment_kits
	name = "Synthetic Treatment Kits"
	desc = "Contains 2 treatment kits for synthetic lifeforms, filled with everything you need to treat an inorganic wound!"
	cost = CARGO_CRATE_VALUE * 4.5
	contains = list(/obj/item/storage/backpack/duffelbag/synth_treatment_kit = 2)
	crate_name = "synthetic treatment kits crate"

	access_view = FALSE
	access = FALSE
	access_any = FALSE

/datum/supply_pack/science/synth_healing_chems
	name = "Synthetic Medicine Pack"
	desc = "Contains a variety of synthetic-exclusive medicine. 2 pill bottles of liquid solder, 2 of nanite slurry, 2 of system cleaner."
	cost = CARGO_CRATE_VALUE * 7 // rarely made, so it should be expensive(?)
	contains = list(
		/obj/item/storage/pill_bottle/liquid_solder = 2,
		/obj/item/storage/pill_bottle/nanite_slurry = 2,
		/obj/item/storage/pill_bottle/system_cleaner = 2
	)
	crate_name = "synthetic medicine crate"

	access_view = FALSE
	access = FALSE
	access_any = FALSE

/datum/supply_pack/science/synth_medkits
	name = "Mechanical Repair Kits"
	desc = "Contains a few low-grade portable synthetic medkits, useful for distributing to the crew."
	cost = CARGO_CRATE_VALUE * 4.5 // same as treatment kits
	contains = list(/obj/item/storage/medkit/mechanical/regular = 4)

	crate_name = "synthetic repair kits crate"

	access_view = FALSE
	access = FALSE
	access_any = FALSE

/datum/supply_pack/goody/mechanical_repair_kit_single
	name = "Mechanical Repair Kit Single-Pack"
	desc = "A single mechanical repair kit, fit for fixing most robotic injuries."
	cost = PAYCHECK_CREW * 3
	contains = list(/obj/item/storage/medkit/mechanical/regular)
