// --- Loadout item datums for exosuits / suits ---

/// Exosuit / Outersuit Slot Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_exosuits, generate_loadout_items(/datum/loadout_item/suit))

/datum/loadout_item/suit
	category = LOADOUT_ITEM_SUIT

/datum/loadout_item/suit/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	outfit.suit = item_path
	if(outfit.suit_store)
		LAZYADD(outfit.backpack_contents, outfit.suit_store)
		outfit.suit_store = null

/datum/loadout_item/suit/winter_coat
	name = "Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat

/datum/loadout_item/suit/winter_coat_greyscale
	name = "Greyscale Winter Coat"
	can_be_greyscale = TRUE
	item_path = /obj/item/clothing/suit/hooded/wintercoat/custom

/datum/loadout_item/suit/denim_overalls
	name = "Denim Overalls"
	item_path = /obj/item/clothing/suit/apron/overalls

/datum/loadout_item/suit/black_suit_jacket
	name = "Black Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/loadout_item/suit/blue_suit_jacket
	name = "Blue Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer

/datum/loadout_item/suit/purple_suit_jacket
	name = "Purple Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/purple

/datum/loadout_item/suit/purple_apron
	name = "Purple Apron"
	item_path = /obj/item/clothing/suit/apron/purple_bartender


/datum/loadout_item/suit/Suspenders_blue
	name = "Blue Suspenders"
	item_path = /obj/item/clothing/suit/toggle/suspenders/blue

/datum/loadout_item/suit/suspenders_grey
	name = "Grey Suspenders"
	item_path = /obj/item/clothing/suit/toggle/suspenders/gray

/datum/loadout_item/suit/suspenders_red
	name = "Red Suspenders"
	item_path = /obj/item/clothing/suit/toggle/suspenders

/datum/loadout_item/suit/white_dress
	name = "White Dress"
	item_path = /obj/item/clothing/suit/whitedress

/datum/loadout_item/suit/labcoat
	name = "Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat

/datum/loadout_item/suit/labcoat_green
	name = "Green Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/mad

/datum/loadout_item/suit/poncho
	name = "Poncho"
	item_path = /obj/item/clothing/suit/poncho

/datum/loadout_item/suit/poncho_green
	name = "Green Poncho"
	item_path = /obj/item/clothing/suit/poncho/green

/datum/loadout_item/suit/poncho_red
	name = "Red Poncho"
	item_path = /obj/item/clothing/suit/poncho/red

/datum/loadout_item/suit/wawaiian_shirt
	name = "Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/hawaiian

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

/datum/loadout_item/suit/brown_letterman
	name = "Brown Letterman"
	item_path = /obj/item/clothing/suit/jacket/letterman

/datum/loadout_item/suit/red_letterman
	name = "Red Letterman"
	item_path = /obj/item/clothing/suit/jacket/letterman_red

/datum/loadout_item/suit/blue_letterman
	name = "Blue Letterman"
	item_path = /obj/item/clothing/suit/jacket/letterman_nanotrasen

/datum/loadout_item/suit/bee
	name = "Bee Outfit"
	item_path = /obj/item/clothing/suit/hooded/bee_costume

/datum/loadout_item/suit/plague_doctor
	name = "Plague Doctor Suit"
	item_path = /obj/item/clothing/suit/bio_suit/plaguedoctorsuit

//MISC
/datum/loadout_item/suit/poncho
	name = "Poncho"
	item_path = /obj/item/clothing/suit/poncho

/datum/loadout_item/suit/ponchogreen
	name = "Green poncho"
	item_path = /obj/item/clothing/suit/poncho/green

/datum/loadout_item/suit/ponchored
	name = "Red poncho"
	item_path = /obj/item/clothing/suit/poncho/red

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

/*Flannels go inside Misc*/
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

/*Hawaiian Shirts*/
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

/datum/loadout_item/suit/frenchtrench
	name = "Blue Trenchcoat"
	item_path = /obj/item/clothing/suit/frenchtrench

/datum/loadout_item/suit/cossak
	name = "Ukrainian Coat"
	item_path = /obj/item/clothing/suit/cossack

//COATS
/datum/loadout_item/suit/coat/normal
	name = "Winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat

/datum/loadout_item/suit/coat/aformal
	name = "Assistant's formal winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/aformal

/datum/loadout_item/suit/coat/runed
	name = "Runed winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/narsie/fake

/datum/loadout_item/suit/coat/brass
	name = "Brass winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/ratvar/fake

/datum/loadout_item/suit/coat/korea
	name = "Eastern winter coat"
	item_path = /obj/item/clothing/suit/koreacoat

/datum/loadout_item/suit/coat/czech
	name = "Modern winter coat"
	item_path = /obj/item/clothing/suit/modernwintercoatthing

/datum/loadout_item/suit/coat/parka
	name = "Falls Parka"
	item_path = /obj/item/clothing/suit/fallsparka

/datum/loadout_item/suit/coat/poly
	name = "Polychromic Wintercoat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/polychromic

/datum/loadout_item/suit/coat/urban
	name = "Urban Coat"
	item_path = /obj/item/clothing/suit/urban/polychromic

/datum/loadout_item/suit/coat/maxson
	name = "Fancy Brown Coat"
	item_path = /obj/item/clothing/suit/brownbattlecoat


/datum/loadout_item/suit/coat/bossu
	name = "Fancy Black Coat"
	item_path = /obj/item/clothing/suit/blackfurrich


/datum/loadout_item/suit/coat/custom
	name = "Alternate Winter Coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/custom


//JACKETS

/datum/loadout_item/suit/jacket/dutchjacket
	name = "Dutch Jacket"
	item_path = /obj/item/clothing/suit/dutchjacketsr

/datum/loadout_item/suit/jacket/caretaker
	name = "Caretaker Jacket"
	item_path = /obj/item/clothing/suit/victoriantailcoatbutler

/datum/loadout_item/suit/jacket/yakuzajacket
	name = "Asian Jacket"
	item_path = /obj/item/clothing/suit/yakuza

/datum/loadout_item/suit/jacket/suitblue
	name = "Blue Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer

/datum/loadout_item/suit/jacket/suitpurple
	name = "Purple Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/purple

/datum/loadout_item/suit/jacket/suitblack
	name = "Black Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

/datum/loadout_item/suit/jacket/suitblackbetter
	name = "Light Black Suit Jacket"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black/better

/datum/loadout_item/suit/jacket/suitwhite
	name = "White Suit Jacket"
	item_path = /obj/item/clothing/suit/texas

/datum/loadout_item/suit/jacket/jacketbomber
	name = "Bomber jacket"
	item_path = /obj/item/clothing/suit/jacket

/datum/loadout_item/suit/jacket/jacketbomber_alt
	name = "Bomber Jacket w/ Zipper"
	item_path = /obj/item/clothing/suit/toggle/jacket

/datum/loadout_item/suit/jacket/jacketleather
	name = "Leather jacket"
	item_path = /obj/item/clothing/suit/jacket/leather

/datum/loadout_item/suit/jacket/overcoatleather
	name = "Leather overcoat"
	item_path = /obj/item/clothing/suit/jacket/leather/overcoat

/datum/loadout_item/suit/jacket/polyjacketleather
	name = "Colorable leather jacket"
	item_path = /obj/item/clothing/suit/jacket/leather/polychromic

/datum/loadout_item/suit/jacket/woolcoat
	name = "Leather overcoat"
	item_path = /obj/item/clothing/suit/woolcoat

/datum/loadout_item/suit/jacket/jacketpuffer
	name = "Puffer jacket"
	item_path = /obj/item/clothing/suit/jacket/puffer

/datum/loadout_item/suit/jacket/vestpuffer
	name = "Puffer vest"
	item_path = /obj/item/clothing/suit/jacket/puffer/vest

/datum/loadout_item/suit/jacket/jacketlettermanbrown
	name = "Brown letterman jacket"
	item_path = /obj/item/clothing/suit/jacket/letterman

/datum/loadout_item/suit/jacket/jacketlettermanred
	name = "Red letterman jacket"
	item_path = /obj/item/clothing/suit/jacket/letterman_red

/datum/loadout_item/suit/jacket/jacketlettermanNT
	name = "Nanotrasen letterman jacket"
	item_path = /obj/item/clothing/suit/jacket/letterman_nanotrasen

/datum/loadout_item/suit/jacket/militaryjacket
	name = "Military Jacket"
	item_path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/jacket/flakjack
	name = "Flak Jacket"
	item_path = /obj/item/clothing/suit/flakjack


/datum/loadout_item/suit/jacket/cardigan
	name = "Cardigan"
	item_path = /obj/item/clothing/suit/toggle/jacket/cardigan

//HOODIES

/datum/loadout_item/suit/hoodie/grey
	name = "Grey Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie

/datum/loadout_item/suit/hoodie/black
	name = "Black Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/black

/datum/loadout_item/suit/hoodie/red
	name = "Red Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/red

/datum/loadout_item/suit/hoodie/blue
	name = "Blue Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/blue

/datum/loadout_item/suit/hoodie/green
	name = "Green Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/green

/datum/loadout_item/suit/hoodie/orange
	name = "orange hoodies"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/orange

/datum/loadout_item/suit/hoodie/yellow
	name = "Yellow Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/yellow

/datum/loadout_item/suit/hoodie/white
	name = "White Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/white

/datum/loadout_item/suit/hoodie/cti
	name = "CTI Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/cti

/datum/loadout_item/suit/hoodie/mu
	name = "Mojave University Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/mu

/datum/loadout_item/suit/hoodie/nt
	name = "NT Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/nt

/datum/loadout_item/suit/hoodie/smw
	name = "SMW Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/smw

/datum/loadout_item/suit/hoodie/nrti
	name = "NRTI Hoodie"
	item_path = /obj/item/clothing/suit/storage/toggle/hoodie/nrti

//JOB RELATED

/datum/loadout_item/suit/job/coat_med
	name = "Medical winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/medical
	restricted_roles = list("Chief Medical Officer", "Medical Doctor") // Reserve it to Medical Doctors and their boss, the Chief Medical Officer

/datum/loadout_item/suit/job/coat_paramedic
	name = "Paramedic winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/paramedic
	restricted_roles = list("Chief Medical Officer", "Paramedic") // Reserve it to Paramedics and their boss, the Chief Medical Officer

/datum/loadout_item/suit/job/coat_robotics
	name = "Robotics winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/robotics
	restricted_roles = list("Research Director", "Roboticist")

/datum/loadout_item/suit/job/coat_sci
	name = "Science winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/science
	restricted_roles = list("Research Director", "Scientist", "Roboticist", "Vanguard Operative") // Reserve it to the Science Departement

/datum/loadout_item/suit/job/coat_eng
	name = "Engineering winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering
	restricted_roles = list("Chief Engineer", "Station Engineer") // Reserve it to Station Engineers and their boss, the Chief Engineer

/datum/loadout_item/suit/job/coat_atmos
	name = "Atmospherics winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	restricted_roles = list("Chief Engineer", "Atmospheric Technician") // Reserve it to Atmos Techs and their boss, the Chief Engineer

/datum/loadout_item/suit/job/coat_hydro
	name = "Hydroponics winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/hydro
	restricted_roles = list("Head of Personnel", "Botanist") // Reserve it to Botanists and their boss, the Head of Personnel

/datum/loadout_item/suit/job/coat_bar
	name = "Bartender winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/bartender
	restricted_roles = list("Head of Personnel", "Bartender") //Reserved for Bartenders and their head-of-staff

/datum/loadout_item/suit/job/coat_cargo
	name = "Cargo winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/cargo
	restricted_roles = list("Quartermaster", "Cargo Technician") // Reserve it to Cargo Techs and their boss, the Quartermaster

/datum/loadout_item/suit/job/coat_miner
	name = "Mining winter coat"
	item_path = /obj/item/clothing/suit/hooded/wintercoat/miner
	restricted_roles = list("Quartermaster", "Shaft Miner") // Reserve it to Miners and their boss, the Quartermaster

// SKYRAT EDIT REMOVAL - COMMAND CLOTHING VENDOR
/*
/datum/loadout_item/suit/job/navybluejackethos
	name = "head of security's navyblue jacket"
	item_path = /obj/item/clothing/suit/armor/hos/navyblue
	restricted_roles = list("Head of Security")
*/
// SKYRAT EDIT END

/datum/loadout_item/suit/job/navybluejacketofficer
	name = "security officer's navyblue jacket"
	item_path = /obj/item/clothing/suit/armor/navyblue
	restricted_roles = list("Security Officer","Security Medic","Security Sergeant","Head of Security", "Warden") // I aint making a medic one, maybe i'll add some rank thing from cm or civ for it

/datum/loadout_item/suit/job/navybluejacketwarden
	name = "warden navyblue jacket"
	item_path = /obj/item/clothing/suit/armor/vest/warden/navyblue
	restricted_roles = list("Warden")

/datum/loadout_item/suit/job/security_jacket
	name = "Security Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sec
	restricted_roles = list("Head of Security", "Security Officer", "Warden", "Detective", "Security Medic", "Security Sergeant") //Not giving this one to CDOs or COs because it's actually better than the one they spawn with
/datum/loadout_item/suit/job/cossak
	name = "Ukrainian Security Jacket"
	item_path = /obj/item/clothing/suit/cossack/sec
	restricted_roles = list("Head of Security", "Security Officer", "Warden", "Detective", "Security Medic", "Security Sergeant", "Civil Disputes Officer", "Corrections Officer")

/datum/loadout_item/suit/job/brit
	name = "High Vis Armored Vest"
	item_path = /obj/item/clothing/suit/toggle/brit/sec
	restricted_roles = list("Head of Security", "Security Officer", "Warden", "Detective", "Security Medic", "Security Sergeant", "Civil Disputes Officer", "Corrections Officer")
/datum/loadout_item/suit/job/british_jacket
	name = "Peacekeeper Officer Coat"
	item_path = /obj/item/clothing/suit/british_officer
	restricted_roles = list("Head of Security", "Warden","Detective","Security Sergeant")

/datum/loadout_item/suit/job/engi_jacket
	name = "Engineering Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/engi
	restricted_roles = list("Chief Engineer", "Station Engineer", "Atmospheric Technician")

/datum/loadout_item/suit/job/sci_jacket
	name = "Science Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/sci
	restricted_roles = list("Research Director", "Scientist", "Roboticist", "Geneticist", "Vanguard Operative")

/datum/loadout_item/suit/job/med_jacket
	name = "Medbay Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/med
	restricted_roles = list("Chief Medical Officer", "Medical Doctor", "Paramedic", "Chemist", "Virologist")

/datum/loadout_item/suit/job/supply_jacket
	name = "Supply Jacket"
	item_path = /obj/item/clothing/suit/toggle/jacket/supply
	restricted_roles = list("Quartermaster", "Cargo Technician", "Miner")

/datum/loadout_item/suit/job/supply_gorka_jacket
	name = "Supply Gorka Jacket"
	item_path = /obj/item/clothing/suit/gorka/supply
	restricted_roles = list("Quartermaster", "Cargo Technician", "Miner")


/datum/loadout_item/suit/job/labcoat_parared
	name = "Red Paramedic Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/para_red
	restricted_roles = list("Chief Medical Officer", "Paramedic","Security Medic") // its a medic jacket anyway screw you

/datum/loadout_item/suit/job/labcoat_highvis
	name = "High-Vis Labcoat"
	item_path = /obj/item/clothing/suit/toggle/labcoat/highvis
	restricted_roles = list("Chief Medical Officer", "Paramedic", "Atmospheric Technician", "Detective", "Security Medic") // why does the atmos get this? sec med is more of a first responder lmao

/datum/loadout_item/suit/job/discojacket
	name = "Disco Ass Blazer"
	item_path = /obj/item/clothing/suit/discoblazer
	restricted_roles = list("Detective")

/datum/loadout_item/suit/job/deckard
	name = "Runner Coat"
	item_path = /obj/item/clothing/suit/toggle/deckard
	restricted_roles = list("Detective")

//Trekkie things.
/datum/loadout_item/suit/job/trek/fedcoat
	name = "Federation Jacket"
	item_path = /obj/item/clothing/suit/storage/fluff/fedcoat

/datum/loadout_item/suit/job/trek/fedmedsci
	name = "Medsci fed jacket"
	item_path = /obj/item/clothing/suit/storage/fluff/fedcoat/medsci
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Chemist","Virologist","Paramedic","Security Medic","Psychologist","Geneticist","Research Director","Scientist","Roboticist","Vanguard Operative")

/datum/loadout_item/suit/job/trek/fedeng
	name = "Ops/Sec fed Jacket"
	item_path = /obj/item/clothing/suit/storage/fluff/fedcoat/eng
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Warden","Security Medic","Security Sergeant","Detective","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer","Cargo Technician", "Shaft Miner", "Quartermaster")

//Modern trekkie
/datum/loadout_item/suit/job/trek/fedcoatmodern
	name = "Modern fed jacket"
	item_path = /obj/item/clothing/suit/storage/fluff/mfedcoat

/datum/loadout_item/suit/job/trek/fedcoatmodernmedsci
	name = "Modern medsci jacket"
	item_path = /obj/item/clothing/suit/storage/fluff/mfedcoat/medsci
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Paramedic","Chemist","Virologist","Security Medic","Psychologist","Geneticist","Research Director","Scientist","Roboticist","Vanguard Operative")

/datum/loadout_item/suit/job/trek/fedcoatmoderneng
	name = "Modern ops jacket"
	item_path = /obj/item/clothing/suit/storage/fluff/mfedcoat/eng
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Cargo Technician", "Shaft Miner", "Quartermaster")

/datum/loadout_item/suit/job/trek/fedcoatmodernsec
	name = "Modern sec jacket"
	item_path = /obj/item/clothing/suit/storage/fluff/mfedcoat/sec
	restricted_roles = list("Head of Security", "Security Officer", "Warden", "Detective", "Security Medic", "Security Sergeant","Civil Disputes Officer","Corrections Officer")

/datum/loadout_item/suit/bltrench
	name = "Black Trenchcoat"
	item_path = /obj/item/clothing/suit/trenchblack


/datum/loadout_item/suit/brtrench
	name = "Brown Trenchcoat"
	item_path = /obj/item/clothing/suit/trenchbrown

