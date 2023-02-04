/datum/smite/randdismemb
	name = "Dismember Randomly"

/datum/smite/randdismemb/effect(client/user, mob/living/target)
	. = ..()
	//Checks if the target is from the correct path
	if(!isliving(target))
		to_chat(user, span_warning("Can only be used on carbon mobs."), confidential = TRUE)
		return

	//the list of parts without the head and chest
	var/list/hcbodyparts = list()

	//the _target
	var/mob/living/carbon/_target = target

	//puts all bodyparts in the hcbodyparts list excluding the head and chest
	for(var/part in _target.bodyparts)
		var/obj/item/bodypart/_part = part
		if(_part.body_part != HEAD && _part.body_part != CHEST)
			if(_part.dismemberable)
				hcbodyparts += _part

	//randomly gets a part from hcbodyparts
	var/obj/item/bodypart/randompart = pick(hcbodyparts)

	//removes the random part
	randompart.dismember()
