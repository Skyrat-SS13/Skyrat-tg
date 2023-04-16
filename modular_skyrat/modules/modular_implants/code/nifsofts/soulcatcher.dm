/obj/item/disk/nifsoft_uploader/soulcatcher
	name = "Soulcatcher"
	loaded_nifsoft = /datum/nifsoft/soulcatcher

/datum/nifsoft/soulcatcher
	name = "Soulcatcher"
	program_desc = "Holds souls" // PLACEHOLDER
	purchase_price = 150 //RP tool
	persistence = TRUE
	/// What is the linked soulcatcher datum used by this NIFSoft?
	var/datum/component/soulcatcher/linked_soulcatcher
	/// What action to bring up the soulcatcher is linked with this NIFSoft?
	var/datum/action/innate/soulcatcher/soulcatcher_action
	/// a list containing saved soulcatcher rooms
	var/list/saved_soulcatcher_rooms = list()

/datum/nifsoft/soulcatcher/New()
	. = ..()
	soulcatcher_action = new
	soulcatcher_action.Grant(linked_mob)
	soulcatcher_action.parent_nifsoft = WEAKREF(src)

	var/obj/item/organ/internal/cyberimp/brain/nif/target_nif = parent_nif
	linked_soulcatcher = target_nif.AddComponent(/datum/component/soulcatcher)

	for(var/room in saved_soulcatcher_rooms)
		linked_soulcatcher.create_room(room, saved_soulcatcher_rooms[room])

	if(length(linked_soulcatcher.soulcatcher_rooms) > 1) //We don't need the default room anymore.
		linked_soulcatcher.soulcatcher_rooms -= linked_soulcatcher.soulcatcher_rooms[1]

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

/datum/nifsoft/soulcatcher/load_persistence_data()
	. = ..()
	var/datum/modular_persistence/persistence = .
	if(!persistence)
		return FALSE

	saved_soulcatcher_rooms = params2list(persistence.nif_soulcatcher_rooms)
	return TRUE

/datum/nifsoft/soulcatcher/save_persistence_data(datum/modular_persistence/persistence)
	. = ..()
	if(!.)
		return FALSE

	var/list/room_list = list()
	for(var/datum/soulcatcher_room/room in linked_soulcatcher.soulcatcher_rooms)
		room_list[room.name] = room.room_description

	persistence.nif_soulcatcher_rooms = list2params(room_list)
	return TRUE

/datum/modular_persistence
	///A param string containing soulcatcher rooms
	var/nif_soulcatcher_rooms = ""

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
