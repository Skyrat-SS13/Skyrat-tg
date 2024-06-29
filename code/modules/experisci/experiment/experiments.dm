/datum/experiment/scanning/points/slime
	name = "Base Slime Experiment"
	required_points = 1

/datum/experiment/scanning/points/slime/hard
	name = "Challenging Slime Survey"
	description = "Another station has challenged your research team to collect several challenging slime cores, \
		are you up to the task?"
	required_points = 10
	required_atoms = list(/obj/item/slime_extract/bluespace = 1,
		/obj/item/slime_extract/sepia = 1,
		/obj/item/slime_extract/cerulean = 1,
		/obj/item/slime_extract/pyrite = 1,
		/obj/item/slime_extract/red = 2,
		/obj/item/slime_extract/green = 2,
		/obj/item/slime_extract/pink = 2,
		/obj/item/slime_extract/gold = 2)

/datum/experiment/scanning/points/slime/expert
	name = "Expert Slime Survey"
	description = "The intergalactic society of xenobiologists are currently looking for samples of the most complex \
		slime cores, we are tasking your station with providing them with everything they need."
	required_points = 10
	required_atoms = list(/obj/item/slime_extract/adamantine = 1,
		/obj/item/slime_extract/oil = 1,
		/obj/item/slime_extract/black = 1,
		/obj/item/slime_extract/lightpink = 1,
		/obj/item/slime_extract/rainbow = 10)

/datum/experiment/scanning/random/cytology/easy
	name = "Basic Cytology Scanning Experiment"
	description = "A scientist needs vermin to test on, use the cytology equipment to grow some of these simple critters!"
	total_requirement = 3
	max_requirement_per_type = 2
	possible_types = list(/mob/living/basic/cockroach, /mob/living/basic/mouse)

/datum/experiment/scanning/random/cytology/medium
	name = "Advanced Cytology Scanning Experiment"
	description = "We need to see how the body functions from the earliest moments. Some cytology experiments will help us gain this understanding."
	total_requirement = 3
	max_requirement_per_type = 2
	possible_types = list(
		/mob/living/basic/pet/cat,
		/mob/living/basic/carp,
		/mob/living/basic/chicken,
		/mob/living/basic/cow,
		/mob/living/basic/pet/dog/corgi,
		/mob/living/basic/snake,
	)

/datum/experiment/scanning/random/cytology/medium/one
	name = "Advanced Cytology Scanning Experiment One"

/datum/experiment/scanning/random/cytology/medium/two
	name = "Advanced Cytology Scanning Experiment Two"

/datum/experiment/scanning/random/janitor_trash
	name = "Station Hygiene Inspection"
	description = "To learn how to clean, we must first learn what it is to have filth. We need you to scan some filth around the station."
	possible_types = list(/obj/effect/decal/cleanable/vomit,
	/obj/effect/decal/cleanable/blood)
	total_requirement = 3

/datum/experiment/ordnance/explosive/lowyieldbomb
	name = "Low-Yield Explosives"
	description = "Low-yield explosives may prove useful for our asset protection teams. Capture a small explosion with a Doppler Array and publish the data in a paper."
	gain = list(10,15,20)
	target_amount = list(5,10,20)
	experiment_proper = TRUE
	sanitized_misc = FALSE
	sanitized_reactions = FALSE
	allow_any_source = TRUE

/datum/experiment/ordnance/explosive/highyieldbomb
	name = "High-Yield Explosives"
	description =  "Several reactions react very energetically and can be utilized for bigger explosives. Capture any tank explosion with a Doppler Array and publish the data in a paper. Any gas reaction is allowed."
	gain = list(10,50,100)
	target_amount = list(50,100,300)
	experiment_proper = TRUE
	sanitized_misc = FALSE
	sanitized_reactions = FALSE

/datum/experiment/ordnance/explosive/hydrogenbomb
	name = "Hydrogen Explosives"
	description = "Combustion of Hydrogen and it's derivatives can be very powerful. Capture any tank explosion with a Doppler Array and publish the data in a paper. Only Hydrogen or Tritium Fires are allowed."
	gain = list(15,40,60)
	target_amount = list(50,75,150)
	experiment_proper = TRUE
	sanitized_misc = TRUE
	sanitized_reactions = TRUE
	require_all = FALSE
	required_reactions = list(/datum/gas_reaction/h2fire, /datum/gas_reaction/tritfire)

/datum/experiment/ordnance/explosive/nobliumbomb
	name = "Noblium Explosives"
	description = "The formation of Hyper-Noblium is very energetic and can be harnessed for explosives. Capture any tank explosion with a Doppler Array and publish the data in a paper. Only Hyper-Noblium Condensation is allowed."
	gain = list(15,60,120)
	target_amount = list(50,100,300)
	experiment_proper = TRUE
	sanitized_misc = TRUE
	sanitized_reactions = TRUE
	required_reactions = list(/datum/gas_reaction/nobliumformation)

/datum/experiment/ordnance/explosive/pressurebomb
	name = "Reactionless Explosives"
	description = "Gases with high specific heat can heat up those with a low one and produce a lot of pressure.Capture any tank explosion with a Doppler Array and publish the data in a paper. No gas reactions are allowed."
	gain = list(10,50,100)
	target_amount = list(20,50,100)
	experiment_proper = TRUE
	sanitized_misc = FALSE
	sanitized_reactions = TRUE

/datum/experiment/ordnance/gaseous/nitrous_oxide
	name = "Nitrous Oxide Gas Shells"
	description = "The delivery of N2O into an area of operation might prove useful. Pack the specified gas into a tank and burst it using a Tank Compressor. Publish the data in a paper."
	gain = list(10,40)
	target_amount = list(200,600)
	experiment_proper = TRUE
	required_gas = /datum/gas/nitrous_oxide

/datum/experiment/ordnance/gaseous/plasma
	name = "Plasma Gas Shells"
	description = "The delivery of Plasma gas into an area of operation might prove useful. Pack the specified gas into a tank and burst it using a Tank Compressor. Publish the data in a paper."
	gain = list(10,40)
	target_amount = list(200,600)
	experiment_proper = TRUE
	required_gas = /datum/gas/plasma

/datum/experiment/ordnance/gaseous/bz
	name = "BZ Gas Shells"
	description = "The delivery of BZ gas into an area of operation might prove useful. Pack the specified gas into a tank and burst it using a Tank Compressor. Publish the data in a paper."
	gain = list(10,30,60)
	target_amount = list(50,125,400)
	experiment_proper = TRUE
	required_gas = /datum/gas/bz

/datum/experiment/ordnance/gaseous/noblium
	name = "Hypernoblium Gas Shells"
	description = "The delivery of Hypernoblium gas into an area of operation might prove useful. Pack the specified gas into a tank and burst it using a Tank Compressor. Publish the data in a paper."
	gain = list(10,40,80)
	target_amount = list(15,55,250)
	experiment_proper = TRUE
	required_gas = /datum/gas/hypernoblium

/datum/experiment/ordnance/gaseous/halon
	name = "Halon Gas Shells"
	description = "The delivery of Halon gas into an area of operation might prove useful. Perform research and publish papers on this field."
	gain = list(10,30,60)
	target_amount = list(15,55,250)
	experiment_proper = TRUE
	required_gas = /datum/gas/halon

/datum/experiment/scanning/random/material/meat
	name = "Biological Material Scanning Experiment"
	description = "They told us we couldn't make chairs out of every material in the world. You're here to prove those nay-sayers wrong."
	possible_material_types = list(/datum/material/meat)

/datum/experiment/scanning/random/material/easy
	name = "Low Grade Material Scanning Experiment"
	description = "Material science is all about a basic understanding of the universe, and how it's built. To explain this, build something basic and we'll show you how to break it."
	total_requirement = 6
	possible_types = list(/obj/structure/chair, /obj/structure/toilet, /obj/structure/table)
	possible_material_types = list(/datum/material/iron, /datum/material/glass)

/datum/experiment/scanning/random/material/medium
	name = "Medium Grade Material Scanning Experiment"
	description = "Not all materials are strong enough to hold together a space station. Look at these materials for example, and see what makes them useful for our electronics and equipment."
	possible_material_types = list(/datum/material/silver, /datum/material/gold, /datum/material/plastic, /datum/material/titanium)

/datum/experiment/scanning/random/material/medium/one
	name = "Medium Grade Material Scanning Experiment One"

/datum/experiment/scanning/random/material/medium/two
	name = "Medium Grade Material Scanning Experiment Two"

/datum/experiment/scanning/random/material/medium/three
	name = "Medium Grade Material Scanning Experiment Three"

/datum/experiment/scanning/random/material/hard
	name = "High Grade Material Scanning Experiment"
	description = "NT spares no expense to test even the most valuable of materials for their qualities as construction materials. Go build us some of these exotic creations and collect the data."
	possible_material_types = list(/datum/material/diamond, /datum/material/plasma, /datum/material/uranium)

/datum/experiment/scanning/random/material/hard/one
	name = "High Grade Material Scanning Experiment One"

/datum/experiment/scanning/random/material/hard/two
	name = "High Grade Material Scanning Experiment Two"

/datum/experiment/scanning/random/material/hard/three
	name = "High Grade Material Scanning Experiment Three"

/datum/experiment/scanning/random/plants/wild
	name = "Wild Biomatter Mutation Sample"
	description = "Due to a number of reasons, (Solar Rays, a diet consisting only of unstable mutagen, entropy) plants with lower levels of instability may occasionally mutate upon harvest. Scan one of these samples for us."
	performance_hint = "\"Wild\" mutations have been recorded to occur above 30 points of instability, while species mutations occur above 60 points of instability."
	total_requirement = 1

/datum/experiment/scanning/random/plants/traits
	name = "Unique Biomatter Mutation Sample"
	description = "We here at CentCom are on the look out for rare and exotic plants with unique properties to brag about to our shareholders. We're looking for a sample with a very specific genes currently."
	performance_hint = "The wide varities of plants on station each carry various traits, some unique to them. Look for plants that may mutate into what we're looking for."
	total_requirement = 3
	possible_plant_genes = list(/datum/plant_gene/trait/squash, /datum/plant_gene/trait/cell_charge, /datum/plant_gene/trait/glow/shadow, /datum/plant_gene/trait/teleport, /datum/plant_gene/trait/brewing, /datum/plant_gene/trait/juicing, /datum/plant_gene/trait/eyes, /datum/plant_gene/trait/sticky)

/datum/experiment/scanning/points/machinery_tiered_scan/tier2_lathes
	name = "Advanced Stock Parts Benchmark"
	description = "Our newly-designed advanced machinery components require practical application tests for hints at possible further advancements, as well as a general confirmation that we didn't actually design worse parts somehow."
	required_points = 6
	required_atoms = list(
		/obj/machinery/rnd/production/protolathe/department/science = 1,
		/obj/machinery/rnd/production/protolathe/department/engineering = 1,
		/obj/machinery/rnd/production/techfab/department/cargo = 1,
		/obj/machinery/rnd/production/techfab/department/medical = 1,
		/obj/machinery/rnd/production/techfab/department/security = 1,
		/obj/machinery/rnd/production/techfab/department/service = 1
	)
	required_tier = 2

/datum/experiment/scanning/points/machinery_tiered_scan/tier3_bluespacemachines
	name = "Bluespace Machinery Attunement"
	description = "Teleportation technology using bluespace capabilities is a high selling point for our company, but the threat of a critical malfunction in calibration procedures wasn't something we predicted to emerge. Since our RnD department has started a flyperson race riot, maybe your advancements in stock parts could help mitigate the buzzing problem."
	required_points = 4
	required_atoms = list(
		/obj/machinery/teleport/hub = 1,
		/obj/machinery/teleport/station = 1
	)
	required_tier = 3

/datum/experiment/scanning/points/machinery_tiered_scan/tier3_variety
	name = "High Efficiency Parts Applications Test"
	description = "We require further testing of the stock part designs to push their efficiency and market price even further."
	required_points = 15
	required_atoms = list(
		/obj/machinery/autolathe = 1,
		/obj/machinery/rnd/production/circuit_imprinter/department/science = 1,
		/obj/machinery/monkey_recycler = 1,
		/obj/machinery/processor/slime = 1,
		/obj/machinery/processor = 2,
		/obj/machinery/reagentgrinder = 2,
		/obj/machinery/hydroponics = 2,
		/obj/machinery/biogenerator = 3,
		/obj/machinery/gibber = 3,
		/obj/machinery/chem_master = 3,
		/obj/machinery/cryo_cell = 3,
		/obj/machinery/harvester = 5,
		/obj/machinery/quantumpad = 5
	)
	required_tier = 3

/datum/experiment/scanning/points/machinery_tiered_scan/tier3_mechbay
	name = "Military-grade Mech Bay Setup"
	description = "Constructing combat-oriented exosuits is a pricy endeavour. Make sure you have an efficient setup for production, and we'll send over some of our design documents."
	required_points = 6
	required_atoms = list(
		/obj/machinery/mecha_part_fabricator = 1,
		/obj/machinery/mech_bay_recharge_port = 1,
		/obj/machinery/recharge_station = 1
	)
	required_tier = 3

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier2_microlaser
	name = "High-power Micro-lasers Calibration"
	description = "Our Nanotrasen High-Power Office-Ready Laser Pointer ™ isn't powerful enough to strike airborne Syndidrones out of the sky yet. Find us some diode applications for hints on how to improve them!"
	required_points = 10
	required_atoms = list(
		/obj/machinery/mecha_part_fabricator = 1,
		/obj/machinery/rnd/experimentor = 1,
		/obj/machinery/dna_scannernew = 1,
		/obj/machinery/microwave = 2,
		/obj/machinery/deepfryer = 2,
		/obj/machinery/chem_heater = 3,
		/obj/machinery/power/emitter = 3
	)
	required_stock_part = /obj/item/stock_parts/micro_laser/high

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier2_capacitors
	name = "Advanced Capacitors Benchmark"
	description = "Further improving the power capacity of devices station-wide is the next step towards the important project marked as CRITICAL: motorised wheelchairs that run on bluespace-contained nuclear power."
	required_points = 12
	required_atoms = list(
		/obj/machinery/recharge_station = 1,
		/obj/machinery/cell_charger = 1,
		/obj/machinery/mech_bay_recharge_port = 1,
		/obj/machinery/recharger = 2,
		/obj/machinery/power/smes = 2,
		/obj/machinery/chem_dispenser = 3,
		/obj/machinery/chem_dispenser/drinks = 3, /*actually having only the chem dispenser works for scanning soda/booze dispensers but im not quite sure how would i go about actually pointing that out w/o these two lines*/
		/obj/machinery/chem_dispenser/drinks/beer = 3
	)
	required_stock_part = /obj/item/stock_parts/capacitor/adv

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier2_scanmodules
	name = "Advanced Scanning Modules Calibration"
	description = "Despite the apparent lack of use of the scanning modules on our stations, we still expect you to run performance tests on them, just in case we come up with a ground-breaking way to fit 6 scanning modules in an exosuit."
	required_points = 6
	required_atoms = list(
		/obj/machinery/dna_scannernew = 1,
		/obj/machinery/rnd/experimentor = 1,
		/obj/machinery/medical_kiosk = 2,
		/obj/machinery/piratepad/civilian = 2,
	)
	required_stock_part = /obj/item/stock_parts/scanning_module/adv

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier3_cells
	name = "Power Cells Capacity Test"
	description = "Nanotrasen has two major problems with their new Hamster-powered Generator Array: excess of power produced and violent protests of Animal Rights Consortium activists over genetically modifying hamsters with the Hulk gene. We place dibs on dealing with the latter!"
	required_points = 8
	required_atoms = list(
		/obj/machinery/recharge_station = 1,
		/obj/machinery/chem_dispenser = 1,
		/obj/machinery/chem_dispenser/drinks = 1,
		/obj/machinery/chem_dispenser/drinks/beer = 1,
		/obj/machinery/power/smes = 2
	)
	required_stock_part = /obj/item/stock_parts/cell/hyper

/datum/experiment/scanning/points/machinery_pinpoint_scan/tier3_microlaser
	name = "Ultra-high-power Micro-lasers Calibration"
	description = "We're very close to outperforming the surgeons of the past by inventing laser tools precise enough to perform surgeries on grapes. Help us fine-tune the diodes to perfection!"
	required_points = 10
	required_atoms = list(
		/obj/machinery/mecha_part_fabricator = 1,
		/obj/machinery/microwave = 1,
		/obj/machinery/rnd/experimentor = 1,
		/obj/machinery/atmospherics/components/unary/thermomachine/freezer = 2,
		/obj/machinery/power/emitter = 2,
		/obj/machinery/chem_heater = 2,
		/obj/machinery/chem_mass_spec = 3
	)
	required_stock_part = /obj/item/stock_parts/micro_laser/ultra

/datum/experiment/scanning/random/mecha_damage_scan
	name = "Exosuit Materials: Stress Failure Test"
	description = "Your exosuit fabricators allow for rapid production on a small scale, but the structural integrity of created parts is inferior to more traditional means."
	exp_tag = "Scan"
	possible_types = list(/obj/vehicle/sealed/mecha)
	total_requirement = 1
	///Damage percent that each mech needs to be at for a scan to work.
	var/damage_percent

/datum/experiment/scanning/random/mecha_equipped_scan
	name = "Exosuit Materials: Load Strain Test"
	description = "Exosuit equipment places unique strain upon the structure of the vehicle. Scan exosuits you have assembled from your exosuit fabricator and fully equipped to accelerate our structural stress simulations."
	possible_types = list(/obj/vehicle/sealed/mecha)
	total_requirement = 1

/// Scan for organs you didn't start the round with
/datum/experiment/scanning/people/novel_organs
	name = "Human Field Research: Divergent Biology"
	description = "We need data on organic compatibility between species. Scan some samples of humanoid organisms with organs they don't usually have. \
		Data on mechanical organs isn't of any use to us."
	performance_hint = "Unusual organs can be introduced manually by transplant, genetic infusion, or very rapidly via a Bioscrambler anomaly effect."
	required_traits_desc = "non-synthetic organs not typical for their species"
	/// Disallow prosthetic organs
	var/organic_only = TRUE

/datum/experiment/scanning/people/novel_organs/is_valid_scan_target(mob/living/carbon/human/check)
	. = ..()
	if (!.)
		return
	// Organs which are valid for get_mutant_organ_type_for_slot
	var/static/list/vital_organ_slots = list(
		ORGAN_SLOT_BRAIN,
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_APPENDIX,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_TONGUE,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
	)

	for (var/obj/item/organ/organ as anything in check.organs)
		if (organic_only && !IS_ORGANIC_ORGAN(organ))
			continue
		var/datum/species/target_species = check.dna.species
		if (organ.slot in vital_organ_slots)
			if (organ.type == target_species.get_mutant_organ_type_for_slot(organ.slot))
				continue
		else
			if ((organ.type in target_species.mutant_organs) || (organ.type in target_species.external_organs))
				continue
		return TRUE
	return FALSE

/// Scan for cybernetic organs
/datum/experiment/scanning/people/augmented_organs
	name = "Human Field Research: Augmented Organs"
	description = "We need to gather data on how cybernetic vital organs integrate with human biology. Conduct a scan on a human with these implants to help us understand their compatibility"
	performance_hint = "Perform an organ manipulation surgery to replace one of the vital organs with a cybernetic variant."
	required_traits_desc = "augmented vital organs"
	required_count = 1

/datum/experiment/scanning/people/augmented_organs/is_valid_scan_target(mob/living/carbon/human/check)
	. = ..()
	if (!.)
		return
	var/static/list/vital_organ_slots = list(
		ORGAN_SLOT_HEART,
		ORGAN_SLOT_LUNGS,
		ORGAN_SLOT_EYES,
		ORGAN_SLOT_EARS,
		ORGAN_SLOT_LIVER,
		ORGAN_SLOT_STOMACH,
	)

	for (var/obj/item/organ/organ as anything in check.organs)
		if (IS_ORGANIC_ORGAN(organ))
			continue
		if (!(organ.slot in vital_organ_slots))
			continue
		return TRUE
	return FALSE

/// Scan for skillchips
/datum/experiment/scanning/people/skillchip
	name = "Human Field Research: Skill Chip Implants"
	description = "Before sticking programmed circuits into human brain, we need to know how it handles simple ones. Scan a live person with a skill chip implant in their brain."
	performance_hint = "Perform a skill chip implantation with a skill station."
	required_traits_desc = "skill chip implant"

/datum/experiment/scanning/people/skillchip/is_valid_scan_target(mob/living/carbon/human/check, datum/component/experiment_handler/experiment_handler)
	. = ..()
	if (!.)
		return
	var/obj/item/organ/internal/brain/scanned_brain = check.get_organ_slot(ORGAN_SLOT_BRAIN)
	if (isnull(scanned_brain))
		experiment_handler.announce_message("Subject is brainless!")
		return FALSE
	if (scanned_brain.get_used_skillchip_slots() == 0)
		experiment_handler.announce_message("No skill chips found!")
		return FALSE
	return TRUE

/datum/experiment/scanning/reagent/cryostylane
	name = "Pure Cryostylane Scan"
	description = "It appears that the Cryostylane reagent can potentially halt all physiological processes in the human body. Produce Cryostylane with at least 99% purity and scan the beaker."
	required_reagent = /datum/reagent/cryostylane
	min_purity = 0.99

/datum/experiment/scanning/points/bluespace_crystal
	name = "Bluespace Crystal Sampling"
	description = "Investigate the properties of bluespace crystals by scanning either an artificial or naturally occurring variant. This will help us deepen our understanding of bluespace phenomena."
	required_points = 1
	required_atoms = list(
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/sheet/bluespace_crystal = 1
	)

/datum/experiment/scanning/points/machinery_tiered_scan/tier2_any
	name = "Upgraded Stock Parts Benchmark"
	description = "Our newly-designed machinery components require practical application tests for hints at possible further advancements, as well as a general confirmation that we didn't actually design worse parts somehow. Scan any machinery with Upgraded Parts and report the results."
	required_points = 4
	required_atoms = list(
		/obj/machinery = 1
	)
	required_tier = 2

/datum/experiment/scanning/points/machinery_tiered_scan/tier3_any
	name = "Advanced Stock Parts Benchmark"
	description = "Our newly-designed machinery components require practical application tests for hints at possible further advancements, as well as a general confirmation that we didn't actually design worse parts somehow. Scan any machinery with Advanced Parts and report the results."
	required_points = 4
	required_atoms = list(
		/obj/machinery = 1
	)
	required_tier = 3
