///NRI police patrol with a mission to find out if the fine reason is legitimate and then act from there.
/datum/pirate_gang/nri_raiders
	name = "NRI IAC Police Patrol"

	ship_template_id = "nri_raider"
	ship_name_pool = "imperial_names"

	threat_title = "NRI Audit"
	threat_content = "Greetings %STATION, this is the %SHIPNAME. \
	Due to recent Imperial regulatory violations, such as %RESULT and many other smaller issues, your station has been fined %PAYOFF credits. \
	Inadequate imperial police activity is currently present in your sector, thus the failure to comply might instead result in a military patrol dispatch \
	for second attempt negotiations. Novaya Rossiyskaya Imperiya collegial secretary out."
	possible_answers = list("Submit to audit and pay the fine.", "Override the response system for an immediate military dispatch.")

	response_received = "Should be it, thank you for cooperation. Novaya Rossiyskaya Imperiya collegial secretary out."
	response_too_late = "Your response was very delayed. We have been instructed to send in the patrol ship for second attempt negotiations, stand by."
	response_not_enough = "Your bank balance does not hold enough money at the moment or the system has been overriden. We are sending a patrol ship for second attempt negotiations, stand by."

/datum/pirate_gang/nri_raiders/generate_message(payoff)
	var/number = rand(1,99)
	///Station name one is the most important pick and is pretty much the station's main argument against getting fined, thus it better be mostly always right.
	var/station_designation = pick_weight(list(
		"Nanotrasen Research Station" = 70,
		"Nanotrasen Refueling Outpost" = 5,
		"Interdyne Pharmaceuticals Chemical Factory" = 5,
		"Free Teshari League Engineering Station" = 5,
		"Agurkrral Military Base" = 5,
		"Sol Federation Embassy" = 5,
		"Novaya Rossiyskaya Imperiya Civilian Port" = 5,
	))
	///"right" = Right for the raiders to use as an argument; usually pretty difficult to avoid.
	var/right_pick = pick(
		"high probability of NRI-affiliated civilian casualties aboard the facility",
		"highly increased funding by the SolFed authorities; neglected NRI-backed subsidiaries' contracts",
		"unethical hiring practices and unfair payment allocation for the NRI citizens",
		"recently discovered BSA-[number] or similar model in close proximity to the neutral space aboard this or nearby affiliated facility",
	)
	///"wrong" = Loosely based accusations that can be easily disproven if people think.
	var/wrong_pick = pick(
		"inadequate support of the local producer",
		"unregulated production of Gauss weaponry aboard this installation",
		"SolFed-backed stationary military formation on the surface of Indecipheres",
		"AUTOMATED REGULATORY VIOLATION DETECTION SYSTEM CRITICAL FAILURE. PLEASE CONTACT AND INFORM THE DISPATCHED AUTHORITIES TO RESOLVE THE ISSUE. \
		ANY POSSIBLE INDENTURE HAS BEEN CLEARED. WE APOLOGIZE FOR THE INCONVENIENCE",
	)
	var/final_result = pick(right_pick, wrong_pick)
	var/built_threat_content = replacetext(threat_content, "%SHIPNAME", ship_name)
	built_threat_content = replacetext(built_threat_content, "%PAYOFF", payoff)
	built_threat_content = replacetext(built_threat_content, "%RESULT", final_result)
	built_threat_content = replacetext(built_threat_content, "%STATION", station_designation)
	return new /datum/comm_message(threat_title, built_threat_content, possible_answers)

/datum/outfit/pirate/nri_officer
	name = "NRI Field Officer"

	head = /obj/item/clothing/head/beret/sec/nri
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild/command
	mask = null
	neck = /obj/item/clothing/neck/security_cape/armplate

	uniform = /obj/item/clothing/under/costume/nri/captain
	suit = null

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/military/nri/captain/pirate_officer
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack/raider = 1, /obj/item/ammo_box/magazine/m9mm_aps = 3, /obj/item/gun/ballistic/automatic/pistol/ladon/nri = 1, /obj/item/crucifix = 1, /obj/item/clothing/mask/gas/hecu2 = 1, /obj/item/modular_computer/pda/security = 1)
	l_pocket = /obj/item/paper/fluff/nri_document
	r_pocket = /obj/item/storage/bag/ammo

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/nri_raider/officer

/datum/outfit/pirate/nri_officer/post_equip(mob/living/carbon/human/equipped)
	. = ..()
	equipped.faction -= "pirate"
	equipped.faction |= "raider"

/datum/id_trim/nri_raider/officer
	assignment = "NRI Field Officer"

/datum/outfit/pirate/nri_marine
	name = "NRI Marine"

	head = null
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild
	mask = null

	uniform = /obj/item/clothing/under/costume/nri
	suit = null

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/military/nri/pirate
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/storage/box/nri_survival_pack/raider = 1, /obj/item/crucifix = 1, /obj/item/ammo_box/magazine/m9mm = 3, /obj/item/clothing/mask/gas/hecu2 = 1, /obj/item/modular_computer/pda/security = 1)
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/storage/bag/ammo

	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/nri_raider

/datum/outfit/pirate/nri_marine/post_equip(mob/living/carbon/human/equipped)
	. = ..()
	equipped.faction -= "pirate"
	equipped.faction |= "raider"

/datum/id_trim/nri_raider
	assignment = "NRI Marine"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_nri"
	department_color = COLOR_RED_LIGHT
	subdepartment_color = COLOR_COMMAND_BLUE
	sechud_icon_state = "hud_nri"
	access = list(ACCESS_SYNDICATE, ACCESS_MAINT_TUNNELS)

/obj/effect/mob_spawn/ghost_role/human/nri_raider
	name = "NRI Raider sleeper"
	desc = "Cozy. You get the feeling you aren't supposed to be here, though..."
	prompt_name = "a NRI Marine"
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	mob_species = /datum/species/human
	faction = list("raider")
	var/rank = "NRI Marine"
	you_are_text = "You are a Novaya Rossiyskaya Imperiya task force."
	flavour_text = "The station has refused to pay the fine for breaking Imperial regulations, you are here to recover the debt. Do so by demanding the funds. Force approach is usually recommended, but isn't the only method."
	important_text = "Allowed races are humans, Akulas, IPCs. Follow your field officer's orders. Important mention - while you are listed as the pirates gamewise, you really aren't lore-and-everything-else-wise. Roleplay accordingly."
	outfit = /datum/outfit/pirate/nri_marine
	spawner_job_path = null
	restricted_species = list(/datum/species/human, /datum/species/akula, /datum/species/synthetic)
	random_appearance = FALSE
	show_flavor = TRUE

/obj/effect/mob_spawn/ghost_role/human/nri_raider/special(mob/living/carbon/human/spawned_human)
	. = ..()
	var/last_name = pick(GLOB.last_names)
	spawned_human.fully_replace_character_name(null, "[rank] [last_name]")
	spawned_human.grant_language(/datum/language/panslavic, TRUE, TRUE, LANGUAGE_MIND)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/datum/job/fugitive_hunter
	title = ROLE_FUGITIVE_HUNTER
	policy_index = ROLE_FUGITIVE_HUNTER

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer
	name = "NRI Officer sleeper"
	mob_name = "Novaya Rossiyskaya Imperiya raiding party's field officer"
	outfit = /datum/outfit/pirate/nri_officer
	rank = "Field Officer"
	important_text = "Allowed races are humans, Akulas, IPCs. Important mention - while you are listed as the pirates gamewise, you really aren't lore-and-everything-else-wise. Roleplay accordingly. There is an important document in your pocket I'd advise you to read and keep safe."

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.grant_language(/datum/language/panslavic, TRUE, TRUE, LANGUAGE_MIND)
	spawned_human.grant_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_MIND)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/marine
	rank = "Marine"

/datum/map_template/shuttle/pirate/nri_raider
	prefix = "_maps/shuttles/skyrat/"
	suffix = "nri_raider"
	name = "pirate ship (NRI Enforcer-Class Starship)"
	port_x_offset = -5
	port_y_offset = 5


/area/shuttle/pirate/nri
	name = "NRI Starship"
	forced_ambience = TRUE
	ambient_buzz = 'modular_skyrat/modules/encounters/sounds/env_ship_idle.ogg'
	ambient_buzz_vol = 15
	ambientsounds = list('modular_skyrat/modules/encounters/sounds/alarm_radio.ogg',
						'modular_skyrat/modules/encounters/sounds/alarm_small_09.ogg',
						'modular_skyrat/modules/encounters/sounds/gear_loop.ogg',
						'modular_skyrat/modules/encounters/sounds/gear_start.ogg',
						'modular_skyrat/modules/encounters/sounds/gear_stop.ogg',
						'modular_skyrat/modules/encounters/sounds/intercom_loop.ogg')

/obj/machinery/computer/shuttle/pirate/nri
	name = "police shuttle console"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/nri
	name = "police shuttle navigation computer"
	desc = "Used to designate a precise transit location for the police shuttle."

/obj/machinery/base_alarm/nri_raider
	alarm_sound_file = 'modular_skyrat/modules/encounters/sounds/env_horn.ogg'
	alarm_cooldown = 32

/obj/machinery/porta_turret/syndicate/nri_raider
	name = "anti-projectile turret"
	desc = "An automatic defense turret designed for point-defense, it's probably not that wise to try approaching it."
	scan_range = 9
	shot_delay = 3
	faction = list("raider")
	icon = 'modular_skyrat/modules/encounters/icons/turrets.dmi'
	icon_state = "gun_turret"
	base_icon_state = "gun_turret"
	max_integrity = 250
	stun_projectile = /obj/projectile/bullet/ciws
	lethal_projectile = /obj/projectile/bullet/ciws
	lethal_projectile_sound = 'modular_skyrat/modules/encounters/sounds/shell_out_tiny.ogg'
	stun_projectile_sound = 'modular_skyrat/modules/encounters/sounds/shell_out_tiny.ogg'

/obj/machinery/porta_turret/syndicate/nri_raider/target(atom/movable/target)
	if(target)
		setDir(get_dir(base, target))//even if you can't shoot, follow the target
		shootAt(target)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), 4)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), 8)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), 12)
		return TRUE

/obj/projectile/bullet/ciws
	name = "anti-projectile salvo"
	icon_state = "guardian"
	damage = 30
	armour_penetration = 10

/obj/docking_port/mobile/pirate/nri_raider
	name = "NRI IAC-PV 'Evangelium'" //Nobody will care about the translation but basically NRI Internal Affairs Collegium-Patrol Vessel
	initial_engine_power = 6
	port_direction = EAST
	preferred_direction = EAST
	callTime = 2 MINUTES
	rechargeTime = 3 MINUTES
	movement_force = list("KNOCKDOWN"=0,"THROW"=0)
	can_move_docking_ports = TRUE
	takeoff_sound = sound('modular_skyrat/modules/encounters/sounds/engine_ignit_int.ogg')
	landing_sound = sound('modular_skyrat/modules/encounters/sounds/env_ship_down.ogg')

/obj/structure/plaque/static_plaque/golden/commission/ks13/nri_raider
	desc = "NRI Terentiev-Yermolayev Orbital Shipworks, Providence High Orbit, Ship OSTs-02\n'Potato Beetle' Class Corvette\nCommissioned 10/11/2562 'Keeping Promises'"

/obj/structure/plaque/static_plaque/golden/commission/ks13/nri_raider/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gps, "NRI Starship")

/obj/machinery/computer/centcom_announcement/nri_raider
	name = "police announcement console"
	desc = "A console used for making priority Internal Affairs Collegium dispatch reports."
	req_access = null
	circuit = null
	command_name = "NRI Enforcer-Class Starship Telegram"
	report_sound = ANNOUNCER_NRI_RAIDERS

/obj/item/gun/ballistic/automatic/pistol/automag
	name = "\improper Automag"
	desc = "A .44 AMP handgun with a sleek metallic finish."
	icon_state = "automag"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/automag.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/automag
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/automag.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'

/obj/item/ammo_box/magazine/automag
	name = "handgun magazine (.44 AMP)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "automag"
	base_icon_state = "automag"
	ammo_type = /obj/item/ammo_casing/c44
	caliber = CALIBER_44
	max_ammo = 7
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/ammo_casing/c44
	name = ".44 AMP bullet casing"
	desc = "A .44 AMP bullet casing."
	caliber = CALIBER_44
	projectile_type = /obj/projectile/bullet/c44

/obj/projectile/bullet/c44
	name = ".44 AMP bullet"
	damage = 40
	wound_bonus = 30

/obj/item/storage/belt/military/nri/captain/pirate_officer/PopulateContents()
	generate_items_inside(list(
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/flashbang = 1,
	),src)

/obj/item/storage/belt/military/nri/pirate/PopulateContents()
	generate_items_inside(list(
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/flashbang = 1,
	),src)

/obj/item/storage/box/nri_survival_pack/raider
	desc = "A box filled with useful emergency items, supplied by the NRI. It feels particularily light."

/obj/item/storage/box/nri_survival_pack/raider/PopulateContents()
	new /obj/item/oxygen_candle(src)
	new /obj/item/tank/internals/emergency_oxygen(src)
	new /obj/item/stack/spacecash/c1000(src)
	new /obj/item/storage/pill_bottle/iron(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/flashlight/flare(src)
	new /obj/item/crowbar/red(src)

/obj/item/paper/fluff/nri_document
	name = "NRI Mission Specifications"
	default_raw_text = {"On behalf of Novaya Rossiyskaya Imperiya Defense and Economical Collegias by the order of the Admiral Voronov Platon Aleksandrovich and the Active Privy Councillor Radich Katarina Dinovich:
	<br> By the Supreme command, a special meeting of representatives from the Imperial Academy of Finances and the Collegias of Foreign and Internal Affairs, Economy, Defense was convened under the chairmanship of Adjutant General Tarkhanov to consider the issue of the incongruity with the Imperial regulations by the Nanotrasen Research Station.
	<br> This meeting, having familiarized itself with all the other possible actions and solutions, came to the conviction that the indenture of fines has casus belli to perform a diplomatic personal meeting.
	<br> The Imperial Regulation has to be enforced in order to minimise any potential threat for the whole Empire, not excluding allied kingdoms, organisations and other partners, and to strengthen our positions in the ongoing Border War.
	<br>
	<br> About such a Supreme Will, reported in the recall of the Councillor of the Defense Collegium, No. 217648, We announce to the military department for immediate actions in appropriate cases.
	<br>
	<br> Signed by We,
	<br> <span style=\"color:black;font-family:'Segoe Script';\"><p><b>Voronov Platon Aleksandrovich and Radich Katarina Dinovich.</b></p></span>"}

/obj/item/paper/fluff/nri_police
	name = "hastily printed note"
	default_raw_text = {"Hey, officer, we couldn't arrange getting you a proper military frigate, -you know, those goddamn bureaucrats with their permission requests and paperwork-, so the police corvette will have to suffice.
	<br> It was not designed for any kind of long-term deployments and anything more aggressive than shooting up a bunch of punks, so expect frequent power outages and a significant lack of raiding machinery.
	<br> We have done some quick modifications to make it more suitable for military use, and smuggled you some defensive and military-grade medical equipment to balance it out. And some SMGs that were so convenient to \"go out of service and get scrapped". It should do the job for now.
	<br> It is worth mentioning that your fourth marine, the maintenance crew man, went on a vacation. Dude's been pretty nervous as of late so it's only fair to let him get some well deserved rest - he has been maintaining this ship the whole time you've been in cryosleep. This should not affect your performance anyways.
	<br> As for the broken Krinkov, there is nothing we can do for now. Will have to use the policemen's, not like you're here to fight the solarians anyways.
	<br> And, please, for the love of God and the Eternal Empress - do not make this mission into a shootout. We can't afford any more casualties in this sector, especially with the most of our military being on the frontline.
	<br>
	<br> Don't screw this up,
	<br> <span style=\"color:black;font-family:'Segoe Script';\"><p><b>Defense Collegia Shipmaster, Akulan Contractor, Shinrun Kantes.</b></p></span>"}

/obj/machinery/suit_storage_unit/nri
	mod_type = /obj/item/mod/control/pre_equipped/frontline/pirate
	storage_type = /obj/item/tank/internals/oxygen/yellow
