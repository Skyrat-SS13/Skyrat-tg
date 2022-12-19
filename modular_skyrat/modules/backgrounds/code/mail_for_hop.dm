/obj/item
	// If TRUE, this item will not show on the shipping manifest.
	var/shipping_manifest_hidden

/datum/controller/subsystem/economy
	var/paid_by_hand_amount = 0
	var/paid_by_hand_bundle_count = 0

/datum/bank_account
	var/paid_by_hand = FALSE

/datum/controller/subsystem/economy/issue_paydays()
	. = ..()
	var/amount = paid_by_hand_amount
	var/count = paid_by_hand_bundle_count
	paid_by_hand_amount = 0 // To avoid double-processing.
	paid_by_hand_bundle_count = 0

	if(amount < 1 || count < 1)
		return

	var/datum/supply_pack = new /datum/supply_pack/hop_mail(amount, count)

	var/datum/supply_order/order = new /datum/supply_order(
		supply_pack,
		"Central Command",
		"Human Resources Division",
		"Spawned by Backgrounds Paid By Hand system.",
		"HR Shipment",
		charge_on_purchase = FALSE,
		department_destination = /area/station/command/heads_quarters/hop,
	)
	SSshuttle.shopping_list += order


/datum/bank_account/payday(amount_of_paychecks, free)
	if(paid_by_hand && !free) // Paid by hand is only true in special circumstances, e.g, the illegal employment backgrounds.
		// These are free, and cargo is *paid* to ship their payment. Everyone benefits from illegal workers here.
		var/pay_amount = round(clamp(account_job.paycheck * payday_modifier, 0, PAYCHECK_CREW) * BASE_PAYCHECK_MULTIPLIER * background_multiplier)
		SSeconomy.paid_by_hand_bundle_count += rand(1, 3)
		SSeconomy.paid_by_hand_amount += pay_amount
		bank_card_talk("Your paycheck has been sent via shuttle. Please collect your approximately [pay_amount]cr paycheck at your nearest Head of Personel.") // Rough amount to allow for HoP skimming.
		return

	return ..()

/// Stub component for flagging an item as off cargo manifest.
/datum/component/hidden_from_cargo_manifest
	dupe_mode = COMPONENT_DUPE_UNIQUE

/datum/supply_pack/hop_mail
	name = "HoP Mail from Central Command"
	hidden = TRUE
	access = ACCESS_HOP
	access_view = ACCESS_HOP
	crate_name = "Mail for HoP"
	crate_type = /obj/structure/closet/crate/secure

	/// How much money to give.
	var/value

/datum/supply_pack/hop_mail/New(var/value)
	. = ..()
	src.value = value

/datum/supply_pack/hop_mail/generate(atom/owning_turf, datum/bank_account/paying_account)
	var/obj/structure/closet/crate/crate
	crate = new /obj/structure/closet/crate/secure(owning_turf)
	crate.name = "Mail for the HoP - Sent by Central Command"

	if(access)
		crate.req_access = list(access)
	if(access_any)
		crate.req_one_access = access_any

	fill(crate)
	return crate

/datum/supply_pack/hop_mail/fill(obj/structure/closet/crate/crate)
	var/obj/item/holochip/chip = new /obj/item/holochip(crate, round(value * rand(0.8, 1.2)))
	chip.AddComponent(/datum/component/hidden_from_cargo_manifest)
