/obj/item/reagent_brick
	name = "brick"
	desc = "An indescribable brick of some unknown substance."
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "cocainebrick"

	/// What the brick will split into.
	var/obj/item/packed_item
	/// How many of packed_item will be made when the brick is split up.
	var/packed_amount = 5
	/// The reagent contained in the item. Set blank for nothing.
	var/datum/reagent/brick_reagent
	/// How much of the reagent is in the item.
	var/reagent_amount = 0

/obj/item/reagent_brick/Initialize(mapload)
	. = ..()
	create_reagents(reagent_amount)
	if(brick_reagent)
		reagents.add_reagent(brick_reagent, reagent_amount)

/obj/item/reagent_brick/attack_self(mob/user)
	if(packed_item) // if this doesnt have a reagent in it, youre fucked
		user.visible_message(span_notice("[user] starts breaking up the [src]."))
		if(do_after(user,10))
			to_chat(user, span_notice("You finish breaking up the [src]."))
			var/datum/reagent/packed_brick_reagent = locate(brick_reagent) in reagents.reagent_list
			for(var/i = 1 to packed_amount)
				var/obj/item/reagent_containers/created_item = new packed_item(user.loc)
				var/datum/reagent/split_brick_reagent = locate(brick_reagent) in created_item.reagents.reagent_list
				split_brick_reagent.creation_purity = packed_brick_reagent.creation_purity
				split_brick_reagent.purity = packed_brick_reagent.creation_purity
			qdel(src)
