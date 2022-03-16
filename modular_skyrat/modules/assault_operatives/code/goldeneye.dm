GLOBAL_LIST_EMPTY(goldeneye_keys)


/**
 * GoldenEye defence network
 *
 * Contains: Key and Terminal
 */

/obj/item/goldeneye_key
	name = "\improper GoldenEye Authentication Key"
	desc = "A high profile authentication key to Nanotrasens GoldenEye defence network."
	icon = 'modular_skyrat/modules/assault_operatives/icons/goldeneye.dmi'
	icon_state = "goldeneye_key"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/extract_name = "NO DATA"
	var/datum/objective/interrogate/linked_objective

/obj/item/goldeneye_key/Initialize(mapload)
	. = ..()
	GLOB.goldeneye_keys += src
	name = "\improper GoldenEye Authentication Key: G[rand(10000, 100000)]"

/obj/item/goldeneye_key/examine(mob/user)
	. = ..()
	. += "The DNA data link belongs to: [extract_name]"

/obj/item/goldeneye_key/Destroy(force)
	linked_objective.linked_key = null
	linked_objective = null
	GLOB.goldeneye_keys -= src
	return ..()

/obj/machinery/goldeneye_upload_terminal
	name = "\improper GoldenEye Defnet Upload Terminal"
	desc = "An ominous terminal with some ports and keypads, the screen is scrolling with illegable nonsense. It has a strange marking on the side, a red ring with a gold circle within."
	icon = 'modular_skyrat/modules/assault_operatives/icons/goldeneye.dmi'
	icon_state = "goldeneye_terminal"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/goldeneye_upload_terminal/attackby(obj/item/weapon, mob/user, params)
	. = ..()
	if(!istype(weapon, /obj/item/goldeneye_key))
		say("AUTHENTICATION ERROR: Please do not insert foreign objects into terminal.")
		playsound(src, 'sound/machines/nuke/angry_beep.ogg', 100)
		return
	var/obj/item/goldeneye_key/inserting_key = weapon
	say("GOLDENEYE KEY ACCEPTED: Please wait while the key is verified...")
	playsound(src, 'sound/machines/nuke/general_beep.ogg', 100)
	if(do_after(user, 10 SECONDS, src))
		say("GOLDENEYE KEY AUTHENTICATED!")
		inserting_key.linked_objective.goldeneye_key_uploaded = TRUE
		inserting_key.linked_objective.linked_key = null
		inserting_key.linked_objective = null
		priority_announce("GOLDENEYE DEFENCE NETWORK SECURITY INTEGRITY LOST, KEYCARD STOLEN AND UPLOADED.", "GoldenEye Defence Network")
		qdel(inserting_key)

/obj/item/pinpointer/nuke/goldeneye
	name = "goldeneye keycard pinpointer"
	desc = "A handheld tracking device that locks onto certain signals. This one is configured to locate any GoldenEye keycards."
	icon_state = "pinpointer_syndicate"
	worn_icon_state = "pinpointer_black"
	active = TRUE
	mode = TRACK_GOLDENEYE

/obj/item/pinpointer/nuke/goldeneye/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSfastprocess, src)

/obj/item/pinpointer/nuke/goldeneye/attack_self(mob/living/user)
	if(!LAZYLEN(GLOB.goldeneye_keys))
		to_chat(user, span_danger("ERROR! No GoldenEye keys detected!"))
		return
	target = tgui_input_list(user, "Select GoldenEye key to track", "GoldenEye key", GLOB.goldeneye_keys)
	if(target)
		to_chat(user, span_notice("Set to track: [target.name]"))

/obj/item/pinpointer/nuke/goldeneye/scan_for_target()
	if(QDELETED(target))
		target = null

/proc/get_goldeneye_target(mob/living/target)
	for(var/datum/objective/interrogate/objective in GLOB.objectives)
		if(objective.target == target.mind)
			return objective
	return FALSE
