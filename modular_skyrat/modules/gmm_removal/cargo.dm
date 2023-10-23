/datum/supply_pack/imports/materials_market
	special = TRUE

/datum/supply_pack/materials/glass50
	name = "50 Glass Sheets"
	desc = "Let some nice light in with fifty glass sheets!"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/stack/sheet/glass/fifty)
	crate_name = "glass sheets crate"

/datum/supply_pack/materials/iron50
	name = "50 Iron Sheets"
	desc = "Any construction project begins with a good stack of fifty iron sheets!"
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/stack/sheet/iron/fifty)
	crate_name = "iron sheets crate"

/datum/supply_pack/materials/plasteel20
	name = "20 Plasteel Sheets"
	desc = "Reinforce the station's integrity with twenty plasteel sheets!"
	cost = CARGO_CRATE_VALUE * 15
	contains = list(/obj/item/stack/sheet/plasteel/twenty)
	crate_name = "plasteel sheets crate"

/datum/supply_pack/materials/plasteel50
	name = "50 Plasteel Sheets"
	desc = "For when you REALLY have to reinforce something."
	cost = CARGO_CRATE_VALUE * 33
	contains = list(/obj/item/stack/sheet/plasteel/fifty)
	crate_name = "plasteel sheets crate"

/datum/export/material/market
	var/static/list/prices_by_material = list(
		/datum/material/iron = CARGO_CRATE_VALUE * 0.01,
		/datum/material/glass = CARGO_CRATE_VALUE * 0.01,
		/datum/material/titanium = CARGO_CRATE_VALUE * 0.25,
		/datum/material/silver = CARGO_CRATE_VALUE * 0.1,
		/datum/material/gold = CARGO_CRATE_VALUE * 0.25,
		/datum/material/uranium = CARGO_CRATE_VALUE * 0.2,
		/datum/material/diamond = CARGO_CRATE_VALUE,
		/datum/material/bluespace = CARGO_CRATE_VALUE * 0.6,
	)

/datum/export/material/market/get_cost(obj/O, apply_elastic = TRUE)
	var/obj/item/I = O
	var/amount = get_amount(I)
	if(!amount)
		return 0
	if(k_elasticity != 0)
		return round((prices_by_material[material_id]/k_elasticity) * (1 - NUM_E**(-1 * k_elasticity * amount)))
	else
		return round(prices_by_material[material_id] * amount)

/datum/export/material/market/sell_object(obj/sold_item, datum/export_report/report, dry_run, apply_elastic)
	. = ..()
	var/value = get_cost(sold_item, apply_elastic)
	var/amount = get_amount(sold_item)
	if(amount <= 0 || (value <= 0 && !allow_negative_cost))
		return FALSE
	if(!dry_run)
		if(apply_elastic)
			prices_by_material[material_id] *= NUM_E**(-1 * k_elasticity * amount)
		SSblackbox.record_feedback("nested tally", "export_sold_cost", 1, list("[sold_item.type]", "[value]"))
	return TRUE
