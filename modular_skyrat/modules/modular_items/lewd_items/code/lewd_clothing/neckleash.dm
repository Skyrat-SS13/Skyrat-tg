/*
#define STATUS_EFFECT_LEASH_PET /datum/status_effect/leash_pet
#define STATUS_EFFECT_LEASH_DOM /datum/status_effect/leash_dom
#define STATUS_EFFECT_LEASH_FREEPET /datum/status_effect/leash_freepet
#define MOVESPEED_ID_LEASH      "LEASH"

/*
*	STATUS EFFECTS
*/

//These are mostly used as flags for the states each member can be in

/datum/status_effect/leash_dom
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null

/datum/status_effect/leash_freepet
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null

/datum/status_effect/leash_pet
	id = "leashed"
	status_type = STATUS_EFFECT_UNIQUE
	var/datum/weakref/redirect_component
	alert_type = null

/datum/movespeed_modifier/leash_pet/leash_pet_slowdown
	multiplicative_slowdown = 3

/datum/status_effect/leash_pet/on_apply()
	redirect_component = WEAKREF(owner.AddComponent(/datum/component/redirect, list(COMSIG_LIVING_RESIST = CALLBACK(src, .proc/owner_resist))))
	if(!owner.stat)
		to_chat(owner, span_userdanger("You have been leashed!"))
	return ..()

//This lets the pet resist their leash
/datum/status_effect/leash_pet/proc/owner_resist()
	to_chat(owner, "You reach for the hook on your collar...")
	//Determine how long it takes to remove the leash
	var/deleash = 15
	//if(owner.get_item_by_slot(SLOT_HANDCUFFED))  //Commented out because there is no clear way to make this proc BEFORE decuff on resist.
		//deleash = 100
	if(do_mob(owner, owner, deleash))//do_mob creates a progress bar and then enacts the code after. Owner, owner, because it's an act on themself
		if(!QDELETED(src))
			to_chat(owner, span_warning("[owner] has removed their leash!"))
			owner.remove_status_effect(/datum/status_effect/leash_pet)

/obj/item/leash
	name = "leash"
	desc = "Leather leash that can easily be hooked onto a collar. Perfect for your pet."
	icon_state = "neckleash"
	inhand_icon_state = "neckleash"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	throw_range = 4
	slot_flags = ITEM_SLOT_BELT
	force = 1
	throwforce = 1
	w_class = WEIGHT_CLASS_TINY

	//leash stuff
	var/leash_used = 0 //A flag to see if the leash has been used yet, because for some reason picking up an unused leash is weird
	var/mob/living/leash_pet = null //Variable to store our pet later
	var/mob/living/leash_master = null //And our master too
	var/leash_location[3] //Three digit list for us to store coordinates later
	var/datum/beam/current_leash = null

	//visual stuff
	var/color_changed = FALSE
	var/current_color = "pink"
	var/static/list/leash_designs
	var/datum/beam/leashrope = null

//VISUAL STUFF//
//create radial menu
/obj/item/leash/proc/populate_leash_designs()
	leash_designs = list(
		"pink" = image (icon = src.icon, icon_state = "neckleash_pink"),
		"teal" = image(icon = src.icon, icon_state = "neckleash_teal"))

//to update model lol
/obj/item/leash/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change color
/obj/item/leash/AltClick(mob/user)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user, src, leash_designs, custom_check = CALLBACK(src, .proc/check_menu, user, I), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		update_icon_state()
		color_changed = TRUE

//to check if we can change leash's model
/obj/item/leash/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/leash/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(leash_designs))
		populate_leash_designs()

/obj/item/leash/update_icon_state()
	. = ..()
	icon_state = icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

//LEASH STUFF//
/obj/item/leash/attack(mob/living/carbon/human/C, mob/living/user) //C is the target, user is the one with the leash
	.=..()
	if(C.has_status_effect(/datum/status_effect/leash_pet)) //If the pet is already leashed, do not leash them. For the love of god.
		to_chat(user, span_notice("[C] has already been leashed."))
		return
	if(istype(C.get_item_by_slot(ITEM_SLOT_NECK), /obj/item/clothing/neck/petcollar) || istype(C.get_item_by_slot(ITEM_SLOT_NECK), /obj/item/electropack/shockcollar) || istype(C.get_item_by_slot(ITEM_SLOT_NECK), /obj/item/clothing/neck/kink_collar) || istype(C.get_item_by_slot(ITEM_SLOT_NECK), /obj/item/clothing/neck/kink_collar/locked))
		var/leashtime = 50
		if(C.handcuffed)
			leashtime = 5
		if(do_mob(user, C, leashtime)) //do_mob adds a progress bar, but then we also check to see if they have a collar
			log_combat(user, C, "leashed", addition = "playfully")
			//TODO: Figure out how to make an easy breakout for leashed leash_pets
			C.apply_status_effect(/datum/status_effect/leash_pet)//Has now been leashed
			user.apply_status_effect(/datum/status_effect/leash_dom) //Is the leasher
			leash_pet = C //Save pet reference for later
			leash_master = user //Save dom reference for later
			RegisterSignal(leash_pet, COMSIG_MOVABLE_MOVED, .proc/on_pet_move)
			RegisterSignal(leash_master, COMSIG_MOVABLE_MOVED, .proc/on_master_move)

			var/datum/beam/new_leash = Beam(C, icon_state = "leash", maxdistance = 5, beam_type = /obj/effect/ebeam/leash)
			RegisterSignal(new_leash, COMSIG_PARENT_QDELETING, .proc/remove_leash, new_leash)

			if(!leash_pet.has_status_effect(/datum/status_effect/leash_dom)) //Add slowdown if the pet didn't leash themselves
				leash_pet.add_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
			for(var/mob/viewing in viewers(user, null))
				if(viewing == leash_master)
				else
					viewing.show_message(span_warning("[leash_pet] has been leashed by [leash_master]!"), 1)
			if(leash_pet.has_status_effect(/datum/status_effect/leash_dom)) //Pet leashed themself. They are not the dom
				leash_pet.apply_status_effect(/datum/status_effect/leash_freepet)
				leash_pet.remove_status_effect(/datum/status_effect/leash_dom)
			while(1) //While true loop. The mark of a genius coder.  ##MAINLOOP START
				sleep(2) //Check every other tick
				if(leash_pet == null) //No pet, break loop
					return
				if(!(leash_pet.get_item_by_slot(ITEM_SLOT_NECK))) //The pet has slipped their collar and is not the pet anymore.
					for(var/mob/viewing in viewers(user, null))
						viewing.show_message(span_notice("[leash_pet] has slipped out of their collar!!"), 1)
					to_chat(leash_pet, span_notice("You have slipped out of your collar!"))
					to_chat(loc, span_notice("[leash_pet] has slipped out of their collar!"))
					leash_pet.remove_status_effect(/datum/status_effect/leash_pet)

				if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet)) //If there is no pet, there is no dom. Loop breaks.
					UnregisterSignal(leash_master, COMSIG_MOVABLE_MOVED)
					UnregisterSignal(leash_pet, COMSIG_MOVABLE_MOVED)
					if(leash_pet.has_status_effect(/datum/status_effect/leash_freepet))
						leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
					if(leash_pet.has_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown))
						leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
					if(!leash_master == null)
						leash_master.remove_status_effect(/datum/status_effect/leash_dom)
					leash_used = 0 //reset the leash to neutral
					leash_pet = null
					return

	else //No collar, no fun
		var/leash_message = pick("Your pet needs a collar")
		to_chat(user, span_notice("[leash_message]"))

/obj/effect/ebeam/leash
	name = "leash"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'
	mouse_opacity = MOUSE_OPACITY_ICON
	desc = "A thin latex rope. Someone is having fun."

/obj/item/leash/proc/remove_leash(datum/beam/leashrope)
	qdel(leashrope)
	current_leash = null

//somestuff
/obj/item/leash/attack_self(mob/living/user)
	.=..()
	if(!leash_master || !leash_pet)
		return
	//Yank the pet. Yank em in close.
	if(leash_pet.x > leash_master.x + 1)
		step(leash_pet, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
		if(leash_pet.y > leash_master.y)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.x < leash_master.x - 1)
		step(leash_pet, EAST, 1)
		if(leash_pet.y > leash_master.y)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.y > leash_master.y + 1)
		step(leash_pet, SOUTH, 1)
		if(leash_pet.x > leash_master.x)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)
	if(leash_pet.y < leash_master.y - 1)
		step(leash_pet, NORTH, 1)
		if(leash_pet.x > leash_master.x)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)

/obj/item/leash/proc/on_master_move()
	SIGNAL_HANDLER

	//Make sure the dom still has a pet
	if(leash_master == null) //There must be a master
		return
	if(leash_pet == null) //There must be a pet
		return
	if(leash_pet == leash_master) //Pet is the master
		return
	if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet))
		UnregisterSignal(leash_master, COMSIG_MOVABLE_MOVED)
		leash_master.remove_status_effect(/datum/status_effect/leash_dom)
		return

	//If the master moves, pull the pet in behind
	sleep(2) //A small sleep so the pet kind of bounces back after they make the step
	//Also, the sleep means that the distance check for master happens before the pet, to prevent both from proccing.

	if(leash_master == null) //Just to stop error messages
		return
	if(leash_pet == null)
		return
	if(leash_pet.x > leash_master.x + 2)
		step(leash_pet, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
		if(leash_pet.y > leash_master.y)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.x < leash_master.x - 2)
		step(leash_pet, EAST, 1)
		if(leash_pet.y > leash_master.y)
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.y > leash_master.y + 2)
		step(leash_pet, SOUTH, 1)
		if(leash_pet.x > leash_master.x)
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)
	if(leash_pet.y < leash_master.y - 2)
		step(leash_pet, NORTH, 1)
		if(leash_pet.x > leash_master.x)
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)

	//Knock the pet over if they get further behind. Shouldn't happen too often.
	sleep(3) //This way running normally won't just yank the pet to the ground.
	if(leash_master == null) //Just to stop error messages. Break the loop early if something removed the master
		return
	if(leash_pet == null)
		return
	if(leash_pet.x > leash_master.x + 3 || leash_pet.x < leash_master.x - 3 || leash_pet.y > leash_master.y + 3 || leash_pet.y < leash_master.y - 3)
		//var/leash_knockdown_message = "[leash_pet] got pulled to the ground by their leash!"
		//to_chat(leash_master, span_notice("[leash_knockdown_message]"))
		//to_chat(leash_pet, span_notice("[leash_knockdown_message]"))
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)

	//This code is to check if the pet has gotten too far away, and then break the leash.
	sleep(3) //Wait to snap the leash
	if(leash_master == null) //Just to stop error messages
		return
	if(leash_pet == null)
		return
	if(leash_pet.x > leash_master.x + 5 || leash_pet.x < leash_master.x - 5 || leash_pet.y > leash_master.y + 5 || leash_pet.y < leash_master.y - 5)
		var/leash_break_message = "The leash snapped free from [leash_pet]!"
		for(var/mob/viewing in viewers(leash_pet, null))
			if(viewing == leash_master)
				to_chat(leash_master, span_warning("The leash snapped free from your pet!"))
			if(viewing == leash_pet)
				to_chat(leash_pet, span_warning("Your leash has popped from your collar!"))
			else
				viewing.show_message(span_warning("[leash_break_message]"), 1)
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)
		leash_pet.adjustOxyLoss(5)
		leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
		leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
		leash_master.remove_status_effect(/datum/status_effect/leash_dom)
		UnregisterSignal(leash_master, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(leash_pet, COMSIG_MOVABLE_MOVED)
		leash_pet = null
		leash_master = null
		leash_used = 0

/obj/item/leash/proc/on_pet_move()
	SIGNAL_HANDLER

	if(leash_pet.has_status_effect(/datum/status_effect/leash_freepet))
		on_freepet_move()
		return
	//This should only work if there is a pet and a master.
	//This is here pretty much just to stop the console from flooding with errors
	if(leash_master == null)
		return
	if(leash_pet == null)
		return
	//Make sure the pet is still a pet
	if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet))
		UnregisterSignal(leash_pet, COMSIG_MOVABLE_MOVED)
		return

	//The pet has escaped. There is no DOM. GO PET RUN.
	if(leash_pet.has_status_effect(/datum/status_effect/leash_freepet))//If the pet is free, break
		return

	//If the pet gets too far away, they get tugged back
	sleep(3)//A small sleep so the pet kind of bounces back after they make the step
	if(leash_master == null)
		return
	if(leash_pet == null)
		return
	//West tug
	if(leash_pet.x > leash_master.x + 2)
		step(leash_pet, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
	//East tug
	if(leash_pet.x < leash_master.x - 2)
		step(leash_pet, EAST, 1)
	//South tug
	if(leash_pet.y > leash_master.y + 2)
		step(leash_pet, SOUTH, 1)
	//North tug
	if(leash_pet.y < leash_master.y - 2)
		step(leash_pet, NORTH, 1)

/obj/item/leash/proc/on_freepet_move()
	//Pet is on the run. Let's drag the leash behind them.
	if(!leash_master == null) //If there is a master, don't do this
		return
	if(leash_pet == null) //If there is no pet, don't do this
		return
	if(leash_pet.is_holding_item_of_type(/obj/item/leash)) //If the pet is holding the leash, don't do this
		return

	sleep(2)
	if(leash_pet == null)
		return
	//Double move to catch the leash up to the pet
	if(src.x > leash_pet.x + 2)
		. = step(src, WEST, 1)
	if(src.x < leash_pet.x - 2)
		. = step(src, EAST, 1)
	if(src.y > leash_pet.y + 2)
		. = step(src, SOUTH, 1)
	if(src.y < leash_pet.y - 2)
		. = step(src, NORTH, 1)
	//Primary dragging code
	if(src.x > leash_pet.x + 1)
		. = step(src, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
		if(src.y > leash_pet.y)//Check the other axis, and tug them into alignment so they are behind the pet
			. = step(src, SOUTH, 1)
		if(src.y < leash_pet.y)
			. = step(src, NORTH, 1)
	if(src.x < leash_pet.x - 1)
		. = step(src, EAST, 1)
		if(src.y > leash_pet.y)
			. = step(src, SOUTH, 1)
		if(src.y < leash_pet.y)
			. = step(src, NORTH, 1)
	if(src.y > leash_pet.y + 1)
		. = step(src, SOUTH, 1)
		if(src.x > leash_pet.x)
			. = step(src, WEST, 1)
		if(src.x < leash_pet.x)
			. = step(src, EAST, 1)
	if(src.y < leash_pet.y - 1)
		. = step(src, NORTH, 1)
		if(src.x > leash_pet.x)
			. = step(src, WEST, 1)
		if(src.x < leash_pet.x)
			. = step(src, EAST, 1)

	sleep(1)
	//Just to prevent error messages
	if(leash_pet == null)
		return
	if(src.x > leash_pet.x + 5 || src.x < leash_pet.x - 5 || src.y > leash_pet.y + 5 || src.y < leash_pet.y - 5)
		var/leash_break_message = "The leash snapped free from [leash_pet]!"
		for(var/mob/viewing in viewers(leash_pet, null))
			if(viewing == leash_pet)
				to_chat(leash_pet, span_warning("Your leash has popped from your collar!"))
			else
				viewing.show_message(span_warning("[leash_break_message]"), 1)
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)
		leash_pet.adjustOxyLoss(5)
		leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
		UnregisterSignal(leash_pet, COMSIG_MOVABLE_MOVED)
		leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
		leash_pet = null
		leash_used = 0

/obj/item/leash/dropped() //Drop the leash, and the leash effects stop
	. = ..()
	leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
	leash_master.remove_status_effect(/datum/status_effect/leash_dom)
	leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
	leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
	leash_pet = null
	leash_master = null
	UnregisterSignal(leash_master, COMSIG_MOVABLE_MOVED)
	leash_used = 0

	/*
	//Dropping procs any time the leash changes slots. So, we will wait a tick and see if the leash was actually dropped
	sleep(1)
	if(leash_master.is_holding_item_of_type(/obj/item/leash) || istype(leash_master.get_item_by_slot(ITEM_SLOT_BELT), /obj/item/leash))
		return  //Dom still has the leash as it turns out. Cancel the proc.
	for(var/mob/viewing in viewers(leash_master, null))
		viewing.show_message(span_notice("[leash_master] has dropped the leash."), 1)
	//DOM HAS DROPPED LEASH. PET IS FREE. SCP HAS BREACHED CONTAINMENT.
	leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
	leash_master.remove_status_effect(/datum/status_effect/leash_dom) //No dom with no leash. We will get a new dom if the leash is picked back up.
	leash_master = null
	UnregisterSignal(leash_master, COMSIG_MOVABLE_MOVED)
	*/
/*
/obj/item/leash/equipped(mob/user)
	. = ..()

	if(leash_used == 0) //Don't apply statuses with a fresh leash. Keeps things clean on the backend.
		return
	sleep(2)
	if(leash_pet == null)
		return
	leash_master = user
	if(leash_master.has_status_effect(/datum/status_effect/leash_freepet) || leash_master.has_status_effect(/datum/status_effect/leash_pet)) //Pet picked up their own leash.
		leash_master = null
		return
	leash_master.apply_status_effect(/datum/status_effect/leash_dom)
	RegisterSignal(leash_master, COMSIG_MOVABLE_MOVED, .proc/on_master_move)
	leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
	leash_pet.add_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
*/
/*

/*
*	OBJECT
*/

//The leash object itself
//The component variables are used for hooks, used later.

/obj/item/leash
	name = "leash"
	desc = "Leather leash that can easily be hooked onto a collar. Perfect for your pet."
	icon_state = "neckleash"
	inhand_icon_state = "neckleash"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_belts.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_belts.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	throw_range = 4
	slot_flags = ITEM_SLOT_BELT
	force = 1
	throwforce = 1
	w_class = WEIGHT_CLASS_TINY
	var/leash_used = 0 //A flag to see if the leash has been used yet, because for some reason picking up an unused leash is weird
	var/mob/living/leash_pet = null //Variable to store our pet later
	var/mob/living/leash_master = null //And our master too
	var/leash_location[3] //Three digit list for us to store coordinates later
	var/color_changed = FALSE
	var/current_color = "pink"
	var/static/list/leash_designs
	var/datum/beam/leashrope = null

//Leash beam
/obj/effect/ebeam/leashrope
	name = "leash"
	mouse_opacity = MOUSE_OPACITY_ICON
	desc = "A leash, connected to someone else's collar."
	icon_state = "leashrope"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_decals/lewd_decals.dmi'

//create radial menu
/obj/item/leash/proc/populate_leash_designs()
	leash_designs = list(
		"pink" = image (icon = src.icon, icon_state = "neckleash_pink"),
		"teal" = image(icon = src.icon, icon_state = "neckleash_teal"))

//to update model lol
/obj/item/leash/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change color
/obj/item/leash/AltClick(mob/user)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user, src, leash_designs, custom_check = CALLBACK(src, .proc/check_menu, user, radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		update_icon_state()
		color_changed = TRUE

//to check if we can change leash's model
/obj/item/leash/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/leash/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(leash_designs))
		populate_leash_designs()

/obj/item/leash/update_icon_state()
	. = ..()
	icon_state = icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

//Called when someone is clicked with the leash
/obj/item/leash/attack(mob/living/carbon/C, mob/living/user) // C is the target, user is the one with the leash
	.=..()
	if(C.has_status_effect(/datum/status_effect/leash_pet)) //If the pet is already leashed, do not leash them. For the love of god.
		to_chat(user, span_notice("[C] has already been leashed."))
		return
	if(istype(C.get_item_by_slot(ITEM_SLOT_NECK), /obj/item/clothing/neck/petcollar) || istype(C.get_item_by_slot(ITEM_SLOT_NECK), /obj/item/electropack/shockcollar) || istype(C.get_item_by_slot(ITEM_SLOT_NECK), /obj/item/clothing/neck/kink_collar) || istype(C.get_item_by_slot(ITEM_SLOT_NECK), /obj/item/clothing/neck/kink_collar/locked))
		var/leashtime = 50
		if(C.handcuffed)
			leashtime = 5
		if(do_mob(user, C, leashtime)) //do_mob adds a progress bar, but then we also check to see if they have a collar
			log_combat(user, C, "leashed", addition = "playfully")
			//TODO: Figure out how to make an easy breakout for leashed leash_pets
			C.apply_status_effect(/datum/status_effect/leash_pet)//Has now been leashed
			user.apply_status_effect(/datum/status_effect/leash_dom) //Is the leasher
			leash_pet = C //Save pet reference for later
			leash_master = user //Save dom reference for later
			RegisterSignal(leash_pet, COMSIG_MOVABLE_MOVED, .proc/on_pet_move)
			RegisterSignal(leash_master, COMSIG_MOVABLE_MOVED, .proc/on_master_move)

			leashrope = user.Beam(leash_pet, icon_state = "leashrope", time = INFINITE, beam_type = /obj/effect/ebeam/leashrope)
			RegisterSignal(leashrope, COMSIG_PARENT_QDELETING)//this is a WAY better rangecheck than what was done before (process check)

			leash_used = 1
			if(!leash_pet.has_status_effect(/datum/status_effect/leash_dom)) //Add slowdown if the pet didn't leash themselves
				leash_pet.add_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
			for(var/mob/viewing in viewers(user, null))
				if(viewing == leash_master)
				else
					viewing.show_message(span_warning("[leash_pet] has been leashed by [leash_master]!"), 1)
			if(leash_pet.has_status_effect(/datum/status_effect/leash_dom)) //Pet leashed themself. They are not the dom
				leash_pet.apply_status_effect(/datum/status_effect/leash_freepet)
				leash_pet.remove_status_effect(/datum/status_effect/leash_dom)
			while(1) //While true loop. The mark of a genius coder.  ##MAINLOOP START
				sleep(2) //Check every other tick
				if(leash_pet == null) //No pet, break loop
					return
				if(!(leash_pet.get_item_by_slot(ITEM_SLOT_NECK))) //The pet has slipped their collar and is not the pet anymore.
					for(var/mob/viewing in viewers(user, null))
						viewing.show_message(span_notice("[leash_pet] has slipped out of their collar!!"), 1)
					to_chat(leash_pet, span_notice("You have slipped out of your collar!"))
					to_chat(loc, span_notice("[leash_pet] has slipped out of their collar!"))
					leash_pet.remove_status_effect(/datum/status_effect/leash_pet)

					qdel(leashrope)
					leashrope = null

				if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet)) //If there is no pet, there is no dom. Loop breaks.
					UnregisterSignal(leash_master, COMSIG_MOVABLE_MOVED)
					UnregisterSignal(leash_pet, COMSIG_MOVABLE_MOVED)
					if(leash_pet.has_status_effect(/datum/status_effect/leash_freepet))
						leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
					if(leash_pet.has_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown))
						leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
					if(!leash_master == null)
						leash_master.remove_status_effect(/datum/status_effect/leash_dom)
					leash_used = 0 //reset the leash to neutral
					leash_pet = null
					return

	else //No collar, no fun
		var/leash_message = pick("Your pet needs a collar")
		to_chat(user, span_notice("[leash_message]"))

//Called when the leash is used in hand
//Tugs the pet closer
/obj/item/leash/attack_self(mob/living/user)
	.=..()
	if(!leash_pet == null) //No pet, no tug.
		return
	//Yank the pet. Yank em in close.
	if(leash_pet.x > leash_master.x + 1)
		step(leash_pet, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
		if(leash_pet.y > leash_master.y)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.x < leash_master.x - 1)
		step(leash_pet, EAST, 1)
		if(leash_pet.y > leash_master.y)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.y > leash_master.y + 1)
		step(leash_pet, SOUTH, 1)
		if(leash_pet.x > leash_master.x)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)
	if(leash_pet.y < leash_master.y - 1)
		step(leash_pet, NORTH, 1)
		if(leash_pet.x > leash_master.x)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)

/obj/item/leash/proc/on_master_move()
	SIGNAL_HANDLER

	//Make sure the dom still has a pet
	if(leash_master == null) //There must be a master
		return
	if(leash_pet == null) //There must be a pet
		return
	if(leash_pet == leash_master) //Pet is the master
		return
	if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet))
		UnregisterSignal(leash_master, COMSIG_MOVABLE_MOVED)
		leash_master.remove_status_effect(/datum/status_effect/leash_dom)
		return

	//If the master moves, pull the pet in behind
	sleep(2) // A small sleep so the pet kind of bounces back after they make the step
	//Also, the sleep means that the distance check for master happens before the pet, to prevent both from proccing.

	if(leash_master == null) //Just to stop error messages
		return
	if(leash_pet == null)
		return
	if(leash_pet.x > leash_master.x + 2)
		step(leash_pet, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
		if(leash_pet.y > leash_master.y)//Check the other axis, and tug them into alignment so they are behind the master
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.x < leash_master.x - 2)
		step(leash_pet, EAST, 1)
		if(leash_pet.y > leash_master.y)
			step(leash_pet, SOUTH, 1)
		if(leash_pet.y < leash_master.y)
			step(leash_pet, NORTH, 1)
	if(leash_pet.y > leash_master.y + 2)
		step(leash_pet, SOUTH, 1)
		if(leash_pet.x > leash_master.x)
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)
	if(leash_pet.y < leash_master.y - 2)
		step(leash_pet, NORTH, 1)
		if(leash_pet.x > leash_master.x)
			step(leash_pet, WEST, 1)
		if(leash_pet.x < leash_master.x)
			step(leash_pet, EAST, 1)

	//Knock the pet over if they get further behind. Shouldn't happen too often.
	sleep(3) //This way running normally won't just yank the pet to the ground.
	if(leash_master == null) //Just to stop error messages. Break the loop early if something removed the master
		return
	if(leash_pet == null)
		return
	if(leash_pet.x > leash_master.x + 3 || leash_pet.x < leash_master.x - 3 || leash_pet.y > leash_master.y + 3 || leash_pet.y < leash_master.y - 3)
		//var/leash_knockdown_message = "[leash_pet] got pulled to the ground by their leash!"
		//to_chat(leash_master, span_notice("[leash_knockdown_message]"))
		//to_chat(leash_pet, span_notice("[leash_knockdown_message]"))
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)

	//This code is to check if the pet has gotten too far away, and then break the leash.
	sleep(3) //Wait to snap the leash
	if(leash_master == null) //Just to stop error messages
		return
	if(leash_pet == null)
		return
	if(leash_pet.x > leash_master.x + 5 || leash_pet.x < leash_master.x - 5 || leash_pet.y > leash_master.y + 5 || leash_pet.y < leash_master.y - 5)
		var/leash_break_message = "The leash snapped free from [leash_pet]!"
		for(var/mob/viewing in viewers(leash_pet, null))
			if(viewing == leash_master)
				to_chat(leash_master, span_warning("The leash snapped free from your pet!"))
			if(viewing == leash_pet)
				to_chat(leash_pet, span_warning("Your leash has popped from your collar!"))
			else
				viewing.show_message(span_warning("[leash_break_message]"), 1)
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)
		leash_pet.adjustOxyLoss(5)
		leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
		leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
		leash_master.remove_status_effect(/datum/status_effect/leash_dom)
		UnregisterSignal(leash_master, COMSIG_MOVABLE_MOVED)
		UnregisterSignal(leash_pet, COMSIG_MOVABLE_MOVED)
		leash_pet = null
		leash_master = null
		leash_used = 0

/obj/item/leash/proc/on_pet_move()
	SIGNAL_HANDLER

	if(leash_pet.has_status_effect(/datum/status_effect/leash_freepet))
		on_freepet_move()
		return
	//This should only work if there is a pet and a master.
	//This is here pretty much just to stop the console from flooding with errors
	if(leash_master == null)
		return
	if(leash_pet == null)
		return
	//Make sure the pet is still a pet
	if(!leash_pet.has_status_effect(/datum/status_effect/leash_pet))
		UnregisterSignal(leash_pet, COMSIG_MOVABLE_MOVED)
		return

	//The pet has escaped. There is no DOM. GO PET RUN.
	if(leash_pet.has_status_effect(/datum/status_effect/leash_freepet))//If the pet is free, break
		return

	//If the pet gets too far away, they get tugged back
	sleep(3) // A small sleep so the pet kind of bounces back after they make the step
	if(leash_master == null)
		return
	if(leash_pet == null)
		return
	//West tug
	if(leash_pet.x > leash_master.x + 2)
		step(leash_pet, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
	//East tug
	if(leash_pet.x < leash_master.x - 2)
		step(leash_pet, EAST, 1)
	//South tug
	if(leash_pet.y > leash_master.y + 2)
		step(leash_pet, SOUTH, 1)
	//North tug
	if(leash_pet.y < leash_master.y - 2)
		step(leash_pet, NORTH, 1)

/obj/item/leash/proc/on_freepet_move()
	//Pet is on the run. Let's drag the leash behind them.
	if(!leash_master == null) //If there is a master, don't do this
		return
	if(leash_pet == null) //If there is no pet, don't do this
		return
	if(leash_pet.is_holding_item_of_type(/obj/item/leash)) //If the pet is holding the leash, don't do this
		return

	sleep(2)
	if(leash_pet == null)
		return
	//Double move to catch the leash up to the pet
	if(src.x > leash_pet.x + 2)
		. = step(src, WEST, 1)
	if(src.x < leash_pet.x - 2)
		. = step(src, EAST, 1)
	if(src.y > leash_pet.y + 2)
		. = step(src, SOUTH, 1)
	if(src.y < leash_pet.y - 2)
		. = step(src, NORTH, 1)
	//Primary dragging code
	if(src.x > leash_pet.x + 1)
		. = step(src, WEST, 1) //"1" is the speed of movement. We want the tug to be faster than their slow current walk speed.
		if(src.y > leash_pet.y)//Check the other axis, and tug them into alignment so they are behind the pet
			. = step(src, SOUTH, 1)
		if(src.y < leash_pet.y)
			. = step(src, NORTH, 1)
	if(src.x < leash_pet.x - 1)
		. = step(src, EAST, 1)
		if(src.y > leash_pet.y)
			. = step(src, SOUTH, 1)
		if(src.y < leash_pet.y)
			. = step(src, NORTH, 1)
	if(src.y > leash_pet.y + 1)
		. = step(src, SOUTH, 1)
		if(src.x > leash_pet.x)
			. = step(src, WEST, 1)
		if(src.x < leash_pet.x)
			. = step(src, EAST, 1)
	if(src.y < leash_pet.y - 1)
		. = step(src, NORTH, 1)
		if(src.x > leash_pet.x)
			. = step(src, WEST, 1)
		if(src.x < leash_pet.x)
			. = step(src, EAST, 1)

	sleep(1)
	//Just to prevent error messages
	if(leash_pet == null)
		return
	if(src.x > leash_pet.x + 5 || src.x < leash_pet.x - 5 || src.y > leash_pet.y + 5 || src.y < leash_pet.y - 5)
		var/leash_break_message = "The leash snapped free from [leash_pet]!"
		for(var/mob/viewing in viewers(leash_pet, null))
			if(viewing == leash_pet)
				to_chat(leash_pet, span_warning("Your leash has popped from your collar!"))
			else
				viewing.show_message(span_warning("[leash_break_message]"), 1)
		leash_pet.apply_effect(20, EFFECT_KNOCKDOWN, 0)
		leash_pet.adjustOxyLoss(5)
		leash_pet.remove_status_effect(/datum/status_effect/leash_pet)
		UnregisterSignal(leash_pet, COMSIG_MOVABLE_MOVED)
		leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
		leash_pet = null
		leash_used = 0

/obj/item/leash/dropped() //Drop the leash, and the leash effects stop
	. = ..()
	if(leash_pet == null) //There is no pet. Stop this silliness
		return
	if(leash_master == null)
		return
	//Dropping procs any time the leash changes slots. So, we will wait a tick and see if the leash was actually dropped
	sleep(1)
	if(leash_master.is_holding_item_of_type(/obj/item/leash) || istype(leash_master.get_item_by_slot(ITEM_SLOT_BELT), /obj/item/leash))
		return  //Dom still has the leash as it turns out. Cancel the proc.
	for(var/mob/viewing in viewers(leash_master, null))
		viewing.show_message(span_notice("[leash_master] has dropped the leash."), 1)
	//DOM HAS DROPPED LEASH. PET IS FREE. SCP HAS BREACHED CONTAINMENT.
	leash_pet.remove_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)
	leash_master.remove_status_effect(/datum/status_effect/leash_dom) //No dom with no leash. We will get a new dom if the leash is picked back up.
	leash_master = null
	UnregisterSignal(leash_master, COMSIG_MOVABLE_MOVED)

/obj/item/leash/equipped(mob/user)
	. = ..()
	if(leash_used == 0) //Don't apply statuses with a fresh leash. Keeps things clean on the backend.
		return
	sleep(2)
	if(leash_pet == null)
		return
	leash_master = user
	if(leash_master.has_status_effect(/datum/status_effect/leash_freepet) || leash_master.has_status_effect(/datum/status_effect/leash_pet)) //Pet picked up their own leash.
		leash_master = null
		return
	leash_master.apply_status_effect(/datum/status_effect/leash_dom)
	RegisterSignal(leash_master, COMSIG_MOVABLE_MOVED, .proc/on_master_move)
	leash_pet.remove_status_effect(/datum/status_effect/leash_freepet)
	leash_pet.add_movespeed_modifier(/datum/movespeed_modifier/leash_pet/leash_pet_slowdown)

*/
*/
