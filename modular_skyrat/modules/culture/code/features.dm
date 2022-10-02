/// Cosmetic for now, but will be used in future PRs to influence factions and events.
/datum/cultural_feature
	var/name
	/// A short-ish and to the point description of the feature.
	var/description
	/// The icon_state for the quick-preview icon of said feature.
	var/icon_state
	/// The path to the icon file.
	var/icon_path

/datum/cultural_feature/good
	name = "Good Wages"
	description = "You start with more money, and have better paychecks."
	icon_state = "spacecash10000"
	icon_path = "icons/obj/economy.dmi"

/datum/cultural_feature/poor
	name = "Poor Wages"
	description = "You start with less money, and have worse paychecks."
	icon_state = "spacecash10"
	icon_path = "icons/obj/economy.dmi"

/datum/cultural_feature/average
	name = "Average Wages"
	description = "You start with a normal amount of money, and have normal paychecks."
	icon_state = "spacecash100"
	icon_path = "icons/obj/economy.dmi"

/datum/cultural_feature/lavaland
	name = "Lavaland \"Native\""
	description = "You do not need money, and you instead have the blessing of the necropolis."
	icon_state = "talisman"
	icon_path = "icons/obj/lavaland/artefacts.dmi"
