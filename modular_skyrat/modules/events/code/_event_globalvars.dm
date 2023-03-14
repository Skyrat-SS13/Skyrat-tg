GLOBAL_VAR_INIT(event_spawner_manager, InitializeEventSpawnManager())
GLOBAL_VAR_INIT(intense_event_credits, 0)

/proc/InitializeEventSpawnManager()
	return new /datum/event_spawner_manager()
