/// Get valid special networks to send to
/obj/machinery/fax/proc/get_possible_special_networks()
	. = list()
	for(var/list/fax_list as anything in special_networks)
		if(!("fax_key_needed" in fax_list))
			. += list(fax_list)
			continue
		if(fax_list["fax_key_needed"] in fax_keys)
			. += list(fax_list)
			continue
	return .
