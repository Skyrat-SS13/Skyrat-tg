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

// /datum/loadout_item/head/beret_white
// 	name = "Beret"
// 	path = /obj/item/clothing/head/beret/white
// 	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/head/beret
	name = "Black beret"
	path = /obj/item/clothing/head/beret/black

/datum/loadout_item/head/flatcap
	name = "Flat cap"
	path = /obj/item/clothing/head/flatcap

/datum/loadout_item/head/pflatcap
	name = "Poly Flat cap"
	path = /obj/item/clothing/head/polyflatc
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/head/pirate
	name = "Pirate hat"
	path = /obj/item/clothing/head/pirate

/datum/loadout_item/head/flowerpin
	name = "Flower Pin"
	path = /obj/item/clothing/head/flowerpin
	extra_info = LOADOUT_INFO_THREE_COLORS

/datum/loadout_item/head/rice_hat
	name = "Rice hat"
	path = /obj/item/clothing/head/rice_hat

/datum/loadout_item/head/ushanka
	name = "Ushanka"
	path = /obj/item/clothing/head/ushanka

/datum/loadout_item/head/wrussian
	name = "Black Papakha"
	path = /obj/item/clothing/head/whiterussian

/datum/loadout_item/head/wrussianw
	name = "White Papakha"
	path = /obj/item/clothing/head/whiterussian/white

/datum/loadout_item/head/wrussianb
	name = "Black and Red Papakha"
	path = /obj/item/clothing/head/whiterussian/black

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

/datum/loadout_item/head/hijab
	name = "Hijab"
	path = /obj/item/clothing/head/hijab
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/head/turban
	name = "Turban"
	path = /obj/item/clothing/head/turb
	extra_info = LOADOUT_INFO_ONE_COLOR

/datum/loadout_item/head/keff
	name = "Keffiyeh"
	path = /obj/item/clothing/head/keffiyeh
	extra_info = LOADOUT_INFO_THREE_COLORS

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

/datum/loadout_item/head/cowboyhat/winter
	name = "Winter Cowboy Hat"
	path = /obj/item/clothing/head/cowboyhat/sheriff

/datum/loadout_item/head/cowboyhat/sheriff
	name = "Sheriff Hat"
	path = /obj/item/clothing/head/cowboyhat/sheriff/alt

/datum/loadout_item/head/cowboyhat/deputy
	name = "Deputy Hat"
	path = /obj/item/clothing/head/cowboyhat/deputy

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
	restricted_roles = list("Chief Medical Officer","Medical Doctor","Security Medic","Paramedic","Chemist","Virologist","Psychologist","Geneticist","Research Director","Scientist","Roboticist","Vanguard Operative")

/datum/loadout_item/head/trek/trekcapeng
	name = "Federation Officer's Cap (Yellow)"
	path = /obj/item/clothing/head/caphat/formal/fedcover/eng
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Security Medic","Security Sergeant","Warden","Detective","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer","Cargo Technician", "Shaft Miner", "Quartermaster")

/datum/loadout_item/head/trek/trekcapsec
	name = "Federation Officer's Cap (Red)"
	path = /obj/item/clothing/head/caphat/formal/fedcover/sec
	restricted_desc = "Engineering, Security, and Cargo"
	restricted_roles = list("Chief Engineer","Atmospheric Technician","Station Engineer","Security Medic","Security Sergeant","Warden","Detective","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer","Cargo Technician", "Shaft Miner", "Quartermaster")

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

/datum/loadout_item/head/job/captain/imperial
	name = "Captain's Naval Cap"
	path = /obj/item/clothing/head/imperial/cap
	restricted_roles = list("Captain", "Nanotrasen Representative")

/datum/loadout_item/head/job/hop/imperial
	name = "Head of Personnel's Naval Cap"
	path = /obj/item/clothing/head/imperial/hop
	restricted_roles = list("Head of Personnel", "Nanotrasen Representative")

/datum/loadout_item/head/job/ce/imperial
	name = "Chief Engineer's blast helmet."
	path = /obj/item/clothing/head/imperial/ce
	restricted_roles = list("Chief Engineer")

/datum/loadout_item/head/job/cowboyhat/sec
	name = "Cowboy Hat, Security"
	path = /obj/item/clothing/head/cowboyhat/sec
	restricted_desc = "Security"
	restricted_roles = list("Warden","Detective","Security Medic","Security Sergeant","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer")

/datum/loadout_item/head/job/cowboyhat/secwide
	name = "Wide Cowboy Hat, Security"
	path = /obj/item/clothing/head/cowboyhat/widesec
	restricted_desc = "Security"
	restricted_roles = list("Warden","Detective","Security Medic","Security Sergeant","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer")

/datum/loadout_item/head/job/sec/ushanka
	name = "Security Ushanka"
	path = /obj/item/clothing/head/ushankasec
	restricted_desc = "Security"
	restricted_roles = list("Warden","Detective","Security Medic","Security Sergeant","Security Officer","Head of Security","Civil Disputes Officer","Corrections Officer")

/datum/loadout_item/head/job/blasthelmet
	name = "General's Helmet"
	path = /obj/item/clothing/head/imperialhelmet
	restricted_desc = "Security and Command"
	restricted_roles = list("Warden","Detective","Security Medic","Security Sergeant","Security Officer","Civil Disputes Officer","Corrections Officer","Captain", "Head of Personnel", "Blueshield", "Head of Security", "Research Director", "Quartermaster", "Chief Medical Officer", "Chief Engineer")

/datum/loadout_item/head/job/navybluehoscap
	name = "Head of Security's Naval Cap"
	path = /obj/item/clothing/head/imperial/hos
	restricted_roles = list("Head of Security")

/datum/loadout_item/head/job/navyblueofficerberet
	name = "Security officer's Navyblue beret"
	path = /obj/item/clothing/head/beret/sec/navyofficer
	restricted_roles = list("Security Officer","Security Medic","Security Sergeant",)

/datum/loadout_item/head/job/solofficercap
	name = "Security officer's Sol Cap"
	path = /obj/item/clothing/head/sec/peacekeeper/sol
	restricted_roles = list("Security Officer","Security Medic","Security Sergeant",)

/datum/loadout_item/head/job/soltrafficoff
	name = "Traffic Officer Cap"
	path = /obj/item/clothing/head/soltraffic
	restricted_roles = list("Security Officer","Security Medic","Security Sergeant","Civil Disputes Officer")

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

/datum/loadout_item/head/job/imperial
	name = "Naval Officer Cap"
	path = /obj/item/clothing/head/imperial
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield", "Head of Security", "Research Director", "Quartermaster", "Chief Medical Officer", "Chief Engineer", "Nanotrasen Representative")
	restricted_desc = "Command Staff"

/datum/loadout_item/head/job/impgrey
	name = "Grey Naval Officer Cap"
	path = /obj/item/clothing/head/imperial/grey
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield", "Head of Security", "Research Director", "Quartermaster", "Chief Medical Officer", "Chief Engineer", "Nanotrasen Representative")
	restricted_desc = "Command Staff"

/datum/loadout_item/head/job/impred
	name = "Red Naval Officer Cap"
	path = /obj/item/clothing/head/imperial/red
	restricted_roles = list("Captain", "Head of Personnel", "Blueshield", "Head of Security", "Research Director", "Quartermaster", "Chief Medical Officer", "Chief Engineer")
	restricted_desc = "Command Staff"

// JOB - Berets
/datum/loadout_item/head/job/atmos_beret
	name = "Atmospherics Beret"
	path = /obj/item/clothing/head/beret/atmos
	restricted_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")
	restricted_desc = "Engineering"

/datum/loadout_item/head/job/engi_beret
	name = "Engineering Beret"
	path = /obj/item/clothing/head/beret/engi
	restricted_roles = list("Station Engineer", "Atmospheric Technician", "Chief Engineer")
	restricted_desc = "Engineering"

// SKYRAT EDIT REMOVAL BEGIN - MOVED TO COMMAND CLOTHING VENDOR
/*
/datum/loadout_item/head/job/CE_beret
	name = "Chief Engineer's Beret"
	path = /obj/item/clothing/head/beret/engi/ce
	restricted_roles = list("Chief Engineer")
	restricted_desc = "Chief Engineer"

/datum/loadout_item/head/job/CE_beret_alt
	name = "Chief Engineer's White Beret"
	path = /obj/item/clothing/head/beret/engi/ce/alt
	restricted_roles = list("Chief Engineer")
	restricted_desc = "Chief Engineer"
*/
// SKYRAT EDIT REMOVAL END
/datum/loadout_item/head/job/med
	name = "Medical Beret"
	path = /obj/item/clothing/head/beret/medical
	restricted_roles = list("Medical Doctor","Virologist", "Chemist", "Chief Medical Officer","Security Medic")
	restricted_desc = "Medical"

/datum/loadout_item/head/job/med
	name = "Paramedic Beret"
	path = /obj/item/clothing/head/beret/medical/paramedic
	restricted_roles = list("Paramedic", "Chief Medical Officer")
	restricted_desc = "Paramedic"

/datum/loadout_item/head/job/med_viro
	name = "Virologist Beret"
	path = /obj/item/clothing/head/beret/medical/virologist
	restricted_roles = list("Virologist", "Chief Medical Officer")
	restricted_desc = "Virology"

/datum/loadout_item/head/job/med_chem
	name = "Chemist Beret"
	path = /obj/item/clothing/head/beret/medical/chemist
	restricted_roles = list("Chemist", "Chief Medical Officer")
	restricted_desc = "Chemistry"

// SKYRAT EDIT REMOVAL BEGIN - MOVED TO COMMAND CLOTHING VENDOR
/*
/datum/loadout_item/head/job/CMO_beret_alt
	name = "Chief Medical Officer's Blue Beret"
	path = /obj/item/clothing/head/beret/medical/cmo
	restricted_roles = list("Chief Medical Officer")
	restricted_desc = "Chief Medical Officer"

/datum/loadout_item/head/job/CMO_beret
	name = "Chief Medical Officer's Beret"
	path = /obj/item/clothing/head/beret/medical/cmo/alt
	restricted_roles = list("Chief Medical Officer")
	restricted_desc = "Chief Medical Officer"
*/
// SKYRAT EDIT REMOVAL END
/datum/loadout_item/head/job/sci
	name = "Scientist's Beret"
	path = /obj/item/clothing/head/beret/science
	restricted_roles = list("Scientist", "Roboticist", "Geneticist", "Research Director", "Vanguard Operative")
	restricted_desc = "Science"

/datum/loadout_item/head/job/robo
	name = "Roboticist's Beret"
	path = /obj/item/clothing/head/beret/science/fancy/robo
	restricted_roles = list("Roboticist", "Research Director")
	restricted_desc = "Robotics"

// SKYRAT EDIT REMOVAL BEGIN - MOVED TO COMMAND CLOTHING VENDOR
/*
/datum/loadout_item/head/job/RD_beret
	name = "Research Director's Beret"
	path = /obj/item/clothing/head/beret/science/fancy/rd
	restricted_roles = list("Research Director")
	restricted_desc = "Research Director"

/datum/loadout_item/head/job/RD_beret_alt
	name = "Research Director's White Beret"
	path = /obj/item/clothing/head/beret/science/fancy/rd
	restricted_roles = list("Research Director")
	restricted_desc = "Research Director"

/datum/loadout_item/head/job/QM_beret
	name = "Quartermaster's Beret"
	path = /obj/item/clothing/head/beret/cargo/qm
	restricted_roles = list("Quartermaster")
	restricted_desc = "Quartermaster"

/datum/loadout_item/head/job/QM_beret
	name = "Quartermaster's White Beret"
	path = /obj/item/clothing/head/beret/cargo/qm/alt
	restricted_roles = list("Quartermaster")
	restricted_desc = "Quartermaster"

/datum/loadout_item/head/job/Cap_beret
	name = "Captain's Beret"
	path = /obj/item/clothing/head/caphat/beret
	restricted_roles = list("Captain")
	restricted_desc = "Captain"

/datum/loadout_item/head/job/Cap_beret_alt
	name = "Captain's White Beret"
	path = /obj/item/clothing/head/caphat/beret/alt
	restricted_roles = list("Captain")
	restricted_desc = "Captain"

/datum/loadout_item/head/job/HOP_beret
	name = "Head of Personnel's Beret"
	path = /obj/item/clothing/head/hopcap/beret
	restricted_roles = list("Head of Personnel")
	restricted_desc = "Head of Personnel"

/datum/loadout_item/head/job/HOP_beret_alt
	name = "Head of Personnel's White Beret"
	path = /obj/item/clothing/head/hopcap/beret/alt
	restricted_roles = list("Head of Personnel")
	restricted_desc = "Head of Personnel"
*/
// SKYRAT EDIT REMOVAL END

/datum/loadout_item/head/brfed
	name = "Brown Fedora"
	path = /obj/item/clothing/head/fedorabrown
	cost = 2

/datum/loadout_item/head/blfed
	name = "Black Fedora"
	path = /obj/item/clothing/head/fedorablack
	cost = 2
