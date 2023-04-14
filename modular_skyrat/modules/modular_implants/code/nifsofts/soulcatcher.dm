/obj/item/disk/nifsoft_uploader/soulcatcher
	name = "Soulcatcher"
	loaded_nifsoft = /datum/nifsoft/soulcatcher

/datum/nifsoft/soulcatcher
	name = "Soulcatcher"
	program_desc = "Holds souls"
	/// What is the linked soulcatcher datum used by this NIFSoft?
	var/datum/component/soulcatcher/linked_soulcatcher
	/// What action to bring up the soulcatcher is linked with this NIFSoft?
	var/datum/action/innate/soulcatcher/soulcatcher_action

/datum/nifsoft/soulcatcher/New()
	. = ..()
	soulcatcher_action = new
	soulcatcher_action.Grant(linked_mob)
	soulcatcher_action.parent_nifsoft = WEAKREF(src)

	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = parent_nif
	linked_soulcatcher = target_nif.AddComponent(/datum/component/soulcatcher)

/datum/nifsoft/soulcatcher/activate()
	. = ..()
	linked_soulcatcher.ui_interact(linked_mob)

/datum/nifsoft/soulcatcher/Destroy()
	if(soulcatcher_action)
		soulcatcher_action.Remove()
		qdel(soulcatcher_action)

	if(linked_soulcatcher)
		qdel(linked_soulcatcher)

	return ..()

/datum/action/innate/soulcatcher
	name = "Soulcatcher"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "soulcatcher"
	/// The weakref of the parent NIFSoft we belong to.
	var/datum/weakref/parent_nifsoft

/datum/action/innate/soulcatcher/Activate()
	. = ..()
	var/datum/nifsoft/soulcatcher/soulcatcher_nifsoft = parent_nifsoft.resolve()
	if(!soulcatcher_nifsoft)
		return FALSE

	soulcatcher_nifsoft.activate()
