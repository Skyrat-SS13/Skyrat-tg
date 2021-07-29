/datum/loadout_item/head
	category = LOADOUT_CATEGORY_HEAD

//MISC
/datum/loadout_item/head/baseball
	name = "Ballcap"
	path = /obj/item/clothing/head/soft/mime
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/head/beanie
	name = "Beanie"
	path = /obj/item/clothing/head/beanie
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/head/beret_white
	name = "Beret"
	path = /obj/item/clothing/head/beret/white
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/head/beret
	name = "Black beret"
	path = /obj/item/clothing/head/beret/black

/datum/loadout_item/head/flatcap
	name = "Flat cap"
	path = /obj/item/clothing/head/flatcap

/datum/loadout_item/head/pirate
	name = "Pirate hat"
	path = /obj/item/clothing/head/pirate

/datum/loadout_item/head/rice_hat
	name = "Rice hat"
	path = /obj/item/clothing/head/rice_hat

/datum/loadout_item/head/ushanka
	name = "Ushanka"
	path = /obj/item/clothing/head/ushanka

/datum/loadout_item/head/slime
	name = "Slime hat"
	path = /obj/item/clothing/head/collectable/slime

/datum/loadout_item/head/fedora
	name = "Fedora"
	path = /obj/item/clothing/head/fedora

/datum/loadout_item/head/that
	name = "Top Hat"
	path = /obj/item/clothing/head/that

/datum/loadout_item/head/flakhelm
	name = "Flak Helmet"
	path = /obj/item/clothing/head/flakhelm
	cost = 2

/datum/loadout_item/head/bunnyears
	name = "Bunny Ears"
	path = /obj/item/clothing/head/rabbitears

/datum/loadout_item/head/mailmanhat
	name = "Mailman's Hat"
	path = /obj/item/clothing/head/mailman

/datum/loadout_item/head/whitekepi
	name = "White Kepi"
	path = /obj/item/clothing/head/kepi

/datum/loadout_item/head/whitekepiold
	name = "White Kepi, Old"
	path = /obj/item/clothing/head/kepi/old

/datum/loadout_item/head/maidhead
	name = "Maid Headband"
	path = /obj/item/clothing/head/maid

/datum/loadout_item/head/widehat
	name = "Wide Black Hat"
	path = /obj/item/clothing/head/costume/widehat

/datum/loadout_item/head/widehat_red
	name = "Wide Red Hat"
	path = /obj/item/clothing/head/costume/widehat/red

/datum/loadout_item/head/cardboard
	name = "Cardboard Helmet"
	path = /obj/item/clothing/head/cardborg
	cost = 2

/datum/loadout_item/head/wig
	name = "Wig"
	path = /obj/item/clothing/head/wig
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/head/wignatural
	name = "Natural Wig"
	path = /obj/item/clothing/head/wig/natural

//Cowboy Stuff
/datum/loadout_item/head/cowboyhat
	name = "Cowboy Hat, Brown"
	path = /obj/item/clothing/head/cowboyhat

/datum/loadout_item/head/cowboyhat/black
	name = "Cowboy Hat, Black"
	path = /obj/item/clothing/head/cowboyhat/black

/datum/loadout_item/head/cowboyhat/blackwide
	name = "Wide Cowboy Hat, Black"
	path = /obj/item/clothing/head/cowboyhat/blackwide

/datum/loadout_item/head/cowboyhat/wide
	name = "Wide Cowboy Hat, Brown"
	path = /obj/item/clothing/head/cowboyhat/wide

/datum/loadout_item/head/cowboyhat/white
	name = "Cowboy Hat, White"
	path = /obj/item/clothing/head/cowboyhat/white

/datum/loadout_item/head/cowboyhat/pink
	name = "Cowboy Hat, Pink"
	path = /obj/item/clothing/head/cowboyhat/pink

//trek fancy Hats!
/datum/loadout_item/head/trek/trekcap
	name = "Federation Officer's Cap (White)"
	path = /obj/item/clothing/head/caphat/formal/fedcover
	restricted_roles = list("Captain","Head of Personnel")

/datum/loadout_item/head/trek/trekcapcap
	name = "Federation Officer's Cap (Black)"
	path = /obj/item/clothing/head/caphat/formal/fedcover/black
	restricted_roles = list("Captain","Head of Personnel")

/datum/loadout_item/head/trek/trekcapmedisci
	name = "Federation Officer's Cap (Blue)"
	path = /obj/item/clothing/head/caphat/formal/fedcover/medsci
	restricted_desc = "Medical and Science"
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Security Medic","Paramedic","Chemist","Virologist","Geneticist","Research Director","Scientist", "Roboticist")

/datum/loadout_item/head/trek/trekcapeng
	name = "Federation Officer's Cap (Yellow)"
	path = /obj/item/clothing/head/caphat/formal/fedcover/eng
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Security Medic","Security Sergeant","Warden","Detective","Security Officer","Head of Security","Cargo Technician", "Shaft Miner", "Quartermaster")

/datum/loadout_item/head/trek/trekcapsec
	name = "Federation Officer's Cap (Red)"
	path = /obj/item/clothing/head/caphat/formal/fedcover/sec
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Security Medic","Security Sergeant","Warden","Detective","Security Officer","Head of Security","Cargo Technician", "Shaft Miner", "Quartermaster")

/*Commenting out Until next Christmas or made automatic
/datum/gear/santahatr
	name = "Red Santa Hat"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/christmashat
/datum/gear/santahatg
	name = "Green Santa Hat"
	category = SLOT_HEAD
	path = /obj/item/clothing/head/christmashatg
*/

//JOB
/datum/loadout_item/head/job
	subcategory = LOADOUT_SUBCATEGORY_JOB

/datum/loadout_item/head/job/cowboyhat/sec
	name = "Cowboy Hat, Security"
	path = /obj/item/clothing/head/cowboyhat/sec
	restricted_desc = "Security"
	restricted_roles = list("Warden","Detective","Security Medic","Security Sergeant","Security Officer","Head of Security")

/datum/loadout_item/head/job/cowboyhat/secwide
	name = "Wide Cowboy Hat, Security"
	path = /obj/item/clothing/head/cowboyhat/widesec
	restricted_desc = "Security"
	restricted_roles = list("Warden","Detective","Security Medic","Security Sergeant","Security Officer","Head of Security")

/datum/loadout_item/head/job/sec/ushanka
	name = "Security Ushanka"
	path = /obj/item/clothing/head/ushankasec
	restricted_desc = "Security"
	restricted_roles = list("Warden","Detective","Security Medic","Security Sergeant","Security Officer","Head of Security")

/datum/loadout_item/head/job/navybluehosberet
	name = "Head of security's navyblue beret"
	path = /obj/item/clothing/head/beret/sec/navyhos
	restricted_roles = list("Head of Security")

/datum/loadout_item/head/job/navyblueofficerberet
	name = "Security officer's Navyblue beret"
	path = /obj/item/clothing/head/beret/sec/navyofficer
	restricted_roles = list("Security Officer","Security Medic","Security Sergeant",)

/datum/loadout_item/head/job/navybluewardenberet
	name = "Warden's navyblue beret"
	path = /obj/item/clothing/head/beret/sec/navywarden
	restricted_roles = list("Warden")

/datum/loadout_item/head/job/cybergoggles	//Cyberpunk-P.I. Outfit
	name = "Type-34C Forensics Headwear"
	path = /obj/item/clothing/head/fedora/det_hat/cybergoggles
	restricted_roles = list("Detective")
	restricted_desc = "Detective"

/datum/loadout_item/head/job/nursehat
	name = "Nurse Hat"
	path = /obj/item/clothing/head/nursehat
	restricted_roles = list("Medical Doctor", "Chief Medical Officer", "Geneticist", "Chemist", "Virologist","Security Medic")
	restricted_desc = "Medical"

// JOB - Berets
/datum/loadout_item/head/job/atmos_beret
	name = "Atmospherics Beret"
	path = /obj/item/clothing/head/beret/job/atmos
	restricted_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")
	restricted_desc = "Engineering"

/datum/loadout_item/head/job/engi_beret
	name = "Engineering Beret"
	path = /obj/item/clothing/head/beret/job/engi
	restricted_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")
	restricted_desc = "Engineering"

/datum/loadout_item/head/job/CE_beret
	name = "Chief Engineer's Beret"
	path = /obj/item/clothing/head/beret/job/engi/head
	restricted_roles = list("Chief Engineer")
	restricted_desc = "Chief Engineer"

/datum/loadout_item/head/job/CE_beret_alt
	name = "Chief Engineer's White Beret"
	path = /obj/item/clothing/head/beret/job/engi/head/alt
	restricted_roles = list("Chief Engineer")
	restricted_desc = "Chief Engineer"

/datum/loadout_item/head/job/med
	name = "Medical Beret"
	path = /obj/item/clothing/head/beret/job/med
	restricted_roles = list("Medical Doctor","Virologist", "Chemist", "Chief Medical Officer","Security Medic")
	restricted_desc = "Medical"

/datum/loadout_item/head/job/med_viro
	name = "Virology Beret"
	path = /obj/item/clothing/head/beret/job/med/viro
	restricted_roles = list("Virologist", "Chief Medical Officer")
	restricted_desc = "Virology"

/datum/loadout_item/head/job/med_chem
	name = "Chemistry Beret"
	path = /obj/item/clothing/head/beret/job/med/chem
	restricted_roles = list("Chemist", "Chief Medical Officer")
	restricted_desc = "Chemistry"

/datum/loadout_item/head/job/CMO_beret
	name = "Chief Medical Officer's Beret"
	path = /obj/item/clothing/head/beret/job/med/head
	restricted_roles = list("Chief Medical Officer")
	restricted_desc = "Chief Medical Officer"

/datum/loadout_item/head/job/CMO_beret_alt
	name = "Chief Medical Officer's Blue Beret"
	path = /obj/item/clothing/head/beret/job/med/head/alt
	restricted_roles = list("Chief Medical Officer")
	restricted_desc = "Chief Medical Officer"

/datum/loadout_item/head/job/sci
	name = "Scientist's Beret"
	path = /obj/item/clothing/head/beret/job/sci
	restricted_roles = list("Scientist", "Roboticist", "Geneticist", "Research Director")
	restricted_desc = "Science"

/datum/loadout_item/head/job/robo
	name = "Roboticist's Beret"
	path = /obj/item/clothing/head/beret/job/sci/robo
	restricted_roles = list("Roboticist", "Research Director")
	restricted_desc = "Robotics"

/datum/loadout_item/head/job/RD_beret
	name = "Research Director's Beret"
	path = /obj/item/clothing/head/beret/job/sci/head
	restricted_roles = list("Research Director")
	restricted_desc = "Research Director"

/datum/loadout_item/head/job/RD_beret_alt
	name = "Research Director's White Beret"
	path = /obj/item/clothing/head/beret/job/sci/head/alt
	restricted_roles = list("Research Director")
	restricted_desc = "Research Director"

/datum/loadout_item/head/job/QM_beret
	name = "Quartermaster's Beret"
	path = /obj/item/clothing/head/beret/job/quartermaster
	restricted_roles = list("Quartermaster")
	restricted_desc = "Quartermaster"

/datum/loadout_item/head/job/Cap_beret
	name = "Captain's Beret"
	path = /obj/item/clothing/head/beret/job/captain
	restricted_roles = list("Captain")
	restricted_desc = "Captain"

/datum/loadout_item/head/job/Cap_beret_alt
	name = "Captain's White Beret"
	path = /obj/item/clothing/head/beret/job/captain/alt
	restricted_roles = list("Captain")
	restricted_desc = "Captain"

/datum/loadout_item/head/job/HOP_beret
	name = "Head of Personnel's Beret"
	path = /obj/item/clothing/head/beret/job/hop
	restricted_roles = list("Head of Personnel")
	restricted_desc = "Head of Personnel"

/datum/loadout_item/head/job/HOP_beret_alt
	name = "Head of Personnel's White Beret"
	path = /obj/item/clothing/head/beret/job/hop/alt
	restricted_roles = list("Head of Personnel")
	restricted_desc = "Head of Personnel"
