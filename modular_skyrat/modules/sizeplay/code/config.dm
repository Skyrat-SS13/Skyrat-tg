/datum/config_entry/number/body_size_sizegun_max
	integer = FALSE
	config_entry_value = 2
	min_val = 0.1

/datum/config_entry/number/body_size_sizegun_min
	integer = FALSE
	config_entry_value = 0.5
	min_val = 0.1

/datum/config_entry/flag/mob_pickup
	config_entry_value = FALSE

/datum/config_entry/number/mob_pickup_relative_size
	integer = FALSE
	config_entry_value = 2.5
	min_val = 1

/datum/config_entry/flag/mob_step_on
	config_entry_value = FALSE

/datum/config_entry/number/mob_step_on_relative_size
	integer = FALSE
	config_entry_value = 2.5
	min_val = 1

/datum/config_entry/number/body_size_slowdown_start
	integer = FALSE
	config_entry_value = 0
	max_val = 1
	min_val = 0

/datum/config_entry/number/body_size_slowdown_factor
	integer = FALSE
	config_entry_value = 4
	max_val = 1
	min_val = 0.1

//For everything we want exempt from the sizeguns, stepping-on, picking up and so on.
GLOBAL_LIST_INIT(mob_type_sizeplay_blacklist, typecacheof(list(
																/mob/living/simple_animal/hostile,
																/mob/living/simple_animal/bot,
																/mob/living/carbon/alien,
																/mob/living/silicon
																)))
