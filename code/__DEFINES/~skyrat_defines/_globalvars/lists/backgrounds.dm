// DO NOT MODIFY ANY OF THESE LISTS BEYOND THEIR INIT IN `/proc/make_background_references`!! Shit WILL break.
// These are caches that are generated at round start to prevent excessive cycles being wasted for stuff that should never change.
// Path to instance.
GLOBAL_LIST_EMPTY(employments)
GLOBAL_LIST_EMPTY(social_backgrounds)
GLOBAL_LIST_EMPTY(origins)
// Name to instance
GLOBAL_LIST_EMPTY(employment_name_to_instance)
GLOBAL_LIST_EMPTY(social_background_name_to_instance)
GLOBAL_LIST_EMPTY(origin_name_to_instance)
// Just a flat list of names. Used in chameleon IDs.
GLOBAL_LIST_EMPTY(employment_names)
GLOBAL_LIST_EMPTY(social_background_names)
GLOBAL_LIST_EMPTY(origin_names)

/// A list of jobs that are command.
GLOBAL_LIST_EMPTY(command_jobs)

/// A list of feature names to associative lists. Used inside the prefs menu.
GLOBAL_LIST_EMPTY(background_features)
/// Valid list of passport types for use in chameleon IDs.
GLOBAL_LIST_EMPTY(valid_passport_disguises)
/// Similar to the _name lists, but unified and categorized. Used for the NTOS passport editor.
GLOBAL_LIST_EMPTY(passport_editor_tabs)

/// Cache for HoP crate goodies.
GLOBAL_LIST_EMPTY(hop_crate_goodies)
