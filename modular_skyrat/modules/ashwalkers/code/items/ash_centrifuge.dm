/obj/item/reagent_containers/cup/primitive_centrifuge
	name = "primitive centrifuge"
	desc = "A small cup that allows a person to slowly spin out liquids they do not desire."
	icon = 'modular_skyrat/modules/ashwalkers/icons/misc_tools.dmi'
	icon_state = "primitive_centrifuge"
	volume = 100
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR

/obj/item/reagent_containers/cup/primitive_centrifuge/examine()
	. = ..()
	. += span_notice("<b>Ctrl + Click</b> to select chemicals to remove.")
	. += span_notice("<b>Ctrl + Shift + Click</b> to select a chemical to keep, the rest removed.")

/obj/item/reagent_containers/cup/primitive_centrifuge/item_ctrl_click(mob/user)
	if(!length(reagents.reagent_list))
		return

	var/datum/user_input = tgui_input_list(user, "Select which chemical to remove.", "Removal Selection", reagents.reagent_list)

	if(!user_input)
		balloon_alert(user, "no selection")
		return

	user.balloon_alert_to_viewers("spinning [src]...")
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	if(!do_after(user, 5 SECONDS * skill_modifier, target = src))
		user.balloon_alert_to_viewers("stopped spinning [src]")
		return

	reagents.del_reagent(user_input.type)
	user.mind.adjust_experience(/datum/skill/primitive, 5)
	balloon_alert(user, "removed reagent from [src]")

/obj/item/reagent_containers/cup/primitive_centrifuge/click_ctrl_shift(mob/user)
	if(!length(reagents.reagent_list))
		return

	var/datum/user_input = tgui_input_list(user, "Select which chemical to keep, the rest removed.", "Keep Selection", reagents.reagent_list)

	if(!user_input)
		balloon_alert(user, "no selection")
		return

	user.balloon_alert_to_viewers("spinning [src]...")
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/primitive, SKILL_SPEED_MODIFIER)
	if(!do_after(user, 5 SECONDS * skill_modifier, target = src))
		user.balloon_alert_to_viewers("stopped spinning [src]")
		return

	for(var/datum/reagent/remove_reagent in reagents.reagent_list)
		if(!istype(remove_reagent, user_input.type))
			reagents.del_reagent(remove_reagent.type)

	user.mind.adjust_experience(/datum/skill/primitive, 5)
	balloon_alert(user, "removed reagents from [src]")
