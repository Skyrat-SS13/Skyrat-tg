/datum/controller/subsystem/economy
	var/paid_by_hand_amount = 0
	var/paid_by_hand_bundle_count = 0

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
