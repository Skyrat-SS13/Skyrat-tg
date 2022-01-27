/datum/component/dirtening
	///the probability that the component will do its dirty work
	var/dirtening_chance = 20
	///the amount that will change on the alpha of the dirt
	var/dirtening_amount = 10
	///the parent/linked human for the component
	var/mob/living/carbon/human/linked_human
	///the cooldown after a successful dirtening
	var/dirtening_cooldown = 10 SECONDS
	COOLDOWN_DECLARE(dirt_cooldown)

/datum/component/dirtening/Initialize(chance = null, amount = null)
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	linked_human = parent

	if(chance)
		dirtening_chance = chance

	if(amount)
		dirtening_amount = amount

	RegisterSignal(linked_human, COMSIG_MOVABLE_MOVED, .proc/try_dirtening)

/datum/component/dirtening/proc/try_dirtening()
	if(!COOLDOWN_FINISHED(src, dirt_cooldown))
		return
	var/turf/human_turf = get_turf(linked_human)
	//we cant dirty space turfs or closed turfs
	if(isspaceturf(human_turf) || isclosedturf(human_turf))
		return
	//if we aren't lucky
	if(!prob(dirtening_chance))
		return
	//try to find the dirt on the current turf
	var/obj/effect/decal/cleanable/dirt/chosen_dirt = locate() in human_turf
	//if there is no dirt, add it and the dirty amount
	if(!chosen_dirt)
		chosen_dirt = new(human_turf)
		chosen_dirt.alpha = dirtening_amount
		COOLDOWN_START(src, dirt_cooldown, dirtening_cooldown)
		return
	//if the dirt is maxed out, do nothing
	if(chosen_dirt.alpha >= 255)
		return
	//we look for the lower number, either the current alpha + 5 or 255
	chosen_dirt.alpha = min(chosen_dirt.alpha + dirtening_amount, 255)
	COOLDOWN_START(src, dirt_cooldown, dirtening_cooldown)
	//if the dirt is minimum of 0, just remove it
	if(chosen_dirt.alpha <= 0)
		qdel(chosen_dirt)

/mob/living/carbon/human/Initialize()
	. = ..()
	AddComponent(/datum/component/dirtening)
