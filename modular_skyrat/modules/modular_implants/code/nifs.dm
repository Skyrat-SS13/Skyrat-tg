/// This is the original NIF that other NIFs are based on.
/obj/item/organ/internal/cyberimp/brain/nif
	name = "Nanite Implant Framework"
	desc = "a brain implant that infuses the user with nanites" //Coder-lore. Change this later
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
	///What access does the user have? This is used for role restricted NIFSofts.
	var/list/user_access_list = list()
	///Is the NIF properly calibrated yet? This is set at true for testing purposes
	var/is_calibrated = TRUE

	//Power Variables
	///What is the maximum power level of the NIF?
	var/max_power = 1000
	///How much power is currently inside of the NIF?
	var/power_level
	///How much power is the NIF currently using? Negative usage will result in power being gained.
	var/power_usage = 0

	///Is power being drawn from nutrition?
	var/nutrition_drain = FALSE
	///How fast is nutrition drained from the host?
	var/nutrition_drain_rate = 1.5
	///What is the rate of nutrition to power?
	var/nutrition_conversion_rate = 5
	///What is the minimum nutrition someone has to be at for the NIF to convert power?
	var/minimum_nutrition = 25

	///Is power being drawn through blood
	var/blood_drain = FALSE
	///The rate of blood to energy
	var/blood_conversion_rate = 5 //From full blood, this would get someone to 500 charge
	///How fast is blood being drained?
	var/blood_drain_rate = 1
	///When is blood draining disabled?
	var/minimum_blood_level = BLOOD_VOLUME_SAFE

	///Is power being drawn through the user's power supply?
	var/electric_drain = FALSE

	//Durability and persistence variables
	///What is the maximum durability of the NIF?
	var/max_durability = 100
	///What level of durability is the NIF at?
	var/durability = 100
	///How much durability is subtracted per shift?
	var/shift_durability_loss = 20
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

	//Software Variables
	///How many programs can the NIF store at once?
	var/max_nifsofts = 5
	///What programs are currently loaded onto the NIF?
	var/list/loaded_nifsofts = list()
	///What programs come already installed on the NIF?
	var/list/preinstalled_nifsofts = list()
	///This shows up in the NIF settings screen as a way to ICly display lore.
	var/manufacturer_notes = "There is no data currently avalible for this product"

/obj/item/organ/internal/cyberimp/brain/nif/Initialize(mapload)
	. = ..()

	durability = max_durability
	loaded_nifsofts = preinstalled_nifsofts

	power_level = max_power

/obj/item/organ/internal/cyberimp/brain/nif/Insert(mob/living/carbon/human/insertee)
	. = ..()

	if(linked_mob && stored_ckey != insertee.ckey && theft_protection)
		insertee.audible_message(span_warning("The [src] lets out a negative buzz before forcefully removing itself from [insertee]'s brain."))
		playsound(insertee, 'sound/machines/buzz-sigh.ogg', 30, TRUE)
		src.Remove(insertee)
		src.forceMove(get_turf(insertee))

		return FALSE


	linked_mob = insertee
	stored_ckey = linked_mob.ckey

	loc = insertee // This needs to be done, otherwise TGUI will not pull up.
	insertee.installed_nif = src
	START_PROCESSING(SSobj, src)

/obj/item/organ/internal/cyberimp/brain/nif/Remove(mob/living/carbon/organ_owner, special=FALSE)
	. = ..()

	STOP_PROCESSING(SSobj, src)

/obj/item/organ/internal/cyberimp/brain/nif/process(delta_time)
	. = ..()

	if(!linked_mob || broken)
		return FALSE

	if(IS_IN_STASIS(linked_mob))
		return

	if((linked_mob.nutrition < minimum_nutrition) && (nutrition_drain)) //Turns nutrition drain off if nutrition is lower than minimum
		toggle_nutrition_drain(TRUE)

	if(blood_drain && (!blood_check())) //Disables blood draining if the mob fails the blood check
		toggle_blood_drain(TRUE)

	if(blood_drain)
		linked_mob.blood_volume -= blood_drain_rate

	if(power_usage > power_level)
		for(var/datum/nifsoft/nifsoft as anything in loaded_nifsofts)
			if(!nifsoft.active)
				continue

			nifsoft.activate()

	power_level += -power_usage
	if(power_level > max_power)
		power_level = max_power //No Overcharging

/obj/item/organ/internal/cyberimp/brain/nif/Destroy()
	linked_mob.nif_examine_text = null
	linked_mob = null

	QDEL_LIST(loaded_nifsofts)
	return ..()

/// Subtracts from the power level of the NIF once, this is good for anything that is single use.
/obj/item/organ/internal/cyberimp/brain/nif/proc/use_power(power_to_use)
	if(power_level < power_to_use)
		return FALSE

	power_level -= power_to_use
	return TRUE

///Toggles nutrition drain as a power source on NIFs on/off
/obj/item/organ/internal/cyberimp/brain/nif/proc/toggle_nutrition_drain(bypass = FALSE)
	if(!nutrition_check() && !bypass)
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
/obj/item/organ/internal/cyberimp/brain/nif/proc/nutrition_check() //This is a seperate proc so that TGUI can preform this check on the menu
	if(!linked_mob || !linked_mob.nutrition)
		return FALSE

	if(isrobotic(linked_mob))
		return FALSE

	if(HAS_TRAIT(linked_mob, TRAIT_NOHUNGER)) //Hemophages HATE this one simple check.
		return FALSE

	if((linked_mob.nutrition < minimum_nutrition)) //No reason why you should be able to turn this on without power
		return FALSE

	return TRUE

///Toggles Blood Drain
/obj/item/organ/internal/cyberimp/brain/nif/proc/toggle_blood_drain(bypass = FALSE)
	if(!blood_check() || bypass)
		return

	if(blood_drain)
		blood_drain = FALSE
		power_usage += (blood_drain_rate * blood_conversion_rate)

		to_chat(linked_mob, span_notice("Blood draining is now disabled"))
		return

	blood_drain = TRUE
	power_usage -= (blood_drain_rate * blood_conversion_rate)

	to_chat(linked_mob, span_notice("Blood draining is now enabled."))

///Can we take blood from the mob?
/obj/item/organ/internal/cyberimp/brain/nif/proc/blood_check()
	if(!linked_mob || !linked_mob.blood_volume)
		return FALSE

	if(linked_mob.blood_volume < minimum_blood_level)
		return FALSE

	return TRUE
///This is run whenever a nifsoft is installed
/obj/item/organ/internal/cyberimp/brain/nif/proc/install_nifsoft(datum/nifsoft/loaded_nifsoft)
	if(broken) //NIFSofts can't be installed to a broken NIF
		return FALSE

	if((length(loaded_nifsofts) >= max_nifsofts))
		return FALSE

	if(!is_type_in_list(src, loaded_nifsoft.compatible_nifs))
		return FALSE

	loaded_nifsofts += loaded_nifsoft
	loaded_nifsoft.parent_nif = src
	loaded_nifsoft.linked_mob = linked_mob

	to_chat(linked_mob, span_notice("[loaded_nifsoft.name] has been added"))
	return TRUE

/obj/item/organ/internal/cyberimp/brain/nif/proc/remove_nifsoft(datum/nifsoft/removed_nifsoft, silent = FALSE)
	if(!is_type_in_list(removed_nifsoft, loaded_nifsofts) || broken)
		return FALSE

	if(!silent)
		to_chat(linked_mob, span_notice("[removed_nifsoft.name] has been removed."))

	qdel(removed_nifsoft)
	return TRUE

/obj/item/organ/internal/cyberimp/brain/nif/proc/repair_nif(repair_amount)
	if(durability == max_durability)
		return FALSE

	durability += repair_amount
	if(durability > max_durability)
		durability = max_durability

	return TRUE

/obj/item/organ/internal/cyberimp/brain/nif/attack_self(mob/user, modifiers)
	return FALSE

// Action used to pull up the NIF menu
/datum/action/item_action/nif
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	icon_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/nif/open_menu
	name = "Open NIF Menu"
	button_icon_state = "weapon" // This is a placeholder

/datum/action/item_action/nif/open_menu/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return

	var/datum/action/item_action/nif/bridge = target
	bridge.ui_interact(usr)

/mob/living/carbon/human
	///What text is shown upon examining a human with a NIF?
	var/nif_examine_text
	//What, if any NIF is currently installed inside of the mob?
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif

/mob/living/carbon/human/examine(mob/user)
	. = ..()

	if(nif_examine_text)
		. += nif_examine_text

///Looks through the human's NIFSoft to find a nifsoft.
/mob/living/carbon/human/proc/find_nifsoft(nifsoft_to_find)
	var/list/nifsoft_list = installed_nif?.loaded_nifsofts
	if(!nifsoft_list)
		return FALSE

	for(var/datum/nifsoft/nifsoft as anything in nifsoft_list)
		if(nifsoft.type == nifsoft_to_find)
			return nifsoft

///NIFSoft Remover. This is mostly here so that security and antags have a way to remove NIFSofts from someome
/obj/item/nifsoft_remover
	name = "NIFSoft Remover"
	desc = "Removes a NIFSoft from someone." //Placeholder Description and name

/obj/item/nifsoft_remover/attack(mob/living/carbon/human/target_mob, mob/living/user)
	. = ..()
	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = target_mob.installed_nif

	if(!target_nif || !length(target_nif.loaded_nifsofts))
		to_chat(user, span_warning("[user] does not posses a NIF with any installed NIFSofts"))
		return

	var/list/installed_nifsofts = target_nif.loaded_nifsofts
	var/datum/nifsoft/nifsoft_to_remove = tgui_input_list(user, "Chose a NIFSoft to remove", "[src]", installed_nifsofts)

	if(!nifsoft_to_remove)
		return FALSE

	user.visible_message(span_warning("[user] starts to use the [src] on [target_mob]"), span_notice("You start to use the [src] on [target_mob]"))
	if(!do_after(user, 5 SECONDS, target_mob))
		return FALSE

	if(!target_nif.remove_nifsoft(nifsoft_to_remove))
		return FALSE

	to_chat(user, span_notice("You successfully remove the NIFSoft"))

///NIF Repair Kit.
/obj/item/nif_repair_kit
	name = "NIF repair kit"
	desc = "Repairs NIFs" //Placeholder
	icon = 'icons/obj/storage/storage.dmi'
	icon_state = "plasticbox"
	w_class = WEIGHT_CLASS_SMALL
	///How much does this repair each time it is used?
	var/repair_amount = 20
	///How many times can this be used?
	var/uses = 5

/obj/item/nif_repair_kit/attack(mob/living/carbon/human/mob_to_repair, mob/living/user)
	. = ..()
	if(!mob_to_repair.installed_nif)
		to_chat(user, span_warning("[mob_to_repair] lacks a NIF"))

	if(!do_after(user, 5 SECONDS, mob_to_repair))
		return FALSE

	if(!mob_to_repair.installed_nif.repair_nif(repair_amount))
		to_chat(user, span_warning("The NIF you are trying to repair is already at max durbility"))
		return FALSE

	to_chat(user, span_notice("You successfully repair [mob_to_repair]'s NIF"))
	to_chat(mob_to_repair, span_notice("[user] successfully repairs your NIF"))

	--uses
	if(!uses)
		qdel(src)

//NIF autosurgeon. This is just here so that I can debug faster.
/obj/item/autosurgeon/organ/nif
	starting_organ = /obj/item/organ/internal/cyberimp/brain/nif
