/obj/item/reagent_containers/glass/primitive_centrifuge
	name = "primitive centrifuge"
	desc = "A small cup that allows a person to slowly spin out liquids they do not desire."
	icon = 'modular_skyrat/modules/ashwalkers/icons/misc_tools.dmi'
	icon_state = "primitive_centrifuge"

/obj/item/reagent_containers/glass/primitive_centrifuge/examine()
	. = ..()
	. += span_notice("Ctrl + Click to select chemicals to remove.")
	. += span_notice("Ctrl + Shift + Click to select a chemical to keep, the rest removed.")

/obj/item/reagent_containers/glass/primitive_centrifuge/CtrlClick(mob/user)
	if(!length(reagents.reagent_list))
		return
	var/datum/user_input = tgui_input_list(user, "Select which chemical to remove.", "Removal Selection", reagents.reagent_list)
	if(!user_input)
		to_chat(user, span_warning("A selection was not made."))
		return
	if(!do_after(user, 5 SECONDS, target = src))
		to_chat(user, span_warning("You stopped attempting to spin out the chemicals."))
		return
	reagents.del_reagent(user_input.type)
	to_chat(user, span_notice("You remove a reagent from [src]."))

/obj/item/reagent_containers/glass/primitive_centrifuge/CtrlShiftClick(mob/user)
	if(!length(reagents.reagent_list))
		return
	var/datum/user_input = tgui_input_list(user, "Select which chemical to keep, the rest removed.", "Keep Selection", reagents.reagent_list)
	if(!user_input)
		to_chat(user, span_warning("A selection was not made."))
		return
	if(!do_after(user, 5 SECONDS, target = src))
		to_chat(user, span_warning("You stopped attempting to spin out the chemicals."))
		return
	for(var/datum/reagent/remove_reagent in reagents.reagent_list)
		if(!istype(remove_reagent, user_input.type))
			reagents.del_reagent(remove_reagent.type)
	to_chat(user, span_notice("You kept a chemical from [src]."))
