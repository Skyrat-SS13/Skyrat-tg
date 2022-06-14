/*
*	Here be the hexadecimal color lists for the MODsuit tail sprites.
*	The list gets passed on to var/list/special_colour_list in species.dm, turned to RGB values, and overlayed onto the uncolored tailsprite in tails_modsuit.dmi
*/

/datum/mod_theme
	/// Tail colors for the tail overlay of the modsuit
	var/list/modsuit_tail_colors = list("#243A61", "#151515", "#585858")

/datum/mod_theme/engineering
	modsuit_tail_colors = list("#997744", "#AA6622", "#CC9955")

/datum/mod_theme/atmospheric
	modsuit_tail_colors = list("#997744", "#448877", "#449988")

/datum/mod_theme/advanced
	modsuit_tail_colors = list("#332211", "#CCCCBB", "#EEEEEE")

/datum/mod_theme/mining
	modsuit_tail_colors = list("#887777", "#BBAA99", "#665555")

/datum/mod_theme/syndicate
	modsuit_tail_colors = list("#AA1111", "#332222", "#cc4455")

/datum/mod_theme/elite
	modsuit_tail_colors = list("#222222", "#445544", "#444433")

/datum/mod_theme/medical
	modsuit_tail_colors = list("#DDDDDD", "#AA7755", "#FFFFFF")

/datum/mod_theme/research
	modsuit_tail_colors = list("#1E1E32", "#0D0C19", "#7A0BB7")

/datum/mod_theme/security
	modsuit_tail_colors = list("#222222", "#CC2233", "#333355")

/datum/mod_theme/safeguard
	modsuit_tail_colors = list("#221122", "#CC3322", "#223344")

/datum/mod_theme/magnate
	modsuit_tail_colors = list("#336688", "#CCAA00", "#003300")

/datum/mod_theme/apocryphal
	modsuit_tail_colors = list("#222222", "#551100", "#444433")

/datum/mod_theme/responsory
	modsuit_tail_colors = list("#111122", "#555533", "#2288FF")

/datum/mod_theme/debug
	modsuit_tail_colors = list("#003377", "#222222", "#22AAFF")

/datum/mod_theme/administrative
	modsuit_tail_colors = list("#003377", "#222222", "#22AAFF")

