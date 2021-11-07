///////////////////
///NORMAL COLLAR///
///////////////////

//To determine what kind of stuff we can put in collar.

/datum/component/storage/concrete/pockets/small/kink_collar
	max_items = 1

/datum/component/storage/concrete/pockets/small/kink_collar/Initialize()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie,
	/obj/item/food/cookie/sugar))

/datum/component/storage/concrete/pockets/small/kink_collar/locked/Initialize()
	. = ..()
	can_hold = typecacheof(list(
	/obj/item/food/cookie,
	/obj/item/food/cookie/sugar,
	/obj/item/key/kink_collar))

/datum/component/storage/concrete/pockets/small/kink_collar/mind_collar/Initialize()
	. = ..()
	can_hold = typecacheof(/obj/item/mind_controller)

//Here goes code for normal collar

/obj/item/clothing/neck/kink_collar
	name = "collar"
	desc = "A nice, tight collar. It fits snug to your skin"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "collar_cyan"
	inhand_icon_state = "collar_cyan"
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	w_class = WEIGHT_CLASS_SMALL
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/kink_collar
	var/tagname = null
	var/treat_path = /obj/item/food/cookie
	unique_reskin = list("Cyan" = "collar_cyan",
						"Yellow" = "collar_yellow",
						"Green" = "collar_green",
						"Red" = "collar_red",
						"Latex" = "collar_latex",
						"Orange" = "collar_orange",
						"White" = "collar_white",
						"Purple" = "collar_purple",
						"Black" = "collar_black",
						"Black-teal" = "collar_tealblack",
						"Spike" = "collar_spike")

//spawn thing in collar

/obj/item/clothing/neck/kink_collar/Initialize()
	. = ..()
	var/Key
	if(treat_path)
		Key = new treat_path(src)
		if(istype(Key,/obj/item/key/kink_collar))
			var/id = rand(111111,999999)
			var/obj/item/clothing/neck/kink_collar/locked/L = src
			var/obj/item/key/kink_collar/K = Key
			L.key_id = id
			K.key_id = id

//reskin code

/obj/item/clothing/neck/kink_collar/AltClick(mob/user)
	. = ..()
	if(unique_reskin && !current_skin && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		reskin_obj(user)

//rename collar code

/obj/item/clothing/neck/kink_collar/attack_self(mob/user)
	tagname = stripped_input(user, "Would you like to change the name on the tag?", "Name your new pet", "Spot", MAX_NAME_LEN)
	name = "[initial(name)] - [tagname]"

////////////////////////
///COLLAR WITH A LOCK///
////////////////////////

/obj/item/clothing/neck/kink_collar/locked
	name = "locked collar"
	desc = "A tight collar. It appears to have some kind of lock."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "lock_collar_cyan"
	inhand_icon_state = "lock_collar_cyan"
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/kink_collar/locked
	treat_path = /obj/item/key/kink_collar
	var/lock = FALSE
	var/broke = FALSE
	var/key_id = null //Adding unique id to collar
	unique_reskin = list("Cyan" = "lock_collar_cyan",
						"Yellow" = "lock_collar_yellow",
						"Green" = "lock_collar_green",
						"Red" = "lock_collar_red",
						"Latex" = "lock_collar_latex",
						"Orange" = "lock_collar_orange",
						"White" = "lock_collar_white",
						"Purple" = "lock_collar_purple",
						"Black" = "lock_collar_black",
						"Black-teal" = "lock_collar_tealblack",
						"Spike" = "lock_collar_spike")

//spawn thing in collar

//reskin code

/obj/item/clothing/neck/kink_collar/locked/AltClick(mob/user)
	. = ..()
	if(unique_reskin && !current_skin && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		reskin_obj(user)

//locking or unlocking collar code

/obj/item/clothing/neck/kink_collar/locked/proc/IsLocked(var/L,mob/user)
	if(!broke)
		if(L == TRUE)
			to_chat(user, span_warning("The collar locks with a resounding click!"))
			lock = TRUE
		if(L == FALSE)
			to_chat(user, span_warning("The collar unlocks with a small clunk."))
			lock = FALSE
			REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_NODROP)
	else
		to_chat(user, span_warning("It looks like the lock is broken - now it's just an ordinary old collar."))
		lock = FALSE
		REMOVE_TRAIT(src, TRAIT_NODROP, TRAIT_NODROP)

/obj/item/clothing/neck/kink_collar/locked/attackby(obj/item/K, mob/user, params)
	var/obj/item/clothing/neck/kink_collar/locked/collar = src
	if(istype(K, /obj/item/key/kink_collar))
		var/obj/item/key/kink_collar/key = K
		if(key.key_id==collar.key_id)
			if(lock != FALSE)
				IsLocked(FALSE,user)
			else
				IsLocked(TRUE,user)
		else
			to_chat(user, span_warning("This isn't the correct key!"))
	return

/obj/item/clothing/neck/kink_collar/locked/equipped(mob/living/U, slot)
	.=..()
	var/mob/living/carbon/human/H = U
	if(lock == TRUE && src == H.wear_neck)
		ADD_TRAIT(src, TRAIT_NODROP, TRAIT_NODROP)
		to_chat(H, span_warning("You hear a suspicious click around your neck - it seems the collar is now locked!"))

//this code prevents wearer from taking collar off if it's locked. Have fun!

/obj/item/clothing/neck/kink_collar/locked/attack_hand(mob/user)
	if(loc == user && user.get_item_by_slot(ITEM_SLOT_NECK) && lock != FALSE)
		to_chat(user, span_warning("The collar is locked! You'll need to unlock it before you can take it off!"))
		return
	add_fingerprint(usr)
	return ..()

/obj/item/clothing/neck/kink_collar/locked/MouseDrop(atom/over_object)
	var/mob/M = usr
	if(loc == usr && usr.get_item_by_slot(ITEM_SLOT_NECK) && lock != FALSE && istype(over_object, /atom/movable/screen/inventory/hand))
		to_chat(usr, span_warning("The collar is locked! You'll need to unlock it before you can take it off!"))
		return
	var/atom/movable/screen/inventory/hand/H = over_object
	if(M.putItemFromInventoryInHandIfPossible(src, H.held_index))
		add_fingerprint(usr)
	return ..()

//This is a KEY moment of this code. You got it. Key.
//...
//It's 2:56 of 08.04.2021, i want to sleep. Please laugh.

/obj/item/key/kink_collar
	name = "kink collar key"
	desc = "A key for a tiny lock on a collar or bag."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "collar_key"
	var/keyname = null//name of our key. It's null by default.
	var/key_id = null //Adding same unique id to key
	unique_reskin = list("Cyan" = "collar_key_blue",
						"Yellow" = "collar_key_yellow",
						"Green" = "collar_key_green",
						"Red" = "collar_key_red",
						"Latex" = "collar_key_latex",
						"Orange" = "collar_key_orange",
						"White" = "collar_key_white",
						"Purple" = "collar_key_purple",
						"Black" = "collar_key_black",
						"Metal" = "collar_key",
						"Black-teal" = "collar_key_tealblack")

//changing color of key in case if we using multiple collars
/obj/item/key/kink_collar/AltClick(mob/user)
	. = ..()
	if(unique_reskin && !current_skin && user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY))
		reskin_obj(user)

//changing name of key in case if we using multiple collars with same color
/obj/item/key/kink_collar/attack_self(mob/user)
	keyname = stripped_input(user, "Would you like to change the name on the key?", "Renaming key", "Key", MAX_NAME_LEN)
	name = "[initial(name)] - [keyname]"

//we checking if we can open collar with THAT KEY with SAME ID as the collar.
/obj/item/key/kink_collar/attack(mob/living/M, mob/living/user, params)
	. = ..()
	var/mob/living/carbon/target = M
	if(istype(target.wear_neck,/obj/item/clothing/neck/kink_collar/locked/))
		var/obj/item/key/kink_collar/key = src
		var/obj/item/clothing/neck/kink_collar/locked/collar = target.wear_neck
		if(collar.key_id == key.key_id)
			if(collar.lock != FALSE)
				collar.IsLocked(FALSE,user)
			else
				collar.IsLocked(TRUE,user)
		else
			to_chat(user, span_warning("This isn't the correct key!"))
	return

/obj/item/circular_saw/attack(mob/living/M, mob/living/user, params)
	. = ..()
	var/mob/living/carbon/target = M
	if(istype(target.wear_neck,/obj/item/clothing/neck/kink_collar/locked/))
		var/obj/item/clothing/neck/kink_collar/locked/collar = target.wear_neck
		if(!collar.broke)
			if(target != user)
				to_chat(user, span_warning("You try to cut the lock right off!"))
				if(do_after(user, 20, target))
					collar.broke = TRUE
					collar.IsLocked(FALSE,user)
					if(rand(0,2) == 0) //chance to get damage
						to_chat(user, span_warning("You successfully cut away the lock, but gave [target.name] several cuts in the process!"))
						target.apply_damage(rand(1,4),BRUTE,BODY_ZONE_HEAD,wound_bonus=10)
					else
						to_chat(user, span_warning("You successfully cut away the lock!"))
			else
				to_chat(user, span_warning("You try to cut the lock right off!"))
				if(do_after(user, 30, target))
					if(rand(0,2) == 0)
						to_chat(user, span_warning("You successfully cut away the lock, but gave yourself several cuts in the process!"))
						collar.broke = TRUE
						collar.IsLocked(FALSE,user)
						target.apply_damage(rand(2,4),BRUTE,BODY_ZONE_HEAD,wound_bonus=10)
					else
						to_chat(user, span_warning("You fail to cut away the lock, cutting yourself in the process!"))
						target.apply_damage(rand(3,5),BRUTE,BODY_ZONE_HEAD,wound_bonus=30)
		else
			to_chat(user, span_warning("The lock is already broken!"))

/////////////////////////
///MIND CONTROL COLLAR///
/////////////////////////

//Ok, first - it's not mind control. Just forcing someone to do emotes that user added to remote thingy. Just a funny illegal ERP toy.

//Controller stuff
/obj/item/mind_controller
	name = "mind controller"
	desc = "A small remote for sending basic emotion patterns to a collar."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	icon_state = "mindcontroller"
	var/obj/item/clothing/neck/mind_collar/collar = null
	w_class = WEIGHT_CLASS_SMALL

/obj/item/mind_controller/Initialize(mapload, collar)
    //Store the collar on creation.
	src.collar = collar
	. = ..() //very important to call parent in Intialize

/obj/item/mind_controller/attack_self(mob/user)
	if (collar)
		collar.emoting = stripped_input(user, "Change the emotion pattern")
		collar.emoting_proc()

//Collar stuff
/obj/item/clothing/neck/mind_collar
	name = "mind collar"
	desc = "A tight collar. It has some strange high-tech emitters on the side."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_neck.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_neck.dmi'
	icon_state = "mindcollar"
	inhand_icon_state = "mindcollar"
	var/obj/item/mind_controller/remote = null
	pocket_storage_component_path = /datum/component/storage/concrete/pockets/small/kink_collar/mind_collar
	var/emoting = "Shivers"

/obj/item/clothing/neck/mind_collar/Initialize()
	. = ..()
	remote = new /obj/item/mind_controller(src, src)
	remote.forceMove(src)

/obj/item/clothing/neck/mind_collar/proc/emoting_proc()
	var/mob/living/carbon/human/U = src.loc
	if(istype(U) && src == U.wear_neck)
		U.emote("me", 1,"[emoting]", TRUE)

/obj/item/clothing/neck/mind_collar/Destroy()
	if(remote)
		remote.collar = null
		remote = null
	return ..()
