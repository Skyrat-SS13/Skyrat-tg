/// Simple proc that converts a direction number into human readable text
/proc/dir_num_to_text(dir, upper_case = FALSE)
	switch(dir)
		if(NORTH)
			return "[upper_case ? "N" : "n"]orth"
		if(EAST)
			return "[upper_case ? "E" : "e"]ast"
		if(SOUTH)
			return "[upper_case ? "S" : "s"]outh"
		if(WEST)
			return "[upper_case ? "W" : "w"]est"
