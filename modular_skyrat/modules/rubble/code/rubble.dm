/obj/structure/rubble //Abstract parent type
	name = "rubble"
	icon = 'modular_skyrat/modules/rubble/icons/rubble.dmi'
	anchored = FALSE
	move_resist = MOVE_FORCE_EXTREMELY_STRONG
	density = TRUE
	can_buckle = TRUE
	layer = TABLE_LAYER
	buckle_lying = 90
	max_integrity = 100
	integrity_failure = 0.33
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/structure/rubble/Initialize(mapload)
	. = ..()
	if(!mapload)
		var/turf/my_turf = get_turf(src)
		if(!isopenspaceturf(my_turf))
			CrushTurf(my_turf)
		my_turf.zFall(src) //Needs to call this because apparently initialized movables dont get /turf/Entered()

/obj/structure/rubble/ex_act(severity, target)
	if(severity == EXPLODE_DEVASTATE)
		return ..()
	return FALSE

/obj/structure/rubble/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/rubble/user_buckle_mob(mob/living/M, mob/user, check_loc = TRUE)
	return

/obj/structure/rubble/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	if(buckled_mob != user)
		buckled_mob.visible_message("<span class='notice'>[user.name] pulls [buckled_mob.name] free from the rubble!</span>",\
			"<span class='notice'>[user.name] pulls you free from the rubble.</span>",\
			"<span class='hear'>You hear something being dragged...</span>")
	else
		buckled_mob.visible_message("<span class='warning'>[buckled_mob.name] struggles to break free from the rubble!</span>",\
			"<span class='notice'>You struggle to break free from the rubble... (Stay still for 30 seconds.)</span>",\
			"<span class='hear'>You hear struggling...</span>")
		if(!do_after(buckled_mob, 30 SECONDS, target = src))
			if(buckled_mob?.buckled)
				to_chat(buckled_mob, "<span class='warning'>You fail to get out!</span>")
			return
		if(!buckled_mob.buckled)
			return
		buckled_mob.visible_message("<span class='warning'>[buckled_mob.name] breaks free from the rubble!</span>",\
			"<span class='notice'>You break free from the rubble!</span>")
	unbuckle_mob(buckled_mob)

/obj/structure/rubble/welder_act(mob/living/user, obj/item/I)
	..()
	if(!I.tool_start_check(user, amount=0))
		return TRUE
	to_chat(user, "<span class='notice'>You start welding the [src] down...</span>")
	if(I.use_tool(src, user, 8 SECONDS, volume=50))
		to_chat(user, "<span class='notice'>You weld the [src] down.</span>")
		qdel(src)
	return TRUE

/obj/structure/rubble/onZImpact(turf/T, levels)
	playsound(src, 'sound/effects/bang.ogg', 50, TRUE)
	CrushTurf(T, 20 * levels)

/obj/structure/rubble/proc/CrushTurf(turf/Turf, power = 10)
	for(var/mob/living/living_mob in Turf)
		living_mob.visible_message("<span class='warning'>[living_mob.name] is crushed under the rubble!</span>",\
			"<span class='userdanger'>Rubble crushes you, pinning you under its weight!</span>",\
			"<span class='hear'>You hear crashing...</span>")
		living_mob.adjustBruteLoss(power)
		living_mob.Paralyze(2 SECONDS)
		buckle_mob(living_mob, TRUE)

/obj/structure/rubble/large
	desc = "A large pile of rubble, rendering the terrain unpassable. You probably could weld this down."
	icon_state = "rubble_big"

/obj/structure/rubble/large/metal
	icon_state = "rubble_big_metal"

/obj/structure/rubble/medium
	desc = "A pile of rubble, you could probably climb over it. You probably could weld this down."
	icon_state = "rubble_medium"
	pass_flags_self = PASSTABLE | LETPASSTHROW

/obj/structure/rubble/medium/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)

/turf/proc/create_rubble(adjacent = FALSE)
	var/rubble_type = prob(50) ? /obj/structure/rubble/medium/metal : /obj/structure/rubble/large/metal
	var/turf/destination = src
	if(adjacent)
		immediate_calculate_adjacent_turfs()
		var/list/adjacent_turfs = get_atmos_adjacent_turfs()
		var/list/free_turfs = list()
		for(var/i in adjacent_turfs)
			var/turf/Turf = i
			if(!Turf.is_blocked_turf(TRUE))
				free_turfs += Turf
		if(length(free_turfs))
			destination = pick(free_turfs)
		else if(length(adjacent_turfs))
			destination = pick(adjacent_turfs)
	new rubble_type(destination)

/obj/structure/rubble/medium/metal
	icon_state = "rubble_medium_metal"
