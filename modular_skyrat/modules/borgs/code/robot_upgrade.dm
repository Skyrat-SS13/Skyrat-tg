/// Use this file to add UPGRADES to borgs, the standard items will go in the modular robot_items.dm

/*
*	ADVANCED MEDICAL CYBORG UPGRADES
*/

/// Advanced Surgery Tools
/obj/item/borg/upgrade/surgerytools
	name = "medical cyborg advanced surgery tools"
	desc = "An upgrade to the Medical model cyborg's surgery loadout, replacing non-advanced tools with their advanced counterpart."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL

/obj/item/borg/upgrade/surgerytools/action(mob/living/silicon/robot/borg)
	. = ..()
	if(.)
		for(var/obj/item/retractor/RT in borg.model.modules)
			borg.model.remove_module(RT, TRUE)
		for(var/obj/item/hemostat/HS in borg.model.modules)
			borg.model.remove_module(HS, TRUE)
		for(var/obj/item/cautery/CT in borg.model.modules)
			borg.model.remove_module(CT, TRUE)
		for(var/obj/item/surgicaldrill/SD in borg.model.modules)
			borg.model.remove_module(SD, TRUE)
		for(var/obj/item/scalpel/SP in borg.model.modules)
			borg.model.remove_module(SP, TRUE)
		for(var/obj/item/circular_saw/CS in borg.model.modules)
			borg.model.remove_module(CS, TRUE)
		for(var/obj/item/healthanalyzer/HA in borg.model.modules)
			borg.model.remove_module(HA, TRUE)

		var/obj/item/scalpel/advanced/AS = new /obj/item/scalpel/advanced(borg.model)
		borg.model.basic_modules += AS
		borg.model.add_module(AS, FALSE, TRUE)
		var/obj/item/retractor/advanced/AR = new /obj/item/retractor/advanced(borg.model)
		borg.model.basic_modules += AR
		borg.model.add_module(AR, FALSE, TRUE)
		var/obj/item/cautery/advanced/AC = new /obj/item/cautery/advanced(borg.model)
		borg.model.basic_modules += AC
		borg.model.add_module(AC, FALSE, TRUE)
		var/obj/item/healthanalyzer/advanced/AHA = new /obj/item/healthanalyzer/advanced(borg.model)
		borg.model.basic_modules += AHA
		borg.model.add_module(AHA, FALSE, TRUE)

/obj/item/borg/upgrade/surgerytools/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/scalpel/advanced/AS in borg.model.modules)
			borg.model.remove_module(AS, TRUE)
		for(var/obj/item/retractor/advanced/AR in borg.model.modules)
			borg.model.remove_module(AR, TRUE)
		for(var/obj/item/cautery/advanced/AC in borg.model.modules)
			borg.model.remove_module(AC, TRUE)
		for(var/obj/item/healthanalyzer/advanced/AHA in borg.model.modules)
			borg.model.remove_module(AHA, TRUE)

		var/obj/item/retractor/RT = new (borg.model)
		borg.model.basic_modules += RT
		borg.model.add_module(RT, FALSE, TRUE)
		var/obj/item/hemostat/HS = new (borg.model)
		borg.model.basic_modules += HS
		borg.model.add_module(HS, FALSE, TRUE)
		var/obj/item/cautery/CT = new (borg.model)
		borg.model.basic_modules += CT
		borg.model.add_module(CT, FALSE, TRUE)
		var/obj/item/surgicaldrill/SD = new (borg.model)
		borg.model.basic_modules += SD
		borg.model.add_module(SD, FALSE, TRUE)
		var/obj/item/scalpel/SP = new (borg.model)
		borg.model.basic_modules += SP
		borg.model.add_module(SP, FALSE, TRUE)
		var/obj/item/circular_saw/CS = new (borg.model)
		borg.model.basic_modules += CS
		borg.model.add_module(CS, FALSE, TRUE)
		var/obj/item/healthanalyzer/HA = new (borg.model)
		borg.model.basic_modules += HA
		borg.model.add_module(HA, FALSE, TRUE)

/*
*	ADVANCED ENGINEERING CYBORG UPGRADES
*/

/// Advanced Materials
#define ENGINEERING_CYBORG_CHARGE_PER_STACK 1000

/datum/robot_energy_storage/plasteel
	name = "Plasteel Processor"
	recharge_rate = 0
	max_energy = ENGINEERING_CYBORG_CHARGE_PER_STACK * 50

/datum/robot_energy_storage/titanium
	name = "Titanium Processor"
	recharge_rate = 0
	max_energy = ENGINEERING_CYBORG_CHARGE_PER_STACK * 50

/obj/item/stack/sheet/plasteel/cyborg
	cost = ENGINEERING_CYBORG_CHARGE_PER_STACK
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/plasteel

/obj/item/stack/sheet/titaniumglass/cyborg
	cost = ENGINEERING_CYBORG_CHARGE_PER_STACK
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/titanium

/obj/item/borg/upgrade/advanced_materials
	name = "engineering advanced materials processor"
	desc = "allows a cyborg to synthesize and store advanced materials"
	icon_state = "cyborg_upgrade3"
	model_type = list(/obj/item/robot_model/engineering)
	model_flags = BORG_MODEL_ENGINEERING

/obj/item/borg/upgrade/advanced_materials/action(mob/living/silicon/robot/borgo, user)
	. = ..()
	if(!.)
		return
	if(borgo.hasAdvanced)
		to_chat(user, span_warning("This unit already has advanced materials installed!"))
		return FALSE;

	var/obj/item/stack/sheet/plasteel/cyborg/plasteel_holder = new(borgo.model)
	var/obj/item/stack/sheet/titaniumglass/cyborg/titanium_holder = new(borgo.model)
	borgo.model.basic_modules += plasteel_holder
	borgo.model.basic_modules += titanium_holder
	borgo.model.add_module(plasteel_holder, FALSE, TRUE)
	borgo.model.add_module(titanium_holder, FALSE, TRUE)
	borgo.hasAdvanced = TRUE

/obj/item/borg/upgrade/advanced_materials/deactivate(mob/living/silicon/robot/borgo, user)
	. = ..()
	if(!.)
		return
	borgo.hasAdvanced = FALSE
	for(var/obj/item/stack/sheet/plasteel/cyborg/plasteel_holder in borgo.model.modules)
		borgo.model.remove_module(plasteel_holder, TRUE)
	for(var/obj/item/stack/sheet/titaniumglass/cyborg/titanium_holder in borgo.model.modules)
		borgo.model.remove_module(titanium_holder, TRUE)
	for(var/datum/robot_energy_storage/plasteel/plasteel_energy in borgo.model.storages)
		qdel(plasteel_energy)
	for(var/datum/robot_energy_storage/titanium/titanium_energy in borgo.model.storages)
		qdel(titanium_energy)

/// funny borg inducer upgrade
/obj/item/borg/upgrade/inducer
	name = "engineering cyborg inducer upgrade"
	desc = "An inducer device for the engineering cyborg."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING

/obj/item/borg/upgrade/inducer/action(mob/living/silicon/robot/target_robot, user = usr)
	. = ..()
	if(.)

		var/obj/item/inducer/cyborg/inducer = locate() in target_robot
		if(inducer)
			to_chat(user, span_warning("This unit is already equipped with an inducer module!"))
			return FALSE

		inducer = new(target_robot.model)
		target_robot.model.basic_modules += inducer
		target_robot.model.add_module(inducer, FALSE, TRUE)

/obj/item/borg/upgrade/inducer/deactivate(mob/living/silicon/robot/target_robot, user = usr)
	. = ..()
	if (.)
		var/obj/item/inducer/cyborg/inducer = locate() in target_robot.model
		if (inducer)
			target_robot.model.remove_module(inducer, TRUE)

/*
*	ADVANCED MINING CYBORG UPGRADES
*/

/// Welder
/obj/item/borg/upgrade/welder
	name = "mining cyborg welder upgrade"
	desc = "A normal welder with a larger tank for cyborgs."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER

/obj/item/borg/upgrade/welder/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/weldingtool/mini/W in R.model)
			R.model.remove_module(W, TRUE)

		var/obj/item/weldingtool/largetank/cyborg/WW = new /obj/item/weldingtool/largetank/cyborg(R.model)
		R.model.basic_modules += WW
		R.model.add_module(WW, FALSE, TRUE)

/obj/item/borg/upgrade/welder/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/weldingtool/largetank/cyborg/WW in R.model)
			R.model.remove_module(WW, TRUE)

		var/obj/item/weldingtool/mini/W = new (R.model)
		R.model.basic_modules += W
		R.model.add_module(W, FALSE, TRUE)

/*
*	ADVANCED CARGO CYBORG UPGRADES
*/

/// Better Clamp
/obj/item/borg/hydraulic_clamp/better
	name = "improved integrated hydraulic clamp"
	desc = "A neat way to lift and move around crates for quick and painless deliveries!"
	storage_capacity = 4
	whitelisted_item_types = list(/obj/structure/closet/crate, /obj/item/delivery/big, /obj/item/delivery, /obj/item/bounty_cube) // If they want to carry a small package or a bounty cube instead, so be it, honestly.
	whitelisted_item_description = "wrapped packages"
	item_weight_limit = NONE
	clamp_sound_volume = 50

/obj/item/borg/hydraulic_clamp/better/examine(mob/user)
	. = ..()
	var/crate_count = contents.len
	. += "There is currently <b>[crate_count > 0 ? crate_count : "no"]</b> crate[crate_count > 1 ? "s" : ""] stored in the clamp's internal storage."

/obj/item/borg/hydraulic_clamp/mail
	name = "integrated rapid mail delivery device"
	desc = "Allows you to carry around a lot of mail, to distribute it around the station like the good little mailbot you are!"
	icon = 'icons/obj/service/library.dmi'
	icon_state = "bookbag"
	storage_capacity = 100
	loading_time = 0.25 SECONDS
	unloading_time = 0.25 SECONDS
	cooldown_duration = 0.25 SECONDS
	whitelisted_item_types = list(/obj/item/mail)
	whitelisted_item_description = "envelopes"
	item_weight_limit = WEIGHT_CLASS_NORMAL
	clamp_sound_volume = 25
	clamp_sound = 'sound/items/pshoom.ogg'

/datum/design/borg_upgrade_clamp
	name = "improved Integrated Hydraulic Clamp Module"
	id = "borg_upgrade_clamp"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/better_clamp
	materials = list(/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2, /datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 5)
	construction_time = 12 SECONDS
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO)


/obj/item/borg/upgrade/better_clamp
	name = "improved integrated hydraulic clamp"
	desc = "An improved hydraulic clamp to allow for bigger packages to be picked up as well!"
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO


/obj/item/borg/upgrade/better_clamp/action(mob/living/silicon/robot/cyborg, user = usr)
	. = ..()
	if(!.)
		return
	var/obj/item/borg/hydraulic_clamp/better/big_clamp = locate() in cyborg.model.modules
	if(big_clamp)
		to_chat(user, span_warning("This cyborg is already equipped with an improved integrated hydraulic clamp!"))
		return FALSE

	big_clamp = new(cyborg.model)
	cyborg.model.basic_modules += big_clamp
	cyborg.model.add_module(big_clamp, FALSE, TRUE)


/obj/item/borg/upgrade/better_clamp/deactivate(mob/living/silicon/robot/cyborg, user = usr)
	. = ..()
	if(!.)
		return
	var/obj/item/borg/hydraulic_clamp/better/big_clamp = locate() in cyborg.model.modules
	if(big_clamp)
		cyborg.model.remove_module(big_clamp, TRUE)

/*
*	UNIVERSAL CYBORG UPGRADES
*/

/// ShapeShifter
/obj/item/borg/upgrade/borg_shapeshifter
	name = "Cyborg Shapeshifter Module"
	desc = "An experimental device which allows a cyborg to disguise themself into another type of cyborg."
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/borg_shapeshifter/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/borg_shapeshifter/BS = new /obj/item/borg_shapeshifter(R.model)
		R.model.basic_modules += BS
		R.model.add_module(BS, FALSE, TRUE)

/obj/item/borg/upgrade/borg_shapeshifter/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/borg_shapeshifter/BS in R.model)
			R.model.remove_module(BS, TRUE)

/// Quadborg time
/obj/item/borg/upgrade/affectionmodule
	name = "borg affection module"
	desc = "A module that upgrades the ability of borgs to display affection."
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/affectionmodule/action(mob/living/silicon/robot/borg)
	. = ..()
	if(!.)
		return
	if(borg.hasAffection)
		to_chat(usr, span_warning("This unit already has a affection module installed!"))
		return FALSE
	if(!(R_TRAIT_WIDE in borg.model.model_features))
		to_chat(usr, span_warning("This unit's chassis does not support this module."))
		return FALSE

	var/obj/item/quadborg_tongue/quadtongue = new /obj/item/quadborg_tongue(borg.model)
	borg.model.basic_modules += quadtongue
	borg.model.add_module(quadtongue, FALSE, TRUE)
	var/obj/item/quadborg_nose/quadnose = new /obj/item/quadborg_nose(borg.model)
	borg.model.basic_modules += quadnose
	borg.model.add_module(quadnose, FALSE, TRUE)
	borg.hasAffection = TRUE

/obj/item/borg/upgrade/affectionmodule/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		return
	borg.hasAffection = FALSE
	for(var/obj/item/quadborg_tongue/quadtongue in borg.model.modules)
		borg.model.remove_module(quadtongue, TRUE)
	for(var/obj/item/quadborg_nose/quadnose in borg.model.modules)
		borg.model.remove_module(quadnose, TRUE)

// Quadruped tongue - lick lick
/obj/item/quadborg_tongue
	name = "synthetic tongue"
	desc = "Useful for slurping mess off the floor before affectionally licking the crew members in the face."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "synthtongue"
	hitsound = 'sound/effects/attackblob.ogg'
	desc = "For giving affectionate kisses."
	item_flags = NOBLUDGEON

/obj/item/quadborg_tongue/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !isliving(target))
		return
	var/mob/living/silicon/robot/borg = user
	var/mob/living/mob = target

	if(!HAS_TRAIT(target, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		if(check_zone(borg.zone_selected) == "head")
			borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]'s face!"), span_notice("You affectionally lick \the [mob]'s face!"))
			playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)
		else
			borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]!"), span_notice("You affectionally lick \the [mob]!"))
			playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)
	else
		to_chat(user, span_warning("ERROR: [target] is on the Do Not Lick registry!"))

// Quadruped nose - Boop
/obj/item/quadborg_nose
	name = "boop module"
	desc = "The BOOP module"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "nose"
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	force = 0

/obj/item/quadborg_nose/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return

	if(!HAS_TRAIT(target, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		do_attack_animation(target, null, src)
		user.visible_message(span_notice("[user] [pick("nuzzles", "pushes", "boops")] \the [target.name] with their nose!"))
	else
		to_chat(user, span_warning("ERROR: [target] is on the No Nosing registry!"))

/// The Shrinkening
/mob/living/silicon/robot
	var/hasShrunk = FALSE
	var/hasAffection = FALSE
	var/hasAdvanced = FALSE

/obj/item/borg/upgrade/shrink
	name = "borg shrinker"
	desc = "A cyborg resizer, it makes a cyborg small."
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/shrink/action(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)

		if(borg.hasShrunk)
			to_chat(usr, span_warning("This unit already has a shrink module installed!"))
			return FALSE
		if(R_TRAIT_SMALL in borg.model.model_features)
			to_chat(usr, span_warning("This unit's chassis cannot be shrunk any further."))
			return FALSE

		borg.hasShrunk = TRUE
		ADD_TRAIT(borg, TRAIT_NO_TRANSFORM, REF(src))
		var/prev_lockcharge = borg.lockcharge
		borg.SetLockdown(TRUE)
		borg.set_anchored(TRUE)
		var/datum/effect_system/fluid_spread/smoke/smoke = new
		smoke.set_up(1, location = get_turf(borg))
		smoke.start()
		sleep(0.2 SECONDS)
		for(var/i in 1 to 4)
			playsound(borg, pick('sound/items/drill_use.ogg', 'sound/items/jaws_cut.ogg', 'sound/items/jaws_pry.ogg', 'sound/items/welder.ogg', 'sound/items/ratchet.ogg'), 80, TRUE, -1)
			sleep(1.2 SECONDS)
		if(!prev_lockcharge)
			borg.SetLockdown(FALSE)
		borg.set_anchored(FALSE)
		REMOVE_TRAIT(borg, TRAIT_NO_TRANSFORM, REF(src))
		borg.update_transform(0.75)

/obj/item/borg/upgrade/shrink/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if (.)
		if (borg.hasShrunk)
			borg.hasShrunk = FALSE
			borg.update_transform(4/3)

/// Syndijack
/obj/item/borg/upgrade/transform/syndicatejack
	name = "borg module picker (Syndicate)"
	desc = "Allows you to to turn a cyborg into a experimental syndicate cyborg."
	icon_state = "cyborg_upgrade3"
	new_model = /obj/item/robot_model/syndicatejack

/obj/item/borg/upgrade/transform/syndicatejack/action(mob/living/silicon/robot/cyborg, user = usr) // Only usable on emagged cyborgs. In exchange. makes you unable to get locked down or detonated.
	if(cyborg.emagged)
		return ..()
