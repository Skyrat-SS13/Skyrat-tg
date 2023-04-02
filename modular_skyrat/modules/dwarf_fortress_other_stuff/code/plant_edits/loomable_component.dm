/// COMPONENT THAT MAKES THINGS HAPPEN  WHEN YOU CLICK ON A LOOM WITH THE PARENT
/datum/component/loomable
	var/loom_result = /obj/item

/datum/component/loomable/Initialize(loom_result)
	. = ..()

	src.loom_result = loom_result

/datum/component/loomable/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_OBJ, PROC_REF(try_and_loom_me))
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))

/datum/component/loomable/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_ITEM_ATTACK_OBJ, COMSIG_PARENT_EXAMINE))

/datum/component/loomable/proc/try_and_loom_me(datum/source, atom/target, mob/living/user)
	SIGNAL_HANDLER

	if(!istype(target, /obj/structure/loom))
		return

	INVOKE_ASYNC(src, PROC_REF(loom_me), user, target)
	. = COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/loomable/proc/loom_me(mob/living/user, obj/structure/loom/target)
	if(!do_after(user, 2 SECONDS, target))
		return

	var/new_thing = new loom_result(target.drop_location())
	user.balloon_alert_to_viewers("spun [new_thing]")
	if(isstack(parent))
		var/obj/item/stack/stack_we_use = parent
		stack_we_use.use(1)
	else
		qdel(parent)

/datum/component/loomable/proc/on_examine(mob/living/source, mob/examiner, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("You could probably process [parent] at a <b>loom</b>.")
