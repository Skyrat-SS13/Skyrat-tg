

#define DEFAULT_METER_DATA	list("current"	=	null, "max"	=	null, 	"regen"	=	null, "blocked"	=	null)
#define METER_HEIGHT	"16"
/atom/movable/screen/meter
	name = "meter"
	var/mob/living/L
	var/atom/movable/screen/meter_component/current/remaining_meter	//The actual remaining health, in red or green
	var/atom/movable/screen/meter_component/delta/delta_meter	//A yellow section indicating recent loss
	var/atom/movable/screen/meter_component/limit/limit_meter	//A solid grey block at the end, representing reduced maximum
	var/atom/movable/screen/meter_component/text/textholder

	var/remaining_color = COLOR_NT_RED
	var/delta_color	=	COLOR_AMBER

	alpha = 200
	color = COLOR_DARK_GRAY

	screen_loc = "CENTER,TOP"
	plane = HUD_PLANE
	layer = HUD_BASE_LAYER
	icon = 'icons/hud/screen_health.dmi'
	icon_state = "white"

	var/total_value = 1
	var/current_value = 0
	var/change_per_second	=	null	//Displayed in the text if non null and nonzero, this is the amount up or down that this value is changing each second

	var/rounding = 1	//How precisely do we round displayed numbers?
	var/change_rounding = 0.01

	//The healthbar size is dynamic and scales with diminishing returns based on the user's health.
	//From 0 to 100, it is 2 pixels wide per health point, then from 100 to 200, 1 pixel for each additional health, and so on. The list below holds the data
	//This ensures that it gets bigger with more health, but never -toooo- big
	var/list/size_pixels = list("0" = 2,
	"100" = 1,
	"200" = 0.5,
	"400" = 0.3)

	mouse_opacity = 2


	//Measured in pixels
	var/length

	//This is an authortime value, it should match sprite size
	var/height = METER_HEIGHT

	var/base_length = 50	//Minimum size which is added to with calculated sizes

	var/margin = 8//Extra length that isn't counted as part of our length for the purpose of components

/atom/movable/screen/meter/New(atom/holder, holder_hud)
	L = holder
	hud = holder_hud
	cache_data(arglist(args))

	.=..()

/atom/movable/screen/meter/Initialize()
	. = ..()
	remaining_meter = new(src)
	remaining_meter.color = remaining_color
	remaining_meter.screen_loc = src.screen_loc

	delta_meter = new(src)
	delta_meter.color = delta_color
	delta_meter.screen_loc = src.screen_loc


	limit_meter = new(src)
	limit_meter.screen_loc = src.screen_loc


	textholder = new(src)
	textholder.screen_loc = src.screen_loc

	hud.infodisplay += list(remaining_meter, delta_meter, limit_meter, textholder)

	update(TRUE)

//Override this and change the parameters in subtypes
/atom/movable/screen/meter/proc/cache_data(atom/holder)


/atom/movable/screen/meter/Destroy()
	QDEL_NULL(remaining_meter)
	QDEL_NULL(delta_meter)
	QDEL_NULL(limit_meter)
	QDEL_NULL(textholder)
	.=..()



/atom/movable/screen/meter/proc/set_size(update = TRUE)
	//Lets set the size


	length = base_length


	var/working_value = total_value
	var/index = 1
	var/current_key = size_pixels[1]
	var/current_multiplier = size_pixels[current_key]
	while (working_value > 0)
		//How much health we convert into pixels this step
		var/delta

		//At the end of the step we'll set current values to these. Cache current values for now, they will be edited if theres any list indices left
		var/next_key = current_key
		var/next_multiplier = current_multiplier

		//Is there a next entry after our current one?
		if (size_pixels.len >= index+1)
			//Cache next key and mult, we'll put them into the current values at the end
			next_key = size_pixels[index+1]
			next_multiplier = size_pixels[next_key]

			//Figure out how much health we'll convert this step
			delta = text2num(next_key) - text2num(current_key)
			delta = min(working_value, delta)
			//Subtract it from the working health
			working_value -= delta

		//If not, then we're at the final tier, convert all remaining health to pixels
		else
			delta = working_value
			working_value = 0


		//Add to our pixel length, and increment things for the next cycle, if there's gonna be one
		length += delta * current_multiplier

		index++
		current_key = next_key
		current_multiplier = next_multiplier

	//Lastly, lets round off that pixel length
	length = round(length)

	//We must make sure it can fit on the client's screen
	length = min(length, L.client.get_viewport_width() - margin)



	//Alright we have the length, now lets figure out a transform
	//We count the margin here without actually adding it to the length variable
	var/x_scale = (length + margin) / WORLD_ICON_SIZE
	var/matrix/M = matrix()
	M.Scale(x_scale, 1)
	animate(src, transform = M, time = 2 SECONDS)
	if (remaining_meter)
		remaining_meter.update_total()
	if (delta_meter)
		delta_meter.update_total()
	if (textholder)
		textholder.update_total(TRUE)
	if (update)
		update()



/atom/movable/screen/meter/proc/update(force_update = FALSE)
	var/list/data = get_data()


	var/max = data["max"]
	if (isnull(max))
		max = total_value	//A null value means "no change from previous"

	//Uh oh, the max health has changed, this doesnt happen often. We gotta recalculate the size
	if (max != total_value)
		total_value = max
		set_size(FALSE)//Prevent infinite loop

	var/value_changed = 0	//1 for positive, -1 for negative
	var/new_value = data["current"]
	if (isnull(new_value))
		//A null value means "no change from previous"
		new_value = current_value

	if (!isnull(data["regen"]))
		change_per_second = round(data["regen"], change_rounding)

	new_value = max(new_value, 0)


	if (new_value > current_value)
		value_changed = 1
	if (new_value < current_value)
		value_changed = -1


	current_value = new_value

	if (!value_changed && force_update)

		value_changed = TRUE


	if (textholder)
		textholder.update_total(FALSE)
	var/blocked = data["blocked"]


	//Lets update the current display first
	if (remaining_meter && value_changed != 0)
		var/remaining_meter_pixels = (current_value / max) * length
		remaining_meter.set_size(remaining_meter_pixels)


	//And blocked
	if (limit_meter && !isnull(blocked))
		limit_meter.set_size((blocked / max) * length)


	//Delta works differently, and only updates if health goes down, not up
	if (delta_meter && value_changed == -1)
		delta_meter.update()





/atom/movable/screen/meter/proc/get_data()
	return DEFAULT_METER_DATA


/*
	The components
	Core:
*/
/atom/movable/screen/meter_component
	var/atom/movable/screen/meter/parent
	alpha = 200

	screen_loc = "CENTER,TOP"
	plane = HUD_PLANE
	layer = HUD_ITEM_LAYER
	icon = 'icons/hud/screen_health.dmi'
	icon_state = "white_slim"
	var/side = -1	//-1 = left, 1 = right

	var/animate_time = 1 SECOND
	var/matrix/M
	var/offset

	mouse_opacity = 2

/atom/movable/screen/meter_component/New(atom/movable/screen/meter/newparent)
	parent = newparent
	hud = parent.hud
	update_total()
	.=..()

/atom/movable/screen/meter_component/Destroy()
	hud.infodisplay -= src
	.=..()


/atom/movable/screen/meter_component/proc/update()

//Sets a new size in pixels
/atom/movable/screen/meter_component/proc/set_size(newsize)
	if (!newsize)
		alpha = 0
		return
	alpha = initial(alpha)
	var/x_scale = newsize / WORLD_ICON_SIZE
	var/matrix/M = matrix()
	M.Scale(x_scale, 1)

	//Alright we have the matrix to make us the right size, but we also need to offset to the correct position
	var/offset = ((parent.length - newsize) * 0.5) * side
	M.Translate(offset, 0)

	animate(src, transform = M,  time = animate_time)


/atom/movable/screen/meter_component/proc/update_total()
	if (parent)
		set_size(parent.length)


/*
	Health
*/
/atom/movable/screen/meter_component/current
	layer = HUD_ABOVE_ITEM_LAYER	//This must draw above the delta
	color = COLOR_NT_RED
	animate_time = 0.3 SECOND


/*
	Limit
*/
/atom/movable/screen/meter_component/limit
	color = COLOR_GRAY40
	side = 1


/*
	Delta
*/
/atom/movable/screen/meter_component/delta
	color = COLOR_AMBER
	var/head_health = 0	//What health value is the tip of the delta meter currently showing
	var/ticks_per_second = 2
	animate_time = 0.5 SECOND

	var/windup_time = 1.5 SECOND	//When the user takes damage for the first time in a while, the delta willpause to show the extend of it before it starts animating down

	//When we're winding up, we won't start the animation until this time. It may be extended while we're waiting
	var/animate_continue_time = 0

	//delta has 3 states
	//0: Idle, not animating or visible
	//1: Waiting: About to start an animation
	//2: Currently animating
	var/animation_state = 0

	var/health_per_tick = 10

/atom/movable/screen/meter_component/delta/New(var/atom/movable/screen/meternewparent)
	.=..()
	head_health = parent.total_value
	animate_time = (1 SECOND / ticks_per_second)
	health_per_tick = (parent.total_value * 0.065)/ticks_per_second


/atom/movable/screen/meter_component/delta/update_total()
	head_health = parent.current_value
	animate_time = (1 SECOND / ticks_per_second)
	alpha = 0
	health_per_tick = (parent.total_value * 0.1)/ticks_per_second

//Delta works very differently
/atom/movable/screen/meter_component/delta/update()
	if (!parent)
		return


	//If the necromorph has suddenly been healed exactly to, or above the damage we're trying to show, we just abort all animation
	if (parent.current_value >= head_health)
		stop_animation()
		return


	animate_continue_time = world.time + windup_time
	//We will start a new animation only if no current one is ongoing
	if (animation_state == 0)
		start_animation()

/atom/movable/screen/meter_component/delta/proc/start_animation()
	set waitfor = FALSE
	alpha = initial(alpha)
	//Gotta do this in the right order
	if (animation_state != 0)
		stop_animation()
		return

	animation_state = 1

	//Immediately update the bar to the current head
	set_size((head_health / parent.total_value) * parent.length)



	//And then we wait
	//We're doing this in a while loop because it's possible (and likely) that the continuation time will be extended while we wait
	//We'll continue waiting until the time stops getting extended
	while (animate_continue_time > world.time)
		sleep(animate_continue_time - world.time)




	//Now we check again to see if things have changed. If they have, we abort
	if (animation_state != 1)
		stop_animation()
		return

	ongoing_animation()

//Here we animate and move each tick until we
/atom/movable/screen/meter_component/delta/proc/ongoing_animation()
	set waitfor = FALSE

	//Gotta do this in the right order
	if (animation_state != 1)
		stop_animation()
		return

	animation_state = 2

	//Here we will animate periodically towards a target value
	while (parent && head_health > parent.current_value && animation_state == 2)
		var/delta = min(health_per_tick, head_health - parent.current_value)
		head_health -= delta
		set_size((head_health / parent.total_value) * parent.length)
		sleep(animate_time)

	//Once we're done, reset animation state
	stop_animation()

//Terminates any ongoing animation
/atom/movable/screen/meter_component/delta/proc/stop_animation()
	animation_state = 0
	head_health = parent.current_value

	set_size((head_health / parent.total_value) * parent.length)

	alpha = 0




/*
	Text
*/
/atom/movable/screen/meter_component/text
	icon_state = ""
	layer = HUD_TEXT_LAYER

/atom/movable/screen/meter_component/text/update_total(resize = FALSE)
	if (parent)
		if (resize)
			set_size(parent.length)
			maptext_width = parent.length
			maptext_height = 16
			maptext_y = 17
		maptext = "[round(parent.current_value, parent.rounding)]/[parent.total_value]"
		if (parent.change_per_second)
			if (parent.change_per_second > 0)
				maptext += "<span style='font-size:6px; color:#CCCCCC;'>+[parent.change_per_second]</span>"
			else
				maptext += "<span style='font-size:6px; color:#CCCCCC;'>-[parent.change_per_second]</span>"

/atom/movable/screen/meter_component/text/set_size()
	return

/*
	Creates a resource meter on the target, giving it any additional parameters passed

	Target can be any of..
		/datum/hud
		/mob
		/client

	Note that this will not immediately update the hud unless instant update is set true
*/
/proc/add_resource_meter(var/target, var/subtype = /atom/movable/screen/meter/resource, var/datum/extension/resource/resource_datum, var/instant_update = TRUE)
	var/list/data = get_hud_data_for_target(target)
	to_chat(world, "Adding meter, for target [target] data: [dump_list(data)]")
	var/datum/hud/H = data["hud"]
	var/mob/M = data["mob"]
	var/atom/movable/screen/meter/resource/meter = new subtype(M, data["hud"], resource_datum)
	H.hud_resource[resource_datum.resource_tag] = meter
	H.infodisplay += meter
	meter.resource_holder = resource_datum

	if (instant_update)
		H.show_hud(-1, M)
		meter.update()

	return meter


/*
	Finds and removes a meter with a matching tag
*/
/proc/remove_resource_meter(var/target, var/tag)
	var/list/data = get_hud_data_for_target(target)
	var/datum/hud/H = data["hud"]
	var/atom/movable/screen/meter/meter = H.hud_resource[tag]
	if (!meter)
		return //Its not there

	H.hud_resource.Remove(tag)

	var/client/C = data["screen"]
	if (C)
		C.screen -= meter
	
	qdel(meter)
	return TRUE