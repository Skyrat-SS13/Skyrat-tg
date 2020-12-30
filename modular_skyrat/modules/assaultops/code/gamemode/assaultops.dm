GLOBAL_LIST_EMPTY(assaultops_targets)

/datum/game_mode/assaultops
	name = "assault operatives"
	config_tag = "assaultops"
	report_type = "assaultops"
	false_report_weight = 10
	required_players = 30 // 30 players - 3 players to be the nuke ops = 27 players remaining
	required_enemies = 2
	recommended_enemies = 7
	antag_flag = ROLE_ASSAULTOPS
	enemy_minimum_age = 14

	announce_span = "danger"
	announce_text = "Syndicate forces are approaching the station in an attempt to occupy it!\n\
	<span class='danger'>Operatives</span>: Capture all of your assigned targets and transport them to the holding facility!\n\
	<span class='notice'>Crew</span>: Defend the station and capture the operatives, we need them for information!"

	var/const/agents_possible = 10 //If we ever need more syndicate agents.
	var/operatives_left = 1
	var/list/pre_operatives = list()

	var/datum/team/assaultops/assault_team

	var/operative_antag_datum_type = /datum/antagonist/assaultops
	var/leader_antag_datum_type = /datum/antagonist/assaultops/leader

/datum/game_mode/assaultops/pre_setup()
	var/n_agents = min(round(num_players() / 10), antag_candidates.len, agents_possible)
	if(n_agents >= required_enemies)
		for(var/i = 0, i < n_agents, ++i)
			var/datum/mind/new_op = pick_n_take(antag_candidates)
			pre_operatives += new_op
			new_op.assigned_role = "Assault Operative"
			new_op.special_role = "Assault Operative"
			log_game("[key_name(new_op)] has been selected as an Assault operative")
		return TRUE
	else
		setup_error = "Not enough assault op candidates"
		return FALSE
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

/datum/game_mode/assaultops/post_setup()
	//Assign leader
	var/datum/mind/leader_mind = pre_operatives[1]
	var/datum/antagonist/assaultops/L = leader_mind.add_antag_datum(leader_antag_datum_type)
	assault_team = L.assault_team
	//Assign the remaining operatives
	for(var/i = 2 to pre_operatives.len)
		var/datum/mind/assault_mind = pre_operatives[i]
		assault_mind.add_antag_datum(operative_antag_datum_type)
	//Assign the targets
	for(var/i in GLOB.player_list)
		if(check_assaultops_target(i))
			GLOB.assaultops_targets.Add(i)
	return ..()

/proc/check_assaultops_target(mob/user)
	if(!isliving(user))
		return FALSE
	var/datum/mind/owner = user.mind
	if(owner.assigned_role == "Captain" || owner.assigned_role == "Head of Personnel" || owner.assigned_role == "Quartermaster" || owner.assigned_role == "Head of Security" || owner.assigned_role == "Chief Engineer" || owner.assigned_role == "Research Director" || owner.assigned_role == "Blueshield" || owner.assigned_role == "Security Officer" || owner.assigned_role == "Warden" || owner.assigned_role == "Detective")
		return TRUE
	return FALSE

/datum/game_mode/assaultops/set_round_result()
	..()
	var/result = assault_team.get_result()
	switch(result)
		if(ASSAULT_RESULT_STALEMATE)
			SSticker.mode_result = "stalemate - mission failure - crew and operatives dead"
			SSticker.news_report = ASSAULTOPS_STALEMATE
		if(ASSAULT_RESULT_ASSAULT_FLAWLESS_WIN)
			SSticker.mode_result = "flawless operatives win - all crew captured"
			SSticker.news_report = ASSAULTOPS_ASSAULT_WIN
		if(ASSAULT_RESULT_ASSAULT_MAJOR_WIN)
			SSticker.mode_result = "major operatives win - all crew captured - some operatives dead"
			SSticker.news_report = ASSAULTOPS_ASSAULT_WIN
		if(ASSAULT_RESULT_ASSAULT_WIN)
			SSticker.mode_result = "operatives win - some crew captured"
			SSticker.news_report = ASSAULTOPS_ASSAULT_WIN
		if(ASSAULT_RESULT_CREW_FLAWLESS_WIN)
			SSticker.mode_result = "flawless crew win - all operatives captured"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		if(ASSAULT_RESULT_CREW_MAJOR_WIN)
			SSticker.mode_result = "major crew win - all operatives captured - but some crew dead"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		if(ASSAULT_RESULT_CREW_WIN)
			SSticker.mode_result = "crew win - some operatives captured"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		if(ASSAULT_RESULT_CREW_LOSS)
			SSticker.mode_result = "crew loss - all operatives dead"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		if(ASSAULT_RESULT_ASSAULT_LOSS)
			SSticker.mode_result = "operatives loss - all crew dead"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		else
			SSticker.mode_result = "halfwin - interrupted"
			SSticker.news_report = OPERATIVE_SKIRMISH

/datum/game_mode/assaultops/generate_report()
	return "Several Nanotransen-affiliated stations in your sector are currently beseiged by the Gorlex Marauders, and current trends suggests your station is next in line.\
           They are heavily armed and dangerous, and we recommend you fortify any defensible positions immediately. They may attempt to communicate or negotiate. Stall for as long as possible. \
            Our ERT force is stretched thin in this sector, so there are no guarantee of reinforcements. As a result, the crew is permitted to aid security as a militia under the directive of the captain . Do not give up control of the station, unless you are unable to resist effectively any further. \
            In which case, surrender to keep costs to a minimal. We will come back eventually to retake the station."

/datum/game_mode/assaultops/check_finished(force_ending)
	if(!SSticker.setup_done || !gamemode_ready)
		return FALSE
	if(replacementmode && round_converted == 2)
		return replacementmode.check_finished()
	if(SSshuttle.emergency && (SSshuttle.emergency.mode == SHUTTLE_ENDGAME))
		return TRUE
	if(station_was_nuked)
		return TRUE
	var/list/continuous = CONFIG_GET(keyed_list/continuous)
	var/list/midround_antag = CONFIG_GET(keyed_list/midround_antag)
	if(!round_converted && (!continuous[config_tag] || (continuous[config_tag] && midround_antag[config_tag]))) //Non-continuous or continous with replacement antags
		if(!continuous_sanity_checked) //make sure we have antags to be checking in the first place
			for(var/mob/Player in GLOB.mob_list)
				if(Player.mind)
					if(Player.mind.special_role || LAZYLEN(Player.mind.antag_datums))
						continuous_sanity_checked = 1
						return FALSE
			if(!continuous_sanity_checked)
				message_admins("The roundtype ([config_tag]) has no antagonists, continuous round has been defaulted to on and midround_antag has been defaulted to off.")
				continuous[config_tag] = TRUE
				midround_antag[config_tag] = FALSE
				SSshuttle.clearHostileEnvironment(src)
				return FALSE

		var/list/targets_alive = assault_team.get_alive_targets()
		var/list/assaultops_alive = assault_team.get_alive_assaultops()
		var/list/targets_alive_captured = assault_team.get_captured_targets()
		var/list/assaultops_alive_captured = assault_team.get_captured_assaultops()

		if(!targets_alive.len)
			return TRUE //All of the targets have died

		if(!assaultops_alive.len)
			return TRUE //All of the assault team is dead

		if(targets_alive_captured.len >= targets_alive.len)
			return TRUE //We got em boys!

		if(assaultops_alive_captured.len >= targets_alive.len)
			return TRUE //The assault team have been captured!


		if(living_antag_player && living_antag_player.mind && isliving(living_antag_player) && living_antag_player.stat != DEAD && !isnewplayer(living_antag_player) &&!isbrain(living_antag_player) && (living_antag_player.mind.special_role || LAZYLEN(living_antag_player.mind.antag_datums)))
			return FALSE //A resource saver: once we find someone who has to die for all antags to be dead, we can just keep checking them, cycling over everyone only when we lose our mark.

		for(var/mob/Player in GLOB.alive_mob_list)
			if(Player.mind && Player.stat != DEAD && !isnewplayer(Player) &&!isbrain(Player) && Player.client && (Player.mind.special_role || LAZYLEN(Player.mind.antag_datums))) //Someone's still antagging but is their antagonist datum important enough to skip mulligan?
				for(var/datum/antagonist/antag_types in Player.mind.antag_datums)
					if(antag_types.prevent_roundtype_conversion)
						living_antag_player = Player //they were an important antag, they're our new mark
						return FALSE

		if(!are_special_antags_dead())
			return FALSE

		if(!continuous[config_tag] || force_ending)
			return TRUE

		else
			round_converted = convert_roundtype()
			if(!round_converted)
				if(round_ends_with_antag_death)
					return TRUE
				else
					midround_antag[config_tag] = 0
					return FALSE

	return FALSE


/proc/is_assault_operative(mob/M)
	return M && istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/assaultops)

/proc/get_assault_loadout(mob/M)
	if(istype(M) && M.mind && M.mind.has_antag_datum(/datum/antagonist/assaultops))
		var/datum/antagonist/assaultops/assops = M.mind.has_antag_datum(/datum/antagonist/assaultops)
		return assops.loadout

//KITS
/datum/outfit/assaultops
	name = "I couldn't choose one!"

	head = /obj/item/clothing/head/helmet/swat
	mask = /obj/item/clothing/mask/gas/syndicate
	glasses = /obj/item/clothing/glasses/thermal
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves =  /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/fireproof
	ears = /obj/item/radio/headset/syndicate/alt
	l_pocket = /obj/item/modular_computer/tablet/nukeops
	id = /obj/item/card/id/syndicate/nuke_leader
	suit = /obj/item/clothing/suit/space/hardsuit/syndi
	suit_store = /obj/item/gun/ballistic/automatic/pistol/aps
	r_pocket = /obj/item/ammo_box/magazine/m9mm_aps
	belt = /obj/item/storage/belt/utility/syndicate

	var/command_radio = FALSE
	var/cqc = FALSE
	var/loadout_desc = "I'm dumb!"

/datum/outfit/assaultops/cqb
	name = "Assault Operative - CQB"
	loadout_desc = "<span class='notice'>You have chosen the CQB class, your role is to deal with hand-to-hand combat!</span>"

	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/c20r,\
		/obj/item/ammo_box/magazine/smgm45=4,\
		)

	cqc = TRUE

/datum/outfit/assaultops/demoman
	name = "Assault Operative - Demolitions"
	loadout_desc = "<span class='notice'>You have chosen the Demolitions class, your role is to blow shit up!</span>"

	belt = /obj/item/storage/belt/grenade/full
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/gyropistol,\
		/obj/item/ammo_box/magazine/m75=4,\
		/obj/item/implant/explosive/macro, \
		/obj/item/storage/box/assaultops/demoman
		)
	l_hand = /obj/item/clothing/suit/space/hardsuit/rd

/obj/item/storage/box/assaultops/demoman
	name = "Assault Operative - Demolitions"

/obj/item/storage/box/assaultops/demoman/PopulateContents()
	for(var/i in 1 to 4)
		new /obj/item/grenade/syndieminibomb(src)
		new /obj/item/grenade/c4/x4(src)

/datum/outfit/assaultops/medic
	name = "Assault Operative - Medic"
	loadout_desc = "<span class='notice'>You have chosen the Medic class, your role is providing medical aid to fellow operatives!</span>"

	glasses = /obj/item/clothing/glasses/hud/health
	belt = /obj/item/storage/belt/medical/paramedic
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/submachine_gun/pps,\
		/obj/item/ammo_box/magazine/pps=4,\
		/obj/item/storage/firstaid/tactical=2,\
		/obj/item/gun/medbeam)

/datum/outfit/assaultops/heavy
	name = "Assault Operative - Heavy Gunner"
	loadout_desc = "<span class='notice'>You have chosen the Heavy class, your role is continuous suppression!</span>"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34/assaultops,\
		/obj/item/ammo_box/magazine/mg34=4,\
		/obj/item/grenade/syndieminibomb)

/obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34/assaultops
	w_class = WEIGHT_CLASS_NORMAL

/datum/outfit/assaultops/assault
	name = "Assault Operative - Assault"
	loadout_desc = "<span class='notice'>You have chosen the Assault class, your role is general combat!</span>"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/assault_rifle/akm,\
		/obj/item/ammo_box/magazine/akm=4,\
		/obj/item/grenade/syndieminibomb=2)

/datum/outfit/assaultops/sniper
	name = "Assault Operative - Sniper"
	loadout_desc = "<span class='notice'>You have chosen the Sniper class, your role is suppressive fire!</span>"

	suit = /obj/item/clothing/suit/space/hardsuit/syndi/elite
	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/sniper_rifle/modular/blackmarket,\
		/obj/item/ammo_box/magazine/sniper_rounds=4,\
		/obj/item/grenade/syndieminibomb=2)

/datum/outfit/assaultops/tech
	name = "Assault Operative - Tech"
	loadout_desc = "<span class='notice'>You have chosen the Tech class, your role is hacking!</span>"

	suit = /obj/item/clothing/suit/space/hardsuit/shielded

	belt = /obj/item/storage/belt/military/abductor/full/assaultops

	backpack_contents = list(/obj/item/storage/box/survival/syndie=1,\
		/obj/item/kitchen/knife/combat/survival,\
		/obj/item/gun/energy/disabler,\
		/obj/item/gun/ballistic/automatic/battle_rifle/fg42,\
		/obj/item/ammo_box/magazine/fg42=4,\
		/obj/item/card/emag,\
		/obj/item/card/emag/doorjack)

/obj/item/storage/belt/military/abductor/full/assaultops
	name = "Assault Belt"
	desc = "A tactical belt full of highly advanced hacking equipment."

/datum/outfit/assaultops/post_equip(mob/living/carbon/human/H)
	var/obj/item/radio/R = H.ears
	R.set_frequency(FREQ_SYNDICATE)
	R.freqlock = TRUE
	if(command_radio)
		R.command = TRUE

	if(cqc)
		var/datum/martial_art/cqc/MA = new
		MA.teach(H)

	var/obj/item/implant/weapons_auth/W = new/obj/item/implant/weapons_auth(H)
	W.implant(H)

	H.update_icons()


/datum/objective/assaultops
	name = "assaultops"
	explanation_text = "Capture all of the security and command team and transport them to the holding facility."
	martyr_compatible = TRUE

/datum/objective/assaultops/check_completion()
	var/finished = TRUE
	for(var/mob/living/carbon/human/H in GLOB.assaultops_targets)
		if(H.stat != DEAD)
			finished = FALSE
	if(finished)
		return TRUE
	return FALSE

/datum/admins/proc/makeAssaultTeam()
	var/datum/game_mode/assaultops/temp = new
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for an assault team being sent in?", ROLE_ASSAULTOPS, temp)
	var/list/mob/dead/observer/chosen = list()
	var/mob/dead/observer/theghost = null
	var/numagents = 7

	if(candidates.len)
		var/agentcount = 0

		for(var/i = 0, i<numagents,i++)
			shuffle_inplace(candidates) //More shuffles means more randoms
			for(var/mob/j in candidates)
				if(!j || !j.client)
					candidates.Remove(j)
					continue

				theghost = j
				candidates.Remove(theghost)
				chosen += theghost
				agentcount++
				break
		//Making sure we have atleast 3 Nuke agents, because less than that is kinda bad
		if(agentcount < 3)
			return FALSE

		//Let's find the spawn locations
		var/leader_chosen = FALSE
		var/datum/team/assaultops/assault_team
		for(var/mob/c in chosen)
			var/mob/living/carbon/human/new_character=makeBody(c)
			if(!leader_chosen)
				leader_chosen = TRUE
				var/datum/antagonist/assaultops/N = new_character.mind.add_antag_datum(/datum/antagonist/assaultops/leader)
				assault_team = N.assault_team
			else
				new_character.mind.add_antag_datum(/datum/antagonist/assaultops,assault_team)
		return TRUE
	else
		return FALSE

//TURRETS>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
/obj/machinery/porta_turret/assaultops
	use_power = IDLE_POWER_USE
	req_access = list(ACCESS_SYNDICATE)
	faction = list(ROLE_SYNDICATE)
	max_integrity = 200
	base_icon_state = "syndie"

/obj/machinery/porta_turret/assaultops/assess_perp(mob/living/carbon/human/perp)
	return 10

/obj/machinery/porta_turret/assaultops/shuttle
	scan_range = 7
	req_access = list(ACCESS_SYNDICATE)
	mode = TURRET_STUN
	lethal_projectile = /obj/projectile/bullet/p50/penetrator/shuttle
	lethal_projectile_sound = 'modular_skyrat/modules/aesthetics/guns/sound/sniperrifle.ogg'
	stun_projectile = /obj/projectile/energy/electrode
	stun_projectile_sound = 'sound/weapons/taser.ogg'
	base_icon_state = "syndie"
	max_integrity = 600
	armor = list(MELEE = 50, BULLET = 30, LASER = 30, ENERGY = 30, BOMB = 80, BIO = 0, RAD = 0, FIRE = 90, ACID = 90)

/obj/machinery/porta_turret/assaultops/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/empprotection, EMP_PROTECT_SELF | EMP_PROTECT_WIRES)

/obj/machinery/porta_turret/assaultops/setup(obj/item/gun/turret_gun)
	return

/obj/machinery/porta_turret/syndicate/assess_perp(mob/living/carbon/human/perp)
	return 10 //Syndicate turrets shoot everything not in their faction

//VENDING MACHINES>>>>>>>>>>>>>>>>>>>>>>>>>
/obj/machinery/vending/assaultops_ammo
	name = "\improper Syndicate Ammo Station"
	desc = "An ammo vending machine which holds a variety of different ammo mags."
	icon_state = "liberationstation"
	vend_reply = "Item dispensed."
	scan_id = FALSE
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 50)
	resistance_flags = FIRE_PROOF
	onstation = FALSE
	light_mask = "liberation-light-mask"
	default_price = 0
	var/filled = FALSE


/obj/machinery/vending/assaultops_ammo/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		fill_ammo(user)
		ui = new(user, src, "Vending")
		ui.open()


/obj/machinery/vending/assaultops_ammo/proc/fill_ammo(mob/user)
	if(last_shopper == user && filled)
		return
	else
		filled = FALSE

	if(!ishuman(user))
		return FALSE

	if(!is_assault_operative(user))
		return FALSE

	//Remove all current items from the vending machine
	products.Cut()
	product_records.Cut()

	var/mob/living/carbon/human/H = user

	//Find all the ammo we should display
	for(var/i in H.contents)
		if(istype(i, /obj/item/gun/ballistic))
			var/obj/item/gun/ballistic/G = i
			if(!G.internal_magazine)
				products.Add(G.mag_type)
		if(istype(i, /obj/item/storage))
			var/obj/item/storage/S = i
			for(var/C in S.contents)
				if(istype(C, /obj/item/gun/ballistic))
					var/obj/item/gun/ballistic/G = C
					if(!G.internal_magazine)
						products.Add(G.mag_type)

	//Add our items to the list of products
	build_inventory(products, product_records, FALSE)

	filled = TRUE

/obj/machinery/vending/assaultops_ammo/build_inventory(list/productlist, list/recordlist, start_empty = FALSE)
	default_price = 0
	extra_price = 0
	for(var/typepath in productlist)
		var/amount = 4
		var/atom/temp = typepath
		var/datum/data/vending_product/R = new /datum/data/vending_product()

		GLOB.vending_products[typepath] = 1
		R.name = initial(temp.name)
		R.product_path = typepath
		if(!start_empty)
			R.amount = amount
		R.max_amount = amount
		R.custom_price = 0
		R.custom_premium_price = 0
		R.age_restricted = FALSE
		recordlist += R
