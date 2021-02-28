/datum/loadout_item/suit
	category = LOADOUT_CATEGORY_SUIT

//MISC
/datum/loadout_item/suit/poncho
	name = "Poncho"
	path = /obj/item/clothing/suit/poncho

/datum/loadout_item/suit/ponchogreen
	name = "Green poncho"
	path = /obj/item/clothing/suit/poncho/green

/datum/loadout_item/suit/ponchored
	name = "Red poncho"
	path = /obj/item/clothing/suit/poncho/red

/datum/loadout_item/suit/redhood
	name = "Red cloak"
	path = /obj/item/clothing/suit/hooded/cloak/david
	cost = 3

/datum/loadout_item/suit/ianshirt
	name = "Ian Shirt"
	path = /obj/item/clothing/suit/ianshirt

/datum/loadout_item/suit/wornshirt
	name = "Worn Shirt"
	path = /obj/item/clothing/suit/wornshirt
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/suit/tailcoat
	name = "Tailcoat"
	path = /obj/item/clothing/suit/costume/tailcoat

/datum/loadout_item/suit/dresscoat
	name = "Black Dresscoat"
	path = /obj/item/clothing/suit/costume/vic_dresscoat

/datum/loadout_item/suit/dresscoat_red
	name = "Red Dresscoat"
	path = /obj/item/clothing/suit/costume/vic_dresscoat/red

/*Flannels go inside Misc*/
/datum/loadout_item/suit/flannel_black
	name = "Black Flannel"
	path = /obj/item/clothing/suit/toggle/jacket/flannel

/datum/loadout_item/suit/flannel_red
	name = "Red Flannel"
	path = /obj/item/clothing/suit/toggle/jacket/flannel/red
	
/datum/loadout_item/suit/flannel_aqua
	name = "Aqua Flannel"
	path = /obj/item/clothing/suit/toggle/jacket/flannel/aqua
	
/datum/loadout_item/suit/flannel_brown
	name = "Brown Flannel"
	path = /obj/item/clothing/suit/toggle/jacket/flannel/brown

//COATS
/datum/loadout_item/suit/coat
	subcategory = LOADOUT_SUBCATEGORY_SUIT_COATS

/datum/loadout_item/suit/coat/normal
	name = "Winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat

/datum/loadout_item/suit/coat/aformal
	name = "Assistant's formal winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/aformal

/datum/loadout_item/suit/coat/runed
	name = "Runed winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/narsie/fake

/datum/loadout_item/suit/coat/brass
	name = "Brass winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/ratvar/fake

/datum/loadout_item/suit/coat/poly
	name = "Polychromic Wintercoat"
	path = /obj/item/clothing/suit/hooded/wintercoat/polychromic
	extra_info = LOADOUT_INFO_THREE_COLORS
	cost = 3

//JACKETS
/datum/loadout_item/suit/jacket
	subcategory = LOADOUT_SUBCATEGORY_SUIT_JACKETS

/datum/loadout_item/suit/jacket/jacketbomber
	name = "Bomber jacket"
	path = /obj/item/clothing/suit/jacket

/datum/loadout_item/suit/jacket/jacketbomber_alt
	name = "Bomber Jacket w/ Zipper"
	path = /obj/item/clothing/suit/toggle/jacket

/datum/loadout_item/suit/jacket/jacketleather
	name = "Leather jacket"
	path = /obj/item/clothing/suit/jacket/leather

/datum/loadout_item/suit/jacket/overcoatleather
	name = "Leather overcoat"
	path = /obj/item/clothing/suit/jacket/leather/overcoat

/datum/loadout_item/suit/jacket/jacketpuffer
	name = "Puffer jacket"
	path = /obj/item/clothing/suit/jacket/puffer

/datum/loadout_item/suit/jacket/vestpuffer
	name = "Puffer vest"
	path = /obj/item/clothing/suit/jacket/puffer/vest

/datum/loadout_item/suit/jacket/jacketlettermanbrown
	name = "Brown letterman jacket"
	path = /obj/item/clothing/suit/jacket/letterman

/datum/loadout_item/suit/jacket/jacketlettermanred
	name = "Red letterman jacket"
	path = /obj/item/clothing/suit/jacket/letterman_red

/datum/loadout_item/suit/jacket/jacketlettermanNT
	name = "Nanotrasen letterman jacket"
	path = /obj/item/clothing/suit/jacket/letterman_nanotrasen

/datum/loadout_item/suit/jacket/militaryjacket
	name = "Military Jacket"
	path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/jacket/flakjack
	name = "Flak Jacket"
	path = /obj/item/clothing/suit/flakjack
	cost = 2

//JOB RELATED
/datum/loadout_item/suit/job
	subcategory = LOADOUT_SUBCATEGORY_JOB

/datum/loadout_item/suit/job/coat_med
	name = "Medical winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/medical
	restricted_roles = list("Chief Medical Officer", "Medical Doctor") // Reserve it to Medical Doctors and their boss, the Chief Medical Officer

/datum/loadout_item/suit/job/coat_paramedic
	name = "Paramedic winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/paramedic
	restricted_roles = list("Chief Medical Officer", "Paramedic") // Reserve it to Paramedics and their boss, the Chief Medical Officer

/datum/loadout_item/suit/job/coat_robotics
	name = "Robotics winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/robotics
	restricted_roles = list("Research Director", "Roboticist")

/datum/loadout_item/suit/job/coat_sci
	name = "Science winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/science
	restricted_roles = list("Research Director", "Scientist", "Roboticist") // Reserve it to the Science Departement

/datum/loadout_item/suit/job/coat_eng
	name = "Engineering winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/engineering
	restricted_roles = list("Chief Engineer", "Station Engineer") // Reserve it to Station Engineers and their boss, the Chief Engineer

/datum/loadout_item/suit/job/coat_atmos
	name = "Atmospherics winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/engineering/atmos
	restricted_roles = list("Chief Engineer", "Atmospheric Technician") // Reserve it to Atmos Techs and their boss, the Chief Engineer

/datum/loadout_item/suit/job/coat_hydro
	name = "Hydroponics winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/hydro
	restricted_roles = list("Head of Personnel", "Botanist") // Reserve it to Botanists and their boss, the Head of Personnel

/datum/loadout_item/suit/job/coat_bar
	name = "Bartender winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/bartender
	restricted_roles = list("Head of Personnel", "Bartender") //Reserved for Bartenders and their head-of-staff

/datum/loadout_item/suit/job/coat_cargo
	name = "Cargo winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/cargo
	restricted_roles = list("Quartermaster", "Cargo Technician") // Reserve it to Cargo Techs and their boss, the Quartermaster

/datum/loadout_item/suit/job/coat_miner
	name = "Mining winter coat"
	path = /obj/item/clothing/suit/hooded/wintercoat/miner
	restricted_roles = list("Quartermaster", "Shaft Miner") // Reserve it to Miners and their boss, the Quartermaster

/datum/loadout_item/suit/job/navybluejackethos
	name = "head of security's navyblue jacket"
	path = /obj/item/clothing/suit/armor/hos/navyblue
	restricted_roles = list("Head of Security")

/datum/loadout_item/suit/job/navybluejacketofficer
	name = "security officer's navyblue jacket"
	path = /obj/item/clothing/suit/armor/navyblue
	restricted_roles = list("Security Officer")

/datum/loadout_item/suit/job/navybluejacketwarden
	name = "warden navyblue jacket"
	path = /obj/item/clothing/suit/armor/vest/warden/navyblue
	restricted_roles = list("Warden")

/datum/loadout_item/suit/job/security_jacket
	name = "Security Jacket"
	path = /obj/item/clothing/suit/toggle/jacket/sec
	restricted_roles = list("Head of Security", "Security Officer", "Warden", "Detective", "Security Medic", "Security Sergeant")
	restricted_desc = "All Security Personnel"

/datum/loadout_item/suit/job/engi_jacket
	name = "Engineering Jacket"
	path = /obj/item/clothing/suit/toggle/jacket/engi
	restricted_roles = list("Chief Engineer", "Station Engineer", "Atmospheric Technician")
	restricted_desc = "All Engineering Personnel"

/datum/loadout_item/suit/job/sci_jacket
	name = "Science Jacket"
	path = /obj/item/clothing/suit/toggle/jacket/sci
	restricted_roles = list("Research Director", "Scientist", "Roboticist", "Geneticist")
	restricted_desc = "All Science Personnel"

/datum/loadout_item/suit/job/med_jacket
	name = "Medbay Jacket"
	path = /obj/item/clothing/suit/toggle/jacket/med
	restricted_roles = list("Chief Medical Officer", "Medical Doctor", "Paramedic", "Chemist", "Virologist")
	restricted_desc = "All Medical Personnel"

/datum/loadout_item/suit/job/supply_jacket
	name = "Supply Jacket"
	path = /obj/item/clothing/suit/toggle/jacket/supply
	restricted_roles = list("Quartermaster", "Cargo Technician", "Miner")
	restricted_desc = "All Cargo Personnel"

/datum/loadout_item/suit/job/supply_head_jacket
	name = "Quartermaster's Jacket"
	path = /obj/item/clothing/suit/toggle/jacket/supply/head
	restricted_roles = list("Quartermaster")
	restricted_desc = "Quartermaster Only"

/datum/loadout_item/suit/job/labcoat_parared
	name = "Red Paramedic Labcoat"
	path = /obj/item/clothing/suit/toggle/labcoat/para_red
	restricted_roles = list("Chief Medical Officer", "Paramedic")
	restricted_desc = "Medical First Responders"

/datum/loadout_item/suit/job/labcoat_highvis
	name = "High-Vis Labcoat"
	path = /obj/item/clothing/suit/toggle/labcoat/highvis
	restricted_roles = list("Chief Medical Officer", "Paramedic", "Atmospheric Technician", "Detective")
	restricted_desc = "First Responders and Detective"