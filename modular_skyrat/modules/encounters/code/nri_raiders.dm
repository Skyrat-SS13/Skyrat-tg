/// Possible places/departments to inspect
#define INSPECTION_LIST list( \
	"Cargo", \
	"Command", \
	"Engineering", \
	"Medical", \
	"Science", \
	"Service", \
	"Security", \
)

/// List of possible decorative job titles for additional roleplay potential
#define NRI_JOB_LIST list( \
	"NRI Patrol Officer", \
	"NRI Satellite-Patrol Officer", \
	"NRI Yefreitor-Patrol Officer", \
	"NRI Junior Patrol Officer", \
	"NRI Government Investigator", \
	"NRI Field Inspector", \
	"NRI Counter-Truancy Officer", \
)

/// List of possible decorative leader job titles for additional roleplay potential
#define NRI_LEADER_JOB_LIST list( \
	"NRI Lieutenant Officer", \
	"NRI Sergeant Officer", \
	"NRI Senior Patrol Officer", \
	"NRI Lead Investigator", \
	"NRI Lead Inspector", \
)

/// Amount of items to "confiscate", lower amount
#define CONFISCATE_LOWER 10
/// Amount of items to "confiscate", higher amount
#define CONFISCATE_HIGHER 25

/// To know whether or not we have an officer already
GLOBAL_VAR(first_officer)

///NRI police patrol with a mission to find out if the fine reason is legitimate and then act from there.
/datum/pirate_gang/nri_raiders
	name = "NRI IAC Police Patrol"

	ship_template_id = "nri_raider"
	ship_name_pool = "imperial_names"

	threat_title = "NRI Audit"
	threat_content = "Greetings %STATION, this is the %SHIPNAME dispatch outpost. \
	Due to recent Imperial regulatory violations, such as %RESULT and many other smaller issues, your station has been fined %PAYOFF credits. \
	Inadequate imperial police activity is currently present in your sector, thus the failure to comply might instead result in a police patrol dispatch \
	for second attempt negotiations, sector police presence reinforcement and close-up inspections. Novaya Rossiyskaya Imperiya collegial secretary out."
	arrival_announcement = "Regulation-identified vessel approaching. Vessel ID tag is %NUMBER1-%NUMBER2-%NUMBER3. \
	Vessel Model: Potato Beetle, Flight ETA: three minutes minimal. Vessel is authorised by the international regulations to perform its duties. \
	We're clear for close orbit. Friendly reminder not to measure the distance between the vessel and the destination location, nor install any tracking devices anywhere on board of the vessel or in its close vicinity, \
	unless given permission to; not to approach it, unless given permission to; not to perform any aggressive actions, nor any preparations to do so, to the vessel or the commissioned crew, \
	as all of this is grounds for preemptive self-defense procedures initiation, and might result in moral or structural damage, arrests, injury or possibly death. In case of any complaints, they are to be sent directly to your employers."
	possible_answers = list("Submit to audit and pay the fine.", "Override the response system for an immediate police dispatch.")

	response_received = "Should be it, thank you for cooperation. Novaya Rossiyskaya Imperiya collegial secretary out."
	response_too_late = "Your response was very delayed. We have been instructed to send in the patrol ship for second attempt negotiations, stand by."
	response_not_enough = "Your bank balance does not hold enough money at the moment or the system has been overriden. We are sending a patrol ship for second attempt negotiations, stand by."
	announcement_color = "purple"

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
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER1", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER2", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER3", pick(GLOB.phonetic_alphabet))
	return new /datum/comm_message(threat_title, built_threat_content, possible_answers)

/datum/outfit/pirate/nri/post_equip(mob/living/carbon/human/equipped)
	. = ..()
	equipped.faction -= "pirate"
	equipped.faction |= "raider"

	// make sure we update the ID's name too
	var/obj/item/card/id/id_card = equipped.wear_id
	if(istype(id_card))
		id_card.registered_name = equipped.real_name
		id_card.update_icon()
		id_card.update_label()

	handlebank(equipped)

/datum/outfit/pirate/nri/officer
	name = "NRI Field Officer"

	head = /obj/item/clothing/head/hats/colonial/nri_police
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/guild/command
	mask = null
	neck = /obj/item/clothing/neck/cloak/colonial/nri_police

	uniform = /obj/item/clothing/under/colonial/nri_police
	suit = null

	gloves = /obj/item/clothing/gloves/combat

	shoes = /obj/item/clothing/shoes/combat

	belt = /obj/item/storage/belt/security/nri
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(
		/obj/item/storage/box/nri_survival_pack/raider = 1,
		/obj/item/ammo_box/magazine/recharge/plasma_battery = 3,
		/obj/item/gun/ballistic/automatic/pistol/plasma_marksman = 1,
		/obj/item/crucifix = 1,
		/obj/item/clothing/mask/gas/nri_police = 1,
		/obj/item/modular_computer/pda/nri_police = 1,
	)
	l_pocket = /obj/item/folder/blue/nri_cop
	r_pocket = /obj/item/storage/pouch/ammo

	id = /obj/item/card/id/advanced/nri_police
	id_trim = /datum/id_trim/nri_police

/obj/item/modular_computer/pda/nri_police
	name = "\improper NRI police PDA"
	device_theme = PDA_THEME_TERMINAL
	greyscale_colors = "#363655#7878f7"
	comp_light_luminosity = 6.3 //Matching a flashlight
	comp_light_color = "#5c20aa" //Simulated ultraviolet light for finding blood and :flushed:
	starting_programs = list(
		/datum/computer_file/program/records/security,
		/datum/computer_file/program/crew_manifest,
		/datum/computer_file/program/robocontrol,
	)
	inserted_item = /obj/item/pen/fourcolor

/obj/item/card/id/advanced/nri_police
	name = "\improper NRI police identification card"
	desc = "A retro-looking card model modified to work with the modern identification systems."
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "card_nri_police"
	assigned_icon_state = "assigned_nri_police"

/datum/id_trim/nri_police
	assignment = "NRI Field Officer"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_nri_police"
	department_color = COLOR_NRI_POLICE_BLUE
	subdepartment_color = COLOR_NRI_POLICE_SILVER
	sechud_icon_state = "hud_nri_police"
	access = list(ACCESS_SYNDICATE, ACCESS_MAINT_TUNNELS)
	threat_modifier = 2 // Not as treatening as syndicate, but still potentially harmful to the station

/obj/item/gun/energy/e_gun/advtaser/normal
	w_class = WEIGHT_CLASS_NORMAL

/obj/effect/mob_spawn/ghost_role/human/nri_raider
	name = "NRI Raider sleeper"
	desc = "Cozy. You get the feeling you aren't supposed to be here, though..."
	prompt_name = "a NRI Marine"
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod"
	mob_species = /datum/species/human
	faction = list(FACTION_RAIDER)
	you_are_text = "You are a Novaya Rossiyskaya Imperiya task force."
	flavour_text = "The station has refused to pay the fine for breaking Imperial regulations, you are here to recover the debt. Do so by demanding the funds. Force approach is usually recommended, but isn't the only method."
	important_text = "Allowed races are humans, Akulas, IPCs. Follow your field officer's orders. Important mention - while you are listed as the pirates gamewise, you really aren't lore-and-everything-else-wise. Roleplay accordingly."
	outfit = /datum/outfit/pirate/nri
	restricted_species = list(/datum/species/human, /datum/species/akula, /datum/species/synthetic)
	random_appearance = FALSE
	show_flavor = TRUE

/obj/effect/mob_spawn/ghost_role/human/nri_raider/proc/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	spawned_human.fully_replace_character_name(null, "[callsign] [number]")

/obj/effect/mob_spawn/ghost_role/human/nri_raider/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.grant_language(/datum/language/panslavic, source = LANGUAGE_SPAWNER)
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/datum/job/fugitive_hunter
	title = ROLE_FUGITIVE_HUNTER
	policy_index = ROLE_FUGITIVE_HUNTER

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer
	name = "NRI Officer sleeper"
	prompt_name = "a NRI Field Officer"
	mob_name = "Novaya Rossiyskaya Imperiya police patrol's field officer"
	outfit = /datum/outfit/pirate/nri/officer
	flavour_text = "The station has refused to pay the fine for breaking Imperial regulations, as a consequence you are here to perform a prolonged inspection."
	important_text = "Allowed races are humans, Akulas, IPCs. Roleplay accordingly. There is an important document in your pocket I'd advise you to read and keep safe."

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/apply_codename(mob/living/carbon/human/spawned_human)
	var/callsign = pick(GLOB.callsigns_nri)
	var/number = pick(GLOB.phonetic_alphabet_numbers)
	spawned_human.fully_replace_character_name(null, "[callsign] [number][GLOB.first_officer == spawned_human ? " Actual" : ""]")

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.mind.add_antag_datum(/datum/antagonist/cop)
	spawned_human.grant_language(/datum/language/uncommon, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/yangyu, source = LANGUAGE_SPAWNER)
	spawned_human.grant_language(/datum/language/panslavic, source = LANGUAGE_SPAWNER)

	// if this is the first officer, keep a reference to them
	if(!GLOB.first_officer)
		GLOB.first_officer = spawned_human
		to_chat(spawned_human, span_bold("With you being the leader of the group and having a special designation, 'Actual', it's your duty to make sure this entire operation \
			goes smoothly. As in, doesn't result in an intergalactic political scandal, or an unneecessary shooting. It's also very likely expected for you to be performing \
			all the necessary negotiations, so do prepare yourself for that."))

	to_chat(spawned_human, "[span_bold("The station has overriden the response system for the reasons unknown, keep the ship intact, communicate with the station, \
		perform an inspection to determine the legitimacy of the fine, and try to get the funds yourself, if it's legitimate. \
		In any case, perform your predefined duties and uphold some semblance of intergalactic law and professionalism, even if just for show.")] <br><br>\
		[span_small("Also, a small OOC clarification: none of your objectives are meant to be completable mechanically, so don't stress yourself over not greentexting or anything; \
		If you have a better plan than 'completing' them, like an idea for a gimmick, it's better to communicate with the admins and your colleagues to possibly allow you to \
		do something custom.")]")
	apply_codename(spawned_human)


/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/post_transfer_prefs(mob/living/carbon/human/spawned_human)
	. = ..()
	apply_codename(spawned_human)

/obj/effect/mob_spawn/ghost_role/human/nri_raider/officer/equip(mob/living/carbon/human/spawned_human)
	. = ..()
	var/obj/item/card/id/advanced/card = spawned_human.get_idcard()
	if(GLOB.first_officer == spawned_human)
		card.assignment = pick(NRI_LEADER_JOB_LIST)
		card.trim.sechud_icon_state = "hud_nri_police_lead"
	else
		card.assignment = pick(NRI_JOB_LIST)
		card.trim.sechud_icon_state = "hud_nri_police"

	card.update_label()

/datum/map_template/shuttle/pirate/nri_raider
	prefix = "_maps/shuttles/skyrat/"
	suffix = "nri_raider"
	name = "pirate ship (NRI Enforcer-Class Starship)"
	port_x_offset = -5
	port_y_offset = 5


/area/shuttle/pirate/nri
	name = "NRI Starship"
	forced_ambience = TRUE
	ambient_buzz = 'modular_skyrat/modules/encounters/sounds/amb_ship_01.ogg'
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
	shot_delay = 15
	faction = list(FACTION_RAIDER)
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
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay * 2)
		addtimer(CALLBACK(src, PROC_REF(shootAt), target), shot_delay * 3)
		return TRUE

/obj/projectile/bullet/ciws
	name = "anti-projectile salvo"
	icon_state = "guardian"
	damage = 15
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

/obj/machinery/computer/centcom_announcement/nri_raider
	name = "police announcement console"
	desc = "A console used for making priority Internal Affairs Collegium dispatch reports."
	req_access = null
	circuit = null
	command_name = "NRI Enforcer-Class Starship Telegram"
	report_sound = ANNOUNCER_NRI_RAIDERS

/obj/item/storage/belt/security/nri/PopulateContents()
	generate_items_inside(list(
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/flashbang = 1,
	),src)

/obj/item/storage/box/nri_survival_pack/raider
	w_class = WEIGHT_CLASS_SMALL
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
	name = "NRI Police SOPs"
	default_raw_text = {"<h1>Novaya Rossiyskaya Imperiya Internal Affairs Collegium Rim-World Patrol Standard Operation Procedures, Part One: Procedures</h1><br>
	<br><br><small>Annotation. The guide is devoted to the consideration of the legal foundations of the expeditionary patrol police of the Novaya Rossiyskaya Imperiya. The scientific analysis of the normative legal acts regulating the activities of the expeditionary patrol police allows us to establish its tasks and functions, as well as the main areas of activity. The system and methods of applying proactive self-defense in the activities of the expeditionary patrol police of the Novaya Rossiyskaya Imperiya are considered. The issues of its differences with the central and political police are touched upon. Attention is paid to the socio-practical significance of issues related to ensuring external security in the Novaya Rossiyskaya Imperiya in the fight against ordinary crime.</small>
	<br><br>One of the main functions of any sovereign State is to ensure national security, that is, to take measures to protect individuals, society and the state from internal and external threats. Through the implementation of this function, the territorial integrity and sustainable development of the state is ensured, its defense and security are strengthened, rights, freedoms, and a decent standard of living of the population are ensured.
	<br>The expeditionary police plays an important role in the protective function of the Novaya Rossiyskaya Imperiya in the second half of the XXVI century. It was it who, in addition to the protective functions, was entrusted with difficult tasks of general management. The main task of the expeditionary police was to ensure and protect the interests of the imperial government at the facilities defined by agreements on interaction and cooperation. At the same time, it was the expeditionary police that was obliged to assist the political police in ensuring the internal security of the Empire.
	<br>In order to effectively carry out the activities of the expeditionary police, an Instruction was adopted to the ranks of independently functioning departments, which consolidated the organizational structure, rights and duties of the ranks of the latter. In particular, the Instruction determined that the branches have the purpose of their activities to secretly investigate and conduct inquiries in the form of preventing, eliminating, exposing and prosecuting criminal acts of an ordinary nature; expanding, consolidating and promoting the influence of the state in the sector. The Instructions drew attention to the area of activity of a chosen dispatch, as well as to the fact that all information on cases of a political nature, the heads of dispatches are required to document those immediately. Of interest is also a note in the Instructions, according to which the chiefs of the expeditionary police were minimally subordinate to the supreme headquarters, and were on self-government.
	<br>The instruction defined the boundaries of self-defense of independent branches. In particular, clear factors were determined, consisting of obvious aggression or preparation for illegal actions on the part of the cooperating stations and the preparations necessary for their action were made. Everything, however, lies entirely on the highest rank designated by the patrol. In addition, the principles of signaling aggression were also defined. Signaling methods, code terminology, and so on will be discussed in the next part of the document set.
	<br><br>Per current NRI External Relationships, as well as NRI Internal Affairs Collegium regulations, the following procedure must be performed, to minimse the risk of first response patrol casualties, as well as better station-to-patrol communication chances:
	<br>1. Ensure that the station's bodyguarding dispatch is limited to one person per two heads only; with a maximum of three present if all heads are invited. This list includes Personal Protection Specialists, i.e. Blueshields, Redshields; security personnel; hired off-station mercenaries; weaponised crewmembers or other militia; weaponised animals, and so on;
	<br>2. Ensure that the station's bodyguarding dispatch is positioned right in front of you; with a clear escape route present to you and your colleagues. It is permitted to install additional reinforcements or barricades in order to increase your chances of survival against untrustworthy elements, if deemed necessary by your commanding officer;
	<br>3. Ensure that the station's command and security/military/defense force is not inspecting your ship, nor close approaching it, without your commanding officer's permission. It is recommended to leave a single officer as a ship's overseer, in order to minimise government property damage, as well as ensure maximum patrol efficiency in the field;
	<br>4. Ensure that the station's security/military/defense force is not preparing for a raid, using your shipped <small>(assembly required)</small> camera console. If needed, call them out on your ship's preinstalled station announcements system and remind them of invested funds, or the station's connections with the government, or so on;
	<br>5. Ensure that the ship, or any of the officers hasn't received any parcels, envelopes, letters or other packages, without its contents being stated by a third party and re-reviewed by any of the officers afterwards, to minimise chances of a bombing, teleportation, or any other terroristic act. If any of the above mentioned objects are to be received without the following procedured being initiated, it is required to dispose of the following objects immediately and report to the commanding officer.
	<br><br>From the recent observations, while not being defined pre-revision in the following list, and officialy not being disclosed by the Nanotrasen Corporation, you might become a victim to their recent invention: a high-precision high-velocity particle accelerator, the Bluespace Artillerty Cannon. This weaponry is frequency-locked on certain global positioning systems, which are according to state regulations are built into the ship's hull. Said weaponry is excellent at disposing of small fighters to patrol corvettes, and damaging attack frigates; capable of splitting your standard issue corvette in half. And thus, to minimise your casualties and to ensure your safety, this guide provides you with a necessary information on how to circumvent said weaponry.
	<br>In order to perform a dodging maneuver, you have to:
	<br>1. For the ship, lock onto the stable position in space, using your navigations console;
	<br>2. The moment Bluespace Artillery Cannon starts charging up, boot up the ship's thrusters;
	<br>3. And as such, dodge the Artillery shot. Its design is position-locked and is only good against stationary, or especially slow targets, thus, allowing you to move away from the target position.
	<br><b>In the case of a confirmed Bluespace Artillery fire on your position, any other unauthorised Bluespace Artillery fire during your presence on station, threats to use the Bluespace Artillery against the dispatch, or sector-wide Bluespace Artillery fire announcement, it is required to dispose of it, as it's a direct notification of aggression towards the dispatch and the foreign nation.</b>
	<br><br>Bluespace Artilleries are a fragile pieces of machinery, so a directed explosion over any of its main battery's parts will disable it for good. For that, you'll require a single standard-issue block of C4 composite explosive, as well as precise follow of this instructions:
	<br>In order to destroy a BSA cannon, you have to:
	<br>1. Approach the main battery, usually looking and designed like the huge artillery emplacement;
	<br>2. Set a C4 plastic explosive charge on it, preferably with a signaller attached for maximum efficiency, or an otherwise short explosion timer;
	<br>3. Depart the explosion radius and the artillery cannon itself, causing additional destruction and damage to other pieces of the artillery in the process. It is advised to do so, as that'll delay any possible attempts at rebuilding the artillery piece.
	<br><b>Afterwards, if any of the following procedures are to be enacted, the station is to be considered a hostile ground; and you are fully permitted to perform the preemptive self-defense procedures afterwards, without the commanding officer's approval.</b>
	<br><br>If any of the following conditions are not met, or in the case of a Bluespace Artillery fire, you're authorised to request the preemptive self-defense procedures initiation from your commanding officer; which, in turn, allows you to disable and arrest the station's security forces, using any of the equipment available to you, or otherwise acquired.
	<br><small>Thus, the creation of independent branches in the Empire led to the fact that these units directed the activities of the entire police to combat ordinary crimes. Prior to their formation, the task of combating corporal crime was the direct responsibility of the ranks of the local planetary patrols and, in special cases, the Planetary Guard. The ranks of independent departments were given equal rights in the investigation of criminal offenses with the ranks of the planetary police, since they acted on the basis of the same adopted normative legal acts. The provisions of the law created in accordance with the recent Instruction were more specifically defined: the goals, tasks of independent departments, their internal structure, the procedure for conducting operational investigative actions. At the same time, it, in general, has not changed the principle of organizational structure of patrols and therefore they, nevertheless, in part, remain limited in their activities within the territory under their jurisdiction. In this regard, they cannot carry out operational search activities outside the stations to which they were assigned.</small>
	<br> <span style=\"color:black;font-family:'Segoe Script';\"><p><b>Printed by: Novaya Rossiyskaya Imperiya Internal Affairs Collegium, for educational and referential purposes only.</b></p></span>"}

/obj/item/paper/fluff/nri_document_two
	name = "NRI Police Codespeak"
	default_raw_text = {"<h1>Novaya Rossiyskaya Imperiya Internal Affairs Collegium Rim-World Patrol Standard Operation Procedures, Part Two: Cyphering and Codewords</h1><br>
	<br><br><small>Annotation. The guide is devoted to the consideration of the communicative foundations of the expeditionary patrol police of the Novaya Rossiyskaya Imperiya. The scientific analysis of the old time police patrol codespeak allows us to reenact their level of efficiency, as well as grants us the possibility to minimise possible information leaks to the civilian population and the possible suspects.</small>
	<br>To better encode signal words and minimize information leaks, an independent detachment of each sector will receive a list of certain signal words and other terminology, which will be provided in the following list. Before each departure, it is recommended to proofread them in order to consolidate the material; and during operations, it is recommended to use them instead of the usual jargon. The list is provided below:
	<br>In order to effectively carry out the activities of the expeditionary police, an Instruction was adopted to the ranks of independently functioning departments, which consolidated the organizational structure, rights and duties of the ranks of the latter. In particular, the Instruction determined that the branches have the purpose of their activities to secretly investigate and conduct inquiries in the form of preventing, eliminating, exposing and prosecuting criminal acts of an ordinary nature; expanding, consolidating and promoting the influence of the state in the sector. The Instructions drew attention to the area of activity of a chosen dispatch, as well as to the fact that all information on cases of a political nature, the heads of dispatches are required to document those immediately. Of interest is also a note in the Instructions, according to which the chiefs of the expeditionary police were minimally subordinate to the supreme headquarters, and were on self-government.
	<br><small>10-0 = Use caution;
	<br>10-1 = Out of service to treat damage;
	<br>10-1s = Out of service to eat;
	<br>10-1r = Out of service to rest;
	<br>10-2 = You are being received clearly;
	<br>10-4 = Understood;
	<br>10-8 = In service;
	<br>10-9 = Stand down or stand-by;
	<br>10-14 = Convoy detail, or request to keep moving;
	<br>10-15 = Prisoner in custody;
	<br>10-20 = Location;
	<br>10-25 = Report in person;
	<br>10-29 = Does conform to rules or regulations;
	<br>10-30 = Does not conform to rules or regulations;
	<br>10-65 = Need assistance;
	<br>10-90 = Animal - sighted;
	<br>10-91 = Alien - sighted;
	<br>10-92 = Humanoid - sighted;
	<br>10-93 = Xenomorph - sighted;
	<br>10-94 = Unknown lifeform - sighted;
	<br>10-90 to 10-94, with a "d" modifier (i.e. 10-90d) = Lifeform - dead;
	<br>10-90 to 10-94, with a "w" modifier (i.e. 10-92w) = Lifeform - wounded;
	<br>10-90 to 10-94, with a "r" modifier (i.e. 10-93r) = Lifeform - resisting;
	<br>10-97 = Arrived at scene;
	<br>10-99 = Last remaining officer;
	<br>10-103 = Disturbance;
	<br>10-107 = Suspicious person;
	<br>10-108 = Officer down;
	<br>10-40 = Reinforcements;
	<br>10-41 = Evacuation;
	<br>10-42 = Medical;
	<br>10-43 = Damage Control;
	<br>10-99 = Officer needs help immediately;
	<br>12-40 = Officer requests Shoot-On-Sight order.</small>
	<br><small>Thus, the creation of independent branches in the Empire led to the fact that these units directed the activities of the entire police to combat ordinary crimes. Prior to their formation, the task of combating corporal crime was the direct responsibility of the ranks of the local planetary patrols and, in special cases, the Planetary Guard. The ranks of independent departments were given equal rights in the investigation of criminal offenses with the ranks of the planetary police, since they acted on the basis of the same adopted normative legal acts. The provisions of the law created in accordance with the recent Instruction were more specifically defined: the goals, tasks of independent departments, their internal structure, the procedure for conducting operational investigative actions. At the same time, it, in general, has not changed the principle of organizational structure of patrols and therefore they, nevertheless, in part, remain limited in their activities within the territory under their jurisdiction. In this regard, they cannot carry out operational search activities outside the stations to which they were assigned.</small>
	<br> <span style=\"color:black;font-family:'Segoe Script';\"><p><b>Printed by: Novaya Rossiyskaya Imperiya Internal Affairs Collegium, for educational and referential purposes only.</b></p></span>"}

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

/obj/item/folder/blue/nri_cop
	name = "NRI police SOPs"

/obj/item/folder/blue/nri_cop/Initialize(mapload)
	. = ..()
	new /obj/item/paper/fluff/nri_document(src)
	new /obj/item/paper/fluff/nri_document_two(src)
	update_appearance()

/obj/machinery/suit_storage_unit/nri
	mod_type = /obj/item/mod/control/pre_equipped/policing
	storage_type = /obj/item/tank/internals/oxygen/yellow

/obj/machinery/shuttle_scrambler/nri
	name = "system crasher"
	desc = "This heap of machinery locks down supply lines to a halt. Can be turned off, but does not siphon any money. Do that yourself, lazyass."
	siphon_per_tick = 0

/obj/machinery/shuttle_scrambler/nri/toggle_on(mob/user)
	SSshuttle.registerTradeBlockade(src)
	AddComponent(/datum/component/gps, "NRI Starship")
	active = TRUE
	to_chat(user,span_notice("You toggle [src] [active ? "on":"off"]."))
	to_chat(user,span_warning("The scrambling signal can be now tracked by GPS."))
	START_PROCESSING(SSobj,src)

/obj/machinery/shuttle_scrambler/nri/process()
	if(active)
		if(is_station_level(z))
			var/datum/bank_account/D = SSeconomy.get_dep_account(ACCOUNT_CAR)
			if(D)
				var/siphoned = min(D.account_balance,siphon_per_tick)
				D.adjust_money(-siphoned)
				credits_stored += siphoned
		else
			return
	else
		STOP_PROCESSING(SSobj,src)

/obj/machinery/shuttle_scrambler/nri/interact(mob/user)
	if(active)
		var/deactivation_response = tgui_alert(user,"Turn the crasher off?", "Crasher", list("Yes", "Cancel"))
		if(deactivation_response != "Yes")
			return
		if(!active|| !user.can_perform_action(src))
			return
		toggle_off(user)
		update_appearance()
		send_notification()
		to_chat(user,span_notice("You toggle [src] [active ? "on":"off"]."))
		return
	var/scramble_response = tgui_alert(user, "Turning the crasher on might alienate the population and will make the shuttle trackable by GPS. Are you sure you want to do it?", "Crasher", list("Yes", "Cancel"))
	if(scramble_response != "Yes")
		return
	if(active || !user.can_perform_action(src))
		return
	toggle_on(user)
	update_appearance()
	send_notification()
	to_chat(user,span_notice("You toggle [src] [active ? "on":"off"]."))
	return


/obj/machinery/shuttle_scrambler/nri/send_notification()
	if(active)
		priority_announce("We're intercepting all of the current and future supply deliveries until you're more cooperative with the dispatch. So, please do be.","NRI IAC HQ",ANNOUNCER_NRI_RAIDERS,"Priority", color_override = "purple")
	else
		priority_announce("We've received a signal to stop the blockade; you're once again free to do whatever you were doing before.","NRI IAC HQ",ANNOUNCER_NRI_RAIDERS,"Priority", color_override = "purple")

/datum/antagonist/cop
	name = "\improper NRI Police Officer"
	//Even if their goal's almost a complete antithesis to what pirates normally do, their spawn is, well, done via pirate code.
	job_rank = ROLE_SPACE_PIRATE
	roundend_category = "nri cops"
	antagpanel_category = "NRI Police"
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	suicide_cry = "God, save the Empress!!"
	///Team datum for admin tracking
	var/datum/team/cop/crew

/datum/antagonist/cop/greet()
	. = ..()
	owner.announce_objectives()

/datum/antagonist/cop/get_team()
	return crew

/datum/antagonist/cop/create_team(datum/team/cop/new_team)
	if(!new_team)
		for(var/datum/antagonist/cop/cop in GLOB.antagonists)
			if(!cop.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [cop]")
				continue

			if(cop.crew)
				crew = cop.crew
				return

		// No existing team was found, time to create one.
		crew = new /datum/team/cop
		crew.forge_objectives()
		return

	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization: [new_team.type].")

	crew = new_team

/datum/antagonist/cop/on_gain()
	if(crew)
		objectives |= crew.objectives

	return ..()

/datum/antagonist/cop/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/owner_mob = mob_override || owner.current
	var/datum/language_holder/holder = owner_mob.get_language_holder()
	holder.grant_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_PIRATE)
	holder.grant_language(/datum/language/panslavic, TRUE, TRUE, LANGUAGE_PIRATE)
	holder.grant_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_PIRATE)

/datum/antagonist/cop/remove_innate_effects(mob/living/mob_override)
	var/mob/living/owner_mob = mob_override || owner.current
	owner_mob.remove_language(/datum/language/uncommon, TRUE, TRUE, LANGUAGE_PIRATE)
	owner_mob.remove_language(/datum/language/panslavic, TRUE, TRUE, LANGUAGE_PIRATE)
	owner_mob.remove_language(/datum/language/yangyu, TRUE, TRUE, LANGUAGE_PIRATE)
	return ..()

/datum/team/cop
	name = "\improper NRI police patrol"

/datum/team/cop/proc/forge_objectives()
	add_objective(new /datum/objective/policing)
	add_objective(new /datum/objective/inspect_area)
	add_objective(new /datum/objective/survey)
	add_objective(new /datum/objective/steal_n_of_type/contraband)
	add_objective(new /datum/objective/dock)
	add_objective(new /datum/objective/survive)

	for(var/datum/mind/member_mind in members)
		var/datum/antagonist/cop/cop = member_mind.has_antag_datum(/datum/antagonist/cop)

		if(!cop)
			continue

		cop.objectives |= objectives

/datum/objective/policing
	name = "policing"
	explanation_text = "Contact the station to perform an inspection. Delegate responsibilities among the ship's crew. Minimise civilian casualties."
	martyr_compatible = TRUE

/datum/objective/inspect_area
	name = "inspect area"
	explanation_text = "Inspect certain department and make sure it's up to our specifications. Special scrutiny and pickyness is advised."
	///Area picked for an entirely roleplay objective.
	var/inspection_area
	martyr_compatible = TRUE

/datum/objective/inspect_area/New(text)
	. = ..()
	inspection_area = pick(INSPECTION_LIST)

/datum/objective/inspect_area/update_explanation_text()
	..()
	if(inspection_area)
		explanation_text = "Inspect [inspection_area] department and make sure it's up to our specifications. Special scrutiny and pickyness is advised."
	else
		explanation_text = "Perform a general station inspection and make sure it's up to any loose specifications you can think of."

/datum/objective/survey
	name = "survey"
	martyr_compatible = TRUE
	admin_grantable = TRUE
	///Area picked for an entirely roleplay objective.
	var/survey_area

/datum/objective/survey/New(text)
	. = ..()
	survey_area = pick(INSPECTION_LIST)

/datum/objective/survey/update_explanation_text()
	..()
	if(survey_area)
		explanation_text = "Execute continuous crime prevention and citizen surveying procedures over [survey_area] department. Prevent crime in a given department and perform a public survey to collect people's opinions on various matters."
	else
		explanation_text = "Execute continuous crime prevention and citizen surveying procedures around the station. Prevent crime around the area and perform a public survey to collect people's opinions on various matters."

/datum/objective/steal_n_of_type/contraband
	name = "confiscate contraband"
	explanation_text = "Confiscate at least cool number pieces of contraband. Drugs, illicit weaponry, armor or equipment of any sort."

/datum/objective/steal_n_of_type/contraband/New()
	. = ..()
	amount = rand(CONFISCATE_LOWER, CONFISCATE_HIGHER)
	explanation_text = "Confiscate at least [amount] pieces of contraband. Drugs, illicit weaponry, armor or equipment of any sort."
	update_explanation_text()
	return

/datum/objective/steal_n_of_type/contraband/check_completion()
	return completed //I am letting them roleplay this out, just like the other objectives.

/datum/objective/dock
	name = "dock"
	explanation_text = "Dock to, or generally attempt to stay in the same sector the station is; to extend your on-site presence."
	martyr_compatible = TRUE

/datum/objective/dock/New()
	. = ..()
	explanation_text = "Dock to, or generally attempt to stay in the same sector the [station_name()] is; to extend your on-site presence."
	update_explanation_text()
	return


#undef INSPECTION_LIST
#undef NRI_JOB_LIST
#undef NRI_LEADER_JOB_LIST
#undef CONFISCATE_LOWER
#undef CONFISCATE_HIGHER
