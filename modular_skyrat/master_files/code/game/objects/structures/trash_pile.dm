/obj/structure/trash_pile
	name = "trash pile"
	desc = "A heap of garbage, but maybe there's something interesting inside?"
	icon = 'modular_skyrat/master_files/icons/obj/trash_piles.dmi'
	icon_state = "randompile"
	density = TRUE
	anchored = TRUE
	layer = TABLE_LAYER
	obj_flags = CAN_BE_HIT
	pass_flags = LETPASSTHROW

	max_integrity = 50

	var/hide_person_time = 30
	var/hide_item_time = 15

	var/list/searchedby	= list()// Characters that have searched this trashpile, with values of searched time.

/obj/structure/trash_pile/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/climbable)
	icon_state = pick(
		"pile1",
		"pile2",
		"pilechair",
		"piletable",
		"pilevending",
		"brtrashpile",
		"microwavepile",
		"rackpile",
		"boxfort",
		"trashbag",
		"brokecomp",
	)

/obj/structure/trash_pile/proc/do_search(mob/user)
	if(contents.len) //There's something hidden
		var/atom/hidden_atom = contents[contents.len] //Get the most recent hidden thing
		if(istype(hidden_atom, /mob/living))
			var/mob/living/hidden_mob = hidden_atom
			to_chat(user, span_notice("You found someone in the trash!"))
			eject_mob(hidden_mob)
		else if (istype(hidden_atom, /obj/item))
			var/obj/item/hidden_item = hidden_atom
			to_chat(user, span_notice("You found something!"))
			hidden_item.forceMove(src.loc)
	else
		//You already searched this one bruh
		if(user.ckey in searchedby)
			to_chat(user, span_warning("There's nothing else for you in \the [src]!"))
		//You found an item!
		else
			produce_alpha_item()
			to_chat(user, span_notice("You found something!"))
			searchedby += user.ckey

/obj/structure/trash_pile/attack_hand(mob/user)
	//Human mob
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		human_user.visible_message("[user] searches through \the [src].", span_notice("You search through \the [src]."))
		//Do the searching
		if(do_after(user, rand(4 SECONDS, 6 SECONDS), target = src))
			if(src.loc) //Let's check if the pile still exists
				do_search(user)
	else
		return ..()

//Random lists
/obj/structure/trash_pile/proc/produce_alpha_item()
	var/lootspawn = pick_weight(GLOB.maintenance_loot)
	while(islist(lootspawn))
		lootspawn = pick_weight(lootspawn)
	var/obj/item/hidden_item = new lootspawn(get_turf(src))
	return hidden_item

/obj/structure/trash_pile/MouseDrop_T(atom/movable/dropped_atom, mob/user)
	if(user == dropped_atom && iscarbon(dropped_atom))
		var/mob/living/dropped_mob = dropped_atom
		if(dropped_mob.mobility_flags & MOBILITY_MOVE)
			dive_in_pile(user)
			return
	. = ..()

/obj/structure/trash_pile/proc/eject_mob(var/mob/living/hidden_mob)
	hidden_mob.forceMove(src.loc)
	to_chat(hidden_mob, span_warning("You've been found!"))
	playsound(hidden_mob.loc, 'sound/machines/chime.ogg', 50, FALSE, -5)
	hidden_mob.do_alert_animation(hidden_mob)

/obj/structure/trash_pile/proc/do_dive(mob/user)
	if(contents.len)
		for(var/mob/hidden_mob in contents)
			to_chat(user, span_warning("There's someone in the trash already!"))
			eject_mob(hidden_mob)
			return FALSE
	return TRUE

/obj/structure/trash_pile/proc/dive_in_pile(mob/user)
	user.visible_message(span_warning("[user] starts diving into [src]."), \
								span_notice("You start diving into [src]..."))
	var/adjusted_dive_time = hide_person_time
	if(HAS_TRAIT(user, TRAIT_RESTRAINED)) //hiding takes twice as long when restrained.
		adjusted_dive_time *= 2

	if(do_mob(user, user, adjusted_dive_time))
		if(src.loc) //Checking if structure has been destroyed
			if(do_dive(user))
				to_chat(user, span_notice("You hide in the trashpile."))
				user.forceMove(src)

/obj/structure/trash_pile/proc/can_hide_item(obj/item/hidden_item)
	if(contents.len > 10)
		return FALSE
	return TRUE

/obj/structure/trash_pile/attackby(obj/item/hidden_item, mob/living/user, params)
	if(!user.combat_mode)
		if(can_hide_item(hidden_item))
			to_chat(user, span_notice("You begin to stealthily hide [hidden_item] in the [src]."))
			if(do_mob(user, user, hide_item_time))
				if(src.loc)
					if(user.transferItemToLoc(hidden_item, src))
						to_chat(user, span_notice("You hide [hidden_item] in the trash."))
					else
						to_chat(user, span_warning("\The [hidden_item] is stuck to your hand, you cannot put it in the trash!"))
		else
			to_chat(user, span_warning("The [src] is way too full to fit [hidden_item]."))
		return

	. = ..()

/obj/structure/trash_pile/Destroy()
	for(var/atom/movable/pile_contents in src)
		pile_contents.forceMove(src.loc)
	return ..()

/obj/structure/trash_pile/container_resist_act(mob/user)
	user.forceMove(src.loc)

/obj/structure/trash_pile/relaymove(mob/user)
	container_resist_act(user)
