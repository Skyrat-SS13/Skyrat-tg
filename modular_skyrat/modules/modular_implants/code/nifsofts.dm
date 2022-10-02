///The base NIF program
/datum/nifsoft
	///What is the name of the program?
	var/name = "Generic NIFsoft"
	///A description of what the program does. This is used when looking at programs in the NIF, along with installing them from the store.
	var/program_desc = "This program does stuff!"
	///How much does the program cost to buy?
	var/cost = 100
	//What NIF does this program belong to?
	var/datum/weakref/parent_nif
	///Who is the NIF currently linked to?
	var/mob/living/carbon/human/linked_mob

	///Does the program have an active mode?
	var/active_mode = FALSE
	///Is the program active?
	var/active = FALSE
	///Does the what power cost does the program have while active?
	var/active_cost = 0
	///What is the power cost to activate the program?
	var/activation_cost = 0
	///Does the NIFSoft persist inbetween rounds?
	var/persistence = FALSE
	///Does the NIFSoft have cooldowns
	var/cooldown = FALSE
	///Is the NIFSoft on cooldown?
	var/on_cooldown = FALSE
	///How long is the cooldown for?
	var/cooldown_duration = 5 SECONDS
	///What NIF models can this software be installed on?
	var/static/list/compatible_nifs = list(/obj/item/organ/internal/cyberimp/brain/nif)

/datum/nifsoft/New(obj/item/organ/internal/cyberimp/brain/nif/recepient_nif)
	. = ..()

	if(!recepient_nif.install_nifsoft(src))
		qdel(src)

/datum/nifsoft/Destroy()
	if(active)
		activate()

	if(!parent_nif)
		return ..()

	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif
	installed_nif.loaded_nifsofts.Remove(src)
	parent_nif = null

	..()

///This proc is called every life cycle on the attached human
/datum/nifsoft/proc/life(mob/living/carbon/human/attached_human)
	return TRUE

/// Activates a NIFSoft, have this called after the child NIFSoft has successfully ran
/datum/nifsoft/proc/activate()
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif

	if(cooldown && on_cooldown)
		to_chat(installed_nif.linked_mob, span_warning("The [src.name] is currently on cooldown"))

	if(active)
		active = FALSE
		to_chat(installed_nif.linked_mob, span_notice("The [src.name] is no longer running"))
		installed_nif.power_usage -= active_cost
		return TRUE

	if(!installed_nif.use_power(activation_cost))
		return FALSE

	if(active_mode)
		to_chat(installed_nif.linked_mob, span_notice("The [src.name] is now running"))
		installed_nif.power_usage += active_cost
		active = TRUE

	if(cooldown)
		addtimer(CALLBACK(src, .proc/remove_cooldown), cooldown_duration)
		on_cooldown = TRUE

/// Removes the cooldown from a NIFSoft
/datum/nifsoft/proc/remove_cooldown()
	on_cooldown = FALSE

/// Checks to see if a NIFSoft can be activated or not.
/datum/nifsoft/proc/activation_check(obj/item/organ/internal/cyberimp/brain/nif/installed_nif)
	if(!installed_nif || !installed_nif.linked_mob)
		return FALSE

	if(on_cooldown && cooldown)
		to_chat(installed_nif.linked_mob, span_warning("The [src.name] is currently on cooldown"))
		return FALSE

	if(activation_cost > installed_nif.power_level)
		to_chat(installed_nif.linked_mob, span_warning("The [installed_nif] does not have enough power to run this program"))
		return FALSE

	return TRUE

/// A disk that can upload NIFSofts to a recpient with a NIFSoft installed.
/obj/item/disk/nifsoft_uploader
	name = "Generic NIFSoft datadisk"
	desc = "A datadisk that can be used to upload a loaded NIFSoft to the user's NIF"
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/disks.dmi'
	icon_state = "base_disk"
	///What NIFSoft is currently loaded in?
	var/datum/nifsoft/loaded_nifsoft = /datum/nifsoft
	///Is the datadisk reusable?
	var/reusable = TRUE

/obj/item/disk/nifsoft_uploader/Initialize()
	. = ..()

	if(name == "Generic NIFSoft datadisk")
		name = "[initial(loaded_nifsoft.name)] datadisk"

/// Attempts to install the NIFSoft on the disk to the target
/obj/item/disk/nifsoft_uploader/proc/attempt_software_install(mob/living/carbon/human/target)
	if(!ishuman(target) || !target.installed_nif)
		return FALSE

	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = target.installed_nif
	new loaded_nifsoft(installed_nif)

	if(!reusable)
		to_chat(target, span_notice("Test message"))
		qdel(src)

/obj/item/disk/nifsoft_uploader/attack_self(mob/user, modifiers)
	. = ..()
	attempt_software_install(user)

/obj/item/disk/nifsoft_uploader/attack(mob/living/mob, mob/living/user, params)
	. = ..()
	attempt_software_install(mob)
