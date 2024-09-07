#define MAX_LOG_REPEAT_LOOKBACK 5

<<<<<<< HEAD
GLOBAL_VAR_INIT(IsLuaCall, FALSE)
GLOBAL_PROTECT(IsLuaCall)

GLOBAL_DATUM(lua_usr, /mob)
GLOBAL_PROTECT(lua_usr)

/datum/lua_state
	var/name

	/// The internal ID of the lua state stored in auxlua's global map
=======
GLOBAL_DATUM(lua_usr, /mob)
GLOBAL_PROTECT(lua_usr)

GLOBAL_LIST_EMPTY_TYPED(lua_state_stack, /datum/weakref)
GLOBAL_PROTECT(lua_state_stack)

/datum/lua_state
	var/display_name

	/// The internal ID of the lua state stored in dreamluau's state list
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	var/internal_id

	/// A log of every return, yield, and error for each chunk execution and function call
	var/list/log = list()

	/// A list of all the variables in the state's environment
	var/list/globals = list()

<<<<<<< HEAD
	/// A list in which to store datums and lists instantiated in lua, ensuring that they don't get garbage collected
	var/list/references = list()

=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	/// Ckey of the last user who ran a script on this lua state.
	var/ckey_last_runner = ""

	/// Whether the timer.lua script has been included into this lua context state.
	var/timer_enabled = FALSE

<<<<<<< HEAD
=======
	/// Whether to supress logging BYOND runtimes for this state.
	var/supress_runtimes = FALSE

>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	/// Callbacks that need to be ran on next tick
	var/list/functions_to_execute = list()

/datum/lua_state/vv_edit_var(var_name, var_value)
	. = ..()
	if(var_name == NAMEOF(src, internal_id))
		return FALSE

/datum/lua_state/New(_name)
	if(SSlua.initialized != TRUE)
		qdel(src)
		return
<<<<<<< HEAD
	name = _name
	internal_id = __lua_new_state()

/datum/lua_state/proc/check_if_slept(result)
	if(result["status"] == "sleeping")
=======
	display_name = _name
	internal_id = DREAMLUAU_NEW_STATE()
	if(isnull(internal_id))
		stack_trace("dreamluau is not loaded")
		qdel(src)
	else if(!isnum(internal_id))
		stack_trace(internal_id)
		qdel(src)

/datum/lua_state/proc/check_if_slept(result)
	if(result["status"] == "sleep")
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
		SSlua.sleeps += src

/datum/lua_state/proc/log_result(result, verbose = TRUE)
	if(!islist(result))
		return
<<<<<<< HEAD
	if(!verbose && result["status"] != "errored" && result["status"] != "bad return" \
		&& !(result["name"] == "input" && (result["status"] == "finished" || length(result["param"]))))
=======
	var/status = result["status"]
	if(!verbose && status != "error" && status != "panic" && status != "runtime" && !(result["name"] == "input" && (status == "finished" || length(result["return_values"]))))
		return
	if(status == "runtime" && supress_runtimes)
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
		return
	var/append_to_log = TRUE
	var/index_of_log
	if(log.len)
		for(var/index in log.len to max(log.len - MAX_LOG_REPEAT_LOOKBACK, 1) step -1)
			var/list/entry = log[index]
<<<<<<< HEAD
			if(entry["status"] == result["status"] \
				&& entry["chunk"] == result["chunk"] \
				&& entry["name"] == result["name"] \
				&& ((entry["param"] == result["param"]) || deep_compare_list(entry["param"], result["param"])))
				if(!entry["repeats"])
					entry["repeats"] = 0
				index_of_log = index
				entry["repeats"]++
				append_to_log = FALSE
				break
	if(append_to_log)
		if(islist(result["param"]))
			result["param"] = weakrefify_list(encode_text_and_nulls(result["param"]))
=======
			if(!compare_lua_logs(entry, result))
				continue
			if(!entry["repeats"])
				entry["repeats"] = 0
			index_of_log = index
			entry["repeats"]++
			append_to_log = FALSE
			break
	if(append_to_log)
		if(islist(result["return_values"]))
			add_lua_return_value_variants(result["return_values"], result["variants"])
			result["return_values"] = weakrefify_list(result["return_values"])
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
		log += list(result)
		index_of_log = log.len
	INVOKE_ASYNC(src, TYPE_PROC_REF(/datum/lua_state, update_editors))
	return index_of_log

<<<<<<< HEAD
/datum/lua_state/proc/load_script(script)
	GLOB.IsLuaCall = TRUE
	var/tmp_usr = GLOB.lua_usr
	GLOB.lua_usr = usr
	var/result = __lua_load(internal_id, script)
	GLOB.IsLuaCall = FALSE
=======
/datum/lua_state/proc/parse_error(message, name)
	if(copytext(message, 1, 7) == "PANIC:")
		return list("status" = "panic", "message" = copytext(message, 7), "name" = name)
	else
		return list("status" = "error", "message" = message, "name" = name)

/datum/lua_state/proc/load_script(script)
	var/tmp_usr = GLOB.lua_usr
	GLOB.lua_usr = usr
	DREAMLUAU_SET_USR
	GLOB.lua_state_stack += WEAKREF(src)
	var/result = DREAMLUAU_LOAD(internal_id, script, "input")
	SSlua.needs_gc_cycle |= src
	pop(GLOB.lua_state_stack)
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	GLOB.lua_usr = tmp_usr

	// Internal errors unrelated to the code being executed are returned as text rather than lists
	if(isnull(result))
<<<<<<< HEAD
		result = list("status" = "errored", "param" = "__lua_load returned null (it may have runtimed - check the runtime logs)", "name" = "input")
	if(istext(result))
		result = list("status" = "errored", "param" = result, "name" = "input")
=======
		result = list("status" = "error", "message" = "load returned null (it may have runtimed - check the runtime logs)", "name" = "input")
	if(istext(result))
		result = parse_error(result, "input")
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	result["chunk"] = script
	check_if_slept(result)

	log_lua("[key_name(usr)] executed the following lua code:\n<code>[script]</code>")

	return result

/datum/lua_state/process(seconds_per_tick)
	if(timer_enabled)
		var/result = call_function("__Timer_timer_process", seconds_per_tick)
		log_result(result, verbose = FALSE)
		for(var/function as anything in functions_to_execute)
			result = call_function(list("__Timer_callbacks", function))
			log_result(result, verbose = FALSE)
		functions_to_execute.Cut()

/datum/lua_state/proc/call_function(function, ...)
	var/call_args = length(args) > 1 ? args.Copy(2) : list()
	if(islist(function))
		var/list/new_function_path = list()
		for(var/path_element in function)
<<<<<<< HEAD
			new_function_path += path_element
		function = new_function_path

	var/tmp_usr = GLOB.lua_usr
	GLOB.lua_usr = usr
	GLOB.IsLuaCall = TRUE
	var/result = __lua_call(internal_id, function, call_args)
	GLOB.IsLuaCall = FALSE
	GLOB.lua_usr = tmp_usr

	if(isnull(result))
		result = list("status" = "errored", "param" = "__lua_call returned null (it may have runtimed - check the runtime logs)", "name" = islist(function) ? jointext(function, ".") : function)
	if(istext(result))
		result = list("status" = "errored", "param" = result, "name" = islist(function) ? jointext(function, ".") : function)
=======
			if(isweakref(path_element))
				var/datum/weakref/weak_ref = path_element
				var/resolved = weak_ref.hard_resolve()
				if(!resolved)
					return list("status" = "error", "message" = "Weakref in function path ([weak_ref] [text_ref(weak_ref)]) resolved to null.", "name" = jointext(function, "."))
				new_function_path += resolved
			else
				new_function_path += path_element
		function = new_function_path
	else
		function = list(function)

	var/tmp_usr = GLOB.lua_usr
	GLOB.lua_usr = usr
	DREAMLUAU_SET_USR
	GLOB.lua_state_stack += WEAKREF(src)
	var/result = DREAMLUAU_CALL_FUNCTION(internal_id, function, call_args)
	SSlua.needs_gc_cycle |= src
	pop(GLOB.lua_state_stack)
	GLOB.lua_usr = tmp_usr

	if(isnull(result))
		result = list("status" = "error", "message" = "call_function returned null (it may have runtimed - check the runtime logs)", "name" = jointext(function, "."))
	if(istext(result))
		result = parse_error(result, jointext(function, "."))
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	check_if_slept(result)
	return result

/datum/lua_state/proc/call_function_return_first(function, ...)
<<<<<<< HEAD
	var/list/result = call_function(arglist(args))
	log_result(result, verbose = FALSE)
	if(length(result))
		if(islist(result["param"]) && length(result["param"]))
			return result["param"][1]

/datum/lua_state/proc/awaken()
	GLOB.IsLuaCall = TRUE
	var/result = __lua_awaken(internal_id)
	GLOB.IsLuaCall = FALSE

	if(isnull(result))
		result = list("status" = "errored", "param" = "__lua_awaken returned null (it may have runtimed - check the runtime logs)", "name" = "An attempted awaken")
	if(istext(result))
		result = list("status" = "errored", "param" = result, "name" = "An attempted awaken")
=======
	SHOULD_NOT_SLEEP(TRUE) // This function is meant to be used for signal handlers.
	var/list/result = call_function(arglist(args))
	INVOKE_ASYNC(src, PROC_REF(log_result), deep_copy_list(result), /*verbose = */FALSE)
	if(length(result))
		if(islist(result["return_values"]) && length(result["return_values"]))
			var/return_value = result["return_values"][1]
			var/variant = (islist(result["variants"]) && length(result["variants"])) && result["variants"][1]
			if(islist(return_value) && islist(variant))
				remove_non_dm_variants(return_value, variant)
			return return_value

/datum/lua_state/proc/awaken()
	DREAMLUAU_SET_USR
	GLOB.lua_state_stack += WEAKREF(src)
	var/result = DREAMLUAU_AWAKEN(internal_id)
	SSlua.needs_gc_cycle |= src
	pop(GLOB.lua_state_stack)

	if(isnull(result))
		result = list("status" = "error", "message" = "awaken returned null (it may have runtimed - check the runtime logs)", "name" = "An attempted awaken")
	if(istext(result))
		result = parse_error(result, "An attempted awaken")
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	check_if_slept(result)
	return result

/// Prefer calling SSlua.queue_resume over directly calling this
/datum/lua_state/proc/resume(index, ...)
	var/call_args = length(args) > 1 ? args.Copy(2) : list()
<<<<<<< HEAD
	var/msg = "[key_name(usr)] resumed a lua coroutine with arguments: [english_list(call_args)]"
	log_lua(msg)

	GLOB.IsLuaCall = TRUE
	var/result = __lua_resume(internal_id, index, call_args)
	GLOB.IsLuaCall = FALSE

	if(isnull(result))
		result = list("status" = "errored", "param" = "__lua_resume returned null (it may have runtimed - check the runtime logs)", "name" = "An attempted resume")
	if(istext(result))
		result = list("status" = "errored", "param" = result, "name" = "An attempted resume")
=======

	DREAMLUAU_SET_USR
	GLOB.lua_state_stack += WEAKREF(src)
	var/result = DREAMLUAU_RESUME(internal_id, index, call_args)
	SSlua.needs_gc_cycle |= src
	pop(GLOB.lua_state_stack)

	if(isnull(result))
		result = list("status" = "error", "param" = "resume returned null (it may have runtimed - check the runtime logs)", "name" = "An attempted resume")
	if(istext(result))
		result = parse_error(result, "An attempted resumt")
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	check_if_slept(result)
	return result

/datum/lua_state/proc/get_globals()
<<<<<<< HEAD
	globals = weakrefify_list(encode_text_and_nulls(__lua_get_globals(internal_id)))

/datum/lua_state/proc/get_tasks()
	return __lua_get_tasks(internal_id)

/datum/lua_state/proc/kill_task(task_info)
	__lua_kill_task(internal_id, task_info)
=======
	var/result = DREAMLUAU_GET_GLOBALS(internal_id)
	if(isnull(result))
		CRASH("get_globals returned null")
	if(istext(result))
		CRASH(result)
	var/list/new_globals = result
	var/list/values = new_globals["values"]
	var/list/variants = new_globals["variants"]
	add_lua_editor_variants(values, variants)
	globals = list("values" = weakrefify_list(values), "variants" = variants)

/datum/lua_state/proc/get_tasks()
	var/result = DREAMLUAU_LIST_THREADS(internal_id)
	if(isnull(result))
		CRASH("list_threads returned null")
	if(istext(result))
		CRASH(result)
	return result

/datum/lua_state/proc/kill_task(is_sleep, index)
	var/result = is_sleep ? DREAMLUAU_KILL_SLEEPING_THREAD(internal_id, index) : DREAMLUAU_KILL_YIELDED_THREAD(internal_id, index)
	SSlua.needs_gc_cycle |= src
	return result

/datum/lua_state/proc/collect_garbage()
	var/result = DREAMLUAU_COLLECT_GARBAGE(internal_id)
	if(!isnull(result))
		CRASH(result)
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3

/datum/lua_state/proc/update_editors()
	var/list/editor_list = LAZYACCESS(SSlua.editors, text_ref(src))
	if(editor_list)
		for(var/datum/lua_editor/editor as anything in editor_list)
			SStgui.update_uis(editor)

<<<<<<< HEAD
/// Called by lua scripts when they add an atom to var/list/references so that it gets cleared up on delete.
/datum/lua_state/proc/clear_on_delete(datum/to_clear)
	RegisterSignal(to_clear, COMSIG_QDELETING, PROC_REF(on_delete))

/// Called by lua scripts when an atom they've added should soft delete and this state should stop tracking it.
/// Needs to unregister all signals.
/datum/lua_state/proc/let_soft_delete(datum/to_clear)
	UnregisterSignal(to_clear, COMSIG_QDELETING, PROC_REF(on_delete))
	references -= to_clear

/datum/lua_state/proc/on_delete(datum/to_clear)
	SIGNAL_HANDLER
	references -= to_clear

=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
#undef MAX_LOG_REPEAT_LOOKBACK
