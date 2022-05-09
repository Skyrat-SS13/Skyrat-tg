/*
*	LOADOUT ITEM DATUMS FOR THE (EXO/OUTER)SUIT SLOT
*/

/// Exosuit / Outersuit Slot Items (Moves items to backpack)
GLOBAL_LIST_INIT(loadout_exosuits, generate_loadout_items(/datum/loadout_item/suit))

/datum/loadout_item/suit
	category = LOADOUT_ITEM_SUIT

/datum/loadout_item/suit/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.suit)
			LAZYADD(outfit.backpack_contents, outfit.suit)
		outfit.suit = item_path
	else
		outfit.suit = item_path

/*
*	WINTER COATS
*/

/datum/loadout_item/suit/winter_coat
	name = "Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat

/datum/loadout_item/suit/winter_coat_greyscale
	name = "Greyscale Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/custom

/datum/loadout_item/suit/aformal
	name = "Assistant's formal winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/aformal

/datum/loadout_item/suit/runed
	name = "Runed winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/narsie/fake

/datum/loadout_item/suit/brass
	name = "Brass winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/ratvar/fake

/datum/loadout_item/suit/korea
	name = "Eastern winter coat"
	item_path = /obj/item/clothing/suit/koreacoat

/datum/loadout_item/suit/czech
	name = "Modern winter coat"
	item_path = /obj/item/clothing/suit/modernwintercoatthing

/*
*	SUITS / SUIT JACKETS
*/

/datum/loadout_item/suit/black_suit_jacket
	name = "Black Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/loadout_item/suit/blue_suit_jacket
	name = "Blue Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer

/datum/loadout_item/suit/purple_suit_jacket
	name = "Purple Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/purple

/datum/loadout_item/suit/white_suit_jacket
	name = "White Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/white

/datum/loadout_item/suit/suitblackbetter
	name = "Light Black Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black/better

/datum/loadout_item/suit/suitwhite
	name = "Texan Suit Jacket"
	item_path = /obj/item/clothing/suit/texas

/*
*	SUSPENDERS
*/

/datum/loadout_item/suit/suspenders_blue
	name = "Blue Suspenders"
	item_path = /obj/item/clothing/suit/toggle/suspenders/blue

/datum/loadout_item/suit/suspenders_grey
	name = "Grey Suspenders"
	item_path = /obj/item/clothing/suit/toggle/suspenders/gray

/datum/loadout_item/suit/suspenders_red
	name = "Red Suspenders"
	item_path = /obj/item/clothing/suit/toggle/suspenders

/*
*	DRESSES
*/

/datum/loadout_item/suit/white_dress
	name = "White Dress"
	item_path = /obj/item/clothing/suit/whitedress

/*
*	LABCOATS
*/

/datum/loadout_item/suit/labcoat
	name = "Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat

/datum/loadout_item/suit/labcoat_green
	name = "Green Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/mad

/*
*	PONCHOS
*/

/datum/loadout_item/suit/poncho
	name = "Poncho"
	item_path = /obj/item/clothing/suit/poncho

/datum/loadout_item/suit/poncho_green
	name = "Green Poncho"
	item_path = /obj/item/clothing/suit/poncho/green

/datum/loadout_item/suit/poncho_red
	name = "Red Poncho"
	item_path = /obj/item/clothing/suit/poncho/red


/*
*	JACKETS
*/

/datum/loadout_item/suit/bomber_jacket
	name = "Bomber Jacket"
	item_path = /obj/item/clothing/suit/jacket

/datum/loadout_item/suit/military_jacket
	name = "Military Jacket"
	item_path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/puffer_jacket
	name = "Puffer Jacket"
	item_path = /obj/item/clothing/suit/jacket/puffer

/datum/loadout_item/suit/puffer_vest
	name = "Puffer Vest"
	item_path = /obj/item/clothing/suit/jacket/puffer/vest

/datum/loadout_item/suit/leather_jacket
	name = "Leather Jacket"
	item_path = /obj/item/clothing/suit/jacket/leather

/datum/loadout_item/suit/leather_coat
	name = "Leather Coat"
	item_path = /obj/item/clothing/suit/jacket/leather/overcoat

/*
*	LETTERMAN
*/

/datum/loadout_item/suit/brown_letterman
	name = "Brown Letterman"
	item_path = /obj/item/clothing/suit/jacket/letterman

/datum/loadout_item/suit/red_letterman
	name = "Red Letterman"
	item_path = /obj/item/clothing/suit/jacket/letterman_red

/datum/loadout_item/suit/blue_letterman
	name = "Blue Letterman"
	item_path = /obj/item/clothing/suit/jacket/letterman_nanotrasen

/*
*	COSTUMES
*/

/datum/loadout_item/suit/owl
	name = "Owl Cloak"
	item_path = /obj/item/clothing/suit/toggle/owlwings

/datum/loadout_item/suit/griffin
	name = "Griffon Cloak"
	item_path = /obj/item/clothing/suit/toggle/owlwings/griffinwings

/datum/loadout_item/suit/syndi
	name = "Black And Red Space Suit Replica"
	item_path = /obj/item/clothing/suit/syndicatefake

/datum/loadout_item/suit/bee
	name = "Bee Outfit"
	item_path = /obj/item/clothing/suit/hooded/bee_costume

/datum/loadout_item/suit/plague_doctor
	name = "Plague Doctor Suit"
	item_path = /obj/item/clothing/suit/bio_suit/plaguedoctorsuit

/datum/loadout_item/suit/snowman
	name = "Snowman Outfit"
	item_path = /obj/item/clothing/suit/snowman

/datum/loadout_item/suit/chicken
	name = "Chicken Suit"
	item_path = /obj/item/clothing/suit/chickensuit

/datum/loadout_item/suit/monkey
	name = "Monkey Suit"
	item_path = /obj/item/clothing/suit/monkeysuit

/datum/loadout_item/suit/cardborg
	name = "Cardborg Suit"
	item_path = /obj/item/clothing/suit/cardborg

/datum/loadout_item/suit/xenos
	name = "Xenos Suit"
	item_path = /obj/item/clothing/suit/xenos

/datum/loadout_item/suit/ian_costume
	name = "Corgi Costume"
	item_path = /obj/item/clothing/suit/hooded/ian_costume

/datum/loadout_item/suit/carp_costume
	name = "Carp Costume"
	item_path = /obj/item/clothing/suit/hooded/carp_costume

/datum/loadout_item/suit/wizard
	name = "Wizard Robe"
	item_path = /obj/item/clothing/suit/wizrobe/fake

/datum/loadout_item/suit/witch
	name = "Witch Robe"
	item_path = /obj/item/clothing/suit/wizrobe/marisa/fake

/*
*	SEASONAL
*/

/datum/loadout_item/suit/winter_coat/christmas
	name = "Christmas Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/christmas
	required_season = CHRISTMAS

/datum/loadout_item/suit/winter_coat/christmas/green
	name = "Green Christmas Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/christmas/green


/*
*	MISC
*/

/datum/loadout_item/suit/purple_apron
	name = "Purple Apron"
	item_path = /obj/item/clothing/suit/apron/purple_bartender

/datum/loadout_item/suit/denim_overalls
	name = "Denim Overalls"
	item_path = /obj/item/clothing/suit/apron/overalls

/datum/loadout_item/suit/redhood
	name = "Red cloak"
	item_path = /obj/item/clothing/suit/hooded/cloak/david

/datum/loadout_item/suit/ianshirt
	name = "Ian Shirt"
	item_path = /obj/item/clothing/suit/ianshirt

/datum/loadout_item/suit/wornshirt
	name = "Worn Shirt"
	item_path = /obj/item/clothing/suit/wornshirt

/datum/loadout_item/suit/tailcoat
	name = "Tailcoat"
	item_path = /obj/item/clothing/suit/costume/tailcoat

/datum/loadout_item/suit/duster
	name = "Colorable Duster"
	item_path = /obj/item/clothing/suit/duster/colorable

/datum/loadout_item/suit/peacoat
	name = "Colorable Peacoat"
	item_path = /obj/item/clothing/suit/toggle/peacoat

/datum/loadout_item/suit/dresscoat
	name = "Black Dresscoat"
	item_path = /obj/item/clothing/suit/costume/vic_dresscoat

/datum/loadout_item/suit/dresscoat_red
	name = "Red Dresscoat"
	item_path = /obj/item/clothing/suit/costume/vic_dresscoat/red

/datum/loadout_item/suit/trackjacket
	name = "Track Jacket"
	item_path = /obj/item/clothing/suit/toggle/trackjacket

/datum/loadout_item/suit/croptop
	name = "Black Crop Top Turtleneck"
	item_path = /obj/item/clothing/suit/croptop

/*
*	FLANNELS
*/

/datum/loadout_item/suit/flannel_black
	name = "Black Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel

/datum/loadout_item/suit/flannel_red
	name = "Red Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/red

/datum/loadout_item/suit/flannel_aqua
	name = "Aqua Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/aqua

/datum/loadout_item/suit/flannel_brown
	name = "Brown Flannel"
	item_path = /obj/item/clothing/suit/toggle/jacket/flannel/brown

/*
*	HAWAIIAN
*/

/datum/loadout_item/suit/hawaiian_shirt
	name = "Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/hawaiian

/datum/loadout_item/suit/hawaiian_blue
	name = "Blue Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/hawaiian_blue

/datum/loadout_item/suit/hawaiian_orange
	name = "Orange Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/hawaiian_orange

/datum/loadout_item/suit/hawaiian_purple
	name = "Purple Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/hawaiian_purple

/datum/loadout_item/suit/hawaiian_green
	name = "Green Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/hawaiian_green

/*
*	MISC
*/

/datum/loadout_item/suit/frenchtrench
	name = "Blue Trenchcoat"
	item_path = /obj/item/clothing/suit/frenchtrench

/datum/loadout_item/suit/cossak
	name = "Ukrainian Coat"
	item_path = /obj/item/clothing/suit/cossack

/datum/loadout_item/suit/parka
	name = "Falls Parka"
	item_path = /obj/item/clothing/suit/fallsparka

/datum/loadout_item/suit/poly
	name = "Polychromic Wintercoat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/polychromic

/datum/loadout_item/suit/urban
	name = "Urban Coat"
	item_path = /obj/item/clothing/suit/urban/polychromic

/datum/loadout_item/suit/maxson
	name = "Fancy Brown Coat"
	item_path = /obj/item/clothing/suit/brownbattlecoat

/datum/loadout_item/suit/bossu
	name = "Fancy Black Coat"
	item_path = /obj/item/clothing/suit/blackfurrich

/datum/loadout_item/suit/dutchjacket
	name = "Dutch Jacket"
	item_path = /obj/item/clothing/suit/dutchjacketsr

/datum/loadout_item/suit/caretaker
	name = "Caretaker Jacket"
	item_path = /obj/item/clothing/suit/victoriantailcoatbutler

/datum/loadout_item/suit/yakuzajacket
	name = "Asian Jacket"
	item_path = /obj/item/clothing/suit/yakuza

/datum/loadout_item/suit/jacketbomber_alt
	name = "Bomber Jacket w/ Zipper"
	item_path = /obj/item/clothing/suit/toggle/jacket

/datum/loadout_item/suit/polyjacketleather
	name = "Colorable Leather Jacket"
	item_path = /obj/item/clothing/suit/jacket/leather/polychromic

/datum/loadout_item/suit/woolcoat
	name = "Leather Overcoat"
	item_path = /obj/item/clothing/suit/woolcoat

/datum/loadout_item/suit/flakjack
	name = "Flak Jacket"
	item_path = /obj/item/clothing/suit/flakjack

/datum/loadout_item/suit/deckard
	name = "Runner Coat"
	item_path = /obj/item/clothing/suit/toggle/deckard
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/bltrench
	name = "Black Trenchcoat"
	item_path = /obj/item/clothing/suit/trenchblack

/datum/loadout_item/suit/brtrench
	name = "Brown Trenchcoat"
	item_path = /obj/item/clothing/suit/trenchbrown

/datum/loadout_item/suit/discojacket
	name = "Disco Ass Blazer"
	item_path = /obj/item/clothing/suit/discoblazer
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/suit/cardigan
	name = "Cardigan"
	item_path = /obj/item/clothing/suit/toggle/jacket/cardigan

/*
*	HOODIES
*/

/datum/loadout_item/suit/hoodie/greyscale
	name = "Greyscale Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie

/datum/loadout_item/suit/hoodie/greyscale_trim
	name = "Greyscale Trimmed Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/trim

/datum/loadout_item/suit/hoodie/greyscale_trim_alt
	name = "Greyscale Trimmed Hoodie (Alt)"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/trim/alt

/datum/loadout_item/suit/hoodie/black
	name = "Black Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/black

/datum/loadout_item/suit/hoodie/red
	name = "Red Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/red

/datum/loadout_item/suit/hoodie/blue
	name = "Blue Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/blue

/datum/loadout_item/suit/hoodie/green
	name = "Green Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/green

/datum/loadout_item/suit/hoodie/orange
	name = "Orange Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/orange

/datum/loadout_item/suit/hoodie/yellow
	name = "Yellow Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/yellow

/datum/loadout_item/suit/hoodie/grey
	name = "Grey Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/grey

/datum/loadout_item/suit/hoodie/nt
	name = "NT Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded

/datum/loadout_item/suit/hoodie/smw
	name = "SMW Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/smw

/datum/loadout_item/suit/hoodie/nrti
	name = "NRTI Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/nrti

/datum/loadout_item/suit/hoodie/cti
	name = "CTI Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/cti

/datum/loadout_item/suit/hoodie/mu
	name = "Mojave University Hoodie"
	item_path = /obj/item/clothing/suit/toggle/jacket/hoodie/branded/mu

/*
*	JOB-LOCKED
*/

// WINTER COATS
/datum/loadout_item/suit/coat_med
	name = "Medical Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_ORDERLY) // Reserve it to Medical Doctors, Orderlies, and their boss, the Chief Medical Officer

/datum/loadout_item/suit/coat_paramedic
	name = "Paramedic Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/paramedic
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_PARAMEDIC) // Reserve it to Paramedics and their boss, the Chief Medical Officer

/datum/loadout_item/suit/coat_robotics
	name = "Robotics Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/robotics
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_ROBOTICIST)

/datum/loadout_item/suit/coat_sci
	name = "Science Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST, JOB_VANGUARD_OPERATIVE, JOB_SCIENCE_GUARD) // Reserve it to the Science Departement

/datum/loadout_item/suit/coat_eng
	name = "Engineering Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ENGINEERING_GUARD) // Reserve it to Station Engineers, Engineering Guards, and their boss, the Chief Engineer

/datum/loadout_item/suit/coat_atmos
	name = "Atmospherics Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN) // Reserve it to Atmos Techs and their boss, the Chief Engineer

/datum/loadout_item/suit/coat_hydro
	name = "Hydroponics Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/hydro
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_BOTANIST) // Reserve it to Botanists and their boss, the Head of Personnel

/datum/loadout_item/suit/coat_bar
	name = "Bartender Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/bartender
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_BARTENDER) //Reserved for Bartenders and their head-of-staff

/datum/loadout_item/suit/coat_cargo
	name = "Cargo Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/cargo
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_CUSTOMS_AGENT) // Reserve it to Cargo Techs, Customs Agentes, and their boss, the Quartermaster

/datum/loadout_item/suit/coat_miner
	name = "Mining Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/miner
	restricted_roles = list(JOB_QUARTERMASTER, JOB_SHAFT_MINER) // Reserve it to Miners and their boss, the Quartermaster

// JACKETS
/datum/loadout_item/suit/navybluejacketofficer
	name = "Security Officer's Navy Blue Jacket"
	item_path = /obj/item/clothing/suit/armor/navyblue
	restricted_roles = list(JOB_SECURITY_OFFICER,JOB_SECURITY_MEDIC ,JOB_HEAD_OF_SECURITY, JOB_WARDEN) // I aint making a medic one, maybe i'll add some rank thing from cm or civ for it

/datum/loadout_item/suit/navybluejacketwarden
	name = "Warden's Navy Blue Jacket"
	item_path = /obj/item/clothing/suit/armor/vest/warden/navyblue
	restricted_roles = list(JOB_WARDEN)

/datum/loadout_item/suit/security_jacket
	name = "Security Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sec
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_MEDIC) //Not giving this one to COs because it's actually better than the one they spawn with

/datum/loadout_item/suit/cossak/sec
	name = "Ukrainian Security Jacket"
	item_path = /obj/item/clothing/suit/armor/cossack/sec
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_MEDIC, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/brit
	name = "High Vis Armored Vest"
	item_path = /obj/item/clothing/suit/toggle/brit/sec
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_SECURITY_MEDIC, JOB_CORRECTIONS_OFFICER)

/datum/loadout_item/suit/british_jacket
	name = "Peacekeeper Officer Coat"
	item_path = /obj/item/clothing/suit/british_officer
	restricted_roles = list(JOB_HEAD_OF_SECURITY, JOB_WARDEN, JOB_DETECTIVE)

/datum/loadout_item/suit/engi_jacket
	name = "Engineering Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/engi
	restricted_roles = list(JOB_CHIEF_ENGINEER, JOB_STATION_ENGINEER, JOB_ATMOSPHERIC_TECHNICIAN, JOB_ENGINEERING_GUARD)

/datum/loadout_item/suit/sci_jacket
	name = "Science Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sci
	restricted_roles = list(JOB_RESEARCH_DIRECTOR, JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_VANGUARD_OPERATIVE, JOB_SCIENCE_GUARD)

/datum/loadout_item/suit/med_jacket
	name = "Medbay Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/med
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_VIROLOGIST, JOB_ORDERLY)

/datum/loadout_item/suit/supply_jacket
	name = "Supply Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/supply
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT)

/datum/loadout_item/suit/supply_gorka_jacket
	name = "Supply Gorka Jacket"
	item_path = /obj/item/clothing/suit/gorka/supply
	restricted_roles = list(JOB_QUARTERMASTER, JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_CUSTOMS_AGENT)

// LABCOATS
/datum/loadout_item/suit/labcoat_parared
	name = "Red Paramedic Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/para_red
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_PARAMEDIC, JOB_SECURITY_MEDIC) // its a medic jacket anyway screw you

/datum/loadout_item/suit/labcoat_highvis
	name = "High-Vis Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/highvis
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER, JOB_PARAMEDIC, JOB_ATMOSPHERIC_TECHNICIAN, JOB_DETECTIVE, JOB_SECURITY_MEDIC, JOB_CHEMIST, JOB_ORDERLY) // And now chemist and orderly get it too.

/*
*	FAMILIES
*/

/datum/loadout_item/suit/osi
	name = "OSI Coat"
	item_path = /obj/item/clothing/suit/osi

/datum/loadout_item/suit/tmc
	name = "TMC Coat"
	item_path = /obj/item/clothing/suit/tmc

/datum/loadout_item/suit/pg
	name = "PG Coat"
	item_path = /obj/item/clothing/suit/pg

/datum/loadout_item/suit/driscoll
	name = "Driscoll Coat"
	item_path = /obj/item/clothing/suit/driscoll

/datum/loadout_item/suit/deckers
	name = "Deckers Coat"
	item_path = /obj/item/clothing/suit/deckers

/datum/loadout_item/suit/morningstar
	name = "Morningstar Coat"
	item_path = /obj/item/clothing/suit/morningstar

/datum/loadout_item/suit/saints
	name = "Saints Coat"
	item_path = /obj/item/clothing/suit/saints

/datum/loadout_item/suit/phantom
	name = "Phantom Coat"
	item_path = /obj/item/clothing/suit/phantom

/datum/loadout_item/suit/sybil
	name = "Sybil Coat"
	item_path = /obj/item/clothing/suit/sybil_slickers

/datum/loadout_item/suit/basil
	name = "Basil Coat"
	item_path = /obj/item/clothing/suit/basil_boys

/datum/loadout_item/suit/soviet
	name = "Soviet Coat"
	item_path = /obj/item/clothing/suit/soviet

/datum/loadout_item/suit/allies
	name = "Allies Coat"
	item_path = /obj/item/clothing/suit/allies

/datum/loadout_item/suit/yuri
	name = "Yuri Coat"
	item_path = /obj/item/clothing/suit/yuri

/*
*	DONATOR
*/

/datum/loadout_item/suit/donator
	donator_only = TRUE

/datum/loadout_item/suit/donator/furredjacket
	name = "Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/public

/datum/loadout_item/suit/donator/whitefurredjacket
	name = "White Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/white

/datum/loadout_item/suit/donator/creamfurredjacket
	name = "Cream Furred Jacket"
	item_path = /obj/item/clothing/suit/brownfurrich/cream

/datum/loadout_item/suit/donator/modern_winter
	name = "Modern Winter Coat"
	item_path = /obj/item/clothing/suit/modern_winter

/datum/loadout_item/suit/donator/blondie
	name = "Cowboy Vest"
	item_path = /obj/item/clothing/suit/cowboyvest

