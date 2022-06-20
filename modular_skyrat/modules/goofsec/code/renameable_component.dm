/datum/component/renameable

/datum/component/renameable/Initialize(required_level)
	. = ..()
	if(!isobj(parent))
		return COMPONENT_INCOMPATIBLE
	var/obj/confirmed_obj = parent
	RegisterSignal(confirmed_obj, COMSIG_PARENT_ATTACKBY, .proc/on_attackby)
	RegisterSignal(confirmed_obj, COMSIG_PARENT_EXAMINE, .proc/on_examined)

/datum/component/renameable/Destroy(force, silent)
	var/obj/confirmed_obj = parent
	UnregisterSignal(confirmed_obj, list(COMSIG_PARENT_ATTACKBY, COMSIG_PARENT_EXAMINE))
	..()

/datum/component/renameable/proc/on_examined(datum/source, mob/user, list/examine_text)
	SIGNAL_HANDLER
	examine_text += span_notice("[parent] can be renamed with a pen.")

/datum/component/renameable/proc/on_attackby(datum/source, obj/item/potential_pen, mob/living/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/stupid_async_shit, potential_pen, user)

/datum/component/renameable/proc/stupid_async_shit(obj/item/potential_pen, mob/living/user)
	var/obj/confirmed_obj = parent
	if(istype(potential_pen, /obj/item/pen))
		// This sucks and is totally copied from pen.dm, but this should be refactored upstream to fully use this component.
		// I'll probably upstream this for the GBP eventually.
		var/penchoice = tgui_input_list(user, "What would you like to edit?", "Pen Setting", list("Rename", "Description", "Reset"))
		if(QDELETED(confirmed_obj) || !user.canUseTopic(confirmed_obj, BE_CLOSE))
			return
		if(penchoice == "Rename")
			var/input = tgui_input_text(user, "What do you want to name [confirmed_obj]?", "Object Name", "[confirmed_obj.name]", MAX_NAME_LEN)
			var/oldname = confirmed_obj.name
			if(QDELETED(confirmed_obj) || !user.canUseTopic(confirmed_obj, BE_CLOSE))
				return
			if(input == oldname || !input)
				to_chat(user, span_notice("You changed [confirmed_obj] to... well... [confirmed_obj]."))
			else
				confirmed_obj.AddComponent(/datum/component/rename, input, confirmed_obj.desc) // This also needs removed and refactored because lmfao
				var/datum/component/label/label = confirmed_obj.GetComponent(/datum/component/label)
				if(label)
					label.remove_label()
					label.apply_label()
				to_chat(user, span_notice("You have successfully renamed \the [oldname] to [confirmed_obj]."))
				confirmed_obj.renamedByPlayer = TRUE

		if(penchoice == "Description")
			var/input = tgui_input_text(user, "Describe [confirmed_obj]", "Description", "[confirmed_obj.desc]", 140)
			var/olddesc = confirmed_obj.desc
			if(QDELETED(confirmed_obj) || !user.canUseTopic(confirmed_obj, BE_CLOSE))
				return
			if(input == olddesc || !input)
				to_chat(user, span_notice("You decide against changing [confirmed_obj]'s description."))
			else
				confirmed_obj.AddComponent(/datum/component/rename, confirmed_obj.name, input)
				to_chat(user, span_notice("You have successfully changed [confirmed_obj]'s description."))
				confirmed_obj.renamedByPlayer = TRUE

		if(penchoice == "Reset")
			if(QDELETED(confirmed_obj) || !user.canUseTopic(confirmed_obj, BE_CLOSE))
				return

			qdel(confirmed_obj.GetComponent(/datum/component/rename))

			//reapply any label to name
			var/datum/component/label/label = confirmed_obj.GetComponent(/datum/component/label)
			if(label)
				label.remove_label()
				label.apply_label()

			to_chat(user, span_notice("You have successfully reset [confirmed_obj]'s name and description."))
			confirmed_obj.renamedByPlayer = FALSE
