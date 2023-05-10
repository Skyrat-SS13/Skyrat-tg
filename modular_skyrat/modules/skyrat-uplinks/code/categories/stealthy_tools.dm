/datum/uplink_item/stealthy_tools/announcement
	name = "Fake Announcement"
	desc = "A device that allows you to spoof an announcement to the station of your choice."
	item = /obj/item/device/traitor_announcer
	surplus = 0
	progression_minimum = 20 MINUTES
	cost = 3
	restricted = TRUE
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/stealthy_tools/syndieshotglasses
	name = "Extra Large Syndicate Shotglasses"
	desc = "These modified shot glasses can hold up to 50 units of booze while looking like a regular 15 unit model \
	guaranteed to knock someone on their ass with a hearty dose of bacchus blessing. Look for the Snake underneath \
	to tell these are the real deal. Box of 7."
	item = /obj/item/storage/box/syndieshotglasses
	cost = 2
	restricted_roles = list(JOB_BARTENDER)
