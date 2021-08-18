/*
///////////////////////
//CODE FOR SERVIETTES//
///////////////////////

//Kubic plz make it clean stuff. My arms grow from same place where grows my legs.

/obj/item/serviette
	name = "serviette"
	desc = "To clean all the mess."
	icon_state = "serviette_clean"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	var/cleanspeed = 50
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	gender = PLURAL

/obj/item/serviette_used
	name = "dirty serviette"
	desc = "Eww... Throw it in trash!"
	icon_state = "serviette_dirty"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY

/obj/item/serviette/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !check_allowed_items(target))
		return
	var/clean_speedies = 1 * cleanspeed
	if(user.mind)
		clean_speedies = cleanspeed * min(user.mind.get_skill_modifier(/datum/skill/cleaning, SKILL_SPEED_MODIFIER)+0.1,1) //less scaling for soapies
	//I couldn't feasibly  fix the overlay bugs caused by cleaning items we are wearing.
	//So this is a workaround. This also makes more sense from an IC standpoint. ~Carn
	if(user.client && ((target in user.client.screen) && !user.is_holding(target)))
		to_chat(user, "<span class='warning'>You need to take that [target.name] off before cleaning it!</span>")
	else if(istype(target, /obj/effect/decal/cleanable))
		user.visible_message("<span class='notice'>[user] begins to clean \the [target.name] out with [src].</span>", "<span class='warning'>You begin to clean \the [target.name] out with [src]...</span>")
		if(do_after(user, clean_speedies, target = target))
			to_chat(user, "<span class='notice'>You clean \the [target.name] out.</span>")
			var/obj/effect/decal/cleanable/cleanies = target
			user.mind?.adjust_experience(/datum/skill/cleaning, max(round(cleanies.beauty/CLEAN_SKILL_BEAUTY_ADJUSTMENT),0)) //again, intentional that this does NOT round but mops do.
			qdel(target)
			qdel(src)
			var/obj/item/serviette_used/W = new /obj/item/serviette_used
			remove_item_from_storage(user)
			user.put_in_hands(W)


	else if(istype(target, /obj/structure/window))
		user.visible_message("<span class='notice'>[user] begins to clean \the [target.name] with [src]...</span>", "<span class='notice'>You begin to clean \the [target.name] with [src]...</span>")
		if(do_after(user, clean_speedies, target = target))
			to_chat(user, "<span class='notice'>You clean \the [target.name].</span>")
			target.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
			target.set_opacity(initial(target.opacity))
			user.mind?.adjust_experience(/datum/skill/cleaning, CLEAN_SKILL_GENERIC_WASH_XP)
			qdel(src)
			var/obj/item/serviette_used/W = new /obj/item/serviette_used
			remove_item_from_storage(user)
			user.put_in_hands(W)

	else
		user.visible_message("<span class='notice'>[user] begins to clean \the [target.name] with [src]...</span>", "<span class='notice'>You begin to clean \the [target.name] with [src]...</span>")
		if(do_after(user, clean_speedies, target = target))
			to_chat(user, "<span class='notice'>You clean \the [target.name].</span>")
			if(user && isturf(target))
				for(var/obj/effect/decal/cleanable/cleanable_decal in target)
					user.mind?.adjust_experience(/datum/skill/cleaning, round(cleanable_decal.beauty / CLEAN_SKILL_BEAUTY_ADJUSTMENT))
			target.wash(CLEAN_SCRUB)
			target.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
			user.mind?.adjust_experience(/datum/skill/cleaning, CLEAN_SKILL_GENERIC_WASH_XP)
			qdel(src)
			var/obj/item/serviette_used/W = new /obj/item/serviette_used
			remove_item_from_storage(user)
			user.put_in_hands(W)

	return

///////////////////////////
//CODE FOR SERVIETTE PACK//
///////////////////////////

/obj/item/serviette_pack
	name = "pack of serviettes"
	desc = "I wonder why LustWish makes them..."
	icon_state = "serviettepack"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	var/servleft = "4"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/serviette_pack/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[servleft]"

/obj/item/serviette_pack/Initialize()
	. = ..()
	update_icon_state()
	update_icon()

/obj/item/serviette_pack/attack_self(mob/user, obj/item/I)
	switch(servleft)
		if("4")
			to_chat(user, "<span class='notice'>You took one of serviettes from pack.</span>")
			servleft = "3"
			var/obj/item/serviette/W = new /obj/item/serviette
			user.put_in_hands(W)
			update_icon()
			update_icon_state()

		if("3")
			to_chat(user, "<span class='notice'>You took one of serviettes from pack.</span>")
			servleft = "2"
			var/obj/item/serviette/W = new /obj/item/serviette
			user.put_in_hands(W)
			update_icon()
			update_icon_state()

		if("2")
			to_chat(user, "<span class='notice'>You took one of serviettes from pack.</span>")
			servleft = "1"
			var/obj/item/serviette/W = new /obj/item/serviette
			user.put_in_hands(W)
			update_icon()
			update_icon_state()

		if("1")
			to_chat(user, "<span class='notice'>You took one of serviettes from pack.</span>")
			servleft = "0"
			var/obj/item/serviette/W = new /obj/item/serviette
			user.put_in_hands(W)
			update_icon()
			update_icon_state()

		if("0")
			to_chat(user, "<span class='notice'>There is no more serviettes left!</span>")
			update_icon()
			update_icon_state()
*/
