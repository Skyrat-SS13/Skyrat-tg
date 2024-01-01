/datum/crafting_recipe/food/reaction/piru_dough
	reaction = /datum/chemical_reaction/food/piru_dough
	result = /obj/item/food/piru_dough
	category = CAT_TESHARI

/datum/chemical_reaction/food/piru_dough
	required_reagents = list(
		/datum/reagent/consumable/piru_flour = 15,
		/datum/reagent/consumable/muli_juice = 10,
	)
	mix_message = "The ingredients form a dough."
	reaction_flags = REACTION_INSTANT
	resulting_food_path = /obj/item/food/piru_dough

/datum/crafting_recipe/food/spiced_jerky
	name = "Spiced Jerky"
	reqs = list(
		/obj/item/food/meat/cutlet = 1,
		/datum/reagent/consumable/nakati_spice = 2,
	)
	result = /obj/item/food/spiced_jerky
	category = CAT_TESHARI

/datum/crafting_recipe/food/sirisai_wrap
	name = "Sirisai Wrap"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/cabbage = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/sirisai_wrap
	category = CAT_TESHARI

/datum/crafting_recipe/food/sweet_piru_noodles
	name = "Sweet Piru Noodles"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/piru_pasta = 1,
		/obj/item/food/grown/kiri = 1,
		/obj/item/food/grown/muli = 1,
		/obj/item/food/grown/carrot = 1,
	)
	result = /obj/item/food/sweet_piru_noodles
	category = CAT_TESHARI

/datum/crafting_recipe/food/kiri_curry
	name = "Kiri Curry"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/obj/item/food/piru_pasta = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/chili = 1,
		/datum/reagent/consumable/nakati_spice = 5,
		/datum/reagent/consumable/kiri_jelly = 5,
	)
	result = /obj/item/food/kiri_curry
	category = CAT_TESHARI

/datum/crafting_recipe/food/sirisai_flatbread
	name = "Sirisai Flatbread"
	reqs = list(
		/obj/item/food/grilled_piru_flatbread = 1,
		/obj/item/food/meat/cutlet = 3,
		/obj/item/food/grown/muli = 1,
		/obj/item/food/grown/tomato = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/sirisai_flatbread
	category = CAT_TESHARI

/datum/crafting_recipe/food/bluefeather_crisp
	name = "Bluefeather Crisp"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/datum/reagent/consumable/nakati_spice = 2,
	)
	result = /obj/item/food/bluefeather_crisp
	category = CAT_TESHARI

/datum/crafting_recipe/food/stewed_muli
	name = "Stewed Muli"
	reqs = list(
		/obj/item/reagent_containers/cup/bowl = 1,
		/datum/reagent/consumable/muli_juice = 10,
		/obj/item/food/meat/cutlet = 2,
		/obj/item/food/grown/cabbage = 1,
		/obj/item/food/grown/carrot = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/stewed_muli
	category = CAT_TESHARI

/datum/crafting_recipe/food/stuffed_muli_pod
	name = "Stuffed Muli Pod"
	reqs = list(
		/obj/item/food/grown/muli = 1,
		/obj/item/food/meat/cutlet = 1,
		/obj/item/food/grown/kiri = 1,
		/obj/item/food/grown/chili = 1,
		/datum/reagent/consumable/nakati_spice = 2,
	)
	result = /obj/item/food/stuffed_muli_pod
	category = CAT_TESHARI

/datum/crafting_recipe/food/caramel_jelly_toast
	name = "Caramel-jelly Toast"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/datum/reagent/consumable/kiri_jelly = 5,
		/datum/reagent/consumable/caramel = 5,
	)
	result = /obj/item/food/caramel_jelly_toast
	category = CAT_TESHARI

/datum/crafting_recipe/food/kiri_jellypuff
	name = "Kiri Jellypuff"
	reqs = list(
		/obj/item/food/breadslice/piru = 1,
		/datum/reagent/consumable/kiri_jelly = 5,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/piru_flour = 5,
	)
	result = /obj/item/food/kiri_jellypuff
	category = CAT_TESHARI

/datum/crafting_recipe/food/bluefeather_crisps_and_dip
	name = "Bluefeather Crisps and Dip"
	reqs = list(
		/obj/item/food/bluefeather_crisp = 2,
		/datum/reagent/consumable/muli_juice = 5,
		/obj/item/food/grown/tomato = 1,
		/datum/reagent/consumable/nakati_spice = 5,
	)
	result = /obj/item/food/bluefeather_crisps_and_dip
	category = CAT_TESHARI
