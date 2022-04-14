// -- Modular mod theme changes. -- (Modception.)

/datum/mod_theme/engineering // Engineer
	armor = list(MELEE = 10, BULLET = 5, LASER = 10, ENERGY = 10, BOMB = 30, BIO = 100, FIRE = 100, ACID = 25, WOUND = 10)

/datum/mod_theme/atmospheric // Atmospheric Technician
	armor = list(MELEE = 10, BULLET = 5, LASER = 10, ENERGY = 10, BOMB = 40, BIO = 100, FIRE = 100, ACID = 75, WOUND = 10)

/datum/mod_theme/advanced // Chief Engineer
	armor = list(MELEE = 30, BULLET = 5, LASER = 10, ENERGY = 10, BOMB = 50, BIO = 100, FIRE = 100, ACID = 90, WOUND = 10)

/datum/mod_theme/loader // Cargo
	armor = list(MELEE = 20, BULLET = 5, LASER = 10, ENERGY = 10, BOMB = 50, BIO = 100, FIRE = 50, ACID = 25, WOUND = 10)

/datum/mod_theme/mining // Shaft Miner / Other half comes from the ashland booster
	armor = list(MELEE = 5, BULLET = 5, LASER = 5, ENERGY = 5, BOMB = 25, BIO = 100, FIRE = 100, ACID = 75, WOUND = 15)

/datum/mod_theme/medical // Paramedic / Medical Doctor
	armor = list(MELEE = 10, BULLET = 5, LASER = 5, ENERGY = 10, BOMB = 10, BIO = 100, FIRE = 60, ACID = 75, WOUND = 10)

/datum/mod_theme/rescue // Chief Medical Officer
	armor = list(MELEE = 20, BULLET = 5, LASER = 10, ENERGY = 10, BOMB = 20, BIO = 100, FIRE = 100, ACID = 100, WOUND = 10)

/datum/mod_theme/research // Research Director
	armor = list(MELEE = 10, BULLET = 5, LASER = 20, ENERGY = 20, BOMB = 100, BIO = 100, FIRE = 100, ACID = 100, WOUND = 15)

/datum/mod_theme/security // Security Officer
	armor = list(MELEE = 30, BULLET = 20, LASER = 20, ENERGY = 30, BOMB = 20, BIO = 100, FIRE = 75, ACID = 75, WOUND = 20)

/datum/mod_theme/safeguard // Head of Security
	armor = list(MELEE = 40, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 30, BIO = 100, FIRE = 100, ACID = 95, WOUND = 25)

/datum/mod_theme/magnate // Captain
	armor = list(MELEE = 40, BULLET = 40, LASER = 40, ENERGY = 40, BOMB = 50, BIO = 100, FIRE = 100, ACID = 100, WOUND = 20)

/datum/mod_theme/cosmohonk // Clown
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 10, BOMB = 10, BIO = 100, FIRE = 50, ACID = 25, WOUND = 5)

/datum/mod_theme/syndicate // Bloodred Syndicate
	armor = list(MELEE = 20, BULLET = 25, LASER = 15, ENERGY = 20, BOMB = 40, BIO = 100, FIRE = 50, ACID = 90, WOUND = 25)

/obj/item/mod/module/armor_booster
	// Half of the old armor is on the MODsuit, the other half is from the booster
	armor_values = list(MELEE = 20, BULLET = 25, LASER = 15, ENERGY = 20)

/datum/mod_theme/elite // Elite Syndiate
	armor = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 30, BOMB = 60, BIO = 100, FIRE = 100, ACID = 100, WOUND = 25)

/obj/item/mod/module/armor_booster/elite
	// Ditto - half on suit, half on booster
	armor_values = list(MELEE = 30, BULLET = 30, LASER = 25, ENERGY = 30)

/datum/mod_theme/prototype // Charlie Station
	armor = list(MELEE = 25, BULLET = 5, LASER = 20, ENERGY = 20, BOMB = 50, BIO = 100, FIRE = 100, ACID = 75, WOUND = 5)

/datum/mod_theme/responsory // ERT
	armor = list(MELEE = 40, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 50, BIO = 100, FIRE = 100, ACID = 90, WOUND = 15)

/datum/mod_theme/corporate // Centcom Commander
	armor = list(MELEE = 50, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 50, BIO = 100, FIRE = 100, ACID = 100, WOUND = 15)
