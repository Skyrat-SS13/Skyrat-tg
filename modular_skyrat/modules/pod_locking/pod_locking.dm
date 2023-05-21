///obj/docking_port/mobile/pod
//		launch_status = NOLAUNCH

/obj/docking_port/mobile/pod/register()
	. = ..()
	if(CONFIG_GET(number/minimum_alert_for_pods) != 0)
		launch_status = NOLAUNCH
		RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, PROC_REF(check_for_evac))

/obj/docking_port/mobile/pod/proc/check_for_evac(datum/source, new_level)
	SIGNAL_HANDLER

	var/min_level = CONFIG_GET(number/minimum_alert_for_pods)
	if(launch_status > UNLAUNCHED)
		return
	launch_status = (new_level >= min_level) ? UNLAUNCHED : NOLAUNCH

/obj/machinery/computer/shuttle/pod/emag_act(mob/user)
	. = ..()

	var/obj/docking_port/mobile/our_pod = SSshuttle.getShuttle(shuttleId)
	our_pod.UnregisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED)
	if(our_pod.launch_status > UNLAUNCHED)
		return
	our_pod.launch_status = UNLAUNCHED
