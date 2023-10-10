// Machine that makes water and nothing else

/obj/machinery/plumbing/synthesizer/water_synth
	name = "water synthesizer"
	desc = "An infinitely useful device for those finding themselves in a frontier without a stable source of water. \
		Using a simplified version of the chemistry dispenser's synthesizer process, it can create water out of nothing \
		but good old electricity."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "water_synth"
	dispensable_reagents = list(
		/datum/reagent/water,
	)

/obj/machinery/plumbing/synthesizer/water_synth/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

// Machine that makes botany nutrients for hydroponics farming

/obj/machinery/plumbing/synthesizer/water_synth/hydroponics
	name = "hydroponics chemical synthesizer"
	desc = "An infinitely useful device for those finding themselves in a frontier without a stable source of nutrients for crops. \
		Using a simplified version of the chemistry dispenser's synthesizer process, it can create hydroponics nutrients out of nothing \
		but good old electricity."
	icon_state = "hydro_synth"
	dispensable_reagents = list(
		/datum/reagent/plantnutriment/eznutriment,
		/datum/reagent/plantnutriment/left4zednutriment,
		/datum/reagent/plantnutriment/robustharvestnutriment,
		/datum/reagent/plantnutriment/endurogrow,
		/datum/reagent/plantnutriment/liquidearthquake,
		/datum/reagent/toxin/plantbgone/weedkiller,
		/datum/reagent/toxin/pestkiller,
	)

// Chem dispenser with a limited range of thematic reagents to dispense

/obj/machinery/chem_dispenser/frontier_appliance
	name = "sustenance dispenser"
	desc = "Creates and dispenses a small pre-defined set of chemicals and other liquids for the convenience of those typically on the frontier. \
		While the machine is loved by many, it also has a reputation for making some of the worst coffees this side of the galaxy. Use at your own risk."
	icon = 'modular_skyrat/modules/colony_fabricator/icons/chemistry_machines.dmi'
	icon_state = "dispenser"
	base_icon_state = "dispenser"
	pass_flags = PASSTABLE
	anchored_tabletop_offset = 4
	anchored = FALSE
	circuit = null
	powerefficiency = 0.25
	recharge_amount = 20
	show_ph = FALSE
	base_reagent_purity = 0.5
	// God's strongest coffee machine
	dispensable_reagents = list(
		/datum/reagent/water,
		/datum/reagent/consumable/powdered_milk,
		/datum/reagent/consumable/sugar,
		/datum/reagent/consumable/powdered_lemonade,
		/datum/reagent/consumable/powdered_coco,
		/datum/reagent/consumable/powdered_coffee,
		/datum/reagent/consumable/powdered_tea,
		/datum/reagent/consumable/vanilla,
		/datum/reagent/consumable/sugar,
		/datum/reagent/consumable/caramel,
		/datum/reagent/consumable/honey,
		/datum/reagent/consumable/korta_nectar,
		/datum/reagent/consumable/korta_milk,
		/datum/reagent/consumable/astrotame,
		/datum/reagent/consumable/salt,
		/datum/reagent/consumable/nutraslop,
	)
	/// Since we don't have a board to take from, we use this to give the dispenser a cell on spawning
	var/cell_we_spawn_with = /obj/item/stock_parts/cell/super/empty

/obj/machinery/chem_dispenser/frontier_appliance/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)
	cell = new cell_we_spawn_with(src)

/obj/machinery/chem_dispenser/frontier_appliance/display_beaker()
	var/mutable_appearance/overlayed_beaker = beaker_overlay || mutable_appearance(icon, "disp_beaker")
	return overlayed_beaker

/obj/machinery/chem_dispenser/frontier_appliance/RefreshParts()
	. = ..()
	powerefficiency = 0.25
	recharge_amount = 20

/obj/machinery/chem_dispenser/frontier_appliance/default_deconstruction_crowbar()
	return

/obj/machinery/chem_dispenser/frontier_appliance/pre_charged
	cell_we_spawn_with = /obj/item/stock_parts/cell/super
