#define BASE_SHAKER_JUICE_REAGENTS list(\
		/datum/reagent/consumable/aloejuice,\
		/datum/reagent/consumable/applejuice,\
		/datum/reagent/consumable/banana,\
		/datum/reagent/consumable/berryjuice,\
		/datum/reagent/consumable/blumpkinjuice,\
		/datum/reagent/consumable/carrotjuice,\
		/datum/reagent/consumable/cherryjelly,\
		/datum/reagent/consumable/grapejuice,\
		/datum/reagent/consumable/lemonjuice,\
		/datum/reagent/consumable/lemon_lime,\
		/datum/reagent/consumable/limejuice,\
		/datum/reagent/consumable/parsnipjuice,\
		/datum/reagent/consumable/peachjuice,\
		/datum/reagent/consumable/pineapplejuice,\
		/datum/reagent/consumable/potato_juice,\
		/datum/reagent/consumable/pumpkinjuice,\
		/datum/reagent/consumable/orangejuice,\
		/datum/reagent/consumable/tomatojuice,\
		/datum/reagent/consumable/watermelonjuice\
	)

#define BASE_SHAKER_ALCOHOL_REAGENTS list(\
		/datum/reagent/consumable/ethanol/absinthe,\
		/datum/reagent/consumable/ethanol/ale,\
		/datum/reagent/consumable/ethanol/amaretto,\
		/datum/reagent/consumable/ethanol/applejack,\
		/datum/reagent/consumable/ethanol/beer,\
		/datum/reagent/consumable/ethanol/cognac,\
		/datum/reagent/consumable/ethanol/champagne,\
		/datum/reagent/consumable/ethanol/creme_de_cacao,\
		/datum/reagent/consumable/ethanol/creme_de_coconut,\
		/datum/reagent/consumable/ethanol/creme_de_menthe,\
		/datum/reagent/consumable/ethanol,\
		/datum/reagent/consumable/ethanol/gin,\
		/datum/reagent/consumable/ethanol/hooch,\
		/datum/reagent/consumable/ethanol/kahlua,\
		/datum/reagent/consumable/laughter,\
		/datum/reagent/consumable/ethanol/lizardwine,\
		/datum/reagent/consumable/ethanol/beer/maltliquor,\
		/datum/reagent/consumable/nothing,\
		/datum/reagent/consumable/ethanol/rum,\
		/datum/reagent/consumable/ethanol/sake,\
		/datum/reagent/consumable/ethanol/synthanol,\
		/datum/reagent/consumable/ethanol/tequila,\
		/datum/reagent/consumable/ethanol/triple_sec,\
		/datum/reagent/consumable/ethanol/vermouth,\
		/datum/reagent/consumable/ethanol/vodka,\
		/datum/reagent/consumable/ethanol/whiskey,\
		/datum/reagent/consumable/ethanol/wine\
	)

#define BASE_SHAKER_SODA_REAGENTS list(\
		/datum/reagent/consumable/dr_gibb,\
		/datum/reagent/consumable/grape_soda,\
		/datum/reagent/consumable/pwr_game,\
		/datum/reagent/consumable/shamblers,\
		/datum/reagent/consumable/sodawater,\
		/datum/reagent/consumable/sol_dry,\
		/datum/reagent/consumable/space_up,\
		/datum/reagent/consumable/space_cola,\
		/datum/reagent/consumable/spacemountainwind\
	)

#define BASE_SHAKER_MISC_REAGENTS list(\
		/datum/reagent/consumable/blackpepper,\
		/datum/reagent/blood,\
		/datum/reagent/pax/catnip,\
		/datum/reagent/consumable/coco,\
		/datum/reagent/toxin/coffeepowder,\
		/datum/reagent/consumable/cream,\
		/datum/reagent/consumable/enzyme,\
		/datum/reagent/consumable/eggyolk,\
		/datum/reagent/consumable/honey,\
		/datum/reagent/consumable/grenadine,\
		/datum/reagent/consumable/ice,\
		/datum/reagent/iron,\
		/datum/reagent/consumable/menthol,\
		/datum/reagent/consumable/milk,\
		/datum/reagent/toxin/mushroom_powder,\
		/datum/reagent/consumable/nutriment,\
		/datum/reagent/consumable/soymilk,\
		/datum/reagent/consumable/sugar,\
		/datum/reagent/toxin/teapowder,\
		/datum/reagent/consumable/tonic,\
		/datum/reagent/consumable/vanilla,\
		/datum/reagent/consumable/vinegar,\
		/datum/reagent/water\
	)


/obj/item/reagent_containers/borghypo/borgshaker/specific
	icon = 'modular_skyrat/modules/borg_buffs/icons/items_cyborg.dmi'
	icon_state = "misc"

/obj/item/reagent_containers/borghypo/borgshaker/specific/juice
	name = "cyborg juice shaker"
	icon_state = "juice"
	default_reagent_types = BASE_SHAKER_JUICE_REAGENTS

/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol
	name = "cyborg alcohol shaker"
	icon_state = "alcohol"
	default_reagent_types = BASE_SHAKER_ALCOHOL_REAGENTS

/obj/item/reagent_containers/borghypo/borgshaker/specific/soda
	name = "cyborg soda shaker"
	icon_state = "soda"
	default_reagent_types = BASE_SHAKER_SODA_REAGENTS

/obj/item/reagent_containers/borghypo/borgshaker/specific/misc
	name = "cyborg misc shaker"
	icon_state = "misc"
	default_reagent_types = BASE_SHAKER_MISC_REAGENTS

// Wirebrush for janiborg
/datum/design/borg_wirebrush
	name = "Wire-brush Module"
	id = "borg_upgrade_brush"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/wirebrush
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2
	)
	construction_time = 40
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR,
	)

/obj/item/borg/upgrade/wirebrush
	name = "janitor cyborg wire-brush"
	desc = "A tool to remove rust from walls."
	icon_state = "module_janitor"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR

/obj/item/borg/upgrade/wirebrush/action(mob/living/silicon/robot/cyborg)
	. = ..()
	if(.)
		for(var/obj/item/wirebrush/brush in cyborg.model.modules)
			cyborg.model.remove_module(brush, TRUE)

		var/obj/item/wirebrush/brush = new /obj/item/wirebrush(cyborg.model)
		cyborg.model.basic_modules += brush
		cyborg.model.add_module(brush, FALSE, TRUE)

/obj/item/borg/upgrade/wirebrush/deactivate(mob/living/silicon/robot/cyborg, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/wirebrush/brush in cyborg.model.modules)
			cyborg.model.remove_module(brush, TRUE)

		var/obj/item/wirebrush/brush = new (cyborg.model)
		cyborg.model.basic_modules += brush
		cyborg.model.add_module(brush, FALSE, TRUE)
