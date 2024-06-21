/obj/item/disk/nifsoft_uploader/soulcatcher
	name = "Soulcatcher"
	loaded_nifsoft = /datum/nifsoft/soulcatcher

/datum/nifsoft/soulcatcher
	name = "Soulcatcher"
	program_desc = "The 'Soulcatcher' coreware is a near-complete upgrade of the nanomachine systems in a NIF, meant for one purpose; supposedly, channeling the dead. This upgrade, in truth, functions as a Resonance Simulation Device; an RSD for short, an instrument capable of hosting someone's consciousness, context or otherwise. 'Resonance', a term for the specific pattern of neural activity that gives way to someone's consciousness, was discovered in the early 2500s by researchers Yun-Seo Jin and Kamakshi Padmanabhan, coining what is now called 'Jin-Padmanabhan Resonance,' or 'JP/Soul Resonance.' This 'Resonance' gives off a sophont's consciousness, their sense of continuation, and their 'I am me.' This Resonance can vary in structure and 'strength' from person to person, and even change over someone's life. When the brain of a sophont undergoes death and stops neural activity, then Resonance dissipates entirely and lingering consciousness becomes essentially an echo, rapidly fading over time.\n\nThe earliest RSDs were massive machines, drawing incredible power and utilizing bleeding-edge, clunky software to 'play' someone's Resonance at 1:1 accuracy with their original brain. However, complications arose that are still being studied. Resonance is replicable and can be re-created artificially; however, like trying to duplicate genetic code, the capture needs to be extremely accurate, and rapidly put into place. Instruments such as RSDs are capable of picking up on lingering consciousness after the end of Resonance, and resuming it through artificial neural activity can give it strength to continue once more. RSDs such as Soulcatchers can only work at such a distance, otherwise running the risk of the Resonance essentially corrupting due to poor signal.\n\nIt is currently impossible to run Resonance in two places at once, because the same Resonance over two places experiences interference; like noise canceling headphones. Slimes and other gestalt consciousnesses can modulate their harmonics to a degree, bearing a partial disconnect and bringing themselves into constructive interference with similar harmonic signatures. A deepscan of the person's brain is necessary to give their consciousness 'context;' running their Resonance and capturing their consciousness alone results in a person with their same original intelligence, but zero memories or identity. These scans rapidly become outdated due to the growth of the brain, and it is prohibitively complex to store them in their entirety.\n\nThe first portable RSD, or Soulcatcher, was developed by the Spider Clan. These were initially designed for the captive interrogation of a person's consciousness without having to worry about the struggling of their body, and for dead or aging members of the mysterious group of orbital shinobi to be able to guide field operatives. These Soulcatchers are the main instrument to play Resonance, but recent advances in medical science have been leading to more. Occasionally, it is known for unusual sources of 'wild' Resonance, called Phantoms, to end up inside of the nearest Soulcatcher, a key finding its own lock; with a wide array of theories as to how these come into existence. Much as how some people intentionally become stable Engrams to achieve digital immortality, such as the witches of the Altspace Coven, it is possible for others to forcibly enter a Soulcatcher and act as a sort of Phantom by hacking their way in."
	purchase_price = 150 //RP tool
	persistence = TRUE
	able_to_keep = TRUE
	ui_icon = "ghost"

	/// What is the linked soulcatcher datum used by this NIFSoft?
	var/datum/weakref/linked_soulcatcher
	/// What action to bring up the soulcatcher is linked with this NIFSoft?
	var/datum/action/innate/soulcatcher/soulcatcher_action
	/// a list containing saved soulcatcher rooms
	var/list/saved_carrier_rooms = list()
	/// The item we are using to store the souls
	var/obj/item/carrier_holder/holder

/datum/nifsoft/soulcatcher/New()
	. = ..()
	soulcatcher_action = new(linked_mob)
	soulcatcher_action.Grant(linked_mob)
	soulcatcher_action.parent_nifsoft = WEAKREF(src)

	holder = new(linked_mob)
	var/datum/component/carrier/soulcatcher/new_soulcatcher = holder.AddComponent(/datum/component/carrier/soulcatcher/nifsoft)
	holder.name = "[linked_mob.name]'s soulcatcher"

	for(var/room in saved_carrier_rooms)
		new_soulcatcher.create_room(room, saved_carrier_rooms[room])

	if(length(new_soulcatcher.carrier_rooms) > 1) //We don't need the default room anymore.
		new_soulcatcher.carrier_rooms -= new_soulcatcher.carrier_rooms[1]

	new_soulcatcher.name = "[linked_mob]"

	RegisterSignal(new_soulcatcher, COMSIG_QDELETING, PROC_REF(no_soulcatcher_component))
	linked_soulcatcher = WEAKREF(new_soulcatcher)
	update_theme() // because we have to do this after the soulcatcher is linked

/datum/nifsoft/soulcatcher/activate()
	. = ..()
	if(!linked_soulcatcher)
		return FALSE

	var/datum/component/carrier/current_soulcatcher = linked_soulcatcher.resolve()
	if(!current_soulcatcher)
		return FALSE

	current_soulcatcher.ui_interact(linked_mob)
	return TRUE

/// If the linked soulcatcher is being deleted we want to set the current linked soulcatcher to `FALSE`
/datum/nifsoft/soulcatcher/proc/no_soulcatcher_component()
	SIGNAL_HANDLER

	linked_soulcatcher = null

/datum/nifsoft/soulcatcher/Destroy()
	if(soulcatcher_action)
		soulcatcher_action.Remove()
		qdel(soulcatcher_action)

	if(linked_soulcatcher)
		var/datum/component/carrier/current_soulcatcher = linked_soulcatcher.resolve()
		if(current_soulcatcher)
			qdel(current_soulcatcher)

	qdel(holder)

	return ..()

/datum/nifsoft/soulcatcher/load_persistence_data()
	. = ..()
	var/datum/modular_persistence/persistence = .
	if(!persistence)
		return FALSE

	saved_carrier_rooms = params2list(persistence.nif_carrier_rooms)
	return TRUE

/datum/nifsoft/soulcatcher/save_persistence_data(datum/modular_persistence/persistence)
	. = ..()
	if(!.)
		return FALSE

	var/list/room_list = list()
	var/datum/component/carrier/current_soulcatcher = linked_soulcatcher.resolve()
	for(var/datum/carrier_room/room in current_soulcatcher.carrier_rooms)
		room_list[room.name] = room.room_description

	persistence.nif_carrier_rooms = list2params(room_list)
	return TRUE

/datum/nifsoft/soulcatcher/update_theme()
	. = ..()
	if(!.)
		return FALSE // uhoh

	if(isnull(linked_soulcatcher))
		return FALSE

	var/datum/component/carrier/current_soulcatcher = linked_soulcatcher.resolve()
	if(!istype(current_soulcatcher))
		stack_trace("[src] ([REF(src)]) tried to update its theme when it was missing a linked_soulcatcher component!")
		return FALSE
	current_soulcatcher.ui_theme = ui_theme

/datum/modular_persistence
	///A param string containing soulcatcher rooms
	var/nif_carrier_rooms = ""

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

/// This is the object we use if we give a mob soulcatcher. Having the souls directly parented could cause issues.
/obj/item/carrier_holder
	name = "Soul Holder"
	desc = "You probably shouldn't be seeing this..."

