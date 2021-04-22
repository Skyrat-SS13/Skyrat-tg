/proc/log_ntsl(text)
	if (CONFIG_GET(flag/log_ntsl))
		WRITE_LOG(GLOB.world_ntsl_log, "NTSL: [text]")
