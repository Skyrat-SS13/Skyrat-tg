/obj/item/clothing/head/helmet/rus_helmet/gcc
	name = "Russian L47 helmet"
	desc = "A Type 47 light helmet, it looks like it has a pocket for a bottle of vodka."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "russian_green_helmet"
	mutant_variants = NONE
	armor = list("melee" = 40, "bullet" = 30, "laser" = 15, "energy" = 30, "bomb" = 25, "bio" = 0, "rad" = 20, "fire" = 50, "acid" = 50, "wound" = 20)

/obj/item/clothing/head/beret/sec/gcc
	name = "commanders beret"
	desc = "Za rodinu!!"
	armor = list("melee" = 40, "bullet" = 30, "laser" = 15, "energy" = 30, "bomb" = 25, "bio" = 0, "rad" = 20, "fire" = 50, "acid" = 50, "wound" = 20)

/obj/item/clothing/head/helmet/gcc_heavy
	name = "altyn helmet"
	desc = "A very heavy Russian combat helmet with a ballistics visor. Alt+click it to adjust."
	icon_state = "russian_heavy_helmet"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	armor = list(MELEE = 70, BULLET = 60, LASER = 50, ENERGY = 50, BOMB = 100, BIO = 100, RAD = 100, FIRE = 90, ACID = 90)
	var/position = TRUE

/obj/item/clothing/head/helmet/gcc_heavy/AltClick(mob/user)
	. = ..()
	position = !position
	to_chat(user, span_notice("You flip [src] [position ? "down" : "up"] with a heavy clunk!"))
	update_appearance()

/obj/item/clothing/head/helmet/gcc_heavy/update_icon_state()
	var/state = "[initial(icon_state)]"
	if(position)
		state += "-down"
	else
		state += "-up"
	icon_state = state
	return ..()
