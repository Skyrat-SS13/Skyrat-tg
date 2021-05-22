/mob/living/simple_animal
	/// If set to TRUE, ghosts will be able to click on the simple mob and take control of it.
	var/ghost_controllable = FALSE

/mob/living/simple_animal/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(.)
		return
	if(ghost_controllable)
		take_control(user)

/mob/living/simple_animal/proc/take_control(mob/user)
	if(key || stat)
		return
	if(is_banned_from(user.ckey, BAN_MOB_CONTROL))
		to_chat(user, "Error, you are banned from taking control of player controlled mobs!")
		return
	var/query = tgui_alert("Become a [src]?", "Take mob control", list("Yes", "No"))
	if(query == "No" || !src || QDELETED(src))
		return
	if(key)
		to_chat(user, "<span class='warning'>Someone else already took this mob!</span>")
		return
	key = user.key
	log_game("[key_name(src)] took control of [name].")
