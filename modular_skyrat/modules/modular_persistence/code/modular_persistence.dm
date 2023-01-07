/// A list of vars that shouldn't be tracked by persistence.
GLOBAL_LIST_INIT(modular_persistence_ignored_vars, list(
	"datum_flags",
	"datum_components",
	"comp_lookup",
	"tgui_shared_states",
	"gc_destroyed",
	"active_timers",
	"status_traits",
	"signal_procs",
	"cached_ref",
	"weak_reference",
	"cooldowns",
	"__auxtools_weakref_id",
	"tag",
	"type",
	"parent_type",
	"owner",
	"vars",
	"stored_character_slot_index",
))

/// Saves the contents of the modular persistence datum for the player's client to their file.
/datum/controller/subsystem/persistence/proc/save_modular_persistence()
	for(var/mob/living/carbon/human/player as anything in GLOB.human_list)
		if(!ishuman(player) || !player.client?.prefs)
			continue

		if(!player.client.prefs.modular_persistence)
			stack_trace("[player] doesn't have a modular_persistence variable in their prefs datum")
			continue

		var/json_file = file("data/player_saves/[player.client.ckey[1]]/[player.client.ckey]/modular_persistence.json")
		var/list/json = fexists(json_file) ? json_decode(file2text(json_file)) : list()
		fdel(json_file)

		if(!islist(json))
			json = list()

		json["[player.client.prefs.modular_persistence.stored_character_slot_index]"] = player.client.prefs.modular_persistence.serialize_contents_to_list()
		WRITE_FILE(json_file, json_encode(json))

/// Saves the contents of the modular persistence datum for the player's client to their file.
/datum/controller/subsystem/persistence/proc/load_modular_persistence(mob/living/carbon/human/player)
	if(!ishuman(player) || !player.client?.prefs)
		return FALSE

	var/json_file = file("data/player_saves/[player.client.ckey[1]]/[player.client.ckey]/modular_persistence.json")
	var/list/json = fexists(json_file) ? json_decode(file2text(json_file)) : null

	player.client.prefs.modular_persistence = new(player, islist(json) ? json["[player.mind.original_character_slot_index]"] : null)

/// The master persistence datum. Add vars onto this in your own code. Just be aware that you'll need to use simple data types, such as strings, ints, and lists.
/datum/modular_persistence
	/// The human that this is attached to.
	var/mob/living/carbon/human/owner
	/// The owner's character slot index.
	var/stored_character_slot_index

/datum/modular_persistence/New(mob/living/carbon/human/player, list/persistence_data)
	owner = player
	. = ..()

	stored_character_slot_index = player.mind?.original_character_slot_index

	if(!persistence_data)
		return

	for(var/var_name in vars)
		var/var_entry = persistence_data[var_name]

		if(var_entry)
			vars[var_name] = var_entry

	owner.load_nif_data(src)

// On a base datum, this should be empty, at a glance.
/datum/modular_persistence/proc/serialize_contents_to_list()
	var/list/returned_list = list()

	owner.save_nif_data(src)

	for(var/var_name in vars)
		if(var_name in GLOB.modular_persistence_ignored_vars)
			continue

		var/var_entry = vars[var_name]

		if(!isnull(var_entry))
			returned_list[var_name] = var_entry

	return returned_list

/// This is an individual verison of the save_modular_persistence proc, only saving the persistence for the owner.
/mob/living/carbon/human/proc/save_individual_persistence()
	if(!client?.prefs)
		return FALSE

	var/json_file = file("data/player_saves/[client.ckey[1]]/[client.ckey]/modular_persistence.json")
	var/list/json = fexists(json_file) ? json_decode(file2text(json_file)) : list()
	fdel(json_file)

	if(!islist(json))
		json = list()

	json["[client.prefs.modular_persistence.stored_character_slot_index]"] = client.prefs.modular_persistence.serialize_contents_to_list()
	WRITE_FILE(json_file, json_encode(json))
