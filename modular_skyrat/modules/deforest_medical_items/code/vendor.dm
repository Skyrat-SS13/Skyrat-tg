/obj/machinery/vending/deforest_medvend
	name = "DeForest Med-Vend"
	desc = "A vending machine providing a selection of medical supplies."
	icon = 'modular_skyrat/modules/deforest_medical_items/icons/vendor.dmi'
	icon_state = "medvend"
	panel_type = "panel15"
	light_mask = "medvend-light-mask"
	light_color = LIGHT_COLOR_LIGHT_CYAN
	product_slogans = "Medical care at regulation-mandated reasonable prices!;DeForest is not liable for accidents due to supply misuse!"
	product_categories = list(
		list(
			"name" = "First Aid",
			"icon" = "notes-medical",
			"products" = list(
				/obj/item/stack/medical/ointment/red_sun = 12,
				/obj/item/stack/medical/ointment = 12,
				/obj/item/stack/medical/bruise_pack = 12,
				/obj/item/stack/medical/gauze/sterilized = 12,
				/obj/item/stack/medical/suture/coagulant = 12,
				/obj/item/stack/medical/suture = 12,
				/obj/item/stack/medical/suture/bloody = 12,
				/obj/item/stack/medical/mesh = 12,
				/obj/item/stack/medical/mesh/bloody = 12,
				/obj/item/stack/medical/bandage = 12,
				/obj/item/stack/medical/wound_recovery = 6,
				/obj/item/stack/medical/wound_recovery/rapid_coagulant = 6,
				/obj/item/storage/pill_bottle/painkiller = 6,
				/obj/item/storage/medkit/civil_defense = 6,
			),
		),
		list(
			"name" = "Autoinjectors",
			"icon" = "syringe",
			"products" = list(
				/obj/item/reagent_containers/hypospray/medipen/deforest/occuisate = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/adrenaline = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/morpital = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/lipital = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/meridine = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/calopine = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/coagulants = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/lepoturi = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/psifinil = 6,
				/obj/item/reagent_containers/hypospray/medipen/deforest/halobinin = 6,
			),
		),
	)

	contraband = list(
		/obj/item/reagent_containers/hypospray/medipen/deforest/pentibinin = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/synephrine = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/krotozine = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/aranepaine = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/synalvipitol = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/twitch = 3,
		/obj/item/reagent_containers/hypospray/medipen/deforest/demoneye = 3,
	)

	refill_canister = /obj/item/vending_refill/medical_deforest
	default_price = PAYCHECK_CREW
	extra_price = PAYCHECK_COMMAND
	payment_department = ACCOUNT_MED

/obj/item/vending_refill/medical_deforest
	machine_name = "DeForest Med-Vend"
	icon_state = "refill_medical"
