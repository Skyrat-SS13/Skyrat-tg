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
		borg.notransform = TRUE
		var/prev_lockcharge = borg.lockcharge
		borg.SetLockdown(1)
		borg.set_anchored(TRUE)
		var/datum/effect_system/fluid_spread/smoke/smoke = new
		smoke.set_up(1, location = get_turf(borg))
		smoke.start()
		sleep(2)
		for(var/i in 1 to 4)
			playsound(borg, pick('sound/items/drill_use.ogg', 'sound/items/jaws_cut.ogg', 'sound/items/jaws_pry.ogg', 'sound/items/welder.ogg', 'sound/items/ratchet.ogg'), 80, TRUE, -1)
			sleep(12)
		if(!prev_lockcharge)
			borg.SetLockdown(0)
		borg.set_anchored(FALSE)
		borg.notransform = FALSE
		borg.resize = 0.75
		borg.update_transform()

/obj/item/borg/upgrade/shrink/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if (.)
		if (borg.hasShrunk)
			borg.hasShrunk = FALSE
			borg.resize = (4/3)
			borg.update_transform()

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

    var/obj/item/dogborg_tongue/dogtongue = new /obj/item/dogborg_tongue(borg.model)
    borg.model.basic_modules += dogtongue
    borg.model.add_module(dogtongue, FALSE, TRUE)
    var/obj/item/dogborg_nose/dognose = new /obj/item/dogborg_nose(borg.model)
    borg.model.basic_modules += dognose
    borg.model.add_module(dognose, FALSE, TRUE)
    borg.hasAffection = TRUE

/obj/item/borg/upgrade/affectionmodule/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		return
	borg.hasAffection = FALSE
	for(var/obj/item/dogborg_tongue/dogtongue in borg.model.modules)
		borg.model.remove_module(dogtongue, TRUE)
	for(var/obj/item/dogborg_nose/dognose in borg.model.modules)
		borg.model.remove_module(dognose, TRUE)

/*
*	ADVANCED ENGINEERING CYBORG MATERIALS
*/

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

// funny borg inducer upgrade
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
