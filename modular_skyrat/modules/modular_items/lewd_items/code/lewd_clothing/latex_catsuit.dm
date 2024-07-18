/obj/item/clothing/under/misc/latex_catsuit
	name = "latex catsuit"
	desc = "A shiny uniform that fits snugly to the skin."
	icon_state = "latex_catsuit_female"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-hoof.dmi'
	inhand_icon_state = "latex_catsuit"
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	equip_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/latex.ogg'
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	strip_delay = 80
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION|STYLE_TAUR_ALL
	var/mutable_appearance/breasts_overlay
	var/mutable_appearance/breasts_icon_overlay

//this fragment of code makes unequipping not instant
/obj/item/clothing/under/misc/latex_catsuit/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/human/affected_human = user
		if(src == affected_human.w_uniform)
			if(!do_after(affected_human, 6 SECONDS, target = src))
				return
	. = ..()

// //some gender identification magic
/obj/item/clothing/under/misc/latex_catsuit/equipped(mob/living/affected_mob, slot)
	. = ..()
	var/mob/living/carbon/human/affected_human = affected_mob
	var/obj/item/organ/external/genital/breasts/affected_breasts = affected_human.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(src == affected_human.w_uniform)
		if(affected_mob.gender == FEMALE)
			icon_state = "latex_catsuit_female"
		else
			icon_state = "latex_catsuit_male"

		affected_mob.update_worn_undersuit()

	breasts_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi', "none")
	update_overlays()

	//Breasts overlay for catsuit
	if(affected_breasts?.genital_size >= 6 || affected_breasts?.genital_type == "pair")
		breasts_overlay.icon_state = "breasts_double"
		breasts_icon_overlay.icon_state = "iconbreasts_double"
		accessory_overlay = breasts_overlay
		add_overlay(breasts_icon_overlay)
		update_overlays()
	if(affected_breasts?.genital_type == "quad")
		breasts_overlay.icon_state = "breasts_quad"
		breasts_icon_overlay.icon_state = "iconbreasts_quad"
		accessory_overlay = breasts_overlay
		add_overlay(breasts_icon_overlay)
		update_overlays()
	if(affected_breasts?.genital_type == "sextuple")
		breasts_overlay.icon_state = "breasts_sextuple"
		breasts_icon_overlay.icon_state = "iconbreasts_sextuple"
		accessory_overlay = breasts_overlay
		add_overlay(breasts_icon_overlay)
		update_overlays()

	affected_human.regenerate_icons()

/obj/item/clothing/under/misc/latex_catsuit/dropped(mob/living/affected_mob)
	. = ..()
	accessory_overlay = null
	breasts_overlay.icon_state = "none"
	cut_overlay(breasts_icon_overlay)
	breasts_icon_overlay.icon_state = "none"

//Plug to bypass the bug with instant suit equip/drop
/obj/item/clothing/under/misc/latex_catsuit/mouse_drop_dragged(atom/over, mob/user, src_location, over_location, params)
	return

/obj/item/clothing/under/misc/latex_catsuit/Initialize(mapload)
	. = ..()
	breasts_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi', "none", ABOVE_MOB_LAYER)
	breasts_overlay.icon_state = ORGAN_SLOT_BREASTS
	breasts_icon_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi', "none")
	breasts_icon_overlay.icon_state = ORGAN_SLOT_BREASTS
