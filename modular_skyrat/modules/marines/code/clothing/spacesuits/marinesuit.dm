/obj/item/clothing/head/helmet/space/hardsuit/ert/marine
	name = "marine helmet"
	desc = "The integrated helmet of an advanced Marine hardsuit, fielded by Nanotrasen's navy."
	icon_state = "hardsuit0-marine"
	inhand_icon_state = "hardsuit0-marine"
	hardsuit_type = "marine"
	armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 60, BOMB = 80, BIO = 100, FIRE = 100, ACID = 80)
	strip_delay = 130
	light_range = 7
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
  
  /obj/item/clothing/suit/space/hardsuit/ert/marine
	name = "marine hardsuit"
	desc = "The standard issue hardsuit of the Nanotrasen Marine Corps, fitted with advanced plasteel composite plating and a nanogel-lined undersuit for maximum protection and minimal slowdown."
	icon_state = "marinesuit"
	inhand_icon_state = "marinesuit"
	helmettype = /obj/item/clothing/head/helmet/space/hardsuit/ert/marine
	allowed = list(/obj/item/gun, /obj/item/ammo_box, /obj/item/ammo_casing, /obj/item/melee/baton, /obj/item/restraints/handcuffs, /obj/item/tank/internals)
	armor = list(MELEE = 65, BULLET = 65, LASER = 65, ENERGY = 60, BOMB = 80, BIO = 100, FIRE = 100, ACID = 80)
	slowdown = 0
	strip_delay = 130
	resistance_flags = FIRE_PROOF
	max_heat_protection_temperature = FIRE_IMMUNITY_MAX_TEMP_PROTECT
	cell = /obj/item/stock_parts/cell/bluespace
