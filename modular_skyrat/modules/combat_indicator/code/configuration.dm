//Loads the combat indicator time as a global variable to avoid excessive CONFIG_GET()
/datum/controller/configuration/proc/LoadCombatIndicator()
	GLOB.combat_indicator_time = Get(/datum/config_entry/number/combat_indicator_time)
