
// --- Loadout item datums for under suits ---

/// Underslot - Jumpsuit Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_jumpsuits, generate_loadout_items(/datum/loadout_item/under/jumpsuit))

/// Underslot - Formal Suit Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_undersuits, generate_loadout_items(/datum/loadout_item/under/formal))

/// Underslot - Misc. Under Items (Deletes overrided items)
GLOBAL_LIST_INIT(loadout_miscunders, generate_loadout_items(/datum/loadout_item/under/miscellaneous))

/datum/loadout_item/under
	category = LOADOUT_ITEM_UNIFORM

/datum/loadout_item/under/pre_equip_item(datum/outfit/outfit, datum/outfit/outfit_important_for_life, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(initial(outfit_important_for_life.uniform))
		.. ()
		return TRUE

/datum/loadout_item/under/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE, override_items = LOADOUT_OVERRIDE_BACKPACK)
	if(override_items == LOADOUT_OVERRIDE_BACKPACK && !visuals_only)
		if(outfit.uniform)
			LAZYADD(outfit.backpack_contents, outfit.uniform)
		outfit.uniform = item_path
	else
		outfit.uniform = item_path
	outfit.modified_outfit_slots |= ITEM_SLOT_ICLOTHING

/*
*	JUMPSUITS
*/

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

/datum/loadout_item/under/jumpsuit/akula_wetsuit
	name = "Shoredress Wetsuit"
	item_path = /obj/item/clothing/under/akula_wetsuit

/datum/loadout_item/under/jumpsuit/impcap
	name = "Captain's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/rank/captain/skyrat/imperial
	restricted_roles = list(JOB_CAPTAIN, JOB_NT_REP)

/datum/loadout_item/under/jumpsuit/imphop
	name = "Head of Personnel's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/imperial
	restricted_roles = list(JOB_HEAD_OF_PERSONNEL, JOB_NT_REP)

/datum/loadout_item/under/jumpsuit/imphos
	name = "Head of Security's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/security/head_of_security/skyrat/imperial
	restricted_roles = list(JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/impcmo
	name = "Chief Medical Officer's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/medical/chief_medical_officer/skyrat/imperial
	restricted_roles = list(JOB_CHIEF_MEDICAL_OFFICER)

/datum/loadout_item/under/jumpsuit/impce
	name = "Chief Engineer's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/engineering/chief_engineer/skyrat/imperial
	restricted_roles = list(JOB_CHIEF_ENGINEER)

/datum/loadout_item/under/jumpsuit/imprd
	name = "Research Director's Naval Uniform"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/skyrat/imperial
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/under/jumpsuit/impcommand
	name = "Light Grey Officer's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/rank/captain/skyrat/imperial/generic

/datum/loadout_item/under/jumpsuit/impcom
	name = "Grey Officer's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/rank/captain/skyrat/imperial/generic/grey

/datum/loadout_item/under/jumpsuit/impred
	name = "Red Officer's Naval Jumpsuit"
	item_path = /obj/item/clothing/under/rank/captain/skyrat/imperial/generic/red

/datum/loadout_item/under/jumpsuit/impcomtrous
	name = "Grey Officer's Naval Jumpsuit (Trousers)"
	item_path = /obj/item/clothing/under/rank/captain/skyrat/imperial/generic/pants

/datum/loadout_item/under/jumpsuit/security_skirt
	name = "Security Battledress"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/skirt
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/security_trousers
	name = "Security Trousers"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/trousers
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/security_shorts
	name = "Security Shorts"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/trousers/shorts
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/security_jumpskirt
	name = "Security Jumpskirt"
	item_path = /obj/item/clothing/under/rank/security/officer/skirt
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/security_shortskirt
	name = "Security Shortskirt"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/shortskirt
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/security_miniskirt
	name = "Security Miniskirt"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/miniskirt
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/security_jumpsuit
	name = "Security Jumpsuit"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper/jumpsuit
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/security_peacekeeper
	name = "Security Peacekeeper Uniform"
	item_path = /obj/item/clothing/under/rank/security/peacekeeper
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_HEAD_OF_SECURITY)

/datum/loadout_item/under/jumpsuit/imperial_police_uniform
	name = "Imperial Police Uniform"
	item_path = /obj/item/clothing/under/colonial/nri_police
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE)

/datum/loadout_item/under/jumpsuit/disco
	name = "Superstar Cop Uniform"
	item_path = /obj/item/clothing/under/rank/security/detective/disco

/datum/loadout_item/under/jumpsuit/kim
	name = "Aerostatic Suit"
	item_path = /obj/item/clothing/under/rank/security/detective/kim

/datum/loadout_item/under/jumpsuit/paramed_light
	name = "Light Paramedic Uniform"
	item_path = /obj/item/clothing/under/rank/medical/paramedic/skyrat/light

/datum/loadout_item/under/jumpsuit/paramed_light_skirt
	name = "Light Paramedic Skirt"
	item_path = /obj/item/clothing/under/rank/medical/paramedic/skyrat/light/skirt

/datum/loadout_item/under/jumpsuit/chemist_formal
	name = "Chemist's Formal Jumpsuit"
	item_path = /obj/item/clothing/under/rank/medical/chemist/skyrat/formal

/datum/loadout_item/under/jumpsuit/chemist_formal_skirt
	name = "Chemist's Formal Jumpskirt"
	item_path = /obj/item/clothing/under/rank/medical/chemist/skyrat/formal/skirt

/datum/loadout_item/under/jumpsuit/viro_jumpsuit
	name = "Virologist's Jumpsuit"
	item_path = /obj/item/clothing/under/rank/medical/virologist

/datum/loadout_item/under/jumpsuit/hlscientist
	name = "Ridiculous Scientist Outfit"
	item_path = /obj/item/clothing/under/rank/rnd/scientist/skyrat/hlscience

/datum/loadout_item/under/jumpsuit/rd_jumpsuit
	name = "Research Director's Jumpsuit"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/under/jumpsuit/rd_jumpskirt
	name = "Research Director's Jumpskirt"
	item_path = /obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit/skirt
	restricted_roles = list(JOB_RESEARCH_DIRECTOR)

/datum/loadout_item/under/jumpsuit/cargo
	name = "Cargo Technician's Jumpsuit"
	item_path = /obj/item/clothing/under/rank/cargo/tech

/datum/loadout_item/under/jumpsuit/cargo/skirt
	name = "Cargo Technician's Skirt"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skirt

/datum/loadout_item/under/jumpsuit/cargo/skirt/alt
	name = "Cargo Technician's Shortskirt"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skirt/alt

/datum/loadout_item/under/jumpsuit/cargo/qm
	name = "Quartermaster's Uniform"
	item_path = /obj/item/clothing/under/rank/cargo/qm
	restricted_roles = list(JOB_QUARTERMASTER)

/datum/loadout_item/under/jumpsuit/utility
	name = "Utility Uniform"
	item_path = /obj/item/clothing/under/misc/skyrat/utility

/datum/loadout_item/under/jumpsuit/utility_eng
	name = "Engineering Utility Uniform"
	item_path = /obj/item/clothing/under/rank/engineering/engineer/skyrat/utility

/datum/loadout_item/under/jumpsuit/utility_med
	name = "Medical Utility Uniform"
	item_path = /obj/item/clothing/under/rank/medical/doctor/skyrat/utility

/datum/loadout_item/under/jumpsuit/utility_sci
	name = "Science Utility Uniform"
	item_path = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility

/datum/loadout_item/under/jumpsuit/utility_cargo
	name = "Supply Utility Uniform"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility

/datum/loadout_item/under/jumpsuit/utility_sec
	name = "Security Utility Uniform"
	item_path = /obj/item/clothing/under/rank/security/skyrat/utility
	restricted_roles = list(JOB_SECURITY_OFFICER, JOB_DETECTIVE, JOB_WARDEN, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_CORRECTIONS_OFFICER) //i dunno about the blueshield, they're a weird combo of sec and command, thats why they arent in the loadout pr im making

/datum/loadout_item/under/jumpsuit/utility_com
	name = "Command Utility Uniform"
	item_path = /obj/item/clothing/under/rank/captain/skyrat/utility
	restricted_roles = list(JOB_CAPTAIN, JOB_HEAD_OF_PERSONNEL, JOB_BLUESHIELD, JOB_HEAD_OF_SECURITY, JOB_RESEARCH_DIRECTOR, JOB_QUARTERMASTER, JOB_CHIEF_MEDICAL_OFFICER, JOB_CHIEF_ENGINEER)

/*
*	MISC UNDERSUITS
*/

/datum/loadout_item/under/miscellaneous

/datum/loadout_item/under/miscellaneous/christmas
	name = "Christmas Suit"
	item_path = /obj/item/clothing/under/costume/skyrat/christmas

/datum/loadout_item/under/miscellaneous/christmas/green
	name = "Green Christmas Suit"
	item_path = /obj/item/clothing/under/costume/skyrat/christmas/green

/datum/loadout_item/under/miscellaneous/christmas/female
	name = "Revealing Christmas Suit"
	item_path = /obj/item/clothing/under/costume/skyrat/christmas/croptop

/datum/loadout_item/under/miscellaneous/christmas/female/green
	name = "Revealing Green Christmas Suit"
	item_path = /obj/item/clothing/under/costume/skyrat/christmas/croptop/green

/datum/loadout_item/under/miscellaneous/buttondown
	name = "Recolorable Buttondown Shirt with Slacks"
	item_path = /obj/item/clothing/under/costume/buttondown/slacks

/datum/loadout_item/under/miscellaneous/buttondown_shorts
	name = "Recolorable Buttondown Shirt with Shorts"
	item_path = /obj/item/clothing/under/costume/buttondown/shorts

/datum/loadout_item/under/miscellaneous/buttondown_skirt
	name = "Recolorable Buttondown Shirt with Skirt"
	item_path = /obj/item/clothing/under/costume/buttondown/skirt

/datum/loadout_item/under/miscellaneous/vicvest
	name = "Recolorable Buttondown Shirt with Double-Breasted Vest"
	item_path = /obj/item/clothing/under/pants/skyrat/vicvest

/datum/loadout_item/under/miscellaneous/slacks
	name = "Recolorable Slacks"
	item_path = /obj/item/clothing/under/pants/slacks

/datum/loadout_item/under/miscellaneous/jeans
	name = "Recolorable Jeans"
	item_path = /obj/item/clothing/under/pants/jeans

/datum/loadout_item/under/miscellaneous/jeansripped
	name = "Recolorable Ripped Jeans"
	item_path = /obj/item/clothing/under/pants/skyrat/jeans_ripped

/datum/loadout_item/under/miscellaneous/yoga
	name = "Recolorable Yoga Pants"
	item_path = /obj/item/clothing/under/pants/skyrat/yoga

/datum/loadout_item/under/miscellaneous/track
	name = "Track Pants"
	item_path = /obj/item/clothing/under/pants/track

/datum/loadout_item/under/miscellaneous/camo
	name = "Camo Pants"
	item_path = /obj/item/clothing/under/pants/camo

/datum/loadout_item/under/miscellaneous/jeanshorts //This doesnt look like a word. Short. Jean-Short. Eugh.
	name = "Recolorable Jean Shorts"
	item_path = /obj/item/clothing/under/shorts/jeanshorts

/datum/loadout_item/under/miscellaneous/pants_blackshorts
	name = "Recolorable Ripped Jean Shorts"
	item_path = /obj/item/clothing/under/shorts/skyrat/shorts_ripped

/datum/loadout_item/under/miscellaneous/shortershorts
	name = "Recolorable Shorter Shorts"
	item_path = /obj/item/clothing/under/shorts/skyrat/shortershorts

/datum/loadout_item/under/miscellaneous/shorts
	name = "Recolorable Shorts"
	item_path = /obj/item/clothing/under/shorts

/datum/loadout_item/under/miscellaneous/red_short
	name = "Red Shorts"
	item_path = /obj/item/clothing/under/shorts/red

/datum/loadout_item/under/miscellaneous/green_short
	name = "Green Shorts"
	item_path = /obj/item/clothing/under/shorts/green

/datum/loadout_item/under/miscellaneous/blue_short
	name = "Blue Shorts"
	item_path = /obj/item/clothing/under/shorts/blue

/datum/loadout_item/under/miscellaneous/black_short
	name = "Black Shorts"
	item_path = /obj/item/clothing/under/shorts/black

/datum/loadout_item/under/miscellaneous/grey_short
	name = "Grey Shorts"
	item_path = /obj/item/clothing/under/shorts/grey

/datum/loadout_item/under/miscellaneous/purple_short
	name = "Purple Shorts"
	item_path = /obj/item/clothing/under/shorts/purple

/datum/loadout_item/under/miscellaneous/recolorable_kilt
	name = "Recolorable Kilt"
	item_path = /obj/item/clothing/under/pants/skyrat/kilt

//TODO: split loadout's miscellaneous to have "Pants/Shorts" and "Dresses/Skirts" as options too. Misc is stupid.

/datum/loadout_item/under/miscellaneous/dress_striped
	name = "Striped Dress"
	item_path = /obj/item/clothing/under/dress/striped

/datum/loadout_item/under/miscellaneous/skirt_black
	name = "Black Skirt"
	item_path = /obj/item/clothing/under/dress/skirt

/datum/loadout_item/under/miscellaneous/skirt_plaid
	name = "Recolorable Plaid Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/plaid

/datum/loadout_item/under/miscellaneous/skirt_turtleneck
	name = "Recolorable Turtleneck Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/turtleskirt

/datum/loadout_item/under/miscellaneous/skirt_cableknit
	name = "Recolorable Cableknit Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/turtleskirt_knit

/datum/loadout_item/under/miscellaneous/dress_tango
	name = "Recolorable Tango Dress"
	item_path = /obj/item/clothing/under/dress/tango

/datum/loadout_item/under/miscellaneous/dress_sun
	name = "Recolorable Sundress"
	item_path = /obj/item/clothing/under/dress/sundress

/datum/loadout_item/under/miscellaneous/straplessdress
	name = "Recolorable Strapless Dress"
	item_path = /obj/item/clothing/under/dress/skyrat/strapless

/datum/loadout_item/under/miscellaneous/pentagramdress
	name = "Recolorable Pentagram Strapped Dress"
	item_path = /obj/item/clothing/under/dress/skyrat/pentagram

/datum/loadout_item/under/miscellaneous/jacarta_dress
	name = "Jacarta Dress"
	item_path = /obj/item/clothing/under/dress/skyrat/jute

/datum/loadout_item/under/miscellaneous/striped_skirt
	name = "Red Striped Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/striped_skirt

/datum/loadout_item/under/miscellaneous/red_skirt
	name = "Red Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/red_skirt

/datum/loadout_item/under/miscellaneous/black_skirt
	name = "Black Skirt (Skyrat)"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/black_skirt

/datum/loadout_item/under/miscellaneous/swept_skirt
	name = "Swept Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/swept

/datum/loadout_item/under/miscellaneous/lone_skirt
	name = "Recolorable Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/lone_skirt

/datum/loadout_item/under/miscellaneous/medium_skirt
	name = "Medium Colourable Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/medium

/datum/loadout_item/under/miscellaneous/long_skirt
	name = "Long Colourable Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/long

/datum/loadout_item/under/miscellaneous/denim_skirt
	name = "Jean Skirt"
	item_path = /obj/item/clothing/under/dress/skirt/skyrat/jean

/datum/loadout_item/under/miscellaneous/littleblack
	name = "Short Black Dress"
	item_path = /obj/item/clothing/under/dress/skyrat/short_dress

/datum/loadout_item/under/miscellaneous/pinktutu
	name = "Pink Tutu"
	item_path = /obj/item/clothing/under/dress/skyrat/pinktutu

/datum/loadout_item/under/miscellaneous/flowerdress
	name = "Flower Dress"
	item_path = /obj/item/clothing/under/dress/skyrat/flower

/datum/loadout_item/under/miscellaneous/kilt
	name = "Kilt"
	item_path = /obj/item/clothing/under/costume/kilt

/datum/loadout_item/under/miscellaneous/treasure_hunter
	name = "Treasure Hunter"
	item_path = /obj/item/clothing/under/rank/civilian/curator/treasure_hunter

/datum/loadout_item/under/miscellaneous/jester
	name = "Jester Suit"
	item_path = /obj/item/clothing/under/rank/civilian/clown/jester

/datum/loadout_item/under/miscellaneous/jesteralt
	name = "Jeset Suit (Alt)"
	item_path = /obj/item/clothing/under/rank/civilian/clown/jesteralt

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

/datum/loadout_item/under/miscellaneous/maidcostume
	name = "Maid Costume"
	item_path = /obj/item/clothing/under/costume/maid

/datum/loadout_item/under/miscellaneous/maid_costume
	name = "Colourable Maid Uniform"
	item_path = /obj/item/clothing/under/maid_costume

/datum/loadout_item/under/miscellaneous/yukata
	name = "Recolorable Yukata"
	item_path = /obj/item/clothing/under/costume/skyrat/yukata

/datum/loadout_item/under/miscellaneous/qipao_black
	name = "Recolorable Qipao"
	item_path = /obj/item/clothing/under/costume/skyrat/qipao

/datum/loadout_item/under/miscellaneous/cheongsam
	name = "Recolorable Cheongsam"
	item_path = /obj/item/clothing/under/costume/skyrat/cheongsam

/datum/loadout_item/under/miscellaneous/kimono
	name = "Fancy Kimono"
	item_path =  /obj/item/clothing/under/costume/skyrat/kimono

/datum/loadout_item/under/miscellaneous/chaps
	name = "Black Chaps"
	item_path = /obj/item/clothing/under/pants/skyrat/chaps

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

/datum/loadout_item/under/miscellaneous/cavalry
	name = "Cavalry Uniform"
	item_path = /obj/item/clothing/under/costume/skyrat/cavalry

/datum/loadout_item/under/miscellaneous/tacticool_turtleneck
	name = "Tacticool Turtleneck"
	item_path = /obj/item/clothing/under/syndicate/tacticool //This has been rebalanced in modular_skyrat\master_files\code\modules\clothing\under\syndicate.dm

/datum/loadout_item/under/miscellaneous/tactical_skirt
	name = "Tacticool Skirtleneck"
	item_path = /obj/item/clothing/under/syndicate/tacticool/skirt //This has been rebalanced in modular_skyrat\master_files\code\modules\clothing\under\syndicate.dm

/datum/loadout_item/under/miscellaneous/tactical_pants
	name = "Tactical Pants"
	item_path = /obj/item/clothing/under/pants/tactical

/datum/loadout_item/under/miscellaneous/blastwave_uniform
	name = "Blastwave Uniform"
	item_path = /obj/item/clothing/under/blastwave

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

/datum/loadout_item/under/miscellaneous/sweater
	name = "Cableknit Sweater" //Different than the Suit item ("Sweater")!!
	item_path = /obj/item/clothing/under/sweater

/datum/loadout_item/under/miscellaneous/keyhole
	name = "Keyhole Sweater"
	item_path = /obj/item/clothing/under/sweater/keyhole

/datum/loadout_item/under/miscellaneous/blacknwhite
	name = "Classic Prisoner Jumpsuit"
	item_path = /obj/item/clothing/under/rank/prisoner/classic

/datum/loadout_item/under/miscellaneous/redscrubs
	name = "Red Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/red

/datum/loadout_item/under/miscellaneous/bluescrubs
	name = "Blue Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/blue

/datum/loadout_item/under/miscellaneous/greenscrubs
	name = "Green Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/green

/datum/loadout_item/under/miscellaneous/purplescrubs
	name = "Purple Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/purple

/datum/loadout_item/under/miscellaneous/whitescrubs
	name = "White Scrubs"
	item_path = /obj/item/clothing/under/rank/medical/scrubs/skyrat/white

/datum/loadout_item/under/miscellaneous/gear_harness
	name = "Gear Harness"
	item_path = /obj/item/clothing/under/misc/skyrat/gear_harness

/datum/loadout_item/under/miscellaneous/taccas
	name = "Tacticasual Uniform"
	item_path = /obj/item/clothing/under/misc/skyrat/taccas

/datum/loadout_item/under/miscellaneous/cargo_casual
	name = "Cargo Tech Casualwear"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/casualman

/datum/loadout_item/under/miscellaneous/cargo_shorts
	name = "Cargo Tech Shorts"
	item_path = /obj/item/clothing/under/rank/cargo/tech/alt

/datum/loadout_item/under/miscellaneous/cargo_black
	name = "Black Cargo Uniform"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/evil

/datum/loadout_item/under/miscellaneous/cargo_turtle
	name = "Cargo Turtleneck"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck

/datum/loadout_item/under/miscellaneous/cargo_skirtle
	name = "Cargo Skirtleneck"
	item_path = /obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck/skirt

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
	item_path = /obj/item/clothing/under/misc/skyrat/gear_harness/eve

/datum/loadout_item/under/miscellaneous/adam
	name = "Leaf"
	item_path = /obj/item/clothing/under/misc/skyrat/gear_harness/adam

/datum/loadout_item/under/miscellaneous/ethereal_tunic
	name = "Ethereal Tunic"
	item_path = /obj/item/clothing/under/ethereal_tunic

/datum/loadout_item/under/miscellaneous/mech_suit
	name = "Mech Suit"
	item_path = /obj/item/clothing/under/costume/mech_suit

/*
*	FORMAL UNDERSUITS
*/

/datum/loadout_item/under/formal

/datum/loadout_item/under/formal/amish_suit
	name = "White Buttondown Shirt with Black Slacks"
	item_path = /obj/item/clothing/under/costume/buttondown/slacks/service

/datum/loadout_item/under/formal/formaldressred
	name = "Formal Red Dress"
	item_path = /obj/item/clothing/under/dress/skyrat/redformal

/datum/loadout_item/under/formal/countessdress
	name = "Countess Dress"
	item_path = /obj/item/clothing/under/dress/skyrat/countess

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

/datum/loadout_item/under/formal/black_lawyer_suit
	name = "Black Lawyer Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black

/datum/loadout_item/under/formal/black_lawyer_skirt
	name = "Black Lawyer Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/black/skirt

/datum/loadout_item/under/formal/blue_suit
	name = "Blue Buttondown Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit

/datum/loadout_item/under/formal/blue_suitskirt
	name = "Blue Buttondown Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/bluesuit/skirt

/datum/loadout_item/under/formal/blue_lawyer_suit
	name = "Blue Lawyer Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue

/datum/loadout_item/under/formal/blue_lawyer_skirt
	name = "Blue Lawyer Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/blue/skirt

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
	name = "Wide-collared Executive Suit"
	item_path = /obj/item/clothing/under/suit/skyrat/black_really_collared

/datum/loadout_item/under/formal/executive_skirt_alt
	name = "Wide-collared Executive Suitskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/black_really_collared/skirt

/datum/loadout_item/under/formal/navy_suit
	name = "Navy Suit"
	item_path = /obj/item/clothing/under/suit/navy

/datum/loadout_item/under/formal/maid_uniform
	name = "Maid Uniform"
	item_path = /obj/item/clothing/under/rank/civilian/janitor/maid

/datum/loadout_item/under/formal/purple_suit
	name = "Purple Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit

/datum/loadout_item/under/formal/purple_suitskirt
	name = "Purple Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/purpsuit/skirt

/datum/loadout_item/under/formal/red_suit
	name = "Red Suit"
	item_path = /obj/item/clothing/under/suit/red

/datum/loadout_item/under/formal/helltaker
	name = "Red Shirt with White Trousers"
	item_path = /obj/item/clothing/under/suit/skyrat/helltaker

/datum/loadout_item/under/formal/helltaker/skirt
	name = "Red Shirt with White Skirt"
	item_path = /obj/item/clothing/under/suit/skyrat/helltaker/skirt

/datum/loadout_item/under/formal/red_lawyer_skirt
	name = "Red Lawyer Suit"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red

/datum/loadout_item/under/formal/red_lawyer_skirt
	name = "Red Lawyer Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/lawyer/red/skirt

/datum/loadout_item/under/formal/red_gown
	name = "Red Evening Gown"
	item_path = /obj/item/clothing/under/dress/eveninggown

/datum/loadout_item/under/formal/sailor
	name = "Sailor Suit"
	item_path = /obj/item/clothing/under/costume/sailor

/datum/loadout_item/under/formal/sailor_skirt
	name = "Sailor Dress"
	item_path = /obj/item/clothing/under/dress/sailor

/datum/loadout_item/under/formal/sensible_suit
	name = "Sensible Suit"
	item_path = /obj/item/clothing/under/rank/civilian/curator

/datum/loadout_item/under/formal/sensible_skirt
	name = "Sensible Suitskirt"
	item_path = /obj/item/clothing/under/rank/civilian/curator/skirt

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

/datum/loadout_item/under/formal/recolorable_suit
	name = "Recolorable Formal Suit"
	item_path = /obj/item/clothing/under/suit/skyrat/recolorable

/datum/loadout_item/under/formal/recolorable_suitskirt
	name = "Recolorable Formal Suitskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/recolorable/skirt

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

//FAMILIES GEAR
/datum/loadout_item/under/formal/osi
	name = "OSI Uniform"
	item_path = /obj/item/clothing/under/costume/osi

/datum/loadout_item/under/formal/tmc
	name = "TMC Uniform"
	item_path = /obj/item/clothing/under/costume/tmc

/datum/loadout_item/under/formal/inferno
	name = "Inferno Suit"
	item_path = /obj/item/clothing/under/suit/skyrat/inferno

/datum/loadout_item/under/formal/inferno_skirt
	name = "Inferno Skirt"
	item_path = /obj/item/clothing/under/suit/skyrat/inferno/skirt

/datum/loadout_item/under/formal/designer_inferno
	name = "Designer Inferno Suit"
	item_path = /obj/item/clothing/under/suit/skyrat/inferno/beeze

/datum/loadout_item/under/formal/pencil
	name = "Black Pencilskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil

/datum/loadout_item/under/formal/pencil/black_really
	name = "Executive Pencilskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/black_really

/datum/loadout_item/under/formal/pencil/charcoal
	name = "Charcoal Pencilskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/charcoal

/datum/loadout_item/under/formal/pencil/navy
	name = "Navy Pencilskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/navy

/datum/loadout_item/under/formal/pencil/burgandy
	name = "Burgandy Pencilskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/burgandy

/datum/loadout_item/under/formal/pencil/checkered
	name = "Checkered Pencilskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/checkered

/datum/loadout_item/under/formal/pencil/tan
	name = "Tan Pencilskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/tan

/datum/loadout_item/under/formal/pencil/green
	name = "Green Pencilskirt"
	item_path = /obj/item/clothing/under/suit/skyrat/pencil/green

/datum/loadout_item/under/formal/azulea_oldblood
	name = " Oldblood's Royal regalia"
	item_path = /obj/item/clothing/under/rank/azulean/old_blood
	restricted_roles = list(JOB_CAPTAIN, JOB_NT_REP)
	restricted_species = list(SPECIES_AKULA)

/datum/loadout_item/under/formal/azulea_oldblood/skirt
	name = " Oldblood's Royal regalia (Skirt)"
	item_path = /obj/item/clothing/under/rank/azulean/old_blood/skirt
	restricted_roles = list(JOB_CAPTAIN, JOB_NT_REP)
	restricted_species = list(SPECIES_AKULA)

/datum/loadout_item/under/formal/azulea_upstart
	name = "Upstart's Noble Getup"
	item_path = /obj/item/clothing/under/rank/azulean/upstart
	restricted_roles = list(JOB_CAPTAIN, JOB_NT_REP)
	restricted_species = list(SPECIES_AKULA)

/datum/loadout_item/under/formal/azulea_upstart/skirt
	name = "Upstart's Noble Getup (Skirt)"
	item_path = /obj/item/clothing/under/rank/azulean/upstart/skirt
	restricted_roles = list(JOB_CAPTAIN, JOB_NT_REP)
	restricted_species = list(SPECIES_AKULA)

/// DONATOR
/datum/loadout_item/under/donator
	donator_only = TRUE

/datum/loadout_item/under/donator/captain_black
	name  = "Captains Black Uniform"
	item_path = /obj/item/clothing/under/rank/captain/skyrat/black
	restricted_roles = list(JOB_CAPTAIN)
