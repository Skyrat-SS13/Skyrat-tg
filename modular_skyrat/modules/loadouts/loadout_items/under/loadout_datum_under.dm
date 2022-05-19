
// --- Loadout item datums for under suits ---

/// Underslot - Jumpsuit Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_jumpsuits, generate_loadout_items(/datum/loadout_item/under/jumpsuit))

/// Underslot - Formal Suit Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_undersuits, generate_loadout_items(/datum/loadout_item/under/formal))

/// Underslot - Misc. Under Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_miscunders, generate_loadout_items(/datum/loadout_item/under/miscellaneous))

/datum/loadout_item/under
	category = LOADOUT_ITEM_UNIFORM

/datum/loadout_item/under/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(isplasmaman(equipper))
		if(!visuals_only)
			to_chat(equipper, "Your loadout uniform was not equipped directly due to your envirosuit.")
			LAZYADD(outfit.backpack_contents, item_path)
	else if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.uniform)
			LAZYADD(outfit.backpack_contents, outfit.uniform)
		outfit.uniform = item_path
	else
		outfit.uniform = item_path

//////////////////////////////////////////////////////JUMPSUITS
/datum/loadout_item/under/jumpsuit

/datum/loadout_item/under/jumpsuit/greyscale
	name = "Greyscale Jumpsuit"
	item_path = /obj/item/clothing/under/color

/datum/loadout_item/under/jumpsuit/greyscale_skirt
	name = "Greyscale Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt

/datum/loadout_item/under/jumpsuit/random
	name = "Random Jumpsuit"
	item_path = /obj/item/clothing/under/color/random
	additional_tooltip_contents = list(TOOLTIP_RANDOM_COLOR)

/datum/loadout_item/under/jumpsuit/random_skirt
	name = "Random Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/random
	additional_tooltip_contents = list(TOOLTIP_RANDOM_COLOR)

/datum/loadout_item/under/jumpsuit/rainbow
	name = "Rainbow Jumpsuit"
	item_path = /obj/item/clothing/under/color/rainbow

/datum/loadout_item/under/jumpsuit/rainbow_skirt
	name = "Rainbow Jumpskirt"
	item_path = /obj/item/clothing/under/color/jumpskirt/rainbow

/datum/loadout_item/under/jumpsuit/impcap
	name = "Captain's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/rank/captain/imperial
	restricted_roles = list(JOB_CAPTAIN, JOB_NT_REP)

/datum/loadout_item/under/jumpsuit/imphop
	name = "Head of Personnel's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/rank/civilian/head_of_personnel/imperial
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_NT_REP)

/datum/loadout_item/under/jumpsuit/imphos
	name = "Head of Security's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/security/head_of_security/imperial
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/impcmo
	name = "Chief Medical Officer's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/medical/chief_medical_officer/imperial
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/under/jumpsuit/impce
	name = "Chief Engineer's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/engineering/chief_engineer/imperial
	restricted_roles = list(JOB_CHIEF_ENGINEER)

/datum/loadout_item/under/jumpsuit/imprd
	name = "Research Director's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/imperial
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/under/jumpsuit/impcommand
	name = "Light Grey Officer's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/imperial
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_NT_REP)

/datum/loadout_item/under/jumpsuit/impcom
	name = "Grey Officer's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/imperial/grey
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_NT_REP)

/datum/loadout_item/under/jumpsuit/impred
	name = "Red Officer's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/imperial/red
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER)	//NT Reps would never wear red, it's unbefitting


/datum/loadout_item/under/jumpsuit/impcomtrous
	name = "Grey Officer's Naval Jumpsuit (Trousers)"
	item_path = /obj/item/clothing/under/imperial/grey/trouser
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER, JOB_NT_REP)

/datum/loadout_item/under/jumpsuit/solwarden
	name = "Sol Warden Uniform"
	item_path = /obj/item/clothing/under/rank/security/warden/peacekeeper/sol
	restricted_roles = list(JOB_WARDEN)

/datum/loadout_item/under/jumpsuit/peacetrouse
	name = "Peacekeeper Trousers"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/trousers
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_SECURITY_MEDIC)

/datum/loadout_item/under/jumpsuit/security_trousers
	name = "Security Trousers"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/trousers/red
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_SECURITY_MEDIC)

/datum/loadout_item/under/jumpsuit/sectrafficop
	name = "Sol Traffic Cop Uniform"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/sol/traffic
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_SECURITY_MEDIC)

/datum/loadout_item/under/jumpsuit/solofficer
	name = "Sol Officer Uniform"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/sol
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_SECURITY_MEDIC)

/datum/loadout_item/under/jumpsuit/disco
	name = "Superstar Cop Uniform"
	item_path = /obj/item/clothing/under/rank/security/detective/disco
	restricted_roles = list(JOB_DETECTIVE)

/datum/loadout_item/under/jumpsuit/seckilt
	name = "Security Kilt"
	item_path = /obj/item/clothing/under/rank/security/blackwatch
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY, JOB_SECURITY_MEDIC)

/datum/loadout_item/under/jumpsuit/paramed_dark
	name = "Dark Paramedic Jumpsuit"
	item_path = /obj/item/clothing/under/rank/medical/paramedic/skyrat/dark
	restricted_roles = list(JOB_PARAMEDIC)

/datum/loadout_item/under/jumpsuit/paramed_dark_skirt
	name = "Dark Paramedic Jumpskirt"
	item_path = /obj/item/clothing/under/rank/medical/paramedic/skyrat/dark/skirt
	restricted_roles = list(JOB_PARAMEDIC)

/datum/loadout_item/under/jumpsuit/chemist_formal
	name = "Chemist's Formal Jumpsuit"
	item_path = /obj/item/clothing/under/rank/medical/chemist/skyrat/formal
	restricted_roles = list(JOB_CHEMIST)

/datum/loadout_item/under/jumpsuit/chemist_formal_skirt
	name = "Chemist's Formal Jumpskirt"
	item_path = /obj/item/clothing/under/rank/medical/chemist/skyrat/formal/skirt
	restricted_roles = list(JOB_CHEMIST)

/datum/loadout_item/under/jumpsuit/hlscientist
	name = "Ridiculous Scientist Outfit"
	item_path = /obj/item/clothing/under/rank/rnd/scientist/skyrat/hlscience
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_VANGUARD_OPERATIVE)

/datum/loadout_item/under/jumpsuit/rd_jumpsuit
	name = "Research Director's Jumpsuit"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/under/jumpsuit/rd_jumpskirt
	name = "Research Director's Jumpskirt"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit/skirt
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/under/jumpsuit/utility
	name = "Utility Uniform"
	item_path = /obj/item/clothing/under/utility

/datum/loadout_item/under/jumpsuit/utility_eng
	name = "Engineering Utility Uniform"
	item_path = /obj/item/clothing/under/rank/engineering/engineer/skyrat/utility
	restricted_roles = list(JOB_STATION_ENGINEER,JOB_ATMOSPHERIC_TECHNICIAN, JOB_CHIEF_ENGINEER, JOB_ENGINEERING_GUARD)

/datum/loadout_item/under/jumpsuit/utility_med
	name = "Medical Utility Uniform"
	item_path = /obj/item/clothing/under/rank/medical/doctor/skyrat/utility
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_PARAMEDIC, JOB_CHEMIST, JOB_VIROLOGIST, JOB_GENETICIST, JOB_SECURITY_MEDIC, JOB_CHIEF_MEDICAL_OFFICER, JOB_PSYCHOLOGIST, JOB_ORDERLY)

/datum/loadout_item/under/jumpsuit/utility_sci
	name = "Science Utility Uniform"
	item_path = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility
	restricted_roles = list(JOB_SCIENTIST, JOB_ROBOTICIST, JOB_GENETICIST, JOB_RESEARCH_DIRECTOR, JOB_VANGUARD_OPERATIVE, JOB_SCIENCE_GUARD)

/datum/loadout_item/under/jumpsuit/utility_cargo
	name = "Supply Utility Uniform"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	restricted_roles = list(JOB_CARGO_TECHNICIAN, JOB_SHAFT_MINER, JOB_QUARTERMASTER, JOB_CUSTOMS_AGENT)

/datum/loadout_item/under/jumpsuit/utility_sec
	name = "Security Utility Uniform"
	item_path = /obj/item/clothing/under/utility/sec
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_BLUESHIELD, JOB_SECURITY_MEDIC, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER) //i dunno about the blueshield, they're a weird combo of sec and command, thats why they arent in the loadout pr im making

/datum/loadout_item/under/jumpsuit/utility_com
	name = "Command Utility Uniform"
	item_path = /obj/item/clothing/under/utility/com
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER)

/datum/loadout_item/under/jumpsuit/polysweater
	name = "Polychromic Sweater"
	item_path = /obj/item/clothing/under/misc/polysweater

/////////////////////////////////////////////////////////////MISC UNDERSUITS
/datum/loadout_item/under/miscellaneous

//christmas stuff, remove afterword
/*/datum/loadout_item/under/miscellaneous/christmas
	name = "Christmas Suit"
	item_path = /obj/item/clothing/under/costume/christmas

/datum/loadout_item/under/miscellaneous/christmas/green
	name = "Green Christmas Suit"
	item_path = /obj/item/clothing/under/costume/christmas/green

/datum/loadout_item/under/miscellaneous/christmas/female
	name = "Revealing Christmas Suit"
	item_path = /obj/item/clothing/under/croptop/christmas

/datum/loadout_item/under/miscellaneous/christmas/female/green
	name = "Revealing Green Christmas Suit"
	item_path = /obj/item/clothing/under/croptop/christmas/green*/

//christmas ends, because every christmas is last christmas

/datum/loadout_item/under/miscellaneous/camo
	name = "Camo Pants"
	item_path = /obj/item/clothing/under/pants/camo

/datum/loadout_item/under/miscellaneous/jeans_classic
	name = "Classic Jeans"
	item_path = /obj/item/clothing/under/pants/classicjeans

/datum/loadout_item/under/miscellaneous/jeans_black
	name = "Black Jeans"
	item_path = /obj/item/clothing/under/pants/blackjeans

/datum/loadout_item/under/miscellaneous/black
	name = "Black Pants"
	item_path = /obj/item/clothing/under/pants/black

/datum/loadout_item/under/miscellaneous/black_short
	name = "Black Shorts"
	item_path = /obj/item/clothing/under/shorts/black

/datum/loadout_item/under/miscellaneous/blue_short
	name = "Blue Shorts"
	item_path = /obj/item/clothing/under/shorts/blue

/datum/loadout_item/under/miscellaneous/green_short
	name = "Green Shorts"
	item_path = /obj/item/clothing/under/shorts/green

/datum/loadout_item/under/miscellaneous/grey_short
	name = "Grey Shorts"
	item_path = /obj/item/clothing/under/shorts/grey

/datum/loadout_item/under/miscellaneous/jeans
	name = "Jeans"
	item_path = /obj/item/clothing/under/pants/jeans

/datum/loadout_item/under/miscellaneous/jeansripped
	name = "Ripped Jeans"
	item_path = /obj/item/clothing/under/pants/jeanripped

/datum/loadout_item/under/miscellaneous/khaki
	name = "Khaki Pants"
	item_path = /obj/item/clothing/under/pants/khaki

/datum/loadout_item/under/miscellaneous/jeans_musthang
	name = "Must Hang Jeans"
	item_path = /obj/item/clothing/under/pants/mustangjeans

/datum/loadout_item/under/miscellaneous/pants/blackshorts
	name = "Black ripped shorts"
	item_path = /obj/item/clothing/under/pants/blackshorts

/datum/loadout_item/under/miscellaneous/purple_short
	name = "Purple Shorts"
	item_path = /obj/item/clothing/under/shorts/purple

/datum/loadout_item/under/miscellaneous/red
	name = "Red Pants"
	item_path = /obj/item/clothing/under/pants/red

/datum/loadout_item/under/miscellaneous/red_short
	name = "Red Shorts"
	item_path = /obj/item/clothing/under/shorts/red

/datum/loadout_item/under/miscellaneous/tam
	name = "Tan Pants"
	item_path = /obj/item/clothing/under/pants/tan

/datum/loadout_item/under/miscellaneous/track
	name = "Track Pants"
	item_path = /obj/item/clothing/under/pants/track

/datum/loadout_item/under/miscellaneous/jeans_youngfolk
	name = "Young Folks Jeans"
	item_path = /obj/item/clothing/under/pants/youngfolksjeans

/datum/loadout_item/under/miscellaneous/white
	name = "White Pants"
	item_path = /obj/item/clothing/under/pants/white

/datum/loadout_item/under/miscellaneous/kilt
	name = "Kilt"
	item_path = /obj/item/clothing/under/costume/kilt

/datum/loadout_item/under/miscellaneous/treasure_hunter
	name = "Treasure Hunter"
	item_path = /obj/item/clothing/under/rank/civilian/curator/treasure_hunter

/datum/loadout_item/under/miscellaneous/overalls
	name = "Overalls"
	item_path = /obj/item/clothing/under/misc/overalls

/datum/loadout_item/under/miscellaneous/pj_blue
	name = "Mailman Jumpsuit"
	item_path = /obj/item/clothing/under/misc/mailman

/datum/loadout_item/under/miscellaneous/vice_officer
	name = "Vice Officer Jumpsuit"
	item_path = /obj/item/clothing/under/misc/vice_officer

/datum/loadout_item/under/miscellaneous/soviet
	name = "Soviet Uniform"
	item_path = /obj/item/clothing/under/costume/soviet

/datum/loadout_item/under/miscellaneous/redcoat
	name = "Redcoat"
	item_path = /obj/item/clothing/under/costume/redcoat

/datum/loadout_item/under/miscellaneous/pj_red
	name = "Red PJs"
	item_path = /obj/item/clothing/under/misc/pj/red

/datum/loadout_item/under/miscellaneous/pj_blue
	name = "Blue PJs"
	item_path = /obj/item/clothing/under/misc/pj/blue

/datum/loadout_item/under/miscellaneous/tactical_hawaiian_orange
	name = "Tactical Hawaiian Outfit - Orange"
	item_path = /obj/item/clothing/under/tachawaiian

/datum/loadout_item/under/miscellaneous/tactical_hawaiian_blue
	name = "Tactical Hawaiian Outfit - Blue"
	item_path = /obj/item/clothing/under/tachawaiian/blue

/datum/loadout_item/under/miscellaneous/tactical_hawaiian_purple
	name = "Tactical Hawaiian Outfit - Purple"
	item_path = /obj/item/clothing/under/tachawaiian/purple

/datum/loadout_item/under/miscellaneous/tactical_hawaiian_green
	name = "Tactical Hawaiian Outfit - Green"
	item_path = /obj/item/clothing/under/tachawaiian/green

/datum/loadout_item/under/miscellaneous/greyshirt
	name = "Grey Shirt"
	item_path = /obj/item/clothing/under/misc/greyshirt

/datum/loadout_item/under/miscellaneous/maidcostume
	name = "Maid costume"
	item_path = /obj/item/clothing/under/costume/maid

/datum/loadout_item/under/miscellaneous/croptop
	name = "Croptop"
	item_path = /obj/item/clothing/under/croptop

/datum/loadout_item/under/miscellaneous/royalkilt
	name = "Royal Kilt"
	item_path = /obj/item/clothing/under/misc/royalkilt

/datum/loadout_item/under/miscellaneous/qipao
	name = "Qipao, Black"
	item_path = /obj/item/clothing/under/costume/qipao

/datum/loadout_item/under/miscellaneous/cheongsam
	name = "Cheongsam, Black"
	item_path = /obj/item/clothing/under/costume/cheongsam

/datum/loadout_item/under/miscellaneous/chaps
	name = "Black Chaps"
	item_path = /obj/item/clothing/under/pants/chaps

/datum/loadout_item/under/miscellaneous/tracky
	name = "Blue Tracksuit"
	item_path = /obj/item/clothing/under/misc/bluetracksuit

/datum/loadout_item/under/miscellaneous/cybersleek
	name = "Sleek Modern Coat"
	item_path = /obj/item/clothing/under/costume/cybersleek

/datum/loadout_item/under/miscellaneous/cybersleek_long
	name = "Long Modern Coat"
	item_path = /obj/item/clothing/under/costume/cybersleek/long

/datum/loadout_item/under/miscellaneous/dutch
	name = "Dutch Suit"
	item_path = /obj/item/clothing/under/costume/dutch

/datum/loadout_item/under/miscellaneous/arthur
	name = "Dutch Assistant Suit"
	item_path = /obj/item/clothing/under/costume/arthur

/datum/loadout_item/under/miscellaneous/yoga
	name = "Yoga Pants"
	item_path = /obj/item/clothing/under/pants/yoga

/datum/loadout_item/under/miscellaneous/tacticool_turtleneck
	name = "Tactitool Turtleneck"
	item_path = /obj/item/clothing/under/syndicate/tacticool/sensors

/datum/loadout_item/under/miscellaneous/tactical_pants
	name = "Tactical Pants"
	item_path = /obj/item/clothing/under/pants/tactical

//HALLOWEEN
/datum/loadout_item/under/miscellaneous/pj_blood
	name = "Blood-red Pajamas"
	item_path = /obj/item/clothing/under/syndicate/bloodred/sleepytime/sensors

/datum/loadout_item/under/miscellaneous/gladiator
	name = "Gladiator Uniform"
	item_path = /obj/item/clothing/under/costume/gladiator

/datum/loadout_item/under/miscellaneous/griffon
	name = "Griffon Uniform"
	item_path = /obj/item/clothing/under/costume/griffin

/datum/loadout_item/under/miscellaneous/owl
	name = "Owl Uniform"
	item_path = /obj/item/clothing/under/costume/owl

/datum/loadout_item/under/miscellaneous/villain
	name = "Villain Suit"
	item_path = /obj/item/clothing/under/costume/villain
//November 1st
/datum/loadout_item/under/miscellaneous/tactical_irish
	name = "Irish Tactical Sweater"
	item_path = /obj/item/clothing/under/misc/tactical1

/datum/loadout_item/under/miscellaneous/tactical_british
	name = "British Tactical Sweater"
	item_path = /obj/item/clothing/under/uvf

/datum/loadout_item/under/miscellaneous/tactical_skirt
	name = "Tactitool Skirtleneck"
	item_path = /obj/item/clothing/under/syndicate/tacticool/skirt/sensors

/datum/loadout_item/under/miscellaneous/cream_sweater
	name = "Cream Sweater"
	item_path = /obj/item/clothing/under/sweater

/datum/loadout_item/under/miscellaneous/black_sweater
	name = "Black Sweater"
	item_path = /obj/item/clothing/under/sweater/black

/datum/loadout_item/under/miscellaneous/purple_sweater
	name = "Purple Sweater"
	item_path = /obj/item/clothing/under/sweater/purple

/datum/loadout_item/under/miscellaneous/green_sweater
	name = "Green Sweater"
	item_path = /obj/item/clothing/under/sweater/green

/datum/loadout_item/under/miscellaneous/red_sweater
	name = "Red Sweater"
	item_path = /obj/item/clothing/under/sweater/red

/datum/loadout_item/under/miscellaneous/blue_sweater
	name = "Blue Sweater"
	item_path = /obj/item/clothing/under/sweater/blue

/datum/loadout_item/under/miscellaneous/keyhole
	name = "Keyhole Sweater"
	item_path = /obj/item/clothing/under/sweater/keyhole

/datum/loadout_item/under/miscellaneous/blacknwhite
	name = "Classic Prisoner Jumpsuit"
	item_path = /obj/item/clothing/under/rank/prisoner/classic
	restricted_roles = list(JOB_PRISONER)

/datum/loadout_item/under/miscellaneous/medrscrubs
	name = "Security Medic's Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec
	restricted_roles = list(JOB_SECURITY_MEDIC)

/datum/loadout_item/under/miscellaneous/redscrubs
	name = "Red Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/red
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_SECURITY_MEDIC, JOB_PARAMEDIC)

/datum/loadout_item/under/miscellaneous/bluescrubs
	name = "Blue Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/blue
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_SECURITY_MEDIC, JOB_PARAMEDIC)

/datum/loadout_item/under/miscellaneous/greenscrubs
	name = "Green Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/green
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_SECURITY_MEDIC, JOB_PARAMEDIC)

/datum/loadout_item/under/miscellaneous/purplescrubs
	name = "Purple Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/purple
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_SECURITY_MEDIC, JOB_PARAMEDIC)

/datum/loadout_item/under/miscellaneous/whitescrubs
	name = "White Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/white
	restricted_roles = list(JOB_MEDICAL_DOCTOR, JOB_CHIEF_MEDICAL_OFFICER, JOB_GENETICIST, JOB_CHEMIST, JOB_VIROLOGIST, JOB_SECURITY_MEDIC, JOB_PARAMEDIC)

/datum/loadout_item/under/miscellaneous/swept_skirt
	name = "Swept Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/swept

/datum/loadout_item/under/miscellaneous/gear_harness
	name = "Gear Harness"
	item_path = /obj/item/clothing/under/misc/gear_harness

/datum/loadout_item/under/miscellaneous/kimunder
	name = "Aerostatic Suit"
	item_path = /obj/item/clothing/under/misc/kimunder

/datum/loadout_item/under/miscellaneous/countess
	name = "Countess Dress"
	item_path = /obj/item/clothing/under/misc/countess

/datum/loadout_item/under/miscellaneous/peakyblinder
	name = "Birmingham Bling"
	item_path = /obj/item/clothing/under/misc/peakyblinder

/datum/loadout_item/under/miscellaneous/taccas
	name = "Tacticasual Uniform"
	item_path = /obj/item/clothing/under/misc/taccas

/datum/loadout_item/under/miscellaneous/rancher
	name = "Rancher Outfit"
	item_path = /obj/item/clothing/under/rancher

/datum/loadout_item/under/miscellaneous/rancher_pioneer
	name = "Pioneer Outfit"
	item_path = /obj/item/clothing/under/rancher/pioneer

/datum/loadout_item/under/miscellaneous/rancher_worker
	name = "Western Worker Outfit"
	item_path = /obj/item/clothing/under/rancher/worker

/datum/loadout_item/under/miscellaneous/rancher_cowboy
	name = "Cowboy Outfit"
	item_path = /obj/item/clothing/under/rancher/cowboy

/datum/loadout_item/under/miscellaneous/rancher_checkered
	name = "Western Checkered Outfit"
	item_path = /obj/item/clothing/under/rancher/checkered

/datum/loadout_item/under/miscellaneous/cargo_casual
	name = "Cargo Tech Casualwear"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/casualman
	restricted_roles = list(JOB_CARGO_TECHNICIAN)

/datum/loadout_item/under/miscellaneous/cargo_black
	name = "Black Cargo Uniform"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/evil
	restricted_roles = list(JOB_CARGO_TECHNICIAN)

/datum/loadout_item/under/miscellaneous/cargo_turtle
	name = "Cargo Turtleneck"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck
	restricted_roles = list(JOB_CARGO_TECHNICIAN)

/datum/loadout_item/under/miscellaneous/cargo_skirtle
	name = "Cargo Skirtleneck"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck/skirt
	restricted_roles = list(JOB_CARGO_TECHNICIAN)

/datum/loadout_item/under/miscellaneous/qm_skirtle
	name = "Quartermaster's Skirtleneck"
	item_path = /obj/item/clothing/under/rank/cargo/qm/skyrat/turtleneck/skirt
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/under/miscellaneous/qm_gorka
	name = "Quartermaster's Gorka Uniform"
	item_path = /obj/item/clothing/under/rank/cargo/qm/skyrat/gorka
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/under/miscellaneous/eve
	name = "Collection of Leaves"
	item_path = /obj/item/clothing/under/misc/gear_harness/eve

/datum/loadout_item/under/miscellaneous/adam
	name = "Leaf"
	item_path = /obj/item/clothing/under/misc/gear_harness/adam


////////////////////////////////////////////////////////////////FORMAL UNDERSUITS
/datum/loadout_item/under/formal

/datum/loadout_item/under/formal/vic_dress
	name = "Black victorian dress"
	item_path = /obj/item/clothing/under/costume/vic_dress

/datum/loadout_item/under/formal/vic_dress_red
	name = "Red victorian dress"
	item_path = /obj/item/clothing/under/costume/vic_dress/red

/datum/loadout_item/under/formal/amish_suit
	name = "Amish Suit"
	item_path = /obj/item/clothing/under/suit/sl

/datum/loadout_item/under/formal/formaldressred
	name = "Formal Red Dress"
	item_path = /obj/item/clothing/under/misc/formaldressred

/datum/loadout_item/under/formal/pinktutu
	name = "Pink Tutu"
	item_path = /obj/item/clothing/under/dress/pinktutu

/datum/loadout_item/under/formal/assistant
	name = "Assistant Formal"
	item_path = /obj/item/clothing/under/misc/assistantformal

/datum/loadout_item/under/formal/beige_suit
	name = "Beige Suit"
	item_path = /obj/item/clothing/under/suit/beige

/datum/loadout_item/under/formal/black_suit
	name = "Black Suit"
	item_path = /obj/item/clothing/under/suit/black

/datum/loadout_item/under/formal/black_suitskirt
	name = "Black Suitskirt"
	item_path = /obj/item/clothing/under/suit/black/skirt

/datum/loadout_item/under/formal/black_tango
	name = "Black Tango Dress"
	item_path = /obj/item/clothing/under/dress/blacktango

/datum/loadout_item/under/formal/black_twopiece
	name = "Black Two-Piece Suit"
	item_path = /obj/item/clothing/under/suit/blacktwopiece

/datum/loadout_item/under/formal/black_skirt
	name = "Black Skirt"
	item_path = /obj/item/clothing/under/dress/skirt

/datum/loadout_item/under/formal/black_lawyer_suit
	name = "Black Lawyer Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black

/datum/loadout_item/under/formal/black_lawyer_skirt
	name = "Black Lawyer Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black/skirt

/datum/loadout_item/under/formal/blue_suit
	name = "Blue Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit

/datum/loadout_item/under/formal/blue_suitskirt
	name = "Blue Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt

/datum/loadout_item/under/formal/blue_lawyer_suit
	name = "Blue Lawyer Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue

/datum/loadout_item/under/formal/blue_lawyer_skirt
	name = "Blue Lawyer Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue/skirt

/datum/loadout_item/under/formal/blue_skirt
	name = "Blue Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/blue

/datum/loadout_item/under/formal/blue_skirt_plaid
	name = "Blue Plaid Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid/blue

/datum/loadout_item/under/formal/burgundy_suit
	name = "Burgundy Suit"
	item_path = /obj/item/clothing/under/suit/burgundy

/datum/loadout_item/under/formal/charcoal_suit
	name = "Charcoal Suit"
	item_path = /obj/item/clothing/under/suit/charcoal

/datum/loadout_item/under/formal/checkered_suit
	name = "Checkered Suit"
	item_path = /obj/item/clothing/under/suit/checkered

/datum/loadout_item/under/formal/executive_suit
	name = "Executive Suit"
	item_path = /obj/item/clothing/under/suit/black_really

/datum/loadout_item/under/formal/executive_skirt
	name = "Executive Suitskirt"
	item_path = /obj/item/clothing/under/suit/black_really/skirt

/datum/loadout_item/under/formal/executive_suit_alt
	name = "Executive Suit Alt"
	item_path = /obj/item/clothing/under/suit/black/female/trousers

/datum/loadout_item/under/formal/executive_skirt_alt
	name = "Executive Suitskirt Alt"
	item_path = /obj/item/clothing/under/suit/black/female/skirt

/datum/loadout_item/under/formal/green_suit
	name = "Green Suit"
	item_path = /obj/item/clothing/under/suit/green

/datum/loadout_item/under/formal/green_skirt_plaid
	name = "Green Plaid Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid/green

/datum/loadout_item/under/formal/navy_suit
	name = "Navy Suit"
	item_path = /obj/item/clothing/under/suit/navy

/datum/loadout_item/under/formal/maid_outfit
	name = "Maid Outfit"
	item_path = /obj/item/clothing/under/costume/maid

/datum/loadout_item/under/formal/maid_uniform
	name = "Maid Uniform"
	item_path = /obj/item/clothing/under/rank/civilian/janitor/maid

/datum/loadout_item/under/formal/purple_suit
	name = "Purple Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit

/datum/loadout_item/under/formal/purple_suitskirt
	name = "Purple Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit/skirt

/datum/loadout_item/under/formal/purple_skirt
	name = "Purple Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/purple

/datum/loadout_item/under/formal/purple_skirt_plaid
	name = "Purple Plaid Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid/purple

/datum/loadout_item/under/formal/red_suit
	name = "Red Suit"
	item_path = /obj/item/clothing/under/suit/red

/datum/loadout_item/under/formal/helltaker
	name = "Red Shirt with White Trousers"
	item_path = /obj/item/clothing/under/suit/helltaker

/datum/loadout_item/under/formal/helltaker/skirt
	name = "Red Shirt with White Skirt"
	item_path = /obj/item/clothing/under/suit/helltaker/skirt

/datum/loadout_item/under/formal/red_lawyer_skirt
	name = "Red Lawyer Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red

/datum/loadout_item/under/formal/red_lawyer_skirt
	name = "Red Lawyer Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red/skirt

/datum/loadout_item/under/formal/red_gown
	name = "Red Evening Gown"
	item_path = /obj/item/clothing/under/dress/redeveninggown

/datum/loadout_item/under/formal/red_skirt
	name = "Red Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/red

/datum/loadout_item/under/formal/red_skirt_plaid
	name = "Red Plaid Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid

/datum/loadout_item/under/formal/sailor
	name = "Sailor Suit"
	item_path = /obj/item/clothing/under/costume/sailor

/datum/loadout_item/under/formal/sailor_skirt
	name = "Sailor Dress"
	item_path = /obj/item/clothing/under/dress/sailor

/datum/loadout_item/under/formal/scratch_suit
	name = "Scratch Suit"
	item_path = /obj/item/clothing/under/suit/white_on_white

/datum/loadout_item/under/formal/denim_skirt
	name = "Denim Skirt"
	item_path = /obj/item/clothing/under/pants/denimskirt

/datum/loadout_item/under/formal/striped_skirt
	name = "Striped Dress"
	item_path = /obj/item/clothing/under/dress/striped

/datum/loadout_item/under/formal/sensible_suit
	name = "Sensible Suit"
	item_path = /obj/item/clothing/under/rank/civilian/curator

/datum/loadout_item/under/formal/sensible_skirt
	name = "Sensible Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/curator/skirt

/datum/loadout_item/under/formal/sundress
	name = "Sundress"
	item_path = /obj/item/clothing/under/dress/sundress

/datum/loadout_item/under/formal/sundress/white
	name = "White Sundress"
	item_path = /obj/item/clothing/under/dress/sundress/white

/datum/loadout_item/under/formal/tuxedo
	name = "Tuxedo Suit"
	item_path = /obj/item/clothing/under/suit/tuxedo

/datum/loadout_item/under/formal/waiter
	name = "Waiter's Suit"
	item_path = /obj/item/clothing/under/suit/waiter

/datum/loadout_item/under/formal/white_suit
	name = "White Suit"
	item_path = /obj/item/clothing/under/suit/white

/datum/loadout_item/under/formal/fancy_suit
	name = "Fancy Suit"
	item_path = /obj/item/clothing/under/suit/fancy


/datum/loadout_item/under/formal/kimono
	name = "Kimono"
	item_path = /obj/item/clothing/under/costume/kimono

/datum/loadout_item/under/formal/kimono_dark
	name = "Dark Kimono"
	item_path = /obj/item/clothing/under/costume/kimono/dark

/datum/loadout_item/under/formal/kimono_sakura
	name = "Sakura Kimono"
	item_path = /obj/item/clothing/under/costume/kimono/sakura

/datum/loadout_item/under/formal/kimono_fancy
	name = "Fancy Kimono"
	item_path =  /obj/item/clothing/under/costume/kimono/fancy

/datum/loadout_item/under/formal/trek
	name = "Trekkie Uniform"
	item_path = /obj/item/clothing/under/trek

/datum/loadout_item/under/formal/trek_command
	name = "Trekkie Command Uniform"
	item_path = /obj/item/clothing/under/trek/command

/datum/loadout_item/under/formal/trek_engsec
	name = "Trekkie Engsec Uniform"
	item_path = /obj/item/clothing/under/trek/engsec

/datum/loadout_item/under/formal/trek_medsci
	name = "Trekkie Medsci Uniform"
	item_path = /obj/item/clothing/under/trek/medsci

/datum/loadout_item/under/formal/trek_next_command
	name = "Trekkie TNG Command Uniform"
	item_path = /obj/item/clothing/under/trek/command/next

/datum/loadout_item/under/formal/trek_next_engsec
	name = "Trekkie TNG Engsec Uniform"
	item_path = /obj/item/clothing/under/trek/engsec/next

/datum/loadout_item/under/formal/trek_next_medsci
	name = "Trekkie TNG Medsci Uniform"
	item_path = /obj/item/clothing/under/trek/medsci/next

/datum/loadout_item/under/formal/trek_ent_command
	name = "Trekkie ENT Command Uniform"
	item_path = /obj/item/clothing/under/trek/command/ent

/datum/loadout_item/under/formal/trek_ent_engsec
	name = "Trekkie ENT Engsec Uniform"
	item_path = /obj/item/clothing/under/trek/engsec/ent

/datum/loadout_item/under/formal/trek_ent_medsci
	name = "Trekkie ENT Medsci Uniform"
	item_path = /obj/item/clothing/under/trek/medsci/ent

/datum/loadout_item/under/formal/the_q
	name = "French Marshall's Uniform"
	item_path = /obj/item/clothing/under/trek/q

/datum/loadout_item/under/formal/vic_vest
	name = "Victorian Vest"
	item_path = /obj/item/clothing/under/costume/vic_vest

/datum/loadout_item/under/formal/vic_vest/red
	name = "Red Victorian Shirt with Vest"
	item_path = /obj/item/clothing/under/costume/vic_vest/red

/datum/loadout_item/under/formal/vic_vest/green
	name = "Green victorian vest"
	item_path = /obj/item/clothing/under/costume/vic_vest/green

/datum/loadout_item/under/formal/vic_vest/blue
	name = "Blue Victorian Vest"
	item_path = /obj/item/clothing/under/costume/vic_vest/blue

/datum/loadout_item/under/formal/vic_vest/red/shirt
	name = "Red Victorian Vest"
	item_path = /obj/item/clothing/under/costume/vic_vest/red_alt

/datum/loadout_item/under/formal/jeanshorts //why are these formal??? who the fuck wears jorts formally??????
	name = "Jean Shorts"
	item_path = /obj/item/clothing/under/pants/jeanshort

//FAMILIES GEAR
/datum/loadout_item/under/formal/osi
	name = "OSI Uniform"
	item_path = /obj/item/clothing/under/costume/osi

/datum/loadout_item/under/formal/tmc
	name = "TMC Uniform"
	item_path = /obj/item/clothing/under/costume/tmc

/datum/loadout_item/under/formal/pg
	name = "PG Uniform"
	item_path = /obj/item/clothing/under/costume/pg

/datum/loadout_item/under/formal/driscol
	name = "Driscol Uniform"
	item_path = /obj/item/clothing/under/costume/driscoll

/datum/loadout_item/under/formal/deckers
	name = "Deckers Uniform"
	item_path = /obj/item/clothing/under/costume/deckers

/datum/loadout_item/under/formal/morningstar
	name = "Morningstar Uniform"
	item_path = /obj/item/clothing/under/costume/morningstar

/datum/loadout_item/under/formal/saints
	name = "Saints Uniform"
	item_path = /obj/item/clothing/under/costume/saints

/datum/loadout_item/under/formal/phantom
	name = "Phantom Uniform"
	item_path = /obj/item/clothing/under/costume/phantom

/datum/loadout_item/under/formal/sybil
	name = "Sybil Uniform"
	item_path = /obj/item/clothing/under/costume/sybil_slickers

/datum/loadout_item/under/formal/basil
	name = "Basil Uniform"
	item_path = /obj/item/clothing/under/costume/basil_boys

/datum/loadout_item/under/formal/inferno
	name = "Inferno Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/inferno

/datum/loadout_item/under/formal/inferno_skirt
	name = "Inferno Skirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/inferno/skirt

/datum/loadout_item/under/formal/designer_inferno
	name = "Designer Inferno Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/inferno/beeze
	restricted_roles = list(JOB_LAWYER)

/// DONATOR
/datum/loadout_item/under/donator
	donator_only = TRUE

/datum/loadout_item/under/donator/captain_black
	name  = "Captains Black Uniform"
	item_path = /obj/item/clothing/under/rank/captain/black
	restricted_roles = list(JOB_CAPTAIN)
