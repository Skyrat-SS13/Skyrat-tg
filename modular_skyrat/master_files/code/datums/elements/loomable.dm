/datum/element/loomable/loom_me(obj/item/source, mob/living/user, atom/target)
	var/new_thing
	if(isstack(source))
		var/obj/item/stack/stack_we_use = source
		while(stack_we_use.amount >= required_amount)
			if(!do_after(user, loom_time, target))
				user.balloon_alert(user, "interrupted!")
				return

			if(!stack_we_use.use(required_amount))
				return

			new_thing = new resulting_atom(target.drop_location())

	else
		if(!do_after(user, loom_time, target))
			user.balloon_alert(user, "interrupted!")
			return

		qdel(source)
		new_thing = new resulting_atom(target.drop_location())

	user.balloon_alert_to_viewers("[process_completion_verb] [new_thing]")
