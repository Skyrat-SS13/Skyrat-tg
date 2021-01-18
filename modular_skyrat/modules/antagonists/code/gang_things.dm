/obj/item/gang_induction_package/attack_self(mob/living/user)
	if(user.mind.assigned_role in GLOB.command_positions)
		to_chat(user, "Joining a gang would hurt profits, wouldn't it? Central wouldn't be happy.")
		user.emote("shake")
		return
	if(user.mind.assigned_role == "Blueshield")
		to_chat(user, "It'd be a terrible idea. What about the Heads of Staff?")
		user.emote("shake")
		return
	if(HAS_TRAIT(user, TRAIT_MINDSHIELD))
		to_chat(user, "You attended a seminar on not signing up for a gang and are not interested.")
		user.emote("shake")
		return
	..()
