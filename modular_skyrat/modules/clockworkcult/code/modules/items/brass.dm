/obj/item/stack/tile/brass
	name = "brass"
	desc = "Sheets made out of brass."
	singular_name = "brass sheet"
	icon_state = "sheet-brass"
	icon = 'icons/obj/stack_objects.dmi'
	resistance_flags = FIRE_PROOF | ACID_PROOF
	throwforce = 10
	max_amount = 50
	throw_speed = 1
	throw_range = 3
	turf_type = /turf/open/floor/clockwork
	novariants = FALSE
	grind_results = list(/datum/reagent/iron = 5, /datum/reagent/teslium = 15)
	merge_type = /obj/item/stack/tile/brass
	custom_materials = list(/datum/material/copper=MINERAL_MATERIAL_AMOUNT*0.5, /datum/material/iron=MINERAL_MATERIAL_AMOUNT*0.5)

/obj/item/stack/tile/brass/narsie_act()
	new /obj/item/stack/sheet/runed_metal(loc, amount)
	qdel(src)

/obj/item/stack/tile/brass/attack_self(mob/living/user)
	if(!is_servant_of_ratvar(user))
		to_chat(user, "<span class='danger'>[src] seems far too brittle to build with.</span>") //haha that's because it's actually replicant alloy you DUMMY << WOAH TOOO FAR!
	else
		return ..()

/obj/item/stack/tile/brass/Initialize(mapload, new_amount, merge = TRUE)
	. = ..()
	recipes = GLOB.brass_recipes
	pixel_x = 0
	pixel_y = 0

/obj/item/stack/tile/brass/fifty
	amount = 50

/obj/item/stack/tile/brass/cyborg
	custom_materials = list()
	is_cyborg = 1
	cost = 500
