/obj/item/implant/stealth
	name = "S3 implant"
	desc = "Allows you to be hidden in plain sight."
	actions_types = list(/datum/action/item_action/agent_box)

/obj/item/implanter/stealth
	name = "implanter" // Skyrat edit , was originaly implanter (stealth)
	imp_type = /obj/item/implant/stealth
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE // Skyrat edit
	special_desc = "A Syndicate implanter used for a stealth implant" // Skyrat edit

//Box Object

/obj/structure/closet/cardboard/agent
	name = "inconspicious box"
	desc = "It's so normal that you didn't notice it before."
	icon_state = "agentbox"
	max_integrity = 1 // "This dumb box shouldn't take more than one hit to make it vanish."
	move_speed_multiplier = 0.5
	enable_door_overlay = FALSE

/obj/structure/closet/cardboard/agent/Initialize(mapload)
	. = ..()
	go_invisible()

/obj/structure/closet/cardboard/agent/proc/go_invisible()
	animate(src, alpha = 0, time = 20)

/obj/structure/closet/cardboard/agent/after_open(mob/living/user)
	. = ..()
	qdel(src)

/obj/structure/closet/cardboard/agent/process()
	alpha = max(0, alpha - 50)

/obj/structure/closet/cardboard/agent/proc/reveal()
	alpha = 255
	addtimer(CALLBACK(src, PROC_REF(go_invisible)), 10, TIMER_OVERRIDE|TIMER_UNIQUE)

/obj/structure/closet/cardboard/agent/Bump(atom/A)
	. = ..()
	if(istype(A, /obj/machinery/door))
		for(var/mob/mob_in_box in contents)
			A.Bumped(mob_in_box)
	if(isliving(A))
		reveal()

/obj/structure/closet/cardboard/agent/Bumped(atom/movable/A)
	. = ..()
	if(isliving(A))
		reveal()
