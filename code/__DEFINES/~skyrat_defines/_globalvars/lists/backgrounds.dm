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

/// A list of jobs that are sensitive. Read: Sec and heads, along with a few other roles that are really "important".
GLOBAL_LIST_EMPTY(sensitive_jobs)

/// A list of feature names to associative lists. Used inside the prefs menu.
GLOBAL_LIST_EMPTY(background_features)
