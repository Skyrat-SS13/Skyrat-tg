/obj/item/reagent_brick
	name = "brick"
	desc = "An indescribable brick of some unknown substance."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "cocainebrick"

	var/obj/item/packed_item // leave blank for nothing
	var/datum/reagent/brick_reagent // leave blank for nothing
	var/reagent_amount = 0 // how much of powder_reagent the powder has in it
	var/extra_amount = 0 // how much of extra volume there should be for other reagents

/obj/item/reagent_brick/Initialize(mapload)
	. = ..()
	create_reagents(reagent_amount) // allow 5 extra units so powders can be spiked
	if(brick_reagent)
		reagents.add_reagent(brick_reagent, reagent_amount)

/obj/item/reagent_brick/attack_self(mob/user)
	if(packed_item) // if this doesnt have a reagent in it, youre fucked
		user.visible_message(span_notice("[user] starts breaking up the [src]."))
		if(do_after(user,10))
			to_chat(user, span_notice("You finish breaking up the [src]."))
			var/datum/reagent/packed_brick_reagent = locate(brick_reagent) in reagents.reagent_list
			for(var/i = 1 to 5)
				var/obj/item/reagent_containers/created_item = new packed_item(user.loc)
				var/datum/reagent/split_brick_reagent = locate(brick_reagent) in created_item.reagents.reagent_list
				split_brick_reagent.creation_purity = packed_brick_reagent.creation_purity
				split_brick_reagent.purity = packed_brick_reagent.creation_purity
			qdel(src)
