#define DEFAULT_NIFSOFT_COOLDOWN 5 SECONDS

///The base NIFSoft
/datum/nifsoft
	///What is the name of the NIFSoft?
	var/name = "Generic NIFsoft"
	///What is the name of the program when looking at the program from inside of a NIF? This is good if you want to mask a NIFSoft's name.
	var/program_name
	///A description of what the program does. This is used when looking at programs in the NIF, along with installing them from the store.
	var/program_desc = "This program does stuff!"
	//What NIF does this program belong to?
	var/datum/weakref/parent_nif
	///Who is the NIF currently linked to?
	var/mob/living/carbon/human/linked_mob
	///How much does the program cost to buy in credits?
	var/purchase_price = 300
	///What catagory is the NIFSoft under?
	var/buying_category = NIFSOFT_CATEGORY_GENERAL
	///What font awesome icon is shown next to the name of the nifsoft?
	var/ui_icon = "floppy-disk"
	///What UI theme do we want to display to users if this NIFSoft has TGUI?
	var/ui_theme = "default"

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
	///Does the NIFSoft have a cooldown?
	var/cooldown = FALSE
	///Is the NIFSoft currently on cooldown?
	var/on_cooldown = FALSE
	///How long is the cooldown for?
	var/cooldown_duration = DEFAULT_NIFSOFT_COOLDOWN
	///What NIF models can this software be installed on?
	var/list/compatible_nifs = list(/obj/item/organ/internal/cyberimp/brain/nif)

	/// How much of the NIFSoft's purchase price is paid out as reward points, if any?
	var/rewards_points_rate = 0.5
	/// Can this item be purchased with reward points?
	var/rewards_points_eligible = TRUE
	///Does the NIFSoft have anything that is saved cross-round?
	var/persistence = FALSE
	/// Is the NIFSoft something that we want to allow the user to keep?
	var/able_to_keep = FALSE
	/// Are we keeping the NIFSoft installed between rounds? This is decided by the user
	var/keep_installed = FALSE
	///Is it a lewd item?
	var/lewd_nifsoft = FALSE

/datum/nifsoft/New(obj/item/organ/internal/cyberimp/brain/nif/recepient_nif, no_rewards_points = FALSE)
	. = ..()

	if(no_rewards_points) //This is mostly so that credits can't be farmed through printed or stolen NIFSoft disks
		rewards_points_rate = 0

	compatible_nifs += /obj/item/organ/internal/cyberimp/brain/nif/debug
	program_name = name

	if(!recepient_nif.install_nifsoft(src))
		qdel(src)

	load_persistence_data()
	update_theme()

/datum/nifsoft/Destroy()
	if(active)
		activate()

	linked_mob = null

	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif?.resolve()
	if(installed_nif)
		installed_nif.loaded_nifsofts.Remove(src)

	return ..()

/// Activates the parent NIFSoft
/datum/nifsoft/proc/activate()
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif?.resolve()

	if(!installed_nif)
		stack_trace("NIFSoft [src] activated on a null parent!") // NIFSoft is -really- broken
		return FALSE

	if(installed_nif.broken)
		installed_nif.balloon_alert(installed_nif.linked_mob, "your NIF is broken")
		return FALSE

	if(cooldown && on_cooldown)
		installed_nif.balloon_alert(installed_nif.linked_mob, "[src.name] is currently on cooldown.")
		return FALSE

	if(active)
		active = FALSE
		installed_nif.balloon_alert(installed_nif.linked_mob, "[src.name] is no longer running")
		installed_nif.power_usage -= active_cost
		return TRUE

	if(!installed_nif.change_power_level(activation_cost))
		return FALSE

	if(active_mode)
		installed_nif.balloon_alert(installed_nif.linked_mob, "[src.name] is now running")
		installed_nif.power_usage += active_cost
		active = TRUE

	if(cooldown)
		addtimer(CALLBACK(src, PROC_REF(remove_cooldown)), cooldown_duration)
		on_cooldown = TRUE

	return TRUE

///Refunds the activation cost of a NIFSoft.
/datum/nifsoft/proc/refund_activation_cost()
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = parent_nif?.resolve()
	if(!installed_nif)
		return
	installed_nif.change_power_level(-activation_cost)

///Removes the cooldown from a NIFSoft
/datum/nifsoft/proc/remove_cooldown()
	on_cooldown = FALSE

///Restores the name of the NIFSoft to default.
/datum/nifsoft/proc/restore_name()
	program_name = initial(name)

///How does the NIFSoft react if the user is EMP'ed?
/datum/nifsoft/proc/on_emp(emp_severity)
	if(active)
		activate()

	var/list/random_characters = list("#","!","%","^","*","$","@","^","A","b","c","D","F","W","H","Y","z","U","O","o")
	var/scrambled_name = "!"

	for(var/i in 1 to length(program_name))
		scrambled_name += pick(random_characters)

	program_name = scrambled_name
	addtimer(CALLBACK(src, PROC_REF(restore_name)), 60 SECONDS)

/datum/nifsoft/ui_state(mob/user)
	return GLOB.conscious_state

/// Updates the theme of the NIFSoft to match the parent NIF
/datum/nifsoft/proc/update_theme()
	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = parent_nif.resolve()
	if(!target_nif)
		return FALSE

	ui_theme = target_nif.current_theme
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

/obj/item/disk/nifsoft_uploader/Initialize(mapload)
	. = ..()

	if(CONFIG_GET(flag/disable_lewd_items) && initial(loaded_nifsoft.lewd_nifsoft))
		return INITIALIZE_HINT_QDEL

	name = "[initial(loaded_nifsoft.name)] datadisk"

/obj/item/disk/nifsoft_uploader/examine(mob/user)
	. = ..()

	var/nifsoft_desc = initial(loaded_nifsoft.program_desc)

	if(nifsoft_desc)
		. += span_cyan("Program description: [nifsoft_desc]")


/// Attempts to install the NIFSoft on the disk to the target
/obj/item/disk/nifsoft_uploader/proc/attempt_software_install(mob/living/carbon/human/target)
	var/obj/item/organ/internal/cyberimp/brain/nif/installed_nif = target.get_organ_by_type(/obj/item/organ/internal/cyberimp/brain/nif)

	if(!ishuman(target) || !installed_nif)
		return FALSE

	var/datum/nifsoft/installed_nifsoft = new loaded_nifsoft(installed_nif, TRUE)

	if(!installed_nifsoft.parent_nif)
		balloon_alert(target, "installation failed")
		return FALSE

	if(!reusable)
		qdel(src)

/obj/item/disk/nifsoft_uploader/attack_self(mob/user, modifiers)
	attempt_software_install(user)

/obj/item/disk/nifsoft_uploader/attack(mob/living/mob, mob/living/user, params)
	if(mob != user && !do_after(user, 5 SECONDS, mob))
		balloon_alert(user, "installation failed")
		return FALSE

	attempt_software_install(mob)

#undef DEFAULT_NIFSOFT_COOLDOWN
