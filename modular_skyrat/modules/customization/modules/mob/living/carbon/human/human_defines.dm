/mob/living/carbon/human
	///Color of the undershirt
	var/undershirt_color = "#FFFFFF"
	///Color of the socks
	var/socks_color = "#FFFFFF"
	///Flags for showing/hiding underwear, toggleabley by a verb
	var/underwear_visibility = NONE
	///Render key for mutant bodyparts, utilized to reduce the amount of re-rendering
	var/mutant_renderkey = ""
	///Whether the human is trying to hide their mutant bodyparts under their clothes intentially
	var/try_hide_mutant_parts = FALSE
	///The Examine Panel TGUI.
	var/datum/examine_panel/tgui = new() //create the datum
	//Whether or not the human has emissive eyes
	var/emissive_eyes
