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
	if(!gradient_or_hair || !user.can_perform_action(src, NEED_DEXTERITY))
		return

	var/dying_themselves = target == user
	if(gradient_or_hair == DYE_OPTION_HAIR_COLOR)
		var/new_color = input(usr, "Choose a hair color:", "Character Preference", "#" + human_target.hair_color) as color|null

		if(!new_color || !user.can_perform_action(src, NEED_DEXTERITY))
			return


		human_target.visible_message(span_notice("[user] starts applying hair dye to [dying_themselves ? "their own" : "[human_target]'s"] hair..."), span_notice("[dying_themselves ? "You start" : "[user] starts"] applying hair dye to [dying_themselves ? "your own" : "your"] hair..."), ignored_mobs = user)
		if(!dying_themselves)
			balloon_alert(user, "dyeing...")
		if(!do_after(usr, 3 SECONDS, target))
			return

		human_target.set_haircolor(sanitize_hexcolor(new_color), update = TRUE)

	else
		var/beard_or_hair = input(user, "What do you want to dye?", "Character Preference")  as null|anything in list("Hair", "Facial Hair")
		if(!beard_or_hair || !user.can_perform_action(src, NEED_DEXTERITY))
			return

		var/list/choices = beard_or_hair == "Hair" ? GLOB.hair_gradients_list : GLOB.facial_hair_gradients_list
		var/new_grad_style = tgui_input_list(usr, "Choose a color pattern:", "Dye Spray", choices)
		if(!new_grad_style || !user.can_perform_action(src, NEED_DEXTERITY))
			return

		var/new_grad_color = input(usr, "Choose a secondary hair color:", "Dye Spray", human_target.grad_color) as color|null
		if(!new_grad_color || !user.can_perform_action(src, NEED_DEXTERITY))
			return

		human_target.visible_message(span_notice("[user] starts applying hair dye to [dying_themselves ? "their own" : "[human_target]'s"] hair..."), span_notice("[dying_themselves ? "You start" : "[user] starts"] applying hair dye to [dying_themselves ? "your own" : "your"] hair..."), ignored_mobs = user)
		if(!dying_themselves)
			balloon_alert(user, "dyeing...")
		if(!do_after(usr, 3 SECONDS, target))
			return

		if(beard_or_hair == "Hair")
			human_target.set_hair_gradient_color(sanitize_hexcolor(new_grad_color), update = FALSE)
			human_target.set_hair_gradient_style(new_grad_style, update = TRUE)
		else
			human_target.set_facial_hair_gradient_color(sanitize_hexcolor(new_grad_color), update = FALSE)
			human_target.set_facial_hair_gradient_style(new_grad_style, update = TRUE)

	playsound(src, 'sound/effects/spray.ogg', 10, vary = TRUE)

	human_target.visible_message(span_notice("[user] finishes applying hair dye to [dying_themselves ? "their own" : "[human_target]'s"] hair, changing its color!"), span_notice("[dying_themselves ? "You finish" : "[user] finishes"] applying hair dye to [dying_themselves ? "your own" : "your"] hair, changing its color!"), ignored_mobs = user)
	if(!dying_themselves)
		balloon_alert(user, "dyeing complete!")

	uses--

/obj/item/dyespray/examine(mob/user)
	. = ..()
	. += "It has [uses] uses left."

#undef DYE_OPTION_HAIR_COLOR
#undef DYE_OPTION_GRADIENT
