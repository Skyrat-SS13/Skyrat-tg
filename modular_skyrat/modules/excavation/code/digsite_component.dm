#define ARTIFACTS_LOW_RAND 1
#define ARTIFACTS_HIGH_RAND 4

#define DIG_DEPTH_LOW 9
#define DIG_DEPTH_HIGH 36

/datum/component/digsite
	var/current_dig_depth = 0
	var/find_list = list()
	var/mutable_appearance/rocky_overlay

/datum/component/digsite/Initialize(amount)
	. = ..()
	if(!isturf(parent))
		return COMPONENT_INCOMPATIBLE
	var/artifacts = amount
	if(!artifacts)
		artifacts = rand(ARTIFACTS_LOW_RAND,ARTIFACTS_HIGH_RAND)

	var/counted_depth = 0
	for(var/i in 1 to artifacts)
		var/added_depth = rand(DIG_DEPTH_LOW,DIG_DEPTH_HIGH)
		counted_depth += added_depth
		var/path = pickweight(GLOB.excavation_finds_weight)
		var/datum/excavation_find/new_find = new path()
		find_list["[counted_depth]"] = new_find

/datum/component/digsite/proc/DoDig(mob/user, dug_depth)
	current_dig_depth += dug_depth
	var/atom/A = parent
	if(!rocky_overlay)
		rocky_overlay = mutable_appearance('icons/excavation/excavation.dmi', "rock")
		if(A.color)
			rocky_overlay.icon_state = "rock_greyscale"
			rocky_overlay.color = A.color
		A.add_overlay(rocky_overlay)
	for(var/text_depth in find_list)
		var/actual_depth = text2num(text_depth)
		var/datum/excavation_find/iterated_find = find_list[text_depth]
		if(current_dig_depth > actual_depth) //We broke it
			find_list -= iterated_find
			qdel(iterated_find)
			A.visible_message("<span class='warning'>Something cracks inside the [A]!</span>")
			playsound(A, 'sound/effects/break_stone.ogg', 30, TRUE)

		else if (current_dig_depth >= (actual_depth - iterated_find.clearance)) //Close dig
			var/obj/item/our_artifact = new iterated_find.type_to_spawn(A)
			if(current_dig_depth != actual_depth) //not perfect dig
				var/obj/item/strange_rock = new /obj/item/strange_rock(A)
				if(A.color)
					strange_rock.icon = 'icons/excavation/strange_rock_grayscale.dmi'
					strange_rock.color = A.color
				our_artifact.forceMove(strange_rock)
			find_list -= text_depth
			qdel(iterated_find)

	if(!length(find_list))
		qdel(src)

/datum/component/digsite/Destroy(force, silent)
	for(var/dpt in find_list)
		var/datum/excavation_find/iterated_find = find_list[dpt]
		find_list -= iterated_find
		qdel(iterated_find)
	if(rocky_overlay)
		//var/atom/A = parent
		//A.cut_overlay(rocky_overlay) ///Lack of this leaves a residual effect that the excavation took place
		qdel(rocky_overlay)
	return ..()

/datum/component/digsite/RegisterWithParent()
	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/AttackItem)

/datum/component/digsite/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_PARENT_ATTACKBY)

/datum/component/digsite/proc/AttackItem(datum/source, obj/item/I, mob/living/user)
	var/atom/A = parent
	if(istype(I, /obj/item/excavation_pick))
		var/obj/item/excavation_pick/pick = I
		if(do_after(user,pick.dig_speed, target = parent))
			if(QDELETED(src))
				return
			to_chat(user, "<span class='notice'>You dig [pick.dig_depth] centimeters deeper.</span>")
			playsound(A, pick.usesound, 50, 1, -1)
			DoDig(user, pick.dig_depth)
		return COMPONENT_NO_AFTERATTACK

	if(istype(I, /obj/item/excavation_measuring_tape))
		if(current_dig_depth)
			to_chat(user, "<span class='notice'>You measure the hole being [current_dig_depth] centimeters deep.</span>")
		return COMPONENT_NO_AFTERATTACK

	if(istype(I, /obj/item/excavation_depth_scanner))
		var/first_artifact_depth
		var/datum/excavation_find/first_pick
		for(var/i in find_list)
			first_artifact_depth = i
			first_pick = find_list[i]
			break
		to_chat(user, "<span class='notice'>Anomalous reading at the depth of [first_artifact_depth] cm, approximating clearance of [first_pick.clearance] cm. Reading a [first_pick.signature] signature.</span>.")
		return COMPONENT_NO_AFTERATTACK

	return FALSE

#undef ARTIFACTS_LOW_RAND
#undef ARTIFACTS_HIGH_RAND

#undef DIG_DEPTH_LOW
#undef DIG_DEPTH_HIGH
