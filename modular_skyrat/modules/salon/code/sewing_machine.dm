/obj/machinery/sewing_machine
	name = "sewing machine"
	desc = "Combine a pattern kit and cloth here to produce clothing!"
	icon = 'modular_skyrat/modules/salon/icons/machinery.dmi'
	icon_state = "sewing"
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 500
	density = TRUE
	var/obj/item/stack/sheet/cloth/cloth_to_use
	var/obj/item/pattern_kit/pattern_kit_to_use
	var/operating = FALSE

/obj/machinery/sewing_machine/attackby(obj/item/weapon, mob/user, params)
	. = ..()
	if(istype(weapon, /obj/item/stack/sheet/cloth) && !cloth_to_use)
		user.balloon_alert(user, "inserted [weapon]")
		cloth_to_use = weapon
		weapon.forceMove(src)
	if(istype(weapon, /obj/item/pattern_kit) && !pattern_kit_to_use)
		user.balloon_alert(user, "inserted [weapon]")
		pattern_kit_to_use = weapon
		weapon.forceMove(src)

/obj/machinery/sewing_machine/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!cloth_to_use || !pattern_kit_to_use)
		user.balloon_alert(user, "no cloth or pattern!")
		return
	if(operating)
		user.balloon_alert(user, "operating!")
		return
	operating = TRUE
	playsound(src, 'modular_skyrat/modules/salon/sound/sewing_machine.ogg', 100)
	user.balloon_alert(user, "sewing started")
	if(do_after(user, 8 SECONDS, src))
		pattern_kit_to_use.forceMove(get_turf(src))
		cloth_to_use.use(1)
		if(QDELETED(cloth_to_use))
			user.balloon_alert(user, "out of cloth")
			cloth_to_use = null
		else
			user.balloon_alert(user, "[cloth_to_use.amount] cloth left")

		var/list/clothing_map = list(
			"Back" = /obj/item/clothing,
			"Face" = /obj/item/clothing/mask,
			"Neck" = /obj/item/clothing/neck,
			"Belt" = /obj/item/clothing,
			"Ears" = /obj/item/clothing/ears,
			"Glasses" = /obj/item/clothing/glasses,
			"Gloves" = /obj/item/clothing/gloves,
			"Hat" = /obj/item/clothing/head,
			"Shoes" = /obj/item/clothing/shoes,
			"Suit" = /obj/item/clothing/suit,
			"Jumpsuit" = /obj/item/clothing/under,
		)
		var/list/slot_match = list(
			"Back" = ITEM_SLOT_BACK,
			"Face" = ITEM_SLOT_MASK,
			"Neck" = ITEM_SLOT_NECK,
			"Belt" = ITEM_SLOT_BELT,
			"Ears" = ITEM_SLOT_EARS,
			"Glasses" = ITEM_SLOT_EYES,
			"Gloves" = ITEM_SLOT_GLOVES,
			"Hat" = ITEM_SLOT_HEAD,
			"Shoes" = ITEM_SLOT_FEET,
			"Suit" = ITEM_SLOT_OCLOTHING,
			"Jumpsuit" = ITEM_SLOT_ICLOTHING
		)
		var/path_to_use = clothing_map[pattern_kit_to_use.clothing_datum.slot]
		var/obj/item/clothing/clothing_made = new path_to_use
		clothing_made.name = pattern_kit_to_use.clothing_datum.name
		clothing_made.desc = pattern_kit_to_use.clothing_datum.desc
		clothing_made.icon = new /icon(file("data/clothing_icons/[pattern_kit_to_use.clothing_datum.id].dmi"))
		if(pattern_kit_to_use.clothing_datum.slot == "Jumpsuit")
			var/icon/onmob_icon = new(clothing_made.icon, "onmob")
			var/icon/stupid_fucking_jumpsuit_icon_bug = icon()
			stupid_fucking_jumpsuit_icon_bug.Insert(onmob_icon, "inventory") // fixes a bug with jumpsuits
			clothing_made.worn_icon = stupid_fucking_jumpsuit_icon_bug
		else
			clothing_made.worn_icon = new /icon(file("data/clothing_icons/[pattern_kit_to_use.clothing_datum.id].dmi"))
		clothing_made.icon_state = "inventory"
		clothing_made.worn_icon_state = "onmob"
		clothing_made.slot_flags = slot_match[pattern_kit_to_use.clothing_datum.slot]
		if(pattern_kit_to_use.clothing_datum.digitigrade)
			if(pattern_kit_to_use.clothing_datum.slot == "Jumpsuit")
				var/icon/onmob_digit_icon = new(clothing_made.icon, "onmob_digit")
				var/icon/digitigrade_jumpsuit_worn_icon = icon()
				digitigrade_jumpsuit_worn_icon.Insert(onmob_digit_icon, "inventory") // fixes a bug with jumpsuits, again
				clothing_made.worn_icon_digi = digitigrade_jumpsuit_worn_icon
			else
				clothing_made.worn_icon_digi = new /icon(file("data/clothing_icons_digitigrade/[pattern_kit_to_use.clothing_datum.id].dmi"))
			clothing_made.mutant_variants = STYLE_DIGITIGRADE
		else
			clothing_made.mutant_variants = NONE // we want it to show regardless
		clothing_made.forceMove(get_turf(src))
		pattern_kit_to_use = null
		operating = FALSE

