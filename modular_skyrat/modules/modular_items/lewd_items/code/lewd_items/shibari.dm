/obj/item/stack/shibari_rope
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	icon_state = "shibari_rope"
	name = "Shibari ropes"
	desc = "Coil of bondage ropes."
	amount = 1
	merge_type = /obj/item/stack/shibari_rope
	singular_name = "ropes"

	///customisation vars
	var/current_color = "pink"
	var/color_changed = FALSE
	var/static/list/ropes_designs

	var/list/torso_styles = list(
		"Torso",
		"Groin"
	)

	///Things this rope can transform into when it's tied to a person
	var/obj/item/clothing/under/shibari/torso/shibari_body
	var/obj/item/clothing/under/shibari/groin/shibari_groin
	var/obj/item/clothing/under/shibari/full/shibari_fullbody
	var/obj/item/clothing/shoes/shibari_legs/shibari_legs
	var/obj/item/clothing/gloves/shibari_hands/shibari_hands

//create radial menu
/obj/item/stack/shibari_rope/proc/populate_ropes_designs()
	ropes_designs = list(
		"pink" = image (icon = src.icon, icon_state = "shibari_rope_pink"),
		"teal" = image(icon = src.icon, icon_state = "shibari_rope_teal"),
		"red" = image (icon = src.icon, icon_state = "shibari_rope_red"),
		"brown" = image (icon = src.icon, icon_state = "shibari_rope_brown"),
		"black" = image (icon = src.icon, icon_state = "shibari_rope_black"),
		"white" = image (icon = src.icon, icon_state = "shibari_rope_white"))

/obj/item/stack/shibari_rope/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//to change model
/obj/item/stack/shibari_rope/AltClick(mob/user, obj/item/thing)
	if(color_changed == FALSE)
		. = ..()
		if(.)
			return
		var/choice = show_radial_menu(user,src, ropes_designs, custom_check = CALLBACK(src, .proc/check_menu, user, thing), radius = 36, require_near = TRUE)
		if(!choice)
			return FALSE
		current_color = choice
		update_icon()
		color_changed = TRUE
	else
		return

//to check if we can change ropes' model
/obj/item/stack/shibari_rope/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/obj/item/stack/shibari_rope/Initialize()
	. = ..()
	update_icon_state()
	update_icon()
	if(!length(ropes_designs))
		populate_ropes_designs()

/obj/item/stack/shibari_rope/full/Initialize(mapload, new_amount, merge, list/mat_override, mat_amt)
	. = ..()
	//random color variation on start. Because why not?
	current_color = pick(ropes_designs)
	update_icon_state()
	update_icon()

/obj/item/stack/shibari_rope/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"
	worn_icon_state = "[initial(icon_state)]_[current_color]"

//examine stuff

/obj/item/stack/shibari_rope/examine(mob/user)
	.=..()
	if(color_changed == FALSE)
		. += span_notice("Alt-Click \the [src.name] to customize it.</span>")

//mechanics stuff
/obj/item/stack/shibari_rope/can_merge(obj/item/stack/check)
	if(!istype(check, merge_type))
		return FALSE
	//different color stacks cannot merge
	if(istype(check, merge_type))
		var/obj/item/stack/shibari_rope/other_stuff = check
		if(other_stuff.current_color != current_color)
			return FALSE
	return TRUE

/obj/item/stack/shibari_rope/attack(mob/living/carbon/attacked, mob/living/user)
	add_fingerprint(user)
	if(ishuman(attacked))
		if(attacked.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
			var/mob/living/carbon/human/them = attacked
			switch(user.zone_selected)
				if(BODY_ZONE_L_LEG || BODY_ZONE_R_LEG)
					if(!(them.shoes))
						if(them?.dna?.mutant_bodyparts["taur"])
							var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][them.dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
							if(S.hide_legs)
								to_chat(user, span_warning("You can't tie their feet, they're a taur!"))
								return ..()
						them.visible_message(span_warning("[user] starts tying [them]'s feet!"),\
							span_userdanger("[user] starts tying your feet!"),\
							span_hear("You hear ropes being tightened."))
						if(do_after(user, 60))
							shibari_legs = new(src)
							if(them.equip_to_slot_if_possible(shibari_legs,ITEM_SLOT_FEET,0,0,1))
								use(1)
								shibari_legs.current_color = current_color
								shibari_legs.update_icon_state()
								shibari_legs.update_icon()
								shibari_legs = null
								them.visible_message(span_warning("[user] tied [them]'s feet!"),\
									span_userdanger("[user] tied your feet!"),\
									span_hear("You hear ropes being completely tightened."))
							else
								qdel(shibari_legs)

				if(BODY_ZONE_PRECISE_GROIN)
					if(!(them.w_uniform))
						them.visible_message(span_warning("[user] starts tying [them]'s groin!"),\
							span_userdanger("[user] starts tying your groin!"),\
							span_hear("You hear ropes being tightened."))
						if(do_after(user, 60))
							shibari_groin = new(src)
							if(them.equip_to_slot_if_possible(shibari_groin,ITEM_SLOT_ICLOTHING,0,0,1))
								use(1)
								shibari_groin.current_color = current_color
								shibari_groin.update_icon_state()
								shibari_groin.update_icon()
								shibari_groin = null
								them.visible_message(span_warning("[user] tied [them]'s groin!"),\
									span_userdanger("[user] tied your groin!"),\
									span_hear("You hear ropes being completely tightened."))
							else
								qdel(shibari_groin)
					else if(istype(them.w_uniform, /obj/item/clothing/under/shibari/torso))
						them.visible_message(span_warning("[user] starts tying [them]'s groin!"),\
							span_userdanger("[user] starts tying your groin!"),\
							span_hear("You hear ropes being tightened."))
						if(do_after(user, 60))
							shibari_fullbody = new(src)
							qdel(them.w_uniform, force = TRUE)
							if(them.equip_to_slot_if_possible(shibari_fullbody,ITEM_SLOT_ICLOTHING,0,0,1))
								use(1)
								shibari_fullbody.current_color = current_color
								shibari_fullbody.update_icon_state()
								shibari_fullbody.update_icon()
								shibari_fullbody = null
								them.visible_message(span_warning("[user] tied [them]'s groin!"),\
									span_userdanger("[user] tied your groin!"),\
									span_hear("You hear ropes being completely tightened."))
							else
								qdel(shibari_fullbody)

				if(BODY_ZONE_CHEST)
					if(!(them.w_uniform))
						them.visible_message(span_warning("[user] starts tying [them]'s chest!"),\
							span_userdanger("[user] starts tying your chest!"),\
							span_hear("You hear ropes being tightened."))
						if(do_after(user, 60))
							shibari_body = new(src)
							if(them.equip_to_slot_if_possible(shibari_body,ITEM_SLOT_ICLOTHING,0,0,1))
								use(1)
								shibari_body.current_color = current_color
								shibari_body.update_icon_state()
								shibari_body.update_icon()
								shibari_body = null
								them.visible_message(span_warning("[user] tied [them]'s chest!"),\
									span_userdanger("[user] tied your chest!"),\
									span_hear("You hear ropes being completely tightened."))
							else
								qdel(shibari_body)
					else if(istype(them.w_uniform, /obj/item/clothing/under/shibari/groin))
						them.visible_message(span_warning("[user] starts tying [them]'s chest!"),\
							span_userdanger("[user] starts tying your chest!"),\
							span_hear("You hear ropes being tightened."))
						if(do_after(user, 60))
							shibari_fullbody = new(src)
							qdel(them.w_uniform, force = TRUE)
							if(them.equip_to_slot_if_possible(shibari_fullbody,ITEM_SLOT_ICLOTHING,0,0,1))
								use(1)
								shibari_fullbody.current_color = current_color
								shibari_fullbody.update_icon_state()
								shibari_fullbody.update_icon()
								shibari_fullbody = null
								them.visible_message(span_warning("[user] tied [them]'s chest!"),\
									span_userdanger("[user] tied your chest!"),\
									span_hear("You hear ropes being completely tightened."))
							else
								qdel(shibari_fullbody)

				if(BODY_ZONE_L_ARM || BODY_ZONE_R_ARM)
					if(!(them.gloves))
						them.visible_message(span_warning("[user] starts tying [them]'s hands!"),\
							span_userdanger("[user] starts tying your hands!"),\
							span_hear("You hear ropes being tightened."))
						if(do_after(user, 60))
							shibari_hands = new(src)
							if(them.equip_to_slot_if_possible(shibari_hands,ITEM_SLOT_GLOVES,0,0,1))
								use(1)
								shibari_hands.current_color = current_color
								shibari_hands.update_icon_state()
								shibari_hands.update_icon()
								shibari_hands = null
								them.visible_message(span_warning("[user] tied [them]'s hands!"),\
									span_userdanger("[user] tied your hands!"),\
									span_hear("You hear ropes being completely tightened."))
							else
								qdel(shibari_hands)
				else
					return ..()
		else
			to_chat(user, span_danger("Looks like [attacked] doesn't want you to do that."))
			return ..()
	else
		return ..()

/obj/item/stack/shibari_rope/full
	amount = 10

