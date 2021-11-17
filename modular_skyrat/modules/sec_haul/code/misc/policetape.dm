//Adapted from our TGMC-base server
/*----- Base items -----*/
/obj/item/taperoll
	name = "tape roll"
	desc = "An unlabeled tape roll, how pointless."
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/jobtape.dmi'
	icon_state = "police_start"	//Just in case shits fucked
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	var/turf/start
	var/turf/end
	var/tape_type = /obj/structure/jobtape
	var/icon_base = "police"	//Just in case shits fucked

/obj/structure/jobtape	//TGMC had this as an item. I have it as a structure, so that we can make it work with tile blocking* (*Don't worry, it's instantly broken upon being in combat mode. It only blocks polite people.)
	name = "tape"
	desc = "An unlabeled line of tape, how pointless."
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/jobtape.dmi'
	anchored = TRUE
	var/lifted = FALSE
	var/crumpled = FALSE
	var/icon_base = "police"	//Just in case shits fucked

/*----- Taping code, in this order: placement, actions, removal -----*/
/obj/item/taperoll/attack_self(mob/user as mob) //This one is pretty much a copy-paste, so dont ask me how the math works I failed that class. I /do/ know this is what handles placing the tape.
	if(icon_state == "[icon_base]_start")
		start = get_turf(src)
		to_chat(usr, span_notice("You place the first end of \the [src]."))
		icon_state = "[icon_base]_stop"
	else
		icon_state = "[icon_base]_start"
		end = get_turf(src)
		if(start.y != end.y && start.x != end.x || start.z != end.z)
			to_chat(usr, span_notice("\The [src] can only be laid horizontally or vertically."))
			return

		var/turf/cur = start
		var/dir
		if (start.x == end.x)
			var/d = end.y-start.y
			if(d) d = d/abs(d)
			end = get_turf(locate(end.x,end.y+d,end.z))
			dir = "v"	//V for Vertical
		else
			var/d = end.x-start.x
			if(d) d = d/abs(d)
			end = get_turf(locate(end.x+d,end.y,end.z))
			dir = "h"	//H for Horizontal

		var/can_place = 1
		while (cur!=end && can_place)
			if(cur.density == 1)
				can_place = 0
			else if (isspaceturf(cur))
				can_place = 0
			else
				for(var/obj/O in cur)
					if(!istype(O, /obj/structure/jobtape) && O.density)
						can_place = 0
						break
			cur = get_step_towards(cur,end)
		if (!can_place)
			to_chat(usr, span_notice("You can't run \the [src] through that!"))
			return

		cur = start
		var/tapetest = 0
		while (cur!=end)
			for(var/obj/structure/jobtape/Ptest in cur)
				if(Ptest.icon_state == "[Ptest.icon_base]_[dir]")
					tapetest = 1
			if(tapetest != 1)
				var/obj/structure/jobtape/P = new tape_type(cur)
				P.icon_state = "[P.icon_base]_[dir]"
			cur = get_step_towards(cur,end)
	//is_blocked_turf(var/turf/T) 			/*(what does this even do? it was commented out when I found it...)*/
		to_chat(usr, span_notice(" You finish placing \the [src].")	)

/obj/item/taperoll/afterattack(atom/A, mob/user as mob, proximity)
	if (proximity && istype(A, /obj/machinery/door/airlock))
		var/turf/T = get_turf(A)
		if(locate(/obj/structure/jobtape) in T)	//Check if the door already has tape
			to_chat(user, span_notice("This door is already taped!"))
			return
		var/obj/structure/jobtape/ourtape = new tape_type(T.x,T.y,T.z)
		ourtape.loc = locate(T.x,T.y,T.z)
		ourtape.icon_state = "[src.icon_base]_door"
		ourtape.layer = ABOVE_WINDOW_LAYER
		to_chat(user, span_notice("You finish placing \the [src]."))

/obj/structure/jobtape/examine(mob/user)
	. = ..()
	. += span_notice("The tape is weak enough to easily push through on harm intent or by walking, though that'd be impolite...")
	if(allowed(user))
		. += span_notice("You can unroll the whole line by right-clicking with the tape roll!")
		. += span_notice("Clicking it with an empty hand will <b>lift</b> the tape, allowing anyone/anything to pass through.")

/obj/structure/jobtape/CanAllowThrough(atom/movable/mover, turf/target)	//This is low-key based off the holosigns, but modified to be better fitting for tape - people can't walk thru, but they can smash
	. = ..()
	if(iscarbon(mover))
		var/mob/living/carbon/target_carbon = mover
		if(allowed(target_carbon) || target_carbon.stat || lifted) //Unconcious/dead people won't be blocked by the tape, nor will people who have the right access; lifted tape lets anyone through
			return TRUE
		//if(allowed(target_carbon) && target_carbon.m_intent != MOVE_INTENT_WALK)	//Allowed people NEED to walk (?) ((If so, remove allowed(target_carbon) from above))
		if(!crumpled)
			if(target_carbon.combat_mode || target_carbon.m_intent == MOVE_INTENT_WALK)
				crumple()
				visible_message(span_notice("[target_carbon] pushes through \the [src] aggressively, ruining the tape!"))
				return TRUE
			else	//Good boi player obeys the tape
			/*to_chat(target_carbon, span_notice("You don't want to cross \the [src], it's there for a reason..."))*/ //-- I WANT to have it post a message, but need a way to avoid chatspamming people walking into it... --//
				return FALSE
		else
			return TRUE

/obj/structure/jobtape/proc/crumple()
	if(lifted)	//Just in case this somehow gets called while tape is already lifted (it shouldnt, but JUST in case), we quickly ditch anything about it
		lifted = FALSE
		alpha = 255
		name = initial(name)
	if(!crumpled)
		crumpled = TRUE
		icon_state = "[icon_state]_c"	//C is for Crumpled (and thats okay with me)
		name = "crumpled [name]"

/obj/structure/jobtape/proc/uncrumple()
	if(!do_after(usr, 1 SECONDS, target = usr))	//Fast to repair, but can't be spammed if you're moving about
		return
	crumpled = FALSE
	if(findtext(icon_state, "_door"))	//Check the icon to see if it's on a door
		icon_state = "[icon_base]_door"
	else if(findtext(icon_state, "_h"))	//Check the icon to see if it's horizontal
		icon_state = "[icon_base]_h"
	else	//Icon is implied to be vertical if it reaches this point
		icon_state = "[icon_base]_v"
	name = initial(name)
	visible_message(span_notice("[usr] repairs \the [src], restoring its quality."))

/obj/structure/jobtape/proc/lifttape()
	if(crumpled)
		to_chat(usr, span_notice("There's no point lifting damaged [src] - try repairing it first."))	//Find out how to make sure this doesnt post "damaged the tape", instead just "damaged tape"
		return
	else
		lifted = !lifted
		visible_message(span_notice("[usr] [lifted ? "lifts" : "lowers"] \the [src], [lifted ? "allowing" : "restricting"] passage."))
		if(!lifted)
			name = initial(name)
			alpha = 255
		else
			name = "lifted [name]"
			alpha = 175
		return

/obj/structure/jobtape/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/taperoll))	//Technically it works with any tape roll but dont tell the users that
		if(LAZYACCESS(params2list(params), RIGHT_CLICK) || allowed(user))
			breaktape(I, user)	//This only runs for tape if it's right-clicked and the user has access
		else if(crumpled)
			uncrumple()
		return	//Keeps non-rightclicked tape from triggering breaktape()
	breaktape(I, user) //Non-tape always runs this

/obj/structure/jobtape/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if (!user.combat_mode && allowed(user))	//Checks if they're on combat mode, and if they're allowed
		lifttape()
	else
		return
		//This was originally going to call crumple() when attacked with an empty hand, but for some reason it already calls CanAllowThrough's checks for it so I won't complain

/obj/structure/jobtape/attack_paw(mob/living/carbon/human/user)
	crumple()	//Monkeys get to ruin your tape hahaha

/obj/structure/jobtape/proc/breaktape(obj/item/useditem, mob/living/user, params)	//Handles actually removing the tape
	if(useditem.tool_behaviour == TOOL_WIRECUTTER || useditem.sharpness == SHARP_EDGED)
		visible_message(span_notice("[user] breaks \the [src]!"))
		qdel(src)
		return
	if(istype(useditem, /obj/item/taperoll))	//Should only trigger on right-click
		if(!do_after(usr, 3.5 SECONDS, target = usr))
			to_chat(usr, span_notice("You have to stand still to re-roll \the [src]!"))
			return
		//Again, IDK what the math and code hear entirely means, it's mostly unchanged from the TGMC code - I /assume/ this is meant to cut entire connected lines of tape
		var/dir[2]
		var/icon_dir = src.icon_state
		if(icon_dir == "[src.icon_base]_h")
			dir[1] = EAST
			dir[2] = WEST
		if(icon_dir == "[src.icon_base]_v")
			dir[1] = NORTH
			dir[2] = SOUTH
		for(var/i=1;i<3;i++)
			var/N = 0
			var/turf/cur = get_step(src,dir[i])
			while(N != 1)
				N = 1
				for (var/obj/structure/jobtape/P in cur)
					if(P.icon_state == icon_dir)
						N = 0
						qdel(P)
				cur = get_step(cur,dir[i])
		visible_message(span_notice("[user] re-rolls \the [src], cleanly removing the full line!"))
		qdel(src)
	else
		to_chat(user, span_notice("You can't break \the [src] with that!"))
		return

/*----- Actually usable tape types below this line -----*/
/obj/item/taperoll/police
	name = "police tape"
	desc = "A roll of police tape used to block off crime scenes from the public."
	icon_state = "police_start"
	tape_type = /obj/structure/jobtape/police
	icon_base = "police"

/obj/structure/jobtape/police
	name = "police tape"
	desc = "A length of police tape. Do not cross."
	req_one_access = list(ACCESS_SECURITY, ACCESS_FORENSICS_LOCKERS)
	icon_base = "police"

/obj/item/taperoll/engi
	name = "engineering tape"
	desc = "A roll of engineering tape used to block off construction zones from the public."
	icon_state = "engi_start"
	tape_type = /obj/structure/jobtape/engi
	icon_base = "engi"

/obj/structure/jobtape/engi
	name = "engineering tape"
	desc = "A length of engineering tape. Better not cross it."
	req_one_access = list(ACCESS_ENGINE_EQUIP)
	icon_base = "engi"

/obj/item/taperoll/atmos
	name = "atmospherics tape"
	desc = "A roll of atmospherics tape used to block off working areas and hazards from the public."
	icon_state = "atmos_start"
	tape_type = /obj/structure/jobtape/atmos
	icon_base = "atmos"

/obj/structure/jobtape/atmos
	name = "atmospherics tape"
	desc = "A length of atmospherics tape. Better not cross it."
	req_one_access = list(ACCESS_ENGINE_EQUIP, ACCESS_ATMOSPHERICS)
	icon_base = "atmos"

/obj/item/taperoll/med
	name = "medical tape"
	desc = "A roll of medical tape used to courdon off medical sites from the public."
	icon_state = "med_start"
	tape_type = /obj/structure/jobtape/med
	icon_base = "med"

/obj/structure/jobtape/med
	name = "medical tape"
	desc = "A length of medical tape. Better not cross it."
	req_one_access = list(ACCESS_MEDICAL)
	icon_base = "med"

/obj/item/taperoll/bio
	name = "biohazard tape"
	desc = "A roll of biohazard tape used to block off potentially infectious areas from the public."
	icon_state = "bio_start"
	tape_type = /obj/structure/jobtape/bio
	icon_base = "bio"

/obj/structure/jobtape/bio
	name = "biohazard tape"
	desc = "A length of biohazard tape. Do not cross."
	req_one_access = list(ACCESS_RESEARCH, ACCESS_MEDICAL, ACCESS_VIROLOGY, ACCESS_XENOBIOLOGY)
	icon_base = "bio"
