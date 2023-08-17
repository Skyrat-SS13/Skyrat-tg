/obj/item/reagent_brick/heroin
	name = "heroin brick"
	desc = "A brick of heroin. Good for transport!"
	icon = 'modular_skyrat/modules/morenarcotics/icons/crack.dmi'
	icon_state = "heroinbrick"
	packed_item = /obj/item/snortable/heroin
	brick_reagent = /datum/reagent/drug/heroin/powder_heroin
	reagent_amount = 20

/datum/crafting_recipe/heroin_brick
	result = /obj/item/reagent_brick/heroin
	reqs = list(/obj/item/snortable/heroin = 5)
	parts = list(/obj/item/snortable/heroin = 5)
	time = 20
	category = CAT_CHEMISTRY //i might just make a crafting category for drugs at some point
	var/list/purity_hash = list()

/datum/crafting_recipe/heroin_brick/on_craft_completion(mob/user, atom/result)
	var/obj/item/reagent_brick/heroin/crafted_brick = result
	var/datum/reagent/drug/heroin/powder_heroin/brick_heroin_reagent = crafted_brick.reagents.has_reagent(/datum/reagent/drug/heroin/powder_heroin)
	brick_heroin_reagent.creation_purity = purity_hash[user]
	brick_heroin_reagent.purity = purity_hash[user]

/datum/export/heroinbrick
	cost = CARGO_CRATE_VALUE * 2.5
	unit_name = "heroin brick"
	export_types = list(/obj/item/reagent_brick/heroin)
	include_subtypes = FALSE
