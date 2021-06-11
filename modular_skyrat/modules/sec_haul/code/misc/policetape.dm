//Adapted from our TGMC-base server
/obj/item/taperoll
	name = "tape roll"
	desc = "An unlabeled tape roll, how pointless."
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/jobtape.dmi'
	icon_state = "police_start"	//Just in case shits fucked
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	var/turf/start
	var/turf/end
	var/tape_type = /obj/item/jobtape
	var/icon_base = "police"	//Just in case shits fucked

/obj/item/jobtape
	name = "tape"
	icon = 'modular_skyrat/modules/sec_haul/icons/misc/jobtape.dmi'
	anchored = TRUE
	var/lifted = 0
	var/crumpled = 0
	var/icon_base = "police"	//Just in case shits fucked

/obj/item/taperoll/attack_self(mob/user as mob) //This one is pretty much a copy-paste, so dont ask me how the math works I failed that class
	if(icon_state == "[icon_base]_start")
		start = get_turf(src)
		to_chat(usr, "<span class='notice'>You place the first end of the [src].</span>")
		icon_state = "[icon_base]_stop"
	else
		icon_state = "[icon_base]_start"
		end = get_turf(src)
		if(start.y != end.y && start.x != end.x || start.z != end.z)
			to_chat(usr, "<span class='notice'>[src] can only be laid horizontally or vertically.</span>")
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
					if(!istype(O, /obj/item/jobtape) && O.density)
						can_place = 0
						break
			cur = get_step_towards(cur,end)
		if (!can_place)
			to_chat(usr, "<span class='notice'>You can't run \the [src] through that!</span>")
			return

		cur = start
		var/tapetest = 0
		while (cur!=end)
			for(var/obj/item/jobtape/Ptest in cur)
				if(Ptest.icon_state == "[Ptest.icon_base]_[dir]")
					tapetest = 1
			if(tapetest != 1)
				var/obj/item/jobtape/P = new tape_type(cur)
				P.icon_state = "[P.icon_base]_[dir]"
			cur = get_step_towards(cur,end)
	//is_blocked_turf(var/turf/T) 			/*(what does this even do?)*/
		to_chat(usr, "<span class='notice'> You finish placing the [src].</span>"	)

/obj/item/taperoll/afterattack(atom/A, mob/user as mob, proximity)
	if (proximity && istype(A, /obj/machinery/door/airlock))
		var/turf/T = get_turf(A)
		var/obj/item/jobtape/ourtape = new tape_type(T.x,T.y,T.z)
		ourtape.loc = locate(T.x,T.y,T.z)
		ourtape.icon_state = "[src.icon_base]_door"
		ourtape.layer = ABOVE_WINDOW_LAYER
		to_chat(user, "<span class='notice'>You finish placing the [src].</span>")

/obj/item/jobtape/proc/crumple()
	if(!crumpled)
		crumpled = 1
		icon_state = "[icon_state]_c"	//C is for Crumpled (and thats okay with me)
		name = "crumpled [name]"

/* FIX FIX FIX FIX FIX
/obj/item/jobtape/Crossed(atom/movable/AM)	//Fuck this isnt allowed to be overridden wtf wtf
	. = ..()
	if(!lifted && ismob(AM))
		var/mob/M = AM
		if(!allowed(M))	//Related job access won't crumple tape.
			if(ishuman(M))
				to_chat(M, "<span class='warning'>You are not supposed to go past [src]...</span>")
			crumple()
FIX FIX FIX FIX FIX*/

/obj/item/jobtape/attackby(obj/item/I, mob/user, params)
	. = ..()
	breaktape(I, user)

/obj/item/jobtape/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if (!user.combat_mode && allowed(user))	//Checks if they're on combat mode, and if they're allowed
		if(!lifted)
			user.visible_message("<span class='notice'>[user] lifts [src], allowing passage.</span>")
			crumple()	//Make a less ugly version for the lifted
			lifted = TRUE
			addtimer(VARSET_CALLBACK(src, lifted, FALSE), 20 SECONDS)
	else
		breaktape(null, user)

/obj/item/jobtape/attack_paw(mob/living/carbon/human/user)
	breaktape(/obj/item/wirecutters, user)	//Make this work with anything that functions as wirecutters, and with knives

/obj/item/jobtape/proc/breaktape(obj/item/useditem, mob/living/user, params)
	if(!(useditem.sharpness == SHARP_EDGED || useditem.tool_behaviour == TOOL_WIRECUTTER) && src.allowed(user))
		to_chat(user, "You can't break the [src] with that!")
		return
	user.visible_message("<span class='notice'> [user] breaks the [src]!</span>")

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
			for (var/obj/item/tape/P in cur)
				if(P.icon_state == icon_dir)
					N = 0
					qdel(P)
			cur = get_step(cur,dir[i])

	qdel(src)

/*-----Actually used tape types below this line -----*/
/obj/item/taperoll/police
	name = "police tape"
	desc = "A roll of police tape used to block off crime scenes from the public."
	icon_state = "police_start"
	tape_type = /obj/item/jobtape/police
	icon_base = "police"

/obj/item/jobtape/police
	name = "police tape"
	desc = "A length of police tape. Do not cross."
	req_one_access = list(ACCESS_SECURITY)
	icon_base = "police"

/obj/item/taperoll/engineering
	name = "engineering tape"
	desc = "A roll of engineering tape used to block off construction zones from the public."
	icon_state = "engineering_start"
	tape_type = /obj/item/jobtape/engineering
	icon_base = "engineering"

/obj/item/jobtape/engineering
	name = "engineering tape"
	desc = "A length of engineering tape. Better not cross it."
	req_one_access = list(ACCESS_ENGINE_EQUIP)
	icon_base = "engineering"

/obj/item/taperoll/atmos
	name = "atmospherics tape"
	desc = "A roll of atmospherics tape used to block off working areas and hazards from the public."
	icon_state = "atmos_start"
	tape_type = /obj/item/jobtape/atmos
	icon_base = "atmos"

/obj/item/jobtape/atmos
	name = "atmospherics tape"
	desc = "A length of atmospherics tape. Better not cross it."
	req_one_access = list(ACCESS_ATMOSPHERICS)
	icon_base = "atmos"

/obj/item/taperoll/med
	name = "medical tape"
	desc = "A roll of medical tape used to courdon off medical sites from the public."
	icon_state = "med_start"
	tape_type = /obj/item/jobtape/med
	icon_base = "med"

/obj/item/jobtape/med
	name = "medical tape"
	desc = "A length of medical tape. Better not cross it."
	req_one_access = list(ACCESS_MEDICAL)
	icon_base = "med"

/obj/item/taperoll/bio
	name = "biohazard tape"
	desc = "A roll of biohazard tape used to block off potentially infectious areas from the public."
	icon_state = "bio_start"
	tape_type = /obj/item/jobtape/bio
	icon_base = "bio"

/obj/item/jobtape/bio
	name = "biohazard tape"
	desc = "A length of biohazard tape. Do not cross."
	req_one_access = list(ACCESS_VIROLOGY, ACCESS_XENOBIOLOGY)
	icon_base = "bio"
