/obj/effect/spawner/random/deep_maintenance/medical_crate
	name = "deepmaint medical crate spawner"
	replacement_closet = /obj/structure/closet/crate/medical
	loot = list(
		// Medical stack items
		// Sutures
		/obj/item/stack/medical/suture = 3,
		/obj/item/stack/medical/suture/coagulant = 2,
		/obj/item/stack/medical/suture/bloody = 2,
		/obj/item/stack/medical/suture/emergency = 4,
		// Bandages
		/obj/item/stack/medical/bandage = 3,
		/obj/item/stack/medical/bandage/makeshift = 4,
		// Gauze
		/obj/item/stack/medical/gauze = 3,
		/obj/item/stack/medical/gauze/sterilized = 3,
		// Bruise pack
		/obj/item/stack/medical/bruise_pack = 4,
		// Meshes
		/obj/item/stack/medical/mesh = 3,
		/obj/item/stack/medical/mesh/bloody = 2,
		// Ointment
		/obj/item/stack/medical/ointment = 4,
		/obj/item/stack/medical/ointment/red_sun = 4,
		// Wound recovery
		/obj/item/stack/medical/wound_recovery = 1,
		/obj/item/stack/medical/wound_recovery/rapid_coagulant = 1,
		// Random medpens
		/obj/effect/spawner/random/deep_maintenance/random_injector = 2,
		// Medigels
		/obj/item/reagent_containers/medigel/libital = 2,
		/obj/item/reagent_containers/medigel/aiuri = 2,
		// Pill bottles
		/obj/item/storage/pill_bottle/iron = 2,
		/obj/item/storage/pill_bottle/potassiodide = 2,
		/obj/item/storage/pill_bottle/painkiller = 2,
		/obj/item/storage/pill_bottle/probital = 2,
		// Medkits
		/obj/item/storage/medkit/civil_defense = 3,
		/obj/item/storage/medkit/frontier = 2,
		/obj/item/storage/medkit/combat_surgeon = 2,
		/obj/item/storage/backpack/duffelbag/deforest_medkit = 1,
		/obj/item/storage/backpack/duffelbag/deforest_surgical = 1,
		// Blood
		/obj/item/reagent_containers/blood/universal = 1,
		/obj/item/reagent_containers/blood/lizard = 2,
		/obj/item/reagent_containers/blood/ethereal = 2,
		/obj/item/reagent_containers/blood/random = 2,
		// Various medical tools and equipment items
		/obj/item/emergency_bed = 3,
		/obj/item/scalpel = 2,
		/obj/item/hemostat = 3,
		/obj/item/retractor = 2,
		/obj/item/circular_saw = 1,
		/obj/item/cautery = 3,
		/obj/item/bodybag = 2,
		/obj/item/clothing/gloves/latex/nitrile = 2,
		/obj/item/clothing/neck/stethoscope = 2,
		/obj/item/healthanalyzer = 1,
		/obj/item/healthanalyzer/simple = 2,
		/obj/item/reagent_containers/syringe = 1,
	)

/obj/effect/spawner/random/deep_maintenance/medical_closet
	name = "deepmaint medical closet spawner"
	replacement_closet = /obj/structure/closet/secure_closet/deepmaints_medical_locker
	loot = list(
		// Wound recovery
		/obj/item/stack/medical/wound_recovery = 1,
		/obj/item/stack/medical/wound_recovery/rapid_coagulant = 1,
		// Random medpens
		/obj/effect/spawner/random/deep_maintenance/random_injector = 3,
		// Medigels
		/obj/item/reagent_containers/medigel/libital = 2,
		/obj/item/reagent_containers/medigel/aiuri = 2,
		/obj/item/reagent_containers/medigel/sterilizine = 2,
		/obj/item/reagent_containers/medigel/synthflesh = 2,
		// Pill bottles
		/obj/item/storage/pill_bottle/iron = 2,
		/obj/item/storage/pill_bottle/potassiodide = 2,
		/obj/item/storage/pill_bottle/painkiller = 2,
		/obj/item/storage/pill_bottle/probital = 2,
		/obj/item/storage/pill_bottle/happinesspsych = 2,
		/obj/item/storage/pill_bottle/lsdpsych = 2,
		/obj/item/storage/pill_bottle/mannitol = 2,
		/obj/item/storage/pill_bottle/multiver = 2,
		/obj/item/storage/pill_bottle/mutadone = 2,
		/obj/item/storage/pill_bottle/neurine = 2,
		/obj/item/storage/pill_bottle/ondansetron = 1,
		/obj/item/storage/pill_bottle/psicodine = 2,
		// Medkits
		/obj/item/storage/medkit/civil_defense = 3,
		/obj/item/storage/medkit/frontier = 2,
		/obj/item/storage/medkit/combat_surgeon = 2,
		/obj/item/storage/backpack/duffelbag/deforest_medkit = 1,
		/obj/item/storage/backpack/duffelbag/deforest_surgical = 1,
		// Blood
		/obj/item/reagent_containers/blood/universal = 1,
		/obj/item/reagent_containers/blood/lizard = 2,
		/obj/item/reagent_containers/blood/ethereal = 2,
		/obj/item/reagent_containers/blood/random = 2,
		// Various medical tools and equipment items
		/obj/item/clothing/gloves/latex/nitrile = 2,
		/obj/item/clothing/neck/stethoscope = 2,
		/obj/item/reagent_containers/cup/beaker = 3,
		/obj/item/reagent_containers/cup/beaker/large = 2,
		/obj/item/reagent_containers/dropper = 2,
		/obj/item/reagent_containers/syringe = 2,
		// Various chemical bottles
		/obj/effect/spawner/random/deep_maintenance/random_chem_bottle = 4,
	)

/obj/structure/closet/secure_closet/deepmaints_medical_locker
	name = "medical locker"
	icon_state = "med"

/obj/effect/spawner/random/deep_maintenance/medical_freezer
	name = "deepmaint medical freezer spawner"
	replacement_closet = /obj/structure/closet/crate/freezer
	loot = list(
		// Random medpens
		/obj/effect/spawner/random/deep_maintenance/random_injector = 4,
		// Medigels
		/obj/item/reagent_containers/medigel/libital = 2,
		/obj/item/reagent_containers/medigel/aiuri = 2,
		/obj/item/reagent_containers/medigel/sterilizine = 2,
		/obj/item/reagent_containers/medigel/synthflesh = 2,
		// Pill bottles
		/obj/item/storage/pill_bottle/iron = 2,
		/obj/item/storage/pill_bottle/potassiodide = 2,
		/obj/item/storage/pill_bottle/painkiller = 2,
		/obj/item/storage/pill_bottle/probital = 2,
		/obj/item/storage/pill_bottle/happinesspsych = 2,
		/obj/item/storage/pill_bottle/lsdpsych = 2,
		/obj/item/storage/pill_bottle/mannitol = 2,
		/obj/item/storage/pill_bottle/multiver = 2,
		/obj/item/storage/pill_bottle/mutadone = 2,
		/obj/item/storage/pill_bottle/neurine = 2,
		/obj/item/storage/pill_bottle/ondansetron = 1,
		/obj/item/storage/pill_bottle/psicodine = 2,
		// Medkits
		/obj/item/storage/medkit/civil_defense = 3,
		// Blood
		/obj/item/reagent_containers/blood/universal = 2,
		/obj/item/reagent_containers/blood/lizard = 3,
		/obj/item/reagent_containers/blood/ethereal = 3,
		/obj/item/reagent_containers/blood/random = 3,
		// Various medical tools and equipment items
		/obj/item/bodybag = 2,
		/obj/item/reagent_containers/syringe = 1,
	)

/obj/effect/spawner/random/deep_maintenance/random_injector
	name = "deepmaint random injector spawner"
	replacement_closet = null
	random_loot_count = FALSE
	loot = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/demoneye = 1,
		/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine = 2,
		/obj/item/reagent_containers/hypospray/medipen/deforest/twitch = 1,
	)

/obj/effect/spawner/random/deep_maintenance/random_chem_bottle
	name = "deepmaint random bottle spawner"
	replacement_closet = null
	random_loot_count = FALSE
	loot = list(
		/obj/item/reagent_containers/cup/bottle/acidic_buffer = 2,
		/obj/item/reagent_containers/cup/bottle/ammoniated_mercury = 3,
		/obj/item/reagent_containers/cup/bottle/atropine = 2,
		/obj/item/reagent_containers/cup/bottle/basic_buffer = 2,
		/obj/item/reagent_containers/cup/bottle/chloralhydrate = 1,
		/obj/item/reagent_containers/cup/bottle/epinephrine = 3,
		/obj/item/reagent_containers/cup/bottle/ethanol = 2,
		/obj/item/reagent_containers/cup/bottle/fentanyl = 1,
		/obj/item/reagent_containers/cup/bottle/formaldehyde = 2,
		/obj/item/reagent_containers/cup/bottle/leadacetate = 1,
		/obj/item/reagent_containers/cup/bottle/morphine = 2,
		/obj/item/reagent_containers/cup/bottle/multiver = 3,
		/obj/item/reagent_containers/cup/bottle/potass_iodide = 2,
		/obj/item/reagent_containers/cup/bottle/salglu_solution = 3,
		/obj/item/reagent_containers/cup/bottle/thermite = 1,
		/obj/item/reagent_containers/cup/bottle/toxin = 2,
	)

/obj/effect/spawner/random/deep_maintenance_single_item/loose_medical
	name = "deepmaint loose medical item spawner"
	spawn_loot_count = 2
	loot = list(
		// Medical stack items
		// Sutures
		/obj/item/stack/medical/suture = 3,
		/obj/item/stack/medical/suture/coagulant = 2,
		/obj/item/stack/medical/suture/bloody = 2,
		/obj/item/stack/medical/suture/emergency = 4,
		// Bandages
		/obj/item/stack/medical/bandage = 3,
		/obj/item/stack/medical/bandage/makeshift = 4,
		// Gauze
		/obj/item/stack/medical/gauze = 3,
		/obj/item/stack/medical/gauze/sterilized = 3,
		// Bruise pack
		/obj/item/stack/medical/bruise_pack = 4,
		// Meshes
		/obj/item/stack/medical/mesh = 3,
		/obj/item/stack/medical/mesh/bloody = 2,
		// Ointment
		/obj/item/stack/medical/ointment = 4,
		/obj/item/stack/medical/ointment/red_sun = 4,
		// Wound recovery
		/obj/item/stack/medical/wound_recovery = 1,
		/obj/item/stack/medical/wound_recovery/rapid_coagulant = 1,
		// Random medpens
		/obj/effect/spawner/random/deep_maintenance/random_injector = 2,
		// Medigels
		/obj/item/reagent_containers/medigel/libital = 2,
		/obj/item/reagent_containers/medigel/aiuri = 2,
		// Pill bottles
		/obj/item/storage/pill_bottle/iron = 2,
		/obj/item/storage/pill_bottle/potassiodide = 2,
		/obj/item/storage/pill_bottle/painkiller = 2,
		/obj/item/storage/pill_bottle/probital = 2,
		// Medkits
		/obj/item/storage/medkit/civil_defense = 3,
		/obj/item/storage/medkit/frontier = 2,
		/obj/item/storage/medkit/combat_surgeon = 2,
		/obj/item/storage/backpack/duffelbag/deforest_medkit = 1,
		/obj/item/storage/backpack/duffelbag/deforest_surgical = 1,
		// Blood
		/obj/item/reagent_containers/blood/universal = 1,
		/obj/item/reagent_containers/blood/lizard = 2,
		/obj/item/reagent_containers/blood/ethereal = 2,
		/obj/item/reagent_containers/blood/random = 2,
		// Various medical tools and equipment items
		/obj/item/emergency_bed = 3,
		/obj/item/scalpel = 2,
		/obj/item/hemostat = 3,
		/obj/item/retractor = 2,
		/obj/item/circular_saw = 1,
		/obj/item/cautery = 3,
		/obj/item/bodybag = 2,
		/obj/item/clothing/gloves/latex/nitrile = 2,
		/obj/item/clothing/neck/stethoscope = 2,
		/obj/item/healthanalyzer = 1,
		/obj/item/healthanalyzer/simple = 2,
		/obj/item/reagent_containers/syringe = 1,
	)

/obj/effect/spawner/random/deep_maintenance_single_item/loose_medkit
	name = "deepmaint loose medkit spawner"
	spawn_loot_count = 1
	loot = list(
		/obj/item/storage/medkit/civil_defense = 3,
		/obj/item/storage/medkit/frontier = 2,
		/obj/item/storage/medkit/combat_surgeon = 2,
		/obj/item/storage/backpack/duffelbag/deforest_medkit = 1,
		/obj/item/storage/backpack/duffelbag/deforest_surgical = 1,
	)
