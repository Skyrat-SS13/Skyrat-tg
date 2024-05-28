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
/datum/design/borg_upgrade_clamp
	name = "Improved Integrated Hydraulic Clamp Module"
	id = "borg_upgrade_clamp"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/better_clamp
	materials = list(
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO,
	)

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

/datum/design/borg_upgrade_cargo_tele
	name = "Cargo teleporter module"
	id = "borg_upgrade_cargo_tele"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/cargo_tele
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/plastic = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO
	)

/obj/item/borg/upgrade/cargo_tele
	name = "cargo teleporter module"
	desc = "Allows you to upgrade a cargo cyborg with the cargo teleporter"
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO

/obj/item/borg/upgrade/cargo_tele/action(mob/living/silicon/robot/cyborg, user = usr)
	. = ..()
	if(!.)
		return

	var/obj/item/cargo_teleporter/locate_tele = locate() in cyborg.model.modules
	if(locate_tele)
		to_chat(user, span_warning("This cyborg is already equipped with a cargo teleporter!"))
		return FALSE

	locate_tele = new(cyborg.model)
	cyborg.model.basic_modules += locate_tele
	cyborg.model.add_module(locate_tele, FALSE, TRUE)

/obj/item/borg/upgrade/cargo_tele/deactivate(mob/living/silicon/robot/cyborg, user)
	. = ..()
	if(!.)
		return

	var/obj/item/cargo_teleporter/locate_tele = locate() in cyborg.model.modules
	if(locate_tele)
		cyborg.model.remove_module(locate_tele, TRUE)

/datum/design/borg_upgrade_forging
	name = "Forging module"
	id = "borg_upgrade_forging"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/forging
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 5)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO
	)

/obj/item/borg/upgrade/forging
	name = "cyborg forging module"
	desc = "Allows you to upgrade a cargo cyborg with forging gear"
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO

/obj/item/borg/upgrade/forging/action(mob/living/silicon/robot/cyborg, user = usr)
	. = ..()
	if(!.)
		return

	var/obj/item/forging/hammer/locate_hammer = locate() in cyborg.model.modules
	var/obj/item/forging/billow/locate_billow = locate() in cyborg.model.modules
	var/obj/item/forging/tongs/locate_tongs = locate() in cyborg.model.modules
	var/obj/item/borg/forging_setup/locate_forge = locate() in cyborg.model.modules
	if(locate_hammer || locate_billow || locate_tongs || locate_forge)
		to_chat(user, span_warning("This cyborg is already equipped with a forging set!"))
		return FALSE

	locate_hammer = new(cyborg.model)
	locate_billow = new(cyborg.model)
	locate_tongs = new(cyborg.model)
	locate_forge = new(cyborg.model)
	cyborg.model.basic_modules += locate_hammer
	cyborg.model.basic_modules += locate_billow
	cyborg.model.basic_modules += locate_tongs
	cyborg.model.basic_modules += locate_forge
	cyborg.model.add_module(locate_hammer, FALSE, TRUE)
	cyborg.model.add_module(locate_billow, FALSE, TRUE)
	cyborg.model.add_module(locate_tongs, FALSE, TRUE)
	cyborg.model.add_module(locate_forge, FALSE, TRUE)

/obj/item/borg/upgrade/forging/deactivate(mob/living/silicon/robot/cyborg, user)
	. = ..()
	if(!.)
		return

	var/obj/item/forging/hammer/locate_hammer = locate() in cyborg.model.modules
	if(locate_hammer)
		cyborg.model.remove_module(locate_hammer, TRUE)
	var/obj/item/forging/billow/locate_billow = locate() in cyborg.model.modules
	if(locate_billow)
		cyborg.model.remove_module(locate_billow, TRUE)
	var/obj/item/forging/tongs/locate_tongs = locate() in cyborg.model.modules
	if(locate_tongs)
		cyborg.model.remove_module(locate_tongs, TRUE)
	var/obj/item/borg/forging_setup/locate_forge = locate() in cyborg.model.modules
	if(locate_forge)
		cyborg.model.remove_module(locate_forge, TRUE)

/*
* SERVICE CYBORG UPGRADES
*/

/datum/design/borg_upgrade_artistic
	name = "Artistic module"
	id = "borg_upgrade_artistic"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/artistic
	materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2,
					/datum/material/glass = SMALL_MATERIAL_AMOUNT * 2)
	construction_time = 10 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_SERVICE
	)

/obj/item/borg/upgrade/artistic
	name = "borg artistic module"
	desc = "Allows you to upgrade a service cyborg with tools for creating art."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/service)
	model_flags = BORG_MODEL_SERVICE
	var/list/items_to_add = list(
			/obj/item/pen,
			/obj/item/toy/crayon/spraycan/borg,
			/obj/item/instrument/guitar,
			/obj/item/instrument/piano_synth,
			/obj/item/stack/pipe_cleaner_coil/cyborg,
			/obj/item/chisel,
			)

/obj/item/borg/upgrade/artistic/action(mob/living/silicon/robot/install, user = usr)
	. = ..()
	if(!.)
		return FALSE
	for(var/item_to_add in items_to_add)
		if(locate(item_to_add) in install.model.modules)
			install.balloon_alert_to_viewers("already installed!")
			return FALSE
		else
			var/obj/item/module_item = new item_to_add(install.model.modules)
			install.model.basic_modules += module_item
			install.model.add_module(module_item, FALSE, TRUE)

/obj/item/borg/upgrade/artistic/deactivate(mob/living/silicon/robot/install, user = usr)
	. = ..()
	if (!.)
		return FALSE
	for(var/item_to_add in items_to_add)
		var/obj/item/module_item = locate(item_to_add) in install.model.modules
		if (module_item)
			install.model.remove_module(module_item, TRUE)

/*
*	UNIVERSAL CYBORG UPGRADES
*/

/// ShapeShifter
/obj/item/borg/upgrade/borg_shapeshifter
	name = "cyborg shapeshifter module"
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
	if(!(TRAIT_R_WIDE in borg.model.model_features))
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
		if(TRAIT_R_SMALL in borg.model.model_features)
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

/// Dominatrix time
/obj/item/borg/upgrade/dominatrixmodule
	name = "borg dominatrix module"
	desc = "A module that greatly upgrades the ability of borgs to display affection."
	icon_state = "cyborg_upgrade3"
	custom_price = 0

/obj/item/borg/upgrade/dominatrixmodule/action(mob/living/silicon/robot/borg)
	. = ..()
	if(!.)
		return
	var/obj/item/kinky_shocker/cur_shocker = locate() in borg.model.modules
	if(cur_shocker)
		to_chat(usr, span_warning("This unit already has a dominatrix module installed!"))
		return FALSE

	var/obj/item/kinky_shocker/shocker = new /obj/item/kinky_shocker()
	borg.model.basic_modules += shocker
	borg.model.add_module(shocker, FALSE, TRUE)
	var/obj/item/clothing/mask/leatherwhip/whipper = new /obj/item/clothing/mask/leatherwhip()
	borg.model.basic_modules += whipper
	borg.model.add_module(whipper, FALSE, TRUE)
	var/obj/item/spanking_pad/spanker = new /obj/item/spanking_pad()
	borg.model.basic_modules += spanker
	borg.model.add_module(spanker, FALSE, TRUE)
	var/obj/item/tickle_feather/tickler = new /obj/item/tickle_feather()
	borg.model.basic_modules += tickler
	borg.model.add_module(tickler, FALSE, TRUE)
	var/obj/item/clothing/erp_leash/leash = new /obj/item/clothing/erp_leash()
	borg.model.basic_modules += leash
	borg.model.add_module(leash, FALSE, TRUE)

/obj/item/borg/upgrade/dominatrixmodule/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(!.)
		return

	for(var/obj/item/kinky_shocker/shocker in borg.model.modules)
		borg.model.remove_module(shocker, TRUE)
	for(var/obj/item/clothing/mask/leatherwhip/whipper in borg.model.modules)
		borg.model.remove_module(whipper, TRUE)
	for(var/obj/item/spanking_pad/spanker in borg.model.modules)
		borg.model.remove_module(spanker, TRUE)
	for(var/obj/item/tickle_feather/tickler in borg.model.modules)
		borg.model.remove_module(tickler, TRUE)
	for(var/obj/item/clothing/erp_leash/leash in borg.model.modules)
		borg.model.remove_module(leash, TRUE)
