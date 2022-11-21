/obj/item/food/drug/extinguisher_crystal
	name = "moon rock"
	desc = "An aerogel-like substance made of firefighting foam in the shape of a crystal.\nUnder no circumstances ever should you roll this up in rolling paper and smoke it, that would be illegal of course."
	icon = 'modular_skyrat/modules/morenarcotics/icons/drug_items.dmi'
	icon_state = "crystal_extinguisher"
	food_reagents = list(
		/datum/reagent/drug/crystal_firefighter_foam = 5,
		/datum/reagent/impurity/inacusiate = 5,
		/datum/reagent/impurity/mannitol = 5,
	)
	tastes = list("flavorless cotton candy" = 2, "rubbing alcohol" = 1)

/obj/item/food/drug/extinguisher_crystal/Initialize(mapload)
	. = ..()

	transform = transform.Turn(rand(0, 360))

	ADD_TRAIT(src, TRAIT_DRIED, TRAIT_GENERIC) // Lets it be put in rolling paper and pipes

/datum/reagent/drug/crystal_firefighter_foam
	name = "Crystalline FireFighting Foam"
	description = "Extinguisher foam in the form of possibly thousands of tiny crystals, not that great at extinguishing fires anymore.\nWhat it is great at however, is being a powerful hallucinogen when smoked."
	reagent_state = SOLID
	color = "#526679"
	taste_description = "asbestos"
	ph = 10
	overdose_threshold = 30
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/hallucinogens = 5)

/datum/reagent/drug/crystal_firefighter_foam/on_mob_metabolize(mob/living/our_guy)
	. = ..()

	our_guy.sound_environment_override = SOUND_ENVIRONMENT_DRUGGED

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	var/list/col_filter_green = list(0.5,0,0,0, 0,0.6,0,0, 0,0,0.75,0, 0,0,0,1)

	game_plane_master_controller.add_filter("da_foam_filter", 10, color_matrix_filter(col_filter_green, FILTER_COLOR_RGB))

	game_plane_master_controller.add_filter("da_foam_waves", 1, list("type" = "wave", "x" = 32, "size" = 6, "offset" = 1))

	for(var/filter in game_plane_master_controller.get_filter("da_foam_waves"))
		animate(filter, loop = -1, size = 12, time = 4 SECONDS, easing = ELASTIC_EASING|EASE_OUT, flags = ANIMATION_PARALLEL)
		animate(size = 6, time = 4 SECONDS, easing = ELASTIC_EASING|EASE_IN)

/datum/reagent/drug/crystal_firefighter_foam/on_mob_end_metabolize(mob/living/carbon/our_guy)
	. = ..()

	our_guy.sound_environment_override = NONE

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	game_plane_master_controller.remove_filter("da_foam_filter")
	game_plane_master_controller.remove_filter("da_foam_waves")
