/obj/item/clothing/head/hair_tie
	name = "hair tie"
	desc = "An elastic hair tie, made to hold your hair up!"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "blackcomb"
	worn_icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	worn_icon_state = "none"
	lefthand_file = 'modular_skyrat/modules/salon/icons/items.dmi'
	righthand_file = 'modular_skyrat/modules/salon/icons/items.dmi'
	inhand_icon_state = "none"
	w_class = WEIGHT_CLASS_TINY
	custom_price = PAYCHECK_CREW * 0.2
	//string which set_hairstyle() will read
	var/picked_hairstyle
	//storage for the original hairstyle string
	var/actual_hairstyle

/obj/item/clothing/head/hair_tie/scrunchie
	name = "scrunchie"
	desc = "An elastic hair tie, its fabric is velvet soft."
	icon_state = "razor"

/obj/item/clothing/head/hair_tie/plastic_beads
	name = "colorful hair tie"
	desc = "An elastic hair tie, adornished with colorful plastic beads."
	icon_state = "scissors"
	custom_materials = (list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT*5))

/obj/item/clothing/head/hair_tie/examine(mob/user)
	. = ..()
	if(picked_hairstyle)
		. += span_notice("Wearing it will change your hairstyle to '[picked_hairstyle]'.")
	. += span_notice("Click [src] to pick a new hairstyle.")
	. += span_notice("Alt-click [src] to fling it.")

/obj/item/clothing/head/hair_tie/mob_can_equip(mob/living/carbon/human/user, slot)
	if(user.hairstyle == "Bald")
		to_chat(user, span_warning("[src] doesn't fit, because you're bald!"))
		return FALSE
	return ..()

/obj/item/clothing/head/hair_tie/attack_self(mob/user)
	var/hair_id = tgui_input_list(user, "How does your hair look when its up?", "Pick!", GLOB.hairstyles_list)
	if(!hair_id || hair_id == "Bald")
		balloon_alert(user, "error!")
		return
	balloon_alert(user, "[hair_id]")
	picked_hairstyle = hair_id

/obj/item/clothing/head/hair_tie/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(!ishuman(user) || !(slot_flags & slot))
		return
	if(!picked_hairstyle)
		return
	user.visible_message(
			span_notice("[user.name] ties up [user.p_their()] hair."),
			span_notice("You tie up your hair!"),
		)
	actual_hairstyle = user.hairstyle
	user.set_hairstyle(picked_hairstyle, update = TRUE)

/obj/item/clothing/head/hair_tie/dropped(mob/living/carbon/human/user)
	. =..()
	if(!ishuman(user))
		return
	if(!picked_hairstyle || !actual_hairstyle)
		return
	user.visible_message(
			span_notice("[user.name] takes [src] out of [user.p_their()] hair."),
			span_notice("You let down your hair!"),
		)
	user.set_hairstyle(actual_hairstyle, update = TRUE)
	actual_hairstyle = null

/obj/item/clothing/head/hair_tie/AltClick(mob/living/user)
	if(!user.get_item_by_slot(ITEM_SLOT_HANDS) == src)
		return
	flick_hair_tie(user)

/obj/item/clothing/head/hair_tie/proc/flick_hair_tie(mob/living/user)
	playsound(src, 'sound/weapons/gun/bow/bow_draw.ogg', 25, TRUE)
	user.visible_message(
		span_danger("[user.name] puts [src] around [user.p_their()] fingers, beginning to flick it!"),
		span_notice("You try to flick [src]!"),
	)
	if(!do_after(user, 1.5 SECONDS, src))
		return

	var/obj/projectile/bullet/hair_tie/projectile = new /obj/projectile/bullet/hair_tie(drop_location())
	//clone some vars
	projectile.name = name
	projectile.icon_state = icon_state
	//add projectile_drop
	projectile.AddElement(/datum/element/projectile_drop, type)
	//fire the projectile
	projectile.firer = user
	projectile.fired_from = user
	projectile.fire(dir2angle(user.dir) + rand(-30, 30))
	playsound(src, 'sound/weapons/gun/bow/bow_fire.ogg', 25, TRUE)
	//get rid of what we just launched to let projectile_drop spawn a new one
	qdel(src)

/obj/projectile/bullet/hair_tie
	name = "hair tie"
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	hitsound = 'sound/weapons/genhit.ogg'
	damage = 5
	sharpness = NONE //no embedding pls
	impact_effect_type = null
	ricochet_chance = 0
	range = 7
	knockdown = 1 SECONDS
	weak_against_armour = TRUE

/datum/design/plastic_hair_tie
	name = "Plastic Hair Tie"
	id = "plastic_hair_tie"
	build_type = PROTOLATHE | AWAY_LATHE | AUTOLATHE | COLONY_FABRICATOR
	materials = list(/datum/material/plastic = SMALL_MATERIAL_AMOUNT*5)
	build_path = /obj/item/clothing/head/hair_tie/plastic_beads
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_SERVICE,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE
