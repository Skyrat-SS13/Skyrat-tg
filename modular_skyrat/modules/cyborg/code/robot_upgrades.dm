/mob/living/silicon/robot
	var/hasShrunk = FALSE

/obj/item/borg/upgrade/shrink
	name = "borg shrinker"
	desc = "A cyborg resizer, it makes a cyborg small."
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/shrink/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)

		if(R.hasShrunk)
			to_chat(usr, "<span class='warning'>This unit already has a shrink module installed!</span>")
			return FALSE

		R.notransform = TRUE
		var/prev_lockcharge = R.lockcharge
		R.SetLockdown(1)
		R.set_anchored(TRUE)
		var/datum/effect_system/smoke_spread/smoke = new
		smoke.set_up(1, R.loc)
		smoke.start()
		sleep(2)
		for(var/i in 1 to 4)
			playsound(R, pick('sound/items/drill_use.ogg', 'sound/items/jaws_cut.ogg', 'sound/items/jaws_pry.ogg', 'sound/items/welder.ogg', 'sound/items/ratchet.ogg'), 80, TRUE, -1)
			sleep(12)
		if(!prev_lockcharge)
			R.SetLockdown(0)
		R.set_anchored(FALSE)
		R.notransform = FALSE
		R.resize = 0.75
		R.hasShrunk = TRUE
		R.update_transform()

/obj/item/borg/upgrade/shrink/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		if (R.hasShrunk)
			R.hasShrunk = FALSE
			R.resize = (4/3)
			R.update_transform()

/obj/item/borg/upgrade/surgerytools
	name = "medical cyborg advanced surgery tools"
	desc = "An upgrade to the Medical model cyborg's surgery loadout, replacing non-advanced tools with their advanced counterpart."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL

/obj/item/borg/upgrade/surgerytools/action(mob/living/silicon/robot/R)
	. = ..()
	if(.)
		for(var/obj/item/retractor/RT in R.model.modules)
			R.model.remove_module(RT, TRUE)
		for(var/obj/item/hemostat/HS in R.model.modules)
			R.model.remove_module(HS, TRUE)
		for(var/obj/item/cautery/CT in R.model.modules)
			R.model.remove_module(CT, TRUE)
		for(var/obj/item/surgicaldrill/SD in R.model.modules)
			R.model.remove_module(SD, TRUE)
		for(var/obj/item/scalpel/SP in R.model.modules)
			R.model.remove_module(SP, TRUE)
		for(var/obj/item/circular_saw/CS in R.model.modules)
			R.model.remove_module(CS, TRUE)

		var/obj/item/scalpel/advanced/AS = new /obj/item/scalpel/advanced(R.model)
		R.model.basic_modules += AS
		R.model.add_module(AS, FALSE, TRUE)
		var/obj/item/retractor/advanced/AR = new /obj/item/retractor/advanced(R.model)
		R.model.basic_modules += AR
		R.model.add_module(AR, FALSE, TRUE)
		var/obj/item/cautery/advanced/AC = new /obj/item/cautery/advanced(R.model)
		R.model.basic_modules += AC
		R.model.add_module(AC, FALSE, TRUE)

/obj/item/borg/upgrade/surgerytools/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/scalpel/advanced/AS in R.model.modules)
			R.model.remove_module(AS, TRUE)
		for(var/obj/item/retractor/advanced/AR in R.model.modules)
			R.model.remove_module(AR, TRUE)
		for(var/obj/item/cautery/advanced/AC in R.model.modules)
			R.model.remove_module(AC, TRUE)

		var/obj/item/retractor/RT = new (R.model)
		R.model.basic_modules += RT
		R.model.add_module(RT, FALSE, TRUE)
		var/obj/item/hemostat/HS = new (R.model)
		R.model.basic_modules += HS
		R.model.add_module(HS, FALSE, TRUE)
		var/obj/item/cautery/CT = new (R.model)
		R.model.basic_modules += CT
		R.model.add_module(CT, FALSE, TRUE)
		var/obj/item/surgicaldrill/SD = new (R.model)
		R.model.basic_modules += SD
		R.model.add_module(SD, FALSE, TRUE)
		var/obj/item/scalpel/SP = new (R.model)
		R.model.basic_modules += SP
		R.model.add_module(SP, FALSE, TRUE)
		var/obj/item/circular_saw/CS = new (R.model)
		R.model.basic_modules += CS
		R.model.add_module(CS, FALSE, TRUE)
