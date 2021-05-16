/proc/station_name()
	if(!GLOB.station_name)
		var/newname
		var/config_station_name = CONFIG_GET(string/stationname)
		if(CONFIG_GET(flag/map_stationname))
			SSmapping.HACK_LoadMapConfig()
			if(SSmapping.config.station_name)
				set_station_name(SSmapping.config.station_name)
				return GLOB.station_name
		if(config_station_name)
			newname = config_station_name
		else
			newname = new_station_name()

		set_station_name(newname)
	return GLOB.station_name
