//SPAWNERS//
/obj/effect/mob_spawn/ghost_role/human/blackmarket
	name = "cryogenics pod"
	prompt_name = "a blackmarket dealer"
	desc = "A humming cryo pod. The machine is attempting to wake up its occupant."
	mob_name = "a black market dealer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	random = TRUE
	mob_species = /datum/species/human
	you_are_text = "You are a black market dealer, with shop set up in Nanotrasen Space."
	flavour_text = "FTU, Independent.. whatever, whoever you are. It doesn't matter out here. \
	You've set up shop in a slightly shady, yet functional little asteroid for your dealings. \
	Explore space, find valuable artifacts and nice loot - and pawn it off to those stooges at NT. \
	Or perhaps more exotic customers are in local space...?"
	important_text = "You are not an antagonist."
	outfit = /datum/outfit/black_market
	can_use_alias = TRUE
	any_station_species = TRUE

/datum/outfit/black_market
	name = "Black Market Trader"
	uniform = /obj/item/clothing/under/rank/cargo/tech
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/away/blackmarket

/obj/effect/mob_spawn/ghost_role/human/ds2/prisoner
	name = "Syndicate Prisoner"
	prompt_name = "a Syndicate prisoner"
	you_are_text = "You are the syndicate prisoner aboard an unknown station."
	flavour_text = "You don't know where you are, but you know you are a prisoner. The plastitanium clues you into your captors.. as for why you're here? That's up to you."
	important_text = "You are still subject to standard prisoner policy, and must Adminhelp before antagonizing Interdyne."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/ds2/prisoner
	can_use_alias = TRUE
	any_station_species = TRUE

/obj/effect/mob_spawn/ghost_role/human/ds2
	name = "DS2 personnel"
	prompt_name = "DS2 personnel"
	you_are_text = "You are a syndicate operative, employed in a top secret research facility developing biological weapons."
	flavour_text = "Unfortunately, your hated enemy, Nanotrasen, has begun mining in this sector. Continue operating as best you can, and try to keep a low profile."

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate
	name = "Syndicate Operative"
	prompt_name = "a Syndicate operative"
	random = TRUE
	can_use_alias = TRUE
	any_station_species = TRUE
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	you_are_text = "You are a syndicate operative, employed in a top secret research facility developing biological weapons."
	flavour_text = "Unfortunately, your hated enemy, Nanotrasen, has begun mining in this sector. Continue operating as best you can, and try to keep a low profile."
	important_text = "You are not an antagonist."
	outfit = /datum/outfit/ds2/syndicate

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/special(mob/living/new_spawn)
	. = ..()
	new_spawn.grant_language(/datum/language/codespeak, TRUE, TRUE, LANGUAGE_MIND)

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/service
	outfit = /datum/outfit/ds2/syndicate/service

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/enginetech
	outfit = /datum/outfit/ds2/syndicate/enginetech

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/researcher
	outfit = /datum/outfit/ds2/syndicate/researcher

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/stationmed
	outfit = /datum/outfit/ds2/syndicate/stationmed

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/masteratarms
	outfit = /datum/outfit/ds2/syndicate/masteratarms

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/brigoff
	outfit = /datum/outfit/ds2/syndicate/brigoff

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate/admiral
	outfit = /datum/outfit/ds2/syndicate/admiral

//OUTFITS//
/datum/outfit/syndicatespace/syndicrew
	ears = /obj/item/radio/headset/cybersun
	id_trim = /datum/id_trim/syndicom/skyrat/crew

/datum/outfit/syndicatespace/syndicaptain
	ears = /obj/item/radio/headset/cybersun/captain
	id_trim = /datum/id_trim/syndicom/skyrat/captain

/datum/outfit/ds2/prisoner
	name = "Syndicate Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner
	shoes = /obj/item/clothing/shoes/sneakers/orange
	id = /obj/item/card/id/advanced/prisoner

/datum/outfit/ds2/syndicate
	name = "DS-2 Operative"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/interdyne
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth)
	id_trim = /datum/id_trim/syndicom/skyrat/assault/assistant

/datum/outfit/ds2/syndicate/service
	name = "DS-2 Staff"
	uniform = /obj/item/clothing/under/utility/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/syndicatestaff

/datum/outfit/ds2/syndicate/enginetech
	name = "DS-2 Engine Technician"
	uniform = /obj/item/clothing/under/utility/eng/syndicate
	id_trim = /datum/id_trim/syndicom/skyratnoicon/enginetechnician
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/ds2/syndicate/researcher
	name = "DS-2 Researcher"
	uniform = /obj/item/clothing/under/utility/sci/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/researcher

/datum/outfit/ds2/syndicate/stationmed
	name = "DS-2 Station Medical Officer"
	uniform = /obj/item/clothing/under/utility/med/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/stationmedicalofficer

/datum/outfit/ds2/syndicate/masteratarms
	name = "DS-2 Master At Arms"
	uniform = /obj/item/clothing/under/utility/sec/old/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/masteratarms
	belt = /obj/item/storage/belt/security/full
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	head = /obj/item/clothing/head/sec/navywarden/syndicate
	ears = /obj/item/radio/headset/interdyne

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/security/loaded
	)

/datum/outfit/ds2/syndicate/brigoff
	name = "DS-2 Brig Officer"
	uniform = /obj/item/clothing/under/utility/sec/old/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/brigofficer
	belt = /obj/item/storage/belt/security/full
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof
	head = /obj/item/clothing/head/helmet/swat
	ears = /obj/item/radio/headset/interdyne

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/security/loaded
	)

/datum/outfit/ds2/syndicate/admiral
	name = "DS-2 Station Admiral"
	uniform = /obj/item/clothing/under/utility/com/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	head = /obj/item/clothing/head/hos/beret/syndicate
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/gold/generic
	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/aps)
	id_trim = /datum/id_trim/syndicom/skyrat/assault/stationadmiral
	ears = /obj/item/radio/headset/interdyne/command

/datum/outfit/ds2/syndicate/post_equip(mob/living/carbon/human/H)
	H.faction |= ROLE_SYNDICATE

//Lost Space Truckers: Six people stranded in deep space aboard a cargo freighter. They must survive their marooning and cooperate.

/obj/effect/mob_spawn/ghost_role/human/lostcargo
	name = "freighter cryo crew pod"
	prompt_name = "a lost cargo tech"
	desc = "A humming cryo pod. There's a freight hauler inside."
	mob_name = "Freighter Crew"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	random = TRUE
	mob_species = /datum/species/human
	you_are_text = "You were running cargo, a typical freight job until pirates attacked. You and your crewmates just barely made it, but the engines are shot. You're trapped in space now, only able to work together to survive this nightmare."
	flavour_text = "You were running cargo, a typical freight job until pirates attacked. You and your crewmates just barely made it, but the engines are shot. You're trapped in space now, only able to work together to survive this nightmare."
	important_text = "Work with your crew and don't abandon them. You are not directly working with NT, you are an independent freighter crew for the ship's Chief. Your job was merely being a deckhand doing freight work and helping with kitchen prep."
	can_use_alias = TRUE
	any_station_species = TRUE

/datum/outfit/freighter_crew
	name = "Freighter Crew"
	uniform = /obj/item/clothing/under/rank/cargo/casualman
	shoes = /obj/item/clothing/shoes/workboots
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/armament_token/sidearm_blackmarket)
	id = /obj/item/card/id/away/freightcrew

/obj/effect/mob_spawn/ghost_role/human/lostminer
	name = "freighter cryo excavator pod"
	prompt_name = "a lost miner"
	desc = "A humming cryo pod. There's an excavation worker inside."
	mob_name = "Freighter Excavator"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	random = TRUE
	mob_species = /datum/species/human
	you_are_text = "You were running cargo, a typical freight job until pirates attacked. You and your crewmates just barely made it, but the engines are shot. You're trapped in space now, only able to work together to survive this nightmare."
	flavour_text = "You were running cargo, a typical freight job until pirates attacked. You and your crewmates just barely made it, but the engines are shot. You're trapped in space now, only able to work together to survive this nightmare."
	important_text = "Work with your crew and don't abandon them. You are not directly working with NT, you are an independent freighter crew working under the ship Chief. Your role was to be an excavation and salvage worker for the ship."
	can_use_alias = TRUE
	any_station_species = TRUE

/datum/outfit/freighter_excavator
	name = "Freighter Excavator"
	uniform = /obj/item/clothing/under/utility/cargo/gorka
	shoes = /obj/item/clothing/shoes/workboots/mining
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/flashlight/seclite=1,\
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1,\
		/obj/item/armament_token/sidearm_blackmarket)
	r_pocket = /obj/item/storage/bag/ore
	id = /obj/item/card/id/away/freightmine

/obj/effect/mob_spawn/ghost_role/human/lostcargoqm
	name = "freighter cryo boss pod"
	prompt_name = "a lost Quartermaster"
	desc = "A humming cryo pod. You see someone who looks In Charge inside."
	mob_name = "Freighter Chief"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	random = TRUE
	mob_species = /datum/species/human
	you_are_text = "You and your crew were running a normal freight haul until a pirate attack knocked out the engines. All you can do now is try and survive and keep your crew alive."
	flavour_text = "You and your crew were running a normal freight haul until a pirate attack knocked out the engines. All you can do now is try and survive and keep your crew alive."
	important_text = "Do not abandon your crew, lead them and work with them to survive. You are not directly working with NT, you are an independent freighter crew. You are the captain of the ship, which you purchased a while ago, and are in charge of the crew."
	can_use_alias = TRUE
	any_station_species = TRUE

/datum/outfit/freighter_boss
	name = "Freighter Boss"
	uniform = /obj/item/clothing/under/utility/cargo/turtleneck
	shoes = /obj/item/clothing/shoes/workboots
	neck = /obj/item/clothing/neck/cloak/qm
	back = /obj/item/storage/backpack
	backpack_contents = list(
    	/obj/item/armament_token/energy=1,
    	/obj/item/megaphone/cargo=1,
    	)
	id = /obj/item/card/id/away/freightqm

//ITEMS//
/obj/item/radio/headset/cybersun
	keyslot = new /obj/item/encryptionkey/headset_cybersun

/obj/item/radio/headset/cybersun/captain
	name = "cybersun captain headset"
	desc = "The headset of the boss."
	command = TRUE

//OBJECTS//
/obj/structure/showcase/machinery/oldpod/used
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod-open"

//IDS//
/obj/item/card/id/away/blackmarket
	name = "scuffed ID card"
	desc = "A faded, scuffed, plastic ID card. You can make out the rank \"Deck Crewman\"."
	trim = /datum/id_trim/away/blackmarket

/datum/id_trim/away/blackmarket
	access = list(ACCESS_AWAY_GENERIC4)
	assignment = "Deck Crewman"

/obj/item/card/id/away/freightcrew
    name = "Freighter ID"
    desc = "An ID card marked with the rank of Freight Hauler."
    trim = /datum/id_trim/job/cargo_technician

/obj/item/card/id/away/freightmine
    name = "Freighter ID"
    desc = "An ID card marked with the rank of Freight Ship Excavator."
    trim = /datum/id_trim/job/shaft_miner

/obj/item/card/id/away/freightqm
    name = "Freighter Deck Chief ID"
    desc = "An ID card marked with the rank of Freight Deck Chief."
    trim = /datum/id_trim/job/quartermaster

//AREAS//
/area/ruin/space/has_grav/deepstorage/lostcargo
	name = "Freighter Ship"
	icon_state = "yellow"

