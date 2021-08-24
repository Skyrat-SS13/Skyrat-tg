/atom/proc/SetName(new_name)
	var/old_name = name
	if(old_name != new_name)
		name = new_name
	/*	if(has_extension(src, /datum/extension/labels))
			var/datum/extension/labels/L = get_extension(src, /datum/extension/labels)
			name = L.AppendLabelsToName(name) */ // TODO - GET THIS WORKING
