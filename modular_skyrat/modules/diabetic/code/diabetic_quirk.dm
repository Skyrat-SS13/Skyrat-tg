/datum/quirk/item_quirk/diabetic
	name = "Diabetic"
	desc = "You have a condition which prevents you from metabolizing sugar correctly! Better bring some cookies and insulin!"
	icon = FA_ICON_CIRCLE_NOTCH
	medical_record_text = "Patient has diabetes, and is at-risk of hypoglycemic shock when their blood sugar level is too low."
	value = -6
	gain_text = span_danger("You feel a dizzying craving for sugar.")
	lose_text = span_notice("Your craving for sugar subsides.")
	hardcore_value = 3
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_PROCESSES
	mail_goodies = list(/obj/item/storage/pill_bottle/insulin/diabetic)

/datum/quirk/item_quirk/diabetic/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/storage/pill_bottle/insulin/diabetic,
		list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		),
		flavour_text = "These will keep you alive until you can secure a supply of medication. Don't rely on them too much!",
	)
	give_item_to_holder(/obj/item/healthanalyzer/simple/disease, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK))
	give_item_to_holder(/obj/item/food/cookie/sugar, list(
			LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
			LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
			LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
			LOCATION_HANDS = ITEM_SLOT_HANDS,
		))

/datum/quirk/item_quirk/diabetic/process(seconds_per_tick)
	if(!iscarbon(quirk_holder))
		return

	if(IS_IN_STASIS(quirk_holder))
		return

	if(quirk_holder.stat == DEAD)
		return

	var/mob/living/carbon/carbon_holder = quirk_holder
	var/datum/reagent/sugar = carbon_holder.reagents.has_reagent(/datum/reagent/consumable/sugar)

	if(sugar != FALSE)
		// Diabetics metabolize sugar much slower than normal.
		if(sugar.volume > 0)
			sugar.metabolization_rate = 0.02
			return

	// No sugar, get hypoglycemia.
	if(carbon_holder.HasDisease(/datum/disease/hypoglycemia))
		return

	var/datum/disease/hypoglycemic_shock = new /datum/disease/hypoglycemia()
	carbon_holder.ForceContractDisease(hypoglycemic_shock, FALSE, TRUE)
