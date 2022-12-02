/**
 * Background Information. This should never be used inside code outside of declaring new background types.
 */
/datum/background_info
	/// Name of the background entry, be it origin, social background, or employment
	var/name
	/// A brief summary of what the background entry is about. 1000 characters at **absolute maximum**.
	var/description
	/// Economic power, this impacts the initial paychecks by a bit. Averaged between the three background entries when applied to gameplay.
	var/economic_power = 1
	/// It'll force people to know this language if they've picked this background entry. They will get these cheaper.
	var/datum/language/required_lang
	/// This will allow people to pick certain languages cheaper.
	var/list/additional_langs = list()
	/// The gameplay features of this background.
	var/list/features = list()
	/// Groups the background belongs to. Restricts what kind of other background entries can be picked.
	var/groups = BACKGROUNDS_ALL
	/// If the background should be veteran only or not.
	var/veteran = FALSE
	/// The roles allowed to be played as by this background. Uses job datums and ghost_role spawners. If null, it doesn't impose restrictions.
	/// Behaviour is inverted if `invert_roles` is `TRUE`.
	var/list/roles
	/// Decides the role filtering of `roles`.
	var/false_if_in_roles = FALSE
	/// Should this be hidden from the passport editor, and other "IC" interactions.
	var/hidden_from_characters = FALSE

/// A simple check that verifies if a role is valid for a given background. Do not override unless you're doing some very special logic.
/datum/background_info/proc/is_role_valid(datum/role)
	if(!roles)
		return TRUE

	if(role.type in roles)
		return !false_if_in_roles

	return false_if_in_roles
