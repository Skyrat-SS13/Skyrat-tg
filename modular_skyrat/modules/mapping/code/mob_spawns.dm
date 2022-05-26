//SPAWNERS//

/obj/effect/mob_spawn/ghost_role/human/ash_walker/special(mob/living/carbon/human/spawned_human)
	. = ..()
	if(SSmapping.level_trait(spawned_human.z, ZTRAIT_ICE_RUINS_UNDERGROUND) || SSmapping.level_trait(spawned_human.z, ZTRAIT_ICE_RUINS_UNDERGROUND))
		ADD_TRAIT(spawned_human, TRAIT_NOBREATH, ROUNDSTART_TRAIT)
		ADD_TRAIT(spawned_human, TRAIT_RESISTCOLD, ROUNDSTART_TRAIT)

/obj/effect/mob_spawn/ghost_role/human/blackmarket
	name = "cryogenics pod"
	prompt_name = "a blackmarket dealer"
	desc = "A humming cryo pod. The machine is attempting to wake up its occupant."
	mob_name = "a black market dealer"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You are a black market dealer, with shop set up in Nanotrasen Space."
	flavour_text = "FTU, Independent.. whatever, whoever you are. It doesn't matter out here. \
	You've set up shop in a slightly shady, yet functional little asteroid for your dealings. \
	Explore space, find valuable artifacts and nice loot - and pawn it off to those stooges at NT. \
	Or perhaps more exotic customers are in local space...?"
	important_text = "You are not an antagonist."
	outfit = /datum/outfit/black_market

/datum/outfit/black_market
	name = "Black Market Trader"
	uniform = /obj/item/clothing/under/rank/cargo/tech
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/away/blackmarket

/obj/effect/mob_spawn/ghost_role/human/ds2
	name = "DS2 personnel"
	prompt_name = "DS2 personnel"
	you_are_text = "You are a syndicate operative, employed in a top secret research facility developing biological weapons."
	flavour_text = "Unfortunately, your hated enemy, Nanotrasen, has begun mining in this sector. Continue operating as best you can, and try to keep a low profile."
	quirks_enabled = TRUE
	random_appearance = FALSE

/obj/effect/mob_spawn/ghost_role/human/ds2/prisoner
	name = "Syndicate Prisoner"
	prompt_name = "a Syndicate prisoner"
	you_are_text = "You are the syndicate prisoner aboard an unknown station."
	flavour_text = "You don't know where you are, but you know you are a prisoner. The plastitanium clues you into your captors.. as for why you're here? That's up to you."
	important_text = "You are still subject to standard prisoner policy, and must Adminhelp before antagonizing Interdyne."
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	outfit = /datum/outfit/ds2/prisoner

/obj/effect/mob_spawn/ghost_role/human/ds2/syndicate
	name = "Syndicate Operative"
	prompt_name = "a Syndicate operative"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	you_are_text = "You are a syndicate operative, employed in a top secret research facility developing biological weapons."
	flavour_text = "Unfortunately, your hated enemy, Nanotrasen, has begun mining in this sector. Continue operating as best you can, and try to keep a low profile."
	important_text = "You are not an antagonist."
	outfit = /datum/outfit/ds2/syndicate
	loadout_enabled = TRUE

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

/datum/outfit/ds2/post_equip(mob/living/carbon/human/syndicate, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = syndicate.wear_id
	if(istype(id_card))
		id_card.registered_name = syndicate.real_name
		id_card.update_label()
		id_card.update_icon()

	return ..()

/datum/outfit/ds2/prisoner
	name = "Syndicate Prisoner"
	uniform = /obj/item/clothing/under/rank/prisoner/syndicate
	shoes = /obj/item/clothing/shoes/sneakers/crimson
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
	uniform = /obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/syndicate
	id_trim = /datum/id_trim/syndicom/skyratnoicon/enginetechnician
	gloves = /obj/item/clothing/gloves/combat

/datum/outfit/ds2/syndicate/researcher
	name = "DS-2 Researcher"
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/researcher

/datum/outfit/ds2/syndicate/stationmed
	name = "DS-2 Station Medical Officer"
	uniform = /obj/item/clothing/under/rank/medical/doctor/skyrat/utility/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/stationmedicalofficer

/datum/outfit/ds2/syndicate/masteratarms
	name = "DS-2 Master At Arms"
	uniform = /obj/item/clothing/under/utility/sec/old/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/masteratarms
	belt = /obj/item/storage/belt/security/full
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	head = /obj/item/clothing/head/sec/navywarden/syndicate
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
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
	suit = /obj/item/clothing/suit/armor/bulletproof/old
	head = /obj/item/clothing/head/helmet/swat/ds
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses
	mask = /obj/item/clothing/mask/gas/syndicate/ds
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

/datum/outfit/ds2/syndicate/post_equip(mob/living/carbon/human/syndicate)
	syndicate.faction |= ROLE_SYNDICATE
	return ..()

//Lost Space Truckers: Six people stranded in deep space aboard a cargo freighter. They must survive their marooning and cooperate.

/obj/effect/mob_spawn/ghost_role/human/lostcargo
	name = "freighter cryo crew pod"
	prompt_name = "a lost cargo tech"
	desc = "A humming cryo pod. There's a freight hauler inside."
	mob_name = "Freighter Crew"
	outfit = /datum/outfit/freighter_crew
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You were running cargo, a typical freight job until pirates attacked. You and your crewmates just barely made it, but the engines are shot. You're trapped in space now, only able to work together to survive this nightmare."
	flavour_text = "You were running cargo, a typical freight job until pirates attacked. You and your crewmates just barely made it, but the engines are shot. You're trapped in space now, only able to work together to survive this nightmare."
	important_text = "Work with your crew and don't abandon them. You are not directly working with NT, you are an independent freighter crew for the ship's Chief. Your job was merely being a deckhand doing freight work and helping with kitchen prep."
	random_appearance = FALSE

/datum/outfit/freighter_crew
	name = "Freighter Crew"
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/casualman
	shoes = /obj/item/clothing/shoes/workboots
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/armament_token/sidearm_blackmarket)
	id = /obj/item/card/id/away/freightcrew

/obj/effect/mob_spawn/ghost_role/human/lostminer
	name = "freighter cryo excavator pod"
	prompt_name = "a lost miner"
	desc = "A humming cryo pod. There's an excavation worker inside."
	mob_name = "Freighter Excavator"
	outfit = /datum/outfit/freighter_excavator
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You were running cargo, a typical freight job until pirates attacked. You and your crewmates just barely made it, but the engines are shot. You're trapped in space now, only able to work together to survive this nightmare."
	flavour_text = "You were running cargo, a typical freight job until pirates attacked. You and your crewmates just barely made it, but the engines are shot. You're trapped in space now, only able to work together to survive this nightmare."
	important_text = "Work with your crew and don't abandon them. You are not directly working with NT, you are an independent freighter crew working under the ship Chief. Your role was to be an excavation and salvage worker for the ship."
	random_appearance = FALSE

/datum/outfit/freighter_excavator
	name = "Freighter Excavator"
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/gorka
	shoes = /obj/item/clothing/shoes/workboots/mining
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/flashlight/seclite=1,\
		/obj/item/knife/combat/survival=1,
		/obj/item/mining_voucher=1,
		/obj/item/t_scanner/adv_mining_scanner/lesser=1,
		/obj/item/gun/energy/recharge/kinetic_accelerator=1,\
		/obj/item/stack/marker_beacon/ten=1,\
		/obj/item/armament_token/sidearm_blackmarket)
	r_pocket = /obj/item/storage/bag/ore
	id = /obj/item/card/id/away/freightmine

/obj/effect/mob_spawn/ghost_role/human/lostcargoqm
	name = "freighter cryo boss pod"
	prompt_name = "a lost Quartermaster"
	desc = "A humming cryo pod. You see someone who looks In Charge inside."
	mob_name = "Freighter Chief"
	outfit = /datum/outfit/freighter_boss
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	mob_species = /datum/species/human
	you_are_text = "You and your crew were running a normal freight haul until a pirate attack knocked out the engines. All you can do now is try and survive and keep your crew alive."
	flavour_text = "You and your crew were running a normal freight haul until a pirate attack knocked out the engines. All you can do now is try and survive and keep your crew alive."
	important_text = "Do not abandon your crew, lead them and work with them to survive. You are not directly working with NT, you are an independent freighter crew. You are the captain of the ship, which you purchased a while ago, and are in charge of the crew."
	random_appearance = FALSE

/datum/outfit/freighter_boss
	name = "Freighter Boss"
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/turtleneck
	shoes = /obj/item/clothing/shoes/workboots
	neck = /obj/item/clothing/neck/cloak/qm
	back = /obj/item/storage/backpack
	backpack_contents = list(
    	/obj/item/armament_token/energy=1,
    	/obj/item/megaphone/cargo=1,
    	)
	id = /obj/item/card/id/away/freightqm

//Port Tarkon, 5 people trapped in a revamped charlie-station like ghost role. Survive the aliens and threats, Fix the port and/or finish construction

/obj/effect/mob_spawn/ghost_role/human/tarkon
	name = "P-T Abandoned Crew"
	prompt_name = "an abandoned cargo member"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper"
	you_are_text = "You are an abandoned member of Port Tarkon, an attempt to create steady living vaults within large asteroids. You have no real idea who Interdyne is, And your last recollection of NT is the producer of some... Less than ethically obtained goods on the port."
	flavour_text = "Something went wrong. Morality of experiments went awry, expansions were made before scans were fully done and now you have to deal with the aftermath of your past crews exodus. Bring P-T to the success it was ment to be, or die trying. (OOC note: This ghost role was not designed with Plasmamen or Vox in mind. While there are some accommodations so that they can survive, it should be noted that they were not the focal point whilst designing Port Tarkon. The closet in the middle of the room above contains the 'accommodations' for those species.)"
	important_text = "DO NOT abandon the port, PERIOD, but using the ship to buy more items or get help is good, if not ideal. Do not trade special equipment to the station. Unwelcomed and uninvited guests are not obligated to your kindness."
	outfit = /datum/outfit/tarkon
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	random_appearance = FALSE

/datum/outfit/tarkon
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	shoes = /obj/item/clothing/shoes/winterboots
	gloves = /obj/item/clothing/gloves/fingerless
	glasses = /obj/item/clothing/glasses/sunglasses
	id = /obj/item/card/id/away/tarkon/cargo
	l_pocket = /obj/item/card/mining_point_card
	r_pocket = /obj/item/mining_voucher
	ears = /obj/item/radio/headset/tarkon

/datum/outfit/tarkon/post_equip(mob/living/carbon/human/tarkon, visualsOnly = FALSE)
	var/obj/item/card/id/id_card = tarkon.wear_id
	if(istype(id_card))
		id_card.registered_name = tarkon.real_name
		id_card.update_label()
		id_card.update_icon()
	var/obj/item/radio/target_radio = tarkon.ears
	target_radio.set_frequency(1243)
	target_radio.recalculateChannels()

	return ..()

/obj/effect/mob_spawn/ghost_role/human/tarkon/sci
	prompt_name = "an abandoned scientist"
	outfit = /datum/outfit/tarkon/sci

/datum/outfit/tarkon/sci
	uniform = /obj/item/clothing/under/rank/rnd/scientist/skyrat/utility
	glasses = /obj/item/clothing/glasses/hud/diagnostic
	id = /obj/item/card/id/away/tarkon/sci
	l_hand = /obj/item/inducer
	l_pocket = null
	r_pocket = /obj/item/stock_parts/cell/high

/obj/effect/mob_spawn/ghost_role/human/tarkon/med
	prompt_name = "an abandoned medical resident"
	outfit = /datum/outfit/tarkon/med

/datum/outfit/tarkon/med
	uniform = /obj/item/clothing/under/rank/medical/doctor/skyrat/utility
	glasses = /obj/item/clothing/glasses/hud/health
	id = /obj/item/card/id/away/tarkon/med
	neck = /obj/item/clothing/neck/stethoscope
	l_pocket = /obj/item/healthanalyzer
	r_pocket = /obj/item/stack/medical/suture/medicated

/obj/effect/mob_spawn/ghost_role/human/tarkon/engi
	prompt_name = "an abandoned maintenance engineer"
	outfit = /datum/outfit/tarkon/engi

/datum/outfit/tarkon/engi
	uniform = /obj/item/clothing/under/rank/engineering/engineer/skyrat/utility
	glasses = /obj/item/clothing/glasses/meson/engine/tray
	id = /obj/item/card/id/away/tarkon/engi
	gloves = /obj/item/clothing/gloves/combat
	l_pocket = /obj/item/tank/internals/emergency_oxygen/engi
	r_pocket = /obj/item/stack/cable_coil

/obj/effect/mob_spawn/ghost_role/human/tarkon/sec
	prompt_name = "an abandoned security deputy"
	outfit = /datum/outfit/tarkon/sec

/datum/outfit/tarkon/sec
	uniform = /obj/item/clothing/under/utility/sec
	glasses = /obj/item/clothing/glasses/hud/security
	gloves = /obj/item/clothing/gloves/tackler/combat
	id = /obj/item/card/id/away/tarkon/sec
	l_pocket = /obj/item/melee/baton/telescopic
	r_pocket = /obj/item/grenade/barrier
	skillchips = list(/obj/item/skillchip/chameleon/reload)

/obj/effect/mob_spawn/ghost_role/human/tarkon/ensign
	name = "P-T Abandoned Ensign"
	prompt_name = "an abandoned ensign"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper-o"
	you_are_text = "You were tasked by Tarkon Industries to Port Tarkon as a low-level command member, Holding no actual command, but as just another scapegoat to blame should it failed... And failed it did. Scan were never done when the overseer commanded construction, and you were left, forever branded with a task not possible for you"
	flavour_text = "The rest of command bailed, and left as nothing more than a glorified assistant, you are held responsible should you be unable to wrangle what hopes of success Headquarters has. Find the blueprints and keep them close, Lest looters and raiders plan to seize what isn't theirs. (OOC note: This ghost role was not designed with Plasmamen or Vox in mind. While there are some accommodations so that they can survive, it should be noted that they were not the focal point whilst designing Port Tarkon. The closet in the middle of the room above contains the 'accommodations' for those species.)"
	important_text = "People aren't obligated to listen to you, and you are, otherwise, just another body with some remnant of control. Make sure important items aren't traded and do your best to survive in the hellscape left for you. Unwelcomed and uninvited guests are not obligated to your kindness."
	outfit = /datum/outfit/tarkon/ensign

/datum/outfit/tarkon/ensign //jack of all trades, master of none, spent all his credits, every last one
	uniform = /obj/item/clothing/under/utility
	ears = /obj/item/radio/headset/tarkon/ensign
	id = /obj/item/card/id/away/tarkon/ensign
	neck = /obj/item/clothing/neck/security_cape/armplate
	gloves = /obj/item/clothing/gloves/combat
	l_pocket = null
	r_pocket = null
	skillchips = list(/obj/item/skillchip/chameleon/reload)

//ITEMS//
/obj/item/radio/headset/cybersun
	keyslot = new /obj/item/encryptionkey/headset_cybersun

/obj/item/radio/headset/cybersun/captain
	name = "cybersun captain headset"
	desc = "The headset of the boss."
	command = TRUE

/obj/item/radio/headset/tarkon
	name = "tarkon headset"
	freerange = TRUE
	freqlock = TRUE
	keyslot = new /obj/item/encryptionkey/headset_tarkon

/obj/item/radio/headset/tarkon/ensign //spoiler for upcoming update
	name = "tarkon ensign headset"
	desc = "A headset personally handed to trusted crew of Tarkon. It fills you with will to do... Something."
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


/datum/id_trim/away/tarkon
	assignment = "P-T Cargo Personell"
	access = list(66, ACCESS_AWAY_GENERAL)

/datum/id_trim/away/tarkon/sec
	assignment = "P-T Port Guard"
	access = list(66, ACCESS_AWAY_GENERAL, 210)

/datum/id_trim/away/tarkon/med
	assignment = "P-T Trauma Medic"
	access = list(5, 66, ACCESS_AWAY_GENERAL)

/datum/id_trim/away/tarkon/eng
	assignment = "P-T Maintenance Crew"

/datum/id_trim/away/tarkon/sci
	assignment = "P-T Field Researcher"
	access = list(29, 66, ACCESS_AWAY_GENERAL)

/datum/id_trim/away/tarkon/ensign
	assignment = "Tarkon Ensign"
	access = list(5, 29, 66, ACCESS_AWAY_GENERAL, 210)

/obj/item/card/id/away/tarkon/sci  //original tarkon ID is defined in fluff
	name = "P-T field researcher's access card"
	desc = "An access card designated for \"the science team\". You are forgotten basically immediately when it comes to the lab."
	trim = /datum/id_trim/away/tarkon/sci

/obj/item/card/id/away/tarkon/med
	name = "P-T trauma medic's access card"
	desc = "An access card designated for \"medical staff\". You provide the medic bags."
	trim = /datum/id_trim/away/tarkon/med

/obj/item/card/id/away/tarkon/sec
	name = "P-T resident deputy's access card"
	desc = "An access card designated for \"security members\". Everyone wants your guns, partner. Yee-haw."
	trim = /datum/id_trim/away/tarkon/sec

/obj/item/card/id/away/tarkon/cargo
	name = "P-T cargo hauler's access card"
	desc = "An access card designated for \"cargo's finest\". You're also a part time space miner, when cargonia is quiet."
	trim = /datum/id_trim/away/tarkon


/obj/item/card/id/away/tarkon/engi
	name = "P-T maintenance engineer's access card"
	desc = "An access card designated for \"engineering staff\". You're going to be the one everyone points at to fix stuff, lets be honest."
	trim = /datum/id_trim/away/tarkon/eng

/obj/item/card/id/away/tarkon/ensign
	name = "Tarkon ensign's access card"
	desc = "An access card designated for \"Tarkon ensign\". No one has to listen to you... But you're the closest there is for command around here."
	trim = /datum/id_trim/away/tarkon/ensign

//AREAS//
/area/ruin/space/has_grav/deepstorage/lostcargo
	name = "Freighter Ship"
	icon_state = "yellow"

