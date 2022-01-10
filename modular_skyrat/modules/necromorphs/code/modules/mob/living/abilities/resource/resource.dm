/*
	Holders for generic resources which regnerate over time, get consumed to use abilities, etc
*/

/datum/extension/resource
	expected_type = /mob
	name = "Resource"
	flags = EXTENSION_FLAG_IMMEDIATE
	var/min_value = 0
	var/current_value = 0
	var/max_value = 100
	var/regen = 1	//Per second

	var/resource_tag = "resource"//This unique lowercase string is used to index this extension and its hud meter in lists.

	var/meter_type = /atom/movable/screen/meter/resource
	var/atom/movable/screen/meter/resource/meter

/datum/extension/resource/New(var/mob/holder)
	.=..()
	start_processing()
	var/mob/M = holder
	if (meter_type && istype(M) && M.client)
		setup_meter()	//Onscreen resource meter

/datum/extension/resource/Destroy()
	remove_meter()
	.=..()


/datum/extension/resource/proc/setup_meter(var/target)
	if (!target)
		target = holder
	meter = add_resource_meter(target, meter_type, src, TRUE)
	to_chat(world, "created meter [meter]")


/datum/extension/resource/proc/remove_meter()
	if (meter)
		meter = null
		remove_resource_meter(holder, resource_tag)

/datum/extension/resource/Process()

	regenerate()

	if (can_stop_processing())
		return PROCESS_KILL



/datum/extension/resource/proc/get_report()
	return list("current"	=	current_value, "max"	=	max_value, 	"regen"	=	(current_value < max_value ? get_regen_amount() : 0))

//Called whenever we might want to start
/datum/extension/resource/proc/start_processing()
	START_PROCESSING(SSprocessing, src)

/datum/extension/resource/proc/stop_processing()
	STOP_PROCESSING(SSprocessing, src)

/datum/extension/resource/can_stop_processing()
	.=TRUE
	if (current_value < max_value)
		return FALSE

/datum/extension/resource/proc/regenerate()
	current_value = clamp(current_value+get_regen_amount(), min_value, max_value)
	if (meter)
		meter.update()


/datum/extension/resource/proc/get_regen_amount()
	return regen

/datum/extension/resource/proc/consume(var/quantity)
	if (current_value >= quantity)
		current_value -= quantity
		start_processing()
		if (meter)
			meter.update()
		return TRUE

	return FALSE


/datum/extension/resource/proc/modify(var/quantity)
	var/old_value = current_value
	current_value += quantity
	current_value = clamp(current_value, min_value, max_value)
	if (old_value != current_value)
		start_processing()
		if (meter)
			meter.update()
		return TRUE

	return FALSE

/datum/extension/resource/proc/can_afford(var/quantity)
	return (current_value >= quantity)


/*
	Helpers:
*/
/datum/proc/consume_resource(var/type, var/quantity)
	.=FALSE
	var/datum/extension/resource/R = get_extension(src, type)
	if (istype(R) && R.consume(quantity))
		return TRUE


/datum/proc/modify_resource(var/type, var/quantity)
	.=FALSE
	var/datum/extension/resource/R = get_extension(src, type)
	if (istype(R) && R.modify(quantity))
		return TRUE

/datum/proc/can_afford_resource(var/type, var/quantity, var/error_message = FALSE)
	.=FALSE
	var/datum/extension/resource/R = get_extension(src, type)
	if (istype(R) && R.can_afford(quantity))
		return TRUE

	else if (error_message)
		to_chat(src, "You don't have enough [R.name]!")


/datum/extension/resource/handle_hud(var/datum/hud/M)
	to_chat(world, "Handling hud for [M]")
	remove_meter()
	setup_meter(M)

//Getters
/datum/proc/get_resource(var/type)
	.=0
	var/datum/extension/resource/R = get_extension(src, type)
	if (istype(R))
		return R.current_value


/datum/proc/get_resource_max(var/type)
	.=0
	var/datum/extension/resource/R = get_extension(src, type)
	if (istype(R))
		return R.max_value


//Returns a string, used for UIs
/datum/proc/get_resource_curmax(var/type)
	.=0
	var/datum/extension/resource/R = get_extension(src, type)
	if (istype(R))
		return "[R.current_value]/[R.max_value]"


