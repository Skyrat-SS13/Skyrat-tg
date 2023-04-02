/// COMPONENT THAT MAKES THINGS HAPPEN  WHEN YOU CLICK ON A LOOM WITH THE PARENT
/datum/component/loomable
	/// The blacklist of areas that the parent will be penalized for entering
	var/loom_result = /obj/item

/datum/component/loomable/Initialize(loom_result)
	. = ..()
	if(!isitem(parent))
		return COMPONENT_INCOMPATIBLE

	src.loom_result = loom_result

/datum/component/loomable/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOB_ITEM_AFTERATTACK, PROC_REF(try_and_loom_me))

/datum/component/loomable/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOB_ITEM_AFTERATTACK)

/datum/component/loomable/proc/try_and_loom_me(mob/living/user, obj/structure/loom/target, obj/item/loomee, proximity_flag, click_parameters)
	SIGNAL_HANDLER

	if(!proximity_flag)
		return
	if(!istype(target))
		return

	INVOKE_ASYNC(src, PROC_REF(loom_me), user, target)

/datum/component/loomable/proc/loom_me(mob/living/user, obj/structure/loom/target)
	if(!do_after(user, 2 SECONDS, target))
		return

	var/new_thing = new loom_result(target.drop_location())
	user.balloon_alert_to_viewers("spun [new_thing]")
	if(!isstack(parent))
		var/obj/item/stack/stack_we_use = parent
		stack_we_use.use(1)
	else
		qdel(parent)
