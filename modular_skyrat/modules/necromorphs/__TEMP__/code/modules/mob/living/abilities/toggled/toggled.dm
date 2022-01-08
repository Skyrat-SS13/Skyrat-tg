#define STATUS_INACTIVE		0
#define STATUS_ACTIVATING	2
#define STATUS_ACTIVE	1
#define STATUS_DEACTIVATING		-1

/*
	Toggled abilities are turned on and off. They don't typically have a defined duration, and may not have cooldowns
*/
/datum/extension/ability/toggled
	var/toggle_on_time = 0.5 SECONDS	//How long is the windup to turn the ability on?
	var/toggle_off_time = null		  //As above, but to turn off. If not set, uses the value of toggle_on_time

	status = STATUS_INACTIVE
	auto_register_statmods = FALSE

	//Persistent by default
	persist = TRUE

	//This only needs to be set if you want a family of shared abilities to be mutually exclusive
	base_type = null

/*
	Helpers
*/
/datum/proc/toggle_extension(var/etype, var/target_state = null,var/can_fail = TRUE, var/instant)
	var/datum/extension/ability/toggled/T
	if (target_state != FALSE)
		T = get_or_create_extension(src, etype)
	else
		//If we're specifically trying to turn off, and the extension doesn't exist, we don't create it.
		//We are happy that its nonexistence is as good as being turned off, and will leave it that way
		T = get_extension(src, etype)
		if (!T)
			return

	if (T.status == target_state)
		return

	if (isnull(target_state))
		T.toggle(can_fail, instant)
	else if (target_state)
		T.activate(can_fail, instant)
	else
		T.deactivate(can_fail, instant)

/datum/extension/ability/toggled/Destroy()
	if (status != STATUS_INACTIVE)
		deactivate(FALSE, TRUE)
	. = ..()


/*
	Hooks: Override these and put custom behaviour in them
	Alwaus rememember to call parent!
*/
//Called before activation starts and before the do-after time.
//The activation can fail after this proc is called so be ready to undo anything it does, in interrupt
/datum/extension/ability/toggled/proc/pre_activate()

//Called when activation suceeds and we enter the active state, do most of your work here
/datum/extension/ability/toggled/proc/activated()
	to_chat(holder, SPAN_DANGER("[src.name] is now active!"))

//As above
/datum/extension/ability/toggled/proc/pre_deactivate()

/datum/extension/ability/toggled/proc/deactivated()
	to_chat(holder, "[src.name] is now inactive")

//Cancel whatever state change was ongoing
/datum/extension/ability/toggled/interrupt()
	switch (status)
		if (STATUS_ACTIVATING)
			status = STATUS_INACTIVE
		if (STATUS_DEACTIVATING)
			status = STATUS_ACTIVE


//For calling when things change, nothing calls it by default
/datum/extension/ability/toggled/proc/update()

/datum/extension/ability/toggled/proc/can_activate()
	return TRUE

/datum/extension/ability/toggled/proc/can_deactivate()
	return TRUE

/*
	Core Functionality, do not override these
*/
/datum/extension/ability/toggled/New(var/mob/holder)
	.=..()
	Initialize()

/datum/extension/ability/toggled/start()
	activate()

/datum/extension/ability/toggled/Initialize()
	GLOB.stat_set_event.register(holder, src, /datum/extension/ability/toggled/proc/stat_set)

/datum/extension/ability/toggled/Destroy()

	if (status == STATUS_ACTIVE)
		deactivate()
	. = ..()

/datum/extension/ability/toggled/proc/toggle(var/can_fail = TRUE, var/instant)
	switch (status)
		if (STATUS_ACTIVE)
			deactivate(can_fail, instant)
		if (STATUS_INACTIVE)
			activate(can_fail, instant)

/datum/extension/ability/toggled/proc/activate(var/can_fail = TRUE, var/instant)
	if (!instant && !can_activate())
		return
	status = STATUS_ACTIVATING
	pre_activate()
	if (toggle_on_time)
		if (!do_after(holder, toggle_on_time, holder, incapacitation_flags = src.incapacitation_flags))
			if (can_fail)
				interrupt()
				return

	status = STATUS_ACTIVE
	activated()

	//This is called after activated so the statmods can be altered based on the mob
	if (statmods)
		register_statmods()

/datum/extension/ability/toggled/proc/deactivate(var/can_fail = TRUE, var/instant)
	if (!can_deactivate())
		return
	status = STATUS_DEACTIVATING
	pre_deactivate()
	if (!instant && toggle_off_time != 0)
		var/time = toggle_off_time ? toggle_off_time : toggle_on_time
		if (time)
			if (!do_after(holder, time, holder, incapacitation_flags = src.incapacitation_flags))
				if (can_fail)
					interrupt()
					return

	status = STATUS_INACTIVE
	deactivated()

	if (statmods)
		unregister_statmods()


/datum/extension/ability/toggled/proc/stat_set()
	var/mob/living/L = holder
	if (L.stat == DEAD)
		remove_self()
	else if (L.stat)
		if (status == STATUS_ACTIVE)
			deactivate(FALSE, TRUE)