#define DYE_OPTION_HAIR_COLOR "Change hair color"
#define DYE_OPTION_GRADIENT "Apply a gradient"

/**
 * Applies a gradient and a gradient color to a mob OR changes their hair color, depending on what they choose.
 *
 * Arguments:
 * * target - The mob who we will apply the hair color / gradient and gradient color to.
 * * user - The mob that is applying the hair color / gradient and gradient color.
 */
/obj/item/dyespray/proc/dye(mob/target, mob/user)
	if(!ishuman(target))
		return

	if(!uses) // Can be set to -1 for infinite uses, basically.
		balloon_alert(user, "it's empty!")
		return

	var/mob/living/carbon/human/human_target = target
	var/static/list/dye_options = list(DYE_OPTION_HAIR_COLOR, DYE_OPTION_GRADIENT)
	var/gradient_or_hair = tgui_alert(user, "What would you like to do?", "Hair Dye Spray", dye_options, autofocus = TRUE)
	if(!gradient_or_hair || !user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE))
		return

	var/dying_themselves = target == user
	if(gradient_or_hair == DYE_OPTION_HAIR_COLOR)
		var/new_color = input(usr, "Choose a hair color:", "Character Preference", "#" + human_target.hair_color) as color|null

		if(!new_color || !user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE))
			return


		human_target.visible_message(span_notice("[user] starts applying hair dye to [dying_themselves ? "their own" : "[human_target]'s"] hair..."), span_notice("[dying_themselves ? "You start" : "[user] starts"] applying hair dye to [dying_themselves ? "your own" : "your"] hair..."), ignored_mobs = user)
		if(!dying_themselves)
			balloon_alert(user, "dyeing...")
		if(!do_after(usr, 3 SECONDS, target))
			return
		human_target.hair_color = sanitize_hexcolor(new_color)

	else
		var/beard_or_hair = input(user, "What do you want to dye?", "Character Preference")  as null|anything in list("Hair", "Facial Hair")
		if(!beard_or_hair || !user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE))
			return

		var/list/choices = beard_or_hair == "Hair" ? GLOB.hair_gradients_list : GLOB.facial_hair_gradients_list
		var/new_grad_style = tgui_input_list(usr, "Choose a color pattern:", "Dye Spray", choices)
		if(!new_grad_style || !user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE))
			return

		var/new_grad_color = input(usr, "Choose a secondary hair color:", "Dye Spray", human_target.grad_color) as color|null
		if(!new_grad_color || !user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE))
			return

		human_target.visible_message(span_notice("[user] starts applying hair dye to [dying_themselves ? "their own" : "[human_target]'s"] hair..."), span_notice("[dying_themselves ? "You start" : "[user] starts"] applying hair dye to [dying_themselves ? "your own" : "your"] hair..."), ignored_mobs = user)
		if(!dying_themselves)
			balloon_alert(user, "dyeing...")
		if(!do_after(usr, 3 SECONDS, target))
			return
		var/gradient_key = beard_or_hair == "Hair" ? GRADIENT_HAIR_KEY : GRADIENT_FACIAL_HAIR_KEY
		LAZYSETLEN(human_target.grad_style, GRADIENTS_LEN)
		LAZYSETLEN(human_target.grad_color, GRADIENTS_LEN)
		human_target.grad_style[gradient_key] = new_grad_style
		human_target.grad_color[gradient_key] = sanitize_hexcolor(new_grad_color)
	playsound(src, 'sound/effects/spray.ogg', 5, TRUE, 5)
	human_target.visible_message(span_notice("[user] finishes applying hair dye to [dying_themselves ? "their own" : "[human_target]'s"] hair, changing its color!"), span_notice("[dying_themselves ? "You finish" : "[user] finishes"] applying hair dye to [dying_themselves ? "your own" : "your"] hair, changing its color!"), ignored_mobs = user)
	if(!dying_themselves)
		balloon_alert(user, "dyeing complete!")
	human_target.update_hair(is_creating = TRUE)

	uses--

/obj/item/dyespray/examine(mob/user)
	. = ..()
	. += "It has [uses] uses left."

#undef DYE_OPTION_HAIR_COLOR
#undef DYE_OPTION_GRADIENT
