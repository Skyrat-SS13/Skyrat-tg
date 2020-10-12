//charliestation stuff
	/obj/item/card/id/away/old
	name = "a perfectly generic identification card"
	desc = "A perfectly generic identification card. Looks like it could use some flavor."
	icon_state = "centcom"

/obj/item/card/id/away/old/sec
	name = "Charlie Station Security Officer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Security Officer\"."
	assignment = "Charlie Station Security Officer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_SEC)

/obj/item/card/id/away/old/sci
	name = "Charlie Station Scientist's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Scientist\"."
	assignment = "Charlie Station Scientist"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/eng
	name = "Charlie Station Engineer's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Station Engineer\"."
	assignment = "Charlie Station Engineer"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_ENGINE, ACCESS_ENGINE_EQUIP)

/obj/item/card/id/away/old/atmos
	name = "Charlie Station Atmospheric Technician's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Atmos Technician\"."
	assignment = "Charlie Station Atmospheric Technician"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_ENGINE, ACCESS_ENGINE_EQUIP)


/obj/item/card/id/away/old/mine
	name = "Charlie Station Miner's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Miner\"."
	assignment = "Charlie Station Miner"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/med
	name = "Charlie Station Doctor's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Doctor\"."
	assignment = "Charlie Station Doctor"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)

/obj/item/card/id/away/old/ass
	name = "Charlie Station Staff Assistant's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Staff Assistant\"."
	assignment = "Charlie Station Staff Assistant"
	access = list(ACCESS_AWAY_GENERAL, ACCESS_AWAY_MAINT)

/obj/item/card/id/away/old/chaplain
	name = "Charlie Station Chaplain's ID card"
	desc = "A faded Charlie Station ID card. You can make out the rank \"Chaplain\"."
	assignment = "Charlie Station Chaplain"
	access = list(ACCESS_AWAY_GENERAL)

/obj/item/card/id/away/old/apc
	name = "APC Access ID"
	desc = "A special ID card that allows access to APC terminals."
	access = list(ACCESS_ENGINE_EQUIP)

