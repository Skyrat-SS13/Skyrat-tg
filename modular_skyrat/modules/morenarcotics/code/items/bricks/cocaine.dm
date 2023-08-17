/obj/item/reagent_brick/cocaine
	name = "cocaine brick"
	desc = "A brick of cocaine. Good for transport!"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "cocainebrick"
	packed_item = /obj/item/snortable/cocaine
	brick_reagent = /datum/reagent/drug/cocaine/powder_cocaine
	reagent_amount = 25

/datum/crafting_recipe/cocaine_brick
	result = /obj/item/reagent_brick/cocaine
	reqs = list(/obj/item/snortable/cocaine = 5)
	parts = list(/obj/item/snortable/cocaine = 5)
	time = 20
	category = CAT_CHEMISTRY //i might just make a crafting category for drugs at some point


/obj/item/reagent_brick/crack
	name = "crack brick"
	desc = "A brick of crack. Good for transport!"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "crackbrick"
	packed_item = /obj/item/smokable/crack
	packed_amount = 4
	brick_reagent = /datum/reagent/drug/cocaine/freebase_cocaine
	reagent_amount = 40

/datum/crafting_recipe/crack_brick
	result = /obj/item/reagent_brick/crack
	reqs = list(/obj/item/smokable/crack = 4)
	parts = list(/obj/item/smokable/crack = 4)
	time = 20
	category = CAT_CHEMISTRY //i might just make a crafting category for drugs at some point
	var/list/purity_hash = list() // im sorry man but there is literally no other fucking idea i have for how to pull this off

/datum/crafting_recipe/crack_brick/check_requirements(mob/user, list/collected_requirements)
	var/purity = 0
	for(var/obj/item/smokable/crack/required_crack in collected_requirements[/obj/item/smokable/crack])
		var/datum/reagent/drug/cocaine/freebase_cocaine/required_crack_reagent = required_crack.reagents.has_reagent(/datum/reagent/drug/cocaine/freebase_cocaine)
		purity += required_crack_reagent.creation_purity
	purity_hash[user] = purity / 4

	return TRUE

/datum/crafting_recipe/crack_brick/on_craft_completion(mob/user, atom/result)
	var/obj/item/reagent_brick/cocaine/crafted_brick = result
	var/datum/reagent/drug/cocaine/powder_cocaine/brick_cocaine_reagent = crafted_brick.reagents.has_reagent(/datum/reagent/drug/cocaine/freebase_cocaine)
	brick_cocaine_reagent.creation_purity = purity_hash[user]
	brick_cocaine_reagent.purity = purity_hash[user]
