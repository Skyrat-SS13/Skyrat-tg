/obj/item/disk/nifsoft_uploader/soulcatcher
	name = "Soulcatcher"
	loaded_nifsoft = /datum/nifsoft/soulcatcher

/datum/nifsoft/soulcatcher
	name = "Soulcatcher"
	program_desc = "The 'Soulcatcher' coreware is a near-complete upgrade of the nanomachine systems in a NIF, meant for one purpose; supposedly, channeling the dead. This upgrade, in truth, functions as a Resonance Simulation Device; an RSD for short, an instrument capable of hosting someone's consciousness, context or otherwise.\n\n'Resonance,' a term for consciousness independent of any one specific body, was discovered in the early 2500s by researchers Yun-Seo Jin and Kamakshi Padmanabhan, coining what is now called 'Jin-Padmanabhan Resonance,' or 'JP/Soul Resonance.' This 'resonance' is a byproduct of neural activity that gives a sophont its consciousness, its sense of continuation, and their 'I am me.' It is, most notably, replicable.\n\nThe earliest RSDs were massive machines, drawing incredible power and utilizing bleeding-edge, clunky software to 'play' someone's Resonance at 1:1 accuracy with their original brain. However, two problems arose. One, Resonance is something that requires 'context;' the memories and associations and identity essentially etched into the nerves or hardware of an organic or synthetic being respectively, the consciousness otherwise having no sense of memory or self. At first, complete deepscans of the brain were needed. Two, outside of strange cases; primarily those concerning synthetics, slimes, and other gestalt consciousnesses, it is extremely difficult to have a person's Resonance 'playing' on multiple 'instruments' at once.\n\nThe first portable RSD, or Soulcatcher, was developed by the Spider Clan. These were initially designed for the captive interrogation of a person's consciousness without having to worry about the struggling of their body, and for dead or aging members of the mysterious group of orbital shinobi to be able to guide field operatives. These Soulcatchers are the main instrument to play Resonance, but recent advances in medical science have been leading to more.\n \nOccasionally, it is known for unusual sources of 'wild' Resonance, called Phantoms or Engrams, to end up inside of the nearest Soulcatcher, a key finding its own lock; thought to be the dead's last hurrah, though known to often be the result of well-tangled, anomalous software quirks still being investigated. Much as how some people intentionally become stable Engrams to achieve digital immortality, such as the witches of the Altspace Coven, it is possible for others to become wild Phantoms by hacking their way into a person's Soulcatcher remotely."
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
