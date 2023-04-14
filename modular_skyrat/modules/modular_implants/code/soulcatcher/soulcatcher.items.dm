/obj/item/soulcatcher_item
	name = "soulcatcher item"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "soulstone"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	/// What soulcatcher datum is associated with this item?
	var/datum/component/soulcatcher/linked_soulcatcher

/obj/item/soulcatcher_item/attack_self(mob/user, modifiers)
	. = ..()
	linked_soulcatcher.ui_interact(user)

/obj/item/soulcatcher_item/New(loc, ...)
	. = ..()
	linked_soulcatcher = AddComponent(/datum/component/soulcatcher)

/obj/item/soulcatcher_item/attack(mob/living/target_mob, mob/living/user, params)
	if(!target_mob)
		return ..()

	if(!target_mob.mind)
		to_chat(user, span_warning("[target_mob] doesn't seem to have a soul..."))
		return ..()

	if(target_mob.stat == DEAD) //We can temporarily store souls of dead mobs.
		var/mob/dead/observer/target_ghost = target_mob.get_ghost(TRUE, TRUE)
		if(!target_ghost)
			to_chat(user, span_warning("You are unable to get the soul of [target_mob]!"))
			return FALSE

		var/datum/soulcatcher_room/target_room = tgui_input_list(user, "Chose a room to send [target_mob]'s soul to.", name, linked_soulcatcher.soulcatcher_rooms)
		if(!target_room)
			return FALSE

		if(tgui_alert(target_ghost, "[user] wants to transfer you to a soulcatcher, do you accept?", name, list("Yes", "No"), autofocus = TRUE) != "Yes")
			to_chat(user, span_warning("[target_mob]'s doesn't seem to want to enter."))

		if(target_room.add_soul_from_ghost(target_ghost))
			return FALSE

		var/datum/component/previous_body/body_component = target_mob.GetComponent(/datum/component/previous_body)
		if(!body_component)
			return FALSE

		body_component.body_scan_needed = FALSE
