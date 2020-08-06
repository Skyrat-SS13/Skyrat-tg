// Storage: Belt and Locker and Bag

/obj/item/storage/bag/strangerock
	name = "strange rock bag"
	desc = "A bag for strange rocks."
	icon = 'modular_skyrat/modules/xenoarch/icons/obj/tools.dmi'
	icon_state = "rockbag"
	w_class = WEIGHT_CLASS_TINY
	resistance_flags = FLAMMABLE
	var/mob/listeningTo
	var/range = null

	var/max_items = 10

	var/spam_protection = FALSE //If this is TRUE, the holder won't receive any messages when they fail to pick up ore through crossing it

/obj/item/storage/bag/strangerock/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_GIGANTIC
	STR.allow_quick_empty = TRUE
	STR.max_combined_w_class = 200
	STR.max_items = max_items
	STR.display_numerical_stacking = FALSE
	STR.can_hold = typecacheof(list(/obj/item/strangerock))


/obj/item/storage/bag/strangerock/equipped(mob/user)
	. = ..()
	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/Pickup_rocks)
	listeningTo = user

/obj/item/storage/bag/strangerock/dropped(mob/user)
	. = ..()
	if(listeningTo)
		UnregisterSignal(listeningTo, COMSIG_MOVABLE_MOVED)
	listeningTo = null

/obj/item/storage/bag/strangerock/proc/Pickup_rocks(mob/living/user)
	var/show_message = FALSE
	var/turf/tile = user.loc
	if (!isturf(tile))
		return

	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		for(var/A in tile)
			if (!is_type_in_typecache(A, STR.can_hold))
				continue
			else if(SEND_SIGNAL(src, COMSIG_TRY_STORAGE_INSERT, A, user, TRUE))
				show_message = TRUE
			else
				if(!spam_protection)
					to_chat(user, "<span class='warning'>Your [name] is full and can't hold any more!</span>")
					spam_protection = TRUE
					continue
	if(show_message)
		playsound(user, "rustle", 50, TRUE)
		user.visible_message("<span class='notice'>[user] scoops up the rocks beneath [user.p_them()].</span>", \
			"<span class='notice'>You scoop up the rocks beneath you with your [name].</span>")
	spam_protection = FALSE

/obj/item/storage/bag/strangerock/adv
	name = "bluespace strange rock bag"
	icon_state = "rockbagadv"
	resistance_flags = FIRE_PROOF | ACID_PROOF

	max_items = 50

//

/obj/item/storage/belt/xenoarch
	name = "xenoarchaeologist belt"
	desc = "used to store your tools for xenoarchaeology."
	icon = 'modular_skyrat/modules/xenoarch/icons/obj/tools.dmi'
	icon_state = "miningbelt"

/obj/item/storage/belt/xenoarch/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	var/static/list/can_hold = typecacheof(list(
		/obj/item/xenoarch/help,
		/obj/item/xenoarch/clean,
		/obj/item/t_scanner/adv_mining_scanner,
		/obj/item/gps
		))
	STR.can_hold = can_hold
	STR.max_items = 12
	STR.max_w_class = WEIGHT_CLASS_BULKY
	STR.max_combined_w_class = 200

/obj/item/storage/belt/xenoarch/full/PopulateContents()
	new /obj/item/xenoarch/help/measuring(src)
	new /obj/item/xenoarch/clean/brush/basic(src)
	new /obj/item/xenoarch/clean/hammer/cm15(src)
	new /obj/item/xenoarch/clean/hammer/cm6(src)
	new /obj/item/xenoarch/clean/hammer/cm5(src)
	new /obj/item/xenoarch/clean/hammer/cm4(src)
	new /obj/item/xenoarch/clean/hammer/cm3(src)
	new /obj/item/xenoarch/clean/hammer/cm2(src)
	new /obj/item/xenoarch/clean/hammer/cm1(src)
	new /obj/item/t_scanner/adv_mining_scanner/xenoarch(src)
	new /obj/item/gps(src)
	return

/obj/structure/closet/wardrobe/xenoarch
	name = "xenoarchaeologist wardrobe"
	icon_state = "science"
	icon_door = "science"

/obj/structure/closet/wardrobe/xenoarch/PopulateContents()
	new /obj/item/xenoarch/help/measuring(src)
	new /obj/item/xenoarch/clean/brush/basic(src)
	new /obj/item/xenoarch/clean/hammer/cm15(src)
	new /obj/item/xenoarch/clean/hammer/cm6(src)
	new /obj/item/xenoarch/clean/hammer/cm5(src)
	new /obj/item/xenoarch/clean/hammer/cm4(src)
	new /obj/item/xenoarch/clean/hammer/cm3(src)
	new /obj/item/xenoarch/clean/hammer/cm2(src)
	new /obj/item/xenoarch/clean/hammer/cm1(src)
	new /obj/item/pickaxe(src)
	new /obj/item/t_scanner/adv_mining_scanner/xenoarch(src)
	new /obj/item/gps(src)
	new /obj/item/storage/belt/xenoarch(src)
	new /obj/item/storage/bag/strangerock(src)
	return
