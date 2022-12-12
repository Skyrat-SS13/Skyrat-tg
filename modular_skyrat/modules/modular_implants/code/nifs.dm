#define NIF_CALIBRATION_STAGE_1 0
#define NIF_CALIBRATION_STAGE_1_END  0.1
#define NIF_CALIBRATION_STAGE_2 0.2
#define NIF_CALIBRATION_STAGE_2_END 0.9
#define NIF_CALIBRATION_STAGE_FINISHED 1

/// This is the original NIF that other NIFs are based on.
/obj/item/organ/internal/cyberimp/brain/nif
	name = "Nanite Implant Framework"
	desc = "A brain implant that infuses the user with nanites." //Coder-lore. Change this later
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/nifs.dmi'
	icon_state = "base_nif"
	w_class = WEIGHT_CLASS_NORMAL
	slot = ORGAN_SLOT_BRAIN_NIF
	actions_types = list(/datum/action/item_action/nif/open_menu)

	//User Variables
	///What user is currently linked with the NIF?
	var/mob/living/carbon/human/linked_mob = null
	///What CKEY does the original user have? Used to prevent theft
	var/stored_ckey

	//Calibration variables
	///Is the NIF properly calibrated yet?
	var/is_calibrated = FALSE
	///Is the NIF currently being calibrated?
	var/calibrating = FALSE
	///How long does each step in the calibration process take in total?
	var/calibration_time = 3 MINUTES
	///How far through the calibration process is the NIF? Do not touch this outside of perform_calibration(), if you can at all help it.
	var/calibration_duration
	///Determines the likelyhood of a side effect occuring each process cycle: 1 / side_effect_risk
	var/side_effect_risk = 50

	//Power Variables
	///What is the maximum power level of the NIF?
	var/max_power = 1000
	///How much power is currently inside of the NIF?
	var/power_level = 0
	///How much power is the NIF currently using? Negative usage will result in power being gained.
	var/power_usage = 0

	//Nutrition variables
	///Is power being drawn from nutrition?
	var/nutrition_drain = FALSE
	///How fast is nutrition drained from the host?
	var/nutrition_drain_rate = 1.5
	///What is the rate of nutrition to power?
	var/nutrition_conversion_rate = 5
	///What is the minimum nutrition someone has to be at for the NIF to convert power?
	var/minimum_nutrition = 25

	//Blood variables
	///Is power being drawn through blood
	var/blood_drain = FALSE
	///The rate of blood to energy
	var/blood_conversion_rate = 5 //From full blood, this would get someone to 500 charge
	///How fast is blood being drained?
	var/blood_drain_rate = 1
	///When is blood draining disabled?
	var/minimum_blood_level = BLOOD_VOLUME_SAFE

	//Durability and persistence variables
	///What is the maximum durability of the NIF?
	var/max_durability = 100
	///What level of durability is the NIF at?
	var/durability = 100
	//How much durability is lost per death if any?
	var/death_durability_loss = 10
	///Does the NIF stay between rounds? By default, they do.
	var/nif_persistence = TRUE
	///Is the NIF disabled? This will make it so that the NIF TGUI can still be seen, but not used.
	var/disabled = FALSE
	///Is the NIF completely broken? If this is true, the user won't be able to pull up the TGUI menu at all.
	var/broken = FALSE
	///Does the NIF have theft protection? This should only be disabled if admins need to fix something.
	var/theft_protection = TRUE
	///Is the NIF able to take damage?
	var/durability_loss_vulnerable = TRUE

	//Software Variables
	///How many programs can the NIF store at once?
	var/max_nifsofts = 5
	///What programs are currently loaded onto the NIF?
	var/list/loaded_nifsofts = list()
	///What programs come already installed on the NIF?
	var/list/preinstalled_nifsofts = list()
	///This shows up in the NIF settings screen as a way to ICly display lore.
	var/manufacturer_notes = "There is no data currently avalible for this product"

	//Appearance Variables
	///This is the sound that plays when doing most things!
	var/good_sound ='modular_skyrat/modules/modular_implants/sounds/default_good.ogg'
	///This is the sound that plays if there is an issue going on.
	var/bad_sound = 'modular_skyrat/modules/modular_implants/sounds/default_bad.ogg'
	///This is the sound that you would hear if you enable if you activate or enable something.
	var/click_sound = 'modular_skyrat/modules/modular_implants/sounds/default_click.ogg'
	///What icon does the NIF display in chat when sending out alerts? Icon states are stored in 'modular_skyrat/modules/modular_implants/icons/chat.dmi'
	var/chat_icon = "standard"

/obj/item/organ/internal/cyberimp/brain/nif/Initialize(mapload)
	. = ..()

	durability = max_durability
	loaded_nifsofts = preinstalled_nifsofts

	for(var/datum/nifsoft/preinstalled_nifsoft as anything in preinstalled_nifsofts)
		install_nifsoft(preinstalled_nifsoft)

	power_level = max_power

/obj/item/organ/internal/cyberimp/brain/nif/Insert(mob/living/carbon/human/insertee, special = FALSE, drop_if_replaced = TRUE)
	. = ..()

	if(linked_mob && stored_ckey != insertee.ckey && theft_protection)
		insertee.audible_message(span_warning("The [src] lets out a negative buzz before forcefully removing itself from [insertee]'s brain."))
		playsound(insertee, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
		Remove(insertee)
		forceMove(get_turf(insertee))

		return FALSE

	linked_mob = insertee
	stored_ckey = linked_mob.ckey

	loc = insertee // This needs to be done, otherwise TGUI will not pull up.
	insertee.installed_nif = src
	START_PROCESSING(SSobj, src)

	if(!is_calibrated)
		send_message("Calibration Process Starting!")
		calibrating = TRUE

/obj/item/organ/internal/cyberimp/brain/nif/Remove(mob/living/carbon/organ_owner, special = FALSE)
	. = ..()

	organ_owner.log_message("[src] was removed from [organ_owner]]",LOG_GAME)
	STOP_PROCESSING(SSobj, src)

/obj/item/organ/internal/cyberimp/brain/nif/process(delta_time)
	. = ..()

	if(!linked_mob || broken)
		return FALSE

	if(calibrating)
		perform_calibration()

	if(IS_IN_STASIS(linked_mob))
		return

	if(nutrition_drain && linked_mob.nutrition < minimum_nutrition) //Turns nutrition drain off if nutrition is lower than minimum
		toggle_nutrition_drain(TRUE)

	if(blood_drain && !blood_check()) //Disables blood draining if the mob fails the blood check
		toggle_blood_drain(TRUE)

	if(blood_drain)
		linked_mob.blood_volume -= blood_drain_rate

	if(power_usage > power_level)
		for(var/datum/nifsoft/nifsoft as anything in loaded_nifsofts)
			if(!nifsoft.active)
				continue

			nifsoft.activate()

	power_level = min(power_level - power_usage, max_power)

/obj/item/organ/internal/cyberimp/brain/nif/Destroy()
	linked_mob.nif_examine_text = null
	linked_mob = null

	QDEL_LIST(loaded_nifsofts)
	return ..()

///Subtracts from the power level of the NIF once
/obj/item/organ/internal/cyberimp/brain/nif/proc/use_power(power_to_use)
	if(power_level < power_to_use)
		return FALSE

	power_level -= power_to_use
	return TRUE

///Adds power to a NIF once.
/obj/item/organ/internal/cyberimp/brain/nif/proc/add_power(power_to_add)
	if(power_level >= max_power)
		return FALSE

	power_level = min(power_level + power_to_add, max_power)
	return TRUE

///Toggles nutrition drain as a power source on NIFs on/off. Bypass - Ignores the need to perform the nutirition_check() proc.
/obj/item/organ/internal/cyberimp/brain/nif/proc/toggle_nutrition_drain(bypass = FALSE)
	if(!bypass && !nutrition_check())
		return FALSE

	var/hunger_modifier = linked_mob.physiology.hunger_mod

	if(nutrition_drain)
		hunger_modifier = nutrition_drain_rate
		power_usage += (nutrition_drain_rate * nutrition_conversion_rate)
		nutrition_drain = FALSE
		return TRUE

	hunger_modifier *= nutrition_drain_rate
	power_usage -= (nutrition_drain_rate * nutrition_conversion_rate)
	nutrition_drain = TRUE

/// Checks to see if the mob has a nutrition that can be drain from
/obj/item/organ/internal/cyberimp/brain/nif/proc/nutrition_check() //This is a seperate proc so that TGUI can perform this check on the menu
	if(!linked_mob || !linked_mob.nutrition)
		return FALSE

	if(isrobotic(linked_mob))
		return FALSE

	if(HAS_TRAIT(linked_mob, TRAIT_NOHUNGER)) //Hemophages HATE this one simple check.
		return FALSE

	return linked_mob.nutrition >= minimum_nutrition

///Toggles Blood Drain. Bypasss -  Ignores the need to perform the blood_check proc.
/obj/item/organ/internal/cyberimp/brain/nif/proc/toggle_blood_drain(bypass = FALSE)
	if(!bypass && !blood_check())
		return

	blood_drain = !blood_drain

	if(!blood_drain)
		power_usage += (blood_drain_rate * blood_conversion_rate)

		to_chat(linked_mob, span_notice("Blood draining is now disabled"))
		return

	power_usage -= (blood_drain_rate * blood_conversion_rate)
	to_chat(linked_mob, span_notice("Blood draining is now enabled."))

///Checks if the NIF is able to draw blood as a power source?
/obj/item/organ/internal/cyberimp/brain/nif/proc/blood_check()
	if(!linked_mob || !linked_mob.blood_volume || linked_mob.blood_volume <= minimum_blood_level)
		return FALSE

	return TRUE

///Calibrates the Parent NIF, this is ran every time the parent NIF is first installed inside of someone.
/obj/item/organ/internal/cyberimp/brain/nif/proc/perform_calibration()
	if(linked_mob.stat == DEAD)
		return FALSE

	if(!calibration_duration)
		calibration_duration = world.time + calibration_time

	var/percentage_done = (world.time - (calibration_duration - (calibration_time))) / calibration_time
	switch(percentage_done)
		if(NIF_CALIBRATION_STAGE_1 to NIF_CALIBRATION_STAGE_1_END)
			linked_mob.set_blindness(5)

		if(NIF_CALIBRATION_STAGE_2 to NIF_CALIBRATION_STAGE_2_END)
			var/random_ailment = rand(1, side_effect_risk)
			switch(random_ailment)
				if(1)
					to_chat(linked_mob, span_warning("You feel sick to your stomach"))
					linked_mob.adjust_disgust(25)
				if(2)
					to_chat(linked_mob, span_warning("You feel a wave of fatigue roll over you"))
					linked_mob.adjustStaminaLoss(50)

		if(NIF_CALIBRATION_STAGE_FINISHED to INFINITY)
			send_message("Installation Proccess Complete!")

			calibrating = FALSE
			is_calibrated = TRUE

///Installs the loaded_nifsoft to the parent NIF.
/obj/item/organ/internal/cyberimp/brain/nif/proc/install_nifsoft(datum/nifsoft/loaded_nifsoft)
	if(broken || calibrating) //NIFSofts can't be installed to a broken NIF
		return FALSE

	if(length(loaded_nifsofts) >= max_nifsofts)
		send_message("You cannot install any additional NIFSofts, please uninstall one to make room!",TRUE)
		return FALSE

	if(!is_type_in_list(src, loaded_nifsoft.compatible_nifs))
		send_message("[loaded_nifsoft] is incompatible with your NIF!", TRUE)
		return FALSE

	for(var/datum/nifsoft/current_nifsoft as anything in loaded_nifsofts)
		if(loaded_nifsoft.single_install && loaded_nifsoft.type == current_nifsoft.type)
			send_message("Multiple of [loaded_nifsoft] cannot be installed", TRUE)
			return FALSE

		if(current_nifsoft.type in loaded_nifsoft.mutually_exclusive_programs)
			send_message("[current_nifsoft] is preventing [loaded_nifsoft] from being installed", TRUE)
			return FALSE

	loaded_nifsofts += loaded_nifsoft
	loaded_nifsoft.parent_nif = src
	loaded_nifsoft.linked_mob = linked_mob

	send_message("[loaded_nifsoft] has been added")
	update_static_data_for_all_viewers()
	return TRUE

///Removes a NIFSoft from a NIF. Silent - determines whether or not alerts will be given to the owner of the NIF
/obj/item/organ/internal/cyberimp/brain/nif/proc/remove_nifsoft(datum/nifsoft/removed_nifsoft, silent = FALSE)
	if(!is_type_in_list(removed_nifsoft, loaded_nifsofts) || broken)
		return FALSE

	if(!silent)
		send_message("[removed_nifsoft.name] has been removed", TRUE)

	qdel(removed_nifsoft)
	update_static_data_for_all_viewers()

	return TRUE

///Repairs the parent NIF based off the repair_amount
/obj/item/organ/internal/cyberimp/brain/nif/proc/repair_nif(repair_amount)
	if(durability == max_durability)
		return FALSE

	durability = min(durability + repair_amount, max_durability)

	return TRUE

///Sends a message to the owner of the NIF. Typically used for messages from the NIF itself or from NIFSofts.
/obj/item/organ/internal/cyberimp/brain/nif/proc/send_message(message_to_send, alert = FALSE)
	var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/chat)
	var/tag = sheet.icon_tag("nif-[chat_icon]")
	var/nif_icon = ""

	if(tag)
		nif_icon = tag

	if(alert)
		to_chat(linked_mob, span_warning("[nif_icon] <b>NIF Alert</b>: [message_to_send]"))
		linked_mob.playsound_local(linked_mob, bad_sound, 60, FALSE)
		return

	to_chat(linked_mob, span_cyan("[nif_icon] <b>NIF Message</b>: [message_to_send]"))
	linked_mob.playsound_local(linked_mob, good_sound, 60, FALSE)


///Changes the broken variable to be false. This does not relate to durability.
/obj/item/organ/internal/cyberimp/brain/nif/proc/fix_nif()
	if(!broken)
		return FALSE

	broken = FALSE
	send_message("Your NIF is now in working condition!")

///Re-enables the durability_loss_vulnerable variable, allowing the parent NIF to take durability damage again.
/obj/item/organ/internal/cyberimp/brain/nif/proc/make_vulnerable()
	durability_loss_vulnerable = TRUE

//This is here so that a TGUI can't be opened by using the implant while it isn't implanted.
/obj/item/organ/internal/cyberimp/brain/nif/attack_self(mob/user, modifiers)
	return FALSE

/obj/item/organ/internal/cyberimp/brain/nif/emp_act(severity)
	. = ..()

	if(!durability_loss_vulnerable)
		return FALSE

	broken = TRUE
	durability_loss_vulnerable = FALSE

	addtimer(CALLBACK(src, .proc/fix_nif), 30 SECONDS)
	addtimer(CALLBACK(src, .proc/make_vulnerable), 3 MINUTES)

	switch(severity)
		if(1)
			durability -= death_durability_loss
		if(2)
			durability -= (death_durability_loss / 2)

	for(var/datum/nifsoft/installed_nifsoft as anything in loaded_nifsofts)
		installed_nifsoft.on_emp(severity)

	send_message("<b>ELECTROMAGNETIC INTERFERENCE DETECTED</b>", TRUE)

///A surgery that repairs the patient's NIF
/datum/surgery/repair_nif
	name = "Repair NIF"
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/retract_skin,
		/datum/surgery_step/saw,
		/datum/surgery_step/clamp_bleeders,
		/datum/surgery_step/incise,
		/datum/surgery_step/repair_nif,
		/datum/surgery_step/close)

	target_mobtypes = list(/mob/living/carbon/human)
	possible_locs = list(BODY_ZONE_HEAD)
	desc = "A surgical procedure that restores the integrity of an installed NIF"

/datum/surgery/repair_nif/can_start(mob/user, mob/living/patient)
	var/mob/living/carbon/human/nif_patient = patient
	if(!nif_patient || !nif_patient.installed_nif)
		return FALSE

	. = ..()

/datum/surgery_step/repair_nif
	name = "Fix NIF"
	repeatable = FALSE
	implements = list(
		TOOL_MULTITOOL = 100,
		TOOL_HEMOSTAT = 35,
		TOOL_SCREWDRIVER = 15,
	)
	time = 12 SECONDS

/datum/surgery_step/repair_nif/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You begin to restore the integrity of [target]'s NIF..."),
		"[user] begins to fix [target]'s NIF.",
		"[user] begins to perform repairs on [target]'s NIF."
	)

/datum/surgery_step/repair_nif/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(user, target, span_notice("You succeed in restoring the integrity of [target]'s NIF."),
		"[user] successfully repairs [target]'s NIF!",
		"[user] completes the repair on [target]'s NIF."
	)

	var/mob/living/carbon/human/nif_patient = target
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = nif_patient.installed_nif

	installed_nif.durability = installed_nif.max_durability
	installed_nif.send_message("Restored to full integrity!")

	return ..()

/datum/surgery_step/repair_nif/failure(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(target.getorganslot(ORGAN_SLOT_BRAIN))
		display_results(user, target, span_warning("You screw up, causing [target] brain damage!"),
			span_warning("[user] screws up, causing damage to [target]'s brain!"),
			"[user] fails to complete the repair on [target]'s NIF.")

		target.adjustOrganLoss(ORGAN_SLOT_BRAIN, 20)
	return FALSE

// Action used to pull up the NIF menu
/datum/action/item_action/nif
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	icon_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/nif/open_menu
	name = "Open NIF Menu"
	button_icon_state = "user"

/datum/action/item_action/nif/open_menu/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = target

	if(target_nif.calibrating)
		target_nif.send_message("The NIF is still calibrating, please wait!", TRUE)
		return FALSE

	if(target_nif.durability < 1)
		target_nif.send_message("Durability low!", TRUE)
		return FALSE

	if(target_nif.broken)
		target_nif.send_message("The NIF is unable to be used at this time!", TRUE)
		return FALSE

	if(!.)
		return

	target_nif.ui_interact(usr)

/mob/living/carbon/human
	///What text is shown upon examining a human with a NIF?
	var/nif_examine_text
	//What, if any NIF is currently installed inside of the mob?
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif

/mob/living/carbon/human/examine(mob/user)
	. = ..()

	if(nif_examine_text)
		. += nif_examine_text

/mob/living/carbon/human/death()
	. = ..()

	if(!installed_nif)
		return

	installed_nif.durability -= installed_nif.death_durability_loss
	installed_nif.durability_loss_vulnerable = FALSE

	addtimer(CALLBACK(installed_nif, /obj/item/organ/internal/cyberimp/brain/nif.proc/make_vulnerable), 20 MINUTES) //Players should have a decent grace period on this.

///Checks to see if a human with a NIF has the nifsoft_to_find type of NIFSoft installed?
/mob/living/carbon/human/proc/find_nifsoft(nifsoft_to_find)
	var/list/nifsoft_list = installed_nif?.loaded_nifsofts
	if(!nifsoft_list)
		return FALSE

	for(var/datum/nifsoft/nifsoft as anything in nifsoft_list)
		if(nifsoft.type == nifsoft_to_find)
			return nifsoft

/datum/asset/spritesheet/chat/create_spritesheets()
	. = ..()

	InsertAll("nif", 'modular_skyrat/modules/modular_implants/icons/chat.dmi')

/obj/item/autosurgeon/organ/nif
	starting_organ = /obj/item/organ/internal/cyberimp/brain/nif/standard

/obj/item/organ/internal/cyberimp/brain/nif/debug
	is_calibrated = TRUE

/obj/item/autosurgeon/organ/nif/debug
	starting_organ = /obj/item/organ/internal/cyberimp/brain/nif/debug

#undef NIF_CALIBRATION_STAGE_1
#undef NIF_CALIBRATION_STAGE_1_END
#undef NIF_CALIBRATION_STAGE_2
#undef NIF_CALIBRATION_STAGE_2_END
#undef NIF_CALIBRATION_STAGE_FINISHED
