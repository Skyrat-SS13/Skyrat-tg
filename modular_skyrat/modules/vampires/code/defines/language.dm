//	BLOODSUCKER LANGUAGE //

/datum/language/vampiric
	name = "Blah-Sucker"
	desc = "The native language of the Bloodsucker elders, learned intuitively by Fledglings and as they pass from death into immortality. Thralls are also given the ability to speak this as apart of their conversion ritual."
	speech_verb = "growls"
	ask_verb = "growls"
	exclaim_verb = "snarls"
	whisper_verb = "hisses"
	sing_verb = "hums" // Skyrat edit
	key = "b"
	space_chance = 40
	default_priority = 90
	icon_state = "bloodsucker"
	//SKYRAT CHANGE - language restriction
	restricted = TRUE
	//

	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_NOT_UNDERSTOOD // Hide the icon next to your text if someone doesn't know this language.
	syllables = list(
		"luk","cha","no","kra","pru","chi","busi","tam","pol","spu","och",		// Start: Vampiric
		"umf","ora","stu","si","ri","li","ka","red","ani","lup","ala","pro",
		"to","siz","nu","pra","ga","ump","ort","a","ya","yach","tu","lit",
		"wa","mabo","mati","anta","tat","tana","prol",
		"tsa","si","tra","te","ele","fa","inz",									// Start: Romanian
		"nza","est","sti","ra","pral","tsu","ago","esch","chi","kys","praz",	// Start: Custom
		"froz","etz","tzil",
		"t'","k'","t'","k'","th'","tz'"
		)

