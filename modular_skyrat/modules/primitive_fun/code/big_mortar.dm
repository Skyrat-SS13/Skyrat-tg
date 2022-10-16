/obj/structure/large_mortar
	name = "large mortar"
	desc = "A large bowl perfect for grinding or juicing a large number of things at once."
	icon = 'modular_skyrat/modules/primitive_fun/icons/cooking_structures.dmi'
	icon_state = "big_mortar"
	density = TRUE
	anchored = TRUE
	max_integrity = 100
	pass_flags = PASSTABLE
	custom_materials = list(/datum/material/wood = MINERAL_MATERIAL_AMOUNT * 10)
	/// The maximum number of items this structure can store
	var/maximum_contained_items = 5

/obj/structure/large_mortar/Initialize(mapload)
	. = ..()
	create_reagents(200, OPENCONTAINER)

/obj/structure/large_mortar/examine(mob/user)
	. = ..()
	. += span_notice("It currently contains <b>[LAZYLEN(contents)]/[maximum_contained_items] items.")
	. += span_notice("It can be (un)secured with <b>Right Click</b>")
	. += span_notice("You can empty all of the items out of it with <b>Alt Click</b>")

/obj/structure/large_mortar/Destroy()
	drop_everything_contained()
	return ..()

/obj/structure/large_mortar/AltClick(mob/user)
	if(!LAZYLEN(contents))
		balloon_alert(user, "nothing inside")
		return
	drop_everything_contained()
	balloon_alert(user, "removed all items")

/// Drops all contents at the mortar
/obj/structure/large_mortar/proc/drop_everything_contained()
	if(!LAZYLEN(contents))
		return
	for(var/obj/target_item in contents)
		target_item.forceMove(get_turf(src))

/obj/structure/large_mortar/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	if(!can_interact(user) || !user.canUseTopic(src, be_close = TRUE))
		return
	set_anchored(!anchored)
	balloon_alert_to_viewers(anchored ? "secured" : "unsecured")
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/large_mortar/attackby(obj/item/attacking_item, mob/living/carbon/human/user)
	if(istype(attacking_item, /obj/item/pestle))
		if(!anchored)
			balloon_alert(user, "secure to ground first")
			return
		if(!LAZYLEN(contents))
			balloon_alert(user, "nothing to grind")
			return
		if(user.getStaminaLoss() > 50)
			balloon_alert(user, "too tired")
			return
		var/list/choose_options = list(
			"Grind" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_grind"),
			"Juice" = image(icon = 'icons/hud/radial.dmi', icon_state = "radial_juice")
		)
		var/picked_option = show_radial_menu(user, src, choose_options, radius = 38, require_near = TRUE)
		if(!LAZYLEN(contents) || !in_range(src, user) || !user.is_holding(attacking_item) && !picked_option)
			return
		balloon_alert_to_viewers("grinding...")
		if(!do_after(user, 5 SECONDS, target = src))
			balloon_alert_to_viewers("stopped grinding")
			return
		user.adjustStaminaLoss(60) //This is a bit more tiring than a normal sized mortar and pestle
		switch(picked_option)
			if("Juice")
				for(var/obj/item/target_item in contents)
					if(target_item.juice_results)
						juice_target_item(target_item, user)
					else
						grind_target_item(target_item, user)
			if("Grind")
				for(var/obj/item/target_item in contents)
					if(target_item.grind_results)
						grind_target_item(target_item, user)
					else
						juice_target_item(target_item, user)
		return
	if(!attacking_item.juice_results || !attacking_item.grind_results)
		balloon_alert(user, "can't grind this")
		return ..()
	if(LAZYLEN(contents) >= maximum_contained_items)
		balloon_alert(user, "already full")
		return
	attacking_item.forceMove(src)
	return


///Juices the passed target item, and transfers any contained chems to the mortar as well
/obj/structure/large_mortar/proc/juice_target_item(obj/item/to_be_juiced, mob/living/carbon/human/user)
	to_be_juiced.on_juice()
	reagents.add_reagent_list(to_be_juiced.juice_results)
	if(to_be_juiced.reagents) //If juiced item has reagents within, transfer them to the mortar
		to_be_juiced.reagents.trans_to(src, to_be_juiced.reagents.total_volume, transfered_by = user)
	to_chat(user, span_notice("You juice [to_be_juiced] into a fine liquid."))
	QDEL_NULL(to_be_juiced)

///Grinds the passed target item, and transfers any contained chems to the mortar as well
/obj/structure/large_mortar/proc/grind_target_item(obj/item/to_be_ground, mob/living/carbon/human/user)
	to_be_ground.on_grind()
	reagents.add_reagent_list(to_be_ground.grind_results)
	if(to_be_ground.reagents) //If grinded item has reagents within, transfer them to the mortar
		to_be_ground.reagents.trans_to(src, to_be_ground.reagents.total_volume, transfered_by = user)
	to_chat(user, span_notice("You break [to_be_ground] into powder."))
	QDEL_NULL(to_be_ground)
