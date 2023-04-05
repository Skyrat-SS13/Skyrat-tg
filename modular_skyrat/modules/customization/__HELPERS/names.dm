/proc/vox_name()
	var/newname = ""

	for(var/i in 1 to rand(2, 8))
		newname += pick(list("ti","hi","ki","ya","ta","ha","ka","ya","chi","cha","kah","ri","ra"))
	return capitalize(newname)

/proc/teshari_name()
	var/newname = ""

	for(var/i in 1 to rand(2, 3))
		newname += pick(list("chi", "chu", "ka", "ki", "kyo", "ko", "la", "li", "mi", "ni", "nu", "nyu", "se", "ri", "ro", "ru", "ryu", "sa", "si", "syo"))
	return capitalize(newname)
