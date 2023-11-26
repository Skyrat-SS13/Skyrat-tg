// -- Modular mod theme changes. -- (Modception.)

/datum/mod_theme/engineering // Engineer
	armor_type = /datum/armor/mod_theme_engineering

/datum/armor/mod_theme_engineering
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 30
	bio = 100
	fire = 100
	acid = 25
	wound = 10

/datum/mod_theme/atmospheric // Atmospheric Technician
	armor_type = /datum/armor/mod_theme_atmospheric

/datum/armor/mod_theme_atmospheric
	melee = 10
	bullet = 5
	laser = 10
	energy = 10
	bomb = 40
	bio = 100
	fire = 100
	acid = 75
	wound = 10

/datum/mod_theme/advanced // Chief Engineer
	armor_type = /datum/armor/mod_theme_advanced

/datum/armor/mod_theme_advanced
	melee = 30
	bullet = 5
	laser = 10
	energy = 10
	bomb = 50
	bio = 100
	fire = 100
	acid = 90
	wound = 10

/datum/mod_theme/loader // Cargo
	armor_type = /datum/armor/mod_theme_loader

/datum/armor/mod_theme_loader
	melee = 20
	bullet = 5
	laser = 10
	energy = 10
	bomb = 50
	bio = 100
	fire = 50
	acid = 25
	wound = 10

/datum/mod_theme/mining // Shaft Miner / Other half comes from the ashland booster
	armor_type = /datum/armor/mod_theme_mining

/datum/armor/mod_theme_mining
	melee = 5
	bullet = 5
	laser = 5
	energy = 5
	bomb = 25
	bio = 100
	fire = 100
	acid = 75
	wound = 15

/datum/mod_theme/medical // Paramedic / Medical Doctor
	armor_type = /datum/armor/mod_theme_medical

/datum/armor/mod_theme_medical
	melee = 10
	bullet = 5
	laser = 5
	energy = 10
	bomb = 10
	bio = 100
	fire = 60
	acid = 75
	wound = 10

/datum/mod_theme/rescue // Chief Medical Officer
	armor_type = /datum/armor/mod_theme_rescue

/datum/armor/mod_theme_rescue
	melee = 20
	bullet = 5
	laser = 10
	energy = 10
	bomb = 20
	bio = 100
	fire = 100
	acid = 100
	wound = 10

/datum/mod_theme/research // Research Director
	armor_type = /datum/armor/mod_theme_research

/datum/armor/mod_theme_research
	melee = 10
	bullet = 5
	laser = 20
	energy = 20
	bomb = 100
	bio = 100
	fire = 100
	acid = 100
	wound = 15

/datum/mod_theme/security // Security Officer
	armor_type = /datum/armor/mod_theme_security

/datum/armor/mod_theme_security
	melee = 30
	bullet = 20
	laser = 20
	energy = 30
	bomb = 20
	bio = 100
	fire = 75
	acid = 75
	wound = 20

/datum/mod_theme/safeguard // Head of Security
	armor_type = /datum/armor/mod_theme_safeguard

/datum/armor/mod_theme_safeguard
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 30
	bio = 100
	fire = 100
	acid = 95
	wound = 25

/datum/mod_theme/magnate // Captain
	armor_type = /datum/armor/mod_theme_magnate

/datum/armor/mod_theme_magnate
	melee = 40
	bullet = 40
	laser = 40
	energy = 40
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 20

/datum/mod_theme/cosmohonk // Clown
	armor_type = /datum/armor/mod_theme_cosmohonk

/datum/armor/mod_theme_cosmohonk
	melee = 10
	energy = 10
	bomb = 10
	bio = 100
	fire = 50
	acid = 25
	wound = 5

/datum/mod_theme/syndicate // Bloodred Syndicate
	armor_type = /datum/armor/mod_theme_syndicate

/datum/armor/mod_theme_syndicate
	melee = 30
	bullet = 35
	laser = 25
	energy = 30
	bomb = 40
	bio = 100
	fire = 50
	acid = 90
	wound = 25

/obj/item/mod/module/armor_booster
	// Half of the old armor is on the MODsuit, the other half is from the booster
	armor_mod = /datum/armor/mod_module_armor_boost_override

/datum/armor/mod_module_armor_boost_override
	melee = 10
	bullet = 15
	laser = 5
	energy = 10

/datum/mod_theme/elite // Elite Syndiate
	armor_type = /datum/armor/mod_theme_elite

/datum/armor/mod_theme_elite
	melee = 40
	bullet = 40
	laser = 40
	energy = 40
	bomb = 60
	bio = 100
	fire = 100
	acid = 100
	wound = 25

/obj/item/mod/module/armor_booster/elite
	// Ditto - half on suit, half on booster
	armor_mod = /datum/armor/mod_module_armor_boost_elite

/datum/armor/mod_module_armor_boost_elite
	melee = 20
	bullet = 20
	laser = 10
	energy = 20

/datum/mod_theme/prototype // Charlie Station
	armor_type = /datum/armor/mod_theme_prototype

/datum/armor/mod_theme_prototype
	melee = 25
	bullet = 5
	laser = 20
	energy = 20
	bomb = 50
	bio = 100
	fire = 100
	acid = 75
	wound = 5

/datum/mod_theme/responsory // ERT
	armor_type = /datum/armor/mod_theme_responsory

/datum/armor/mod_theme_responsory
	melee = 40
	bullet = 30
	laser = 30
	energy = 40
	bomb = 50
	bio = 100
	fire = 100
	acid = 90
	wound = 15

/datum/mod_theme/corporate // Centcom Commander
	armor_type = /datum/armor/mod_theme_corporate

/datum/armor/mod_theme_corporate
	melee = 50
	bullet = 50
	laser = 50
	energy = 50
	bomb = 50
	bio = 100
	fire = 100
	acid = 100
	wound = 15
