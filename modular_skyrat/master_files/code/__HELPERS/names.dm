/proc/station_name()
	if(!GLOB.station_name)
		var/newname
		var/config_station_name = CONFIG_GET(string/stationname)
		if(CONFIG_GET(flag/mapname_as_stationname))
			SSmapping.HACK_LoadMapConfig()
			var/config_map_name = SSmapping.config.map_name
			set_station_name(config_map_name)
			return GLOB.station_name
		if(config_station_name)
			newname = config_station_name
		else
			newname = new_station_name()

		set_station_name(newname)
	return GLOB.station_name
