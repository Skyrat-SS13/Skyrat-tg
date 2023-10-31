/obj/item/clothing/head/hairband
	name = "hairband"
	desc = "A piece of elastic band."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairband"
	worn_icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	worn_icon_state = "none"
	lefthand_file = 'modular_skyrat/modules/salon/icons/items.dmi'
	righthand_file = 'modular_skyrat/modules/salon/icons/items.dmi'
	inhand_icon_state = "none"
	w_class = WEIGHT_CLASS_TINY
	//string which set_hairstyle() will read
	var/picked_hairstyle
	//storage for the original hairstyle string
	var/actual_hairstyle

/obj/item/clothing/head/hairband/examine(mob/user)
	. = ..()
	if(picked_hairstyle)
		. += span_notice("Wearing it will change your hairstyle to '[picked_hairstyle]'.")
	. += span_notice("Use in-hand to select an alternative hairstyle.")
	. += span_notice("Alt-click [src] to fling it.")

/obj/item/clothing/head/hairband/attack_self(mob/user)
	var/hair_id = tgui_input_list(user, "How does your hair look when its up?", "Pick!", GLOB.hairstyles_list)
	if(!hair_id)
		return
	balloon_alert(user, "[hair_id]")
	picked_hairstyle = hair_id

/obj/item/clothing/head/hairband/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!ishuman(user) || !(slot_flags & slot))
		return
	if(!picked_hairstyle || (user.hairstyle == "Bald"))
		return
	user.visible_message(
			span_notice(""),
			span_notice(""),
		)
	actual_hairstyle = user.hairstyle
	user.set_hairstyle(picked_hairstyle, update = TRUE)

/obj/item/clothing/head/hairband/dropped(mob/living/carbon/human/user)
	. =..()
	if(!ishuman(user))
		return
	if(!picked_hairstyle || !actual_hairstyle)
		return
	user.visible_message(
			span_notice(""),
			span_notice(""),
		)
	user.set_hairstyle(actual_hairstyle, update = TRUE)
	actual_hairstyle = null

/obj/item/clothing/head/hairband/AltClick(mob/living/user)
	if(user.get_item_by_slot(ITEM_SLOT_HEAD) == src)
		return
	playsound(src, 'sound/weapons/gun/bow/bow_draw.ogg', 25, TRUE)
	if(do_after(user, 1 SECONDS, src))
		user.visible_message(
			span_danger(""),
			span_nicegreen(""),
		)
		var/obj/projectile/hairband = new /obj/projectile/bullet/hairband(drop_location())
		hairband.firer = user
		hairband.fired_from = src
		hairband.fire(dir2angle(user.dir) + rand(-30, 30))
		hairband.greyscale_colors = greyscale_colors
		playsound(src, 'sound/weapons/gun/bow/bow_fire.ogg', 25, TRUE)
		qdel(src)
	else
		return

/obj/projectile/bullet/hairband
	name = "hairband"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "hairband"
	hitsound = 'sound/weapons/genhit.ogg'
	damage = 5
	sharpness = NONE
	impact_effect_type = null
	ricochet_chance = 0
	range = 7
	knockdown = 1 SECONDS
	var/drop_type = /obj/item/clothing/head/hairband

/obj/projectile/bullet/hairband/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/projectile_drop, drop_type)
