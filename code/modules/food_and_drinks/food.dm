////////////////////////////////////////////////////////////////////////////////
/// Food.
////////////////////////////////////////////////////////////////////////////////
/// Note: When adding food items with dummy parents, make sure to add
/// the parent to the exclusion list in code/__HELPERS/unsorted.dm's
/// get_random_food proc.
////////////////////////////////////////////////////////////////////////////////

/obj/item/reagent_containers/food
	possible_transfer_amounts = list()
	volume = 50 //Sets the default container amount for all food items.
	reagent_flags = INJECTABLE
	resistance_flags = FLAMMABLE
	var/foodtype = NONE
	var/last_check_time
	var/in_container = FALSE //currently just stops "was bitten X times!" messages on canned food

/obj/item/reagent_containers/food/Initialize(mapload)
	. = ..()
	if(!mapload)
		pixel_x = rand(-5, 5)
		pixel_y = rand(-5, 5)

/obj/item/reagent_containers/food/examine(mob/user)
	. = ..()
	if(foodtype)
		var/list/types = bitfield_to_list(foodtype, FOOD_FLAGS)
		. += span_notice("It is [lowertext(english_list(types))].")

/obj/item/reagent_containers/food/proc/checkLiked(fraction, mob/M)
	if(last_check_time + 50 < world.time)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(!HAS_TRAIT(H, TRAIT_AGEUSIA))
				if(foodtype & H.dna.species.toxic_food)
					to_chat(H,span_warning("What the hell was that thing?!"))
					H.adjust_disgust(25 + 30 * fraction)
					H.add_mood_event("toxic_food", /datum/mood_event/disgusting_food)
				else if(foodtype & H.dna.species.disliked_food)
					to_chat(H,span_notice("That didn't taste very good..."))
					H.adjust_disgust(11 + 15 * fraction)
					H.add_mood_event("gross_food", /datum/mood_event/gross_food)
				else if(foodtype & H.dna.species.liked_food)
					to_chat(H,span_notice("I love this taste!"))
					H.adjust_disgust(-5 + -2.5 * fraction)
					H.add_mood_event("fav_food", /datum/mood_event/favorite_food)
			else
				if(foodtype & H.dna.species.toxic_food)
					to_chat(H, span_warning("You don't feel so good..."))
					H.adjust_disgust(25 + 30 * fraction)
			if((foodtype & BREAKFAST) && world.time - SSticker.round_start_time < STOP_SERVING_BREAKFAST)
				H.add_mood_event("breakfast", /datum/mood_event/breakfast)
			last_check_time = world.time
