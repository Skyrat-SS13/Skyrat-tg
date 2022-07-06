/// This is the original NIF that other NIFs are based on.
/obj/item/organ/cyberimp/brain/nif
	name = "Nanite Implant Frameworkk"
	desc = "a brain implant that infuses the user with nanites" //Coder-lore. Change this later
	w_class = WEIGHT_CLASS_NORMAL
	actions_types = list(/datum/action/item_action/nif/open_menu)

	//User Variables
	///What user is currently linked with the NIF?
	var/mob/living/carbon/human/linked_mob
	///What access does the user have? This is used for role restricted NIFSofts.
	var/list/user_access_list = list()

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
	var/nutrition_conversion_rate = 1
	///What is the minimum nutrition someone has to be at for the NIF to convert power?
	var/minimum_nutrition = 25

	///Is power being drawn through blood/electricty?
	var/blood_drain = FALSE

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
	var/nif_persistence

	//Software Variables
	///How many programs can the NIF store at once?
	var/max_nifsofts = 5
	///What types of programs are the NIF compatible with?
	var/list/program_compatibilty = list()
	///What programs are currently loaded onto the NIF?
	var/list/loaded_programs = list()
	///WHat programs come already installed on the NIF?
	var/list/preinstalled_programs = list()
	///This shows up in the NIF settings screen, it servers as a way to ICly display lore.
	var/manufacturer_notes = "There is no data currently avalible for this product"

/obj/item/organ/cyberimp/brain/nif/Initialize(mapload)
	. = ..()
	power_level = max_power

/obj/item/organ/cyberimp/brain/nif/Insert(mob/living/carbon/insertee)
	. = ..()
	linked_mob = insertee
	loc = insertee // This needs to be done, otherwise TGUI will not pull up.
	START_PROCESSING(SSobj, src)

/obj/item/organ/cyberimp/brain/nif/Remove(mob/living/carbon/removee)
	. = ..()
	linked_mob = null //This is going to need to be changed later on.
	STOP_PROCESSING(SSobj, src)

/obj/item/organ/cyberimp/brain/nif/process(delta_time)
	. = ..()

	if(!linked_mob)
		return FALSE
	if(IS_IN_STASIS(linked_mob))
		return

	if((linked_mob.nutrition < minimum_nutrition) && (nutrition_drain)) //Turns nutrition drain off if nutrition is lower than minimum
		toggle_nutrition_drain(TRUE)

	power_level += -power_usage
	if(power_level > max_power)
		power_level = max_power //No Overcharging

/// Subtracts from the power level of the NIF once, this is good for anything that is single use.
/obj/item/organ/cyberimp/brain/nif/proc/use_power(power_to_use)
	power_level = power_level - power_to_use

///Toggles nutrition drain as a power source on NIFs on/off
/obj/item/organ/cyberimp/brain/nif/proc/toggle_nutrition_drain(bypass = FALSE)
	if(!nutrition_check() && !bypass)
		return FALSE

	var/hunger_modifier = linked_mob.physiology.hunger_mod

	if(nutrition_drain)
		hunger_modifier = nutrition_drain_rate
		power_usage += (nutrition_drain_rate * nutrition_conversion_rate)
		nutrition_drain = FALSE
		return TRUE

	hunger_modifier *= nutrition_drain_rate
	power_usage += -(nutrition_drain_rate * nutrition_conversion_rate)
	nutrition_drain = TRUE

/// Checks to see if the mob has a nutrition that can be drain from
/obj/item/organ/cyberimp/brain/nif/proc/nutrition_check() //This is a seperate proc so that TGUI can preform this check on the menu
	if(!linked_mob || !linked_mob.nutrition)
		return FALSE

	if(isrobotic(linked_mob))
		return FALSE

	if(HAS_TRAIT(linked_mob, TRAIT_NOHUNGER)) //Hemophages HATE this one simple check.
		return FALSE

	if((linked_mob.nutrition < minimum_nutrition)) //No reason why you should be able to turn this on without power
		return FALSE

	return TRUE

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

/mob/living/carbon/human/examine(mob/user)
	. = ..()

	if(nif_examine_text)
		. += nif_examine_text

//NIF autosurgeon. This is just here so that I can debug faster.
/obj/item/autosurgeon/organ/nif
	starting_organ = /obj/item/organ/cyberimp/brain/nif
