/obj/item/essence_cube
	name = "essence cube"
	desc = "Someone's essence, compacted into a cube that shimmers lightly. If you squeeze it in your hand, they will be revived."
	icon = 'modular_skyrat/modules/vore/icons/items.dmi'
	icon_state = "essence_cube" //credit for the icon goes to Arctaisia :3
	w_class = WEIGHT_CLASS_TINY
	var/mob/living/to_revive
	var/key_to_revive
	var/check_cooldown = 0
	var/is_deleting = FALSE

/obj/item/essence_cube/Initialize(mapload, mob/living/mob_to_revive)
	. = ..()
	if (!istype(mob_to_revive) || !mob_to_revive.key)
		return INITIALIZE_HINT_QDEL
	to_revive = mob_to_revive
	key_to_revive = mob_to_revive.key
	to_revive.forceMove(src)
	name = "[mob_to_revive.real_name]'s essence cube"
	RegisterSignal(to_revive, COMSIG_PARENT_PREQDELETED, .proc/spin_away)

/obj/item/essence_cube/examine(mob/user)
	. = ..()
	var/mob/current_control = get_mob_by_key(key_to_revive)
	if (!current_control.client)
		. += "You get the feeling that [to_revive.real_name] can't be revived right now..."

/obj/item/essence_cube/Exited(atom/movable/gone, direction)
	. = ..()
	if (gone == to_revive)
		spin_away(delete_body=FALSE)

/obj/item/essence_cube/attack_self(mob/user)
	var/error = span_warning("They can't be revived right now!")
	if (!ismob(loc))
		to_chat(user, span_warning("You can't use the essence cube without having it in your hand!"))
		return
	if (!to_revive)
		spin_away()
		return
	if (check_cooldown > world.time)
		to_chat(user, span_warning("You can't use the essence cube for another [round((check_cooldown - world.time)/(1 SECONDS))] seconds!"))
		return
	check_cooldown = world.time + 30 SECONDS
	var/mob/current_control = get_mob_by_key(key_to_revive)
	if (!current_control?.client)
		to_chat(user, error)
		return
	if (!isobserver(current_control) && current_control != to_revive)
		spin_away()
		return
	var/check_revive = alert(current_control, "Someone is trying to revive you via essence cube, do you want to be revived as [to_revive.real_name]?", "Revival", "Yes", "No", "Never")
	switch(check_revive)
		if("No")
			to_chat(user, error)
			return
		if("Never")
			if (alert(current_control, "Are you sure? The essence cube will be deleted.", "Confirmation", "Delete it", "Don't delete it") == "Delete it")
				spin_away()
			else
				to_chat(user, error)
			return
	if (isnull(check_revive)) //just in case
		to_chat(user, error)
		return
	to_revive.revive(full_heal=TRUE)
	if (current_control != to_revive)
		var/datum/mind/mind = current_control.mind
		mind.transfer_to(to_revive)
	spin_away(FALSE)

/obj/item/essence_cube/proc/spin_away(fail=TRUE, delete_body=TRUE)
	if (is_deleting)
		return
	is_deleting = TRUE
	visible_message(span_warning("The essence cube begins to spin wildly!"))
	addtimer(CALLBACK(src, .proc/delete_self, fail, delete_body), (2 SECONDS))
	SpinAnimation(6)

/obj/item/essence_cube/proc/delete_self(fail=TRUE, delete_body=TRUE)
	UnregisterSignal(to_revive, COMSIG_PARENT_PREQDELETED)
	if (fail)
		visible_message(span_warning("<b>The essence cube suddenly spins itself out of existence!</b>"))
		if (delete_body)
			qdel(to_revive)
	else
		visible_message(span_warning("[to_revive.real_name] appears suddenly appears where the essence cube was!"))
		to_revive.forceMove(loc.drop_location()) //where the cube was
	qdel(src)
