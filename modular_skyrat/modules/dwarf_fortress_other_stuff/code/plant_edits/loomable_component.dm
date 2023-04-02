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
	RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(try_and_loom_me))

/datum/component/loomable/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_ATTACK)

/datum/component/loomable/proc/try_and_loom_me(datum/source, obj/structure/loom/target, mob/living/user)
	SIGNAL_HANDLER

	if(!istype(target))
		return

	INVOKE_ASYNC(src, PROC_REF(loom_me), user, target)
	. = COMPONENT_CANCEL_ATTACK_CHAIN

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
