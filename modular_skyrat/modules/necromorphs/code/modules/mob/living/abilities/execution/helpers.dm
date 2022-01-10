//Access Proc
/atom/proc/can_execute(var/execution_type = /datum/extension/execution, var/error_messages = TRUE)

	var/datum/extension/execution/E = get_extension(src, execution_type)
	if(istype(E))
		if (E.stopped_at)
			to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
		else
			to_chat(src, SPAN_NOTICE("You're already performing an execution"))

		return FALSE

	return TRUE


/mob/living/can_execute(var/execution_type = /datum/extension/execution, var/error_messages = TRUE)
	if (incapacitated())
		return FALSE
	.=..()


/atom/proc/perform_execution(var/execution_type = /datum/extension/execution, var/atom/target)
	if (!can_execute(execution_type))
		return FALSE
	var/list/arguments = list(src, execution_type, target)
	if (args.len > 2)
		arguments += args.Copy(3)


	//Here we bootstrap the execution datum
	var/datum/extension/execution/E = set_extension(arglist(arguments))
	if (!E.can_start())
		E.failed_start()
		.=FALSE
	E.ongoing_timer = addtimer(CALLBACK(E, /datum/extension/execution/proc/start), 0, TIMER_STOPPABLE)

	.= TRUE



