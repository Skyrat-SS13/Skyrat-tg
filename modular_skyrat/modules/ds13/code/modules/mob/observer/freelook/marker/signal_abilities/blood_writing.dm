/datum/signal_ability/writing
	name = "Bloody Scrawl"
	id = "writing"
	desc = "Writes a message in blood"
	target_string = "a wall or floor"
	energy_cost = 15
	require_corruption = FALSE
	autotarget_range = 0
	LOS_block = FALSE	//This is for spooking people, we want them to see it happen
	target_types = list(/turf/simulated)


/datum/signal_ability/writing/special_check(var/turf/target)
	var/num_doodles = 0
	for(var/obj/effect/decal/cleanable/blood/writing/W in target)
		num_doodles++
	if(num_doodles > 4)
		to_chat(src, "<span class='warning'>There is no space to write on!</span>")
		return
	return TRUE

/datum/signal_ability/writing/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/message = sanitize(input("Write a message", "Blood writing", ""))
	if (!message)
		refund()
		return

	var/obj/effect/decal/cleanable/blood/writing/W = new(target)
	W.transform = W.transform.Scale(2)
	W.message = message
	W.visible_message("<span class='warning'>Invisible fingers crudely paint something in blood on \the [target].</span>")

