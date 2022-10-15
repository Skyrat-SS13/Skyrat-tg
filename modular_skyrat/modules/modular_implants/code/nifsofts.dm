///The base NIF program
/datum/nifsoft
	///What is the name of the program?
	var/name = "Generic NIFsoft"
	///What is the name of the program when looking at the program from inside of a NIF? This is good if you want to mask a NIFSoft's name.
	var/program_name
	///A description of what the program does. This is used when looking at programs in the NIF, along with installing them from the store.
	var/program_desc = "This program does stuff!"
	//What NIF does this program belong to?
	var/datum/weakref/parent_nif
	///Who is the NIF currently linked to?
	var/mob/living/carbon/human/linked_mob

	///Can the program be installed with other instances of itself?
	var/single_install = TRUE
	///Is the program mutually exclusive with another program?
	var/list/mutually_exclusive_programs = list()

	///Does the program have an active mode?
	var/active_mode = FALSE
	///Is the program active?
	var/active = FALSE
	///Does the what power cost does the program have while active?
	var/active_cost = 0
	///What is the power cost to activate the program?
	var/activation_cost = 0
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

	program_name = name

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
	var/reusable = FALSE

/obj/item/disk/nifsoft_uploader/Initialize()
	. = ..()

	if(name == "Generic NIFSoft datadisk")
		name = "[initial(loaded_nifsoft.name)] datadisk"

/// Attempts to install the NIFSoft on the disk to the target
/obj/item/disk/nifsoft_uploader/proc/attempt_software_install(mob/living/carbon/human/target)
	if(!ishuman(target) || !target.installed_nif)
		return FALSE

	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = target.installed_nif
	var/datum/nifsoft/installed_nifsoft = new loaded_nifsoft(installed_nif)

	if(!installed_nifsoft.parent_nif)
		return FALSE

	if(!reusable)
		qdel(src)

/obj/item/disk/nifsoft_uploader/attack_self(mob/user, modifiers)
	. = ..()
	attempt_software_install(user)

/obj/item/disk/nifsoft_uploader/attack(mob/living/mob, mob/living/user, params)
	. = ..()
	attempt_software_install(mob)

///NIFSoft Remover. This is mostly here so that security and antags have a way to remove NIFSofts from someome
/obj/item/nifsoft_remover
	name = "NIFSoft Remover"
	desc = "Removes a NIFSoft from someone." //Placeholder Description and name
	icon = 'modular_skyrat/modules/modular_implants/icons/obj/devices.dmi'
	icon_state = "nifsoft_remover"

	///Is a disk with the removed NIFSoft created?
	var/create_disk = FALSE

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

	to_chat(user, span_notice("You successfully remove the [nifsoft_to_remove.name]"))

	if(create_disk)
		var/obj/item/disk/nifsoft_uploader/new_disk = new /obj/item/disk/nifsoft_uploader
		new_disk.loaded_nifsoft = nifsoft_to_remove.type
		new_disk.name = "[nifsoft_to_remove.name] datadisk"

		user.put_in_hands(new_disk)

	return TRUE

/obj/item/nifsoft_remover/syndie
	name = "Syndicate NIFSoft Remover"
	desc = "A syndicate version of the standard NIFSoft remover"
	icon_state =  "nifsoft_remover_syndie"

	create_disk = TRUE
