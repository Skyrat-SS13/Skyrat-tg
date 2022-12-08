/obj/item/food/drug/extinguisher_crystal
	name = "moon rock"
	desc = "An aerogel-like substance made of firefighting foam in the shape of a crystal.\nUnder no circumstances ever should you roll this up in rolling paper and smoke it, that would be illegal of course."
	icon = 'modular_skyrat/modules/morenarcotics/icons/drug_items.dmi'
	icon_state = "crystal_extinguisher"
	food_reagents = list(
		/datum/reagent/drug/crystal_firefighter_foam = 20,
	)
	tastes = list("flavorless cotton candy" = 2, "rubbing alcohol" = 1)

/obj/item/food/drug/extinguisher_crystal/Initialize(mapload)
	. = ..()

	transform = transform.Turn(rand(0, 360))

	ADD_TRAIT(src, TRAIT_DRYABLE, TRAIT_NARCOTICS) // Lets it be put in rolling paper and pipes

/datum/chemical_reaction/extinguisher_crystal
	required_reagents = list(/datum/reagent/firefighting_foam = 20)
	required_temp = 450 // Foam is made when its really cold so itll then turn into crystals if made really hot
	mob_react = FALSE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING

/datum/chemical_reaction/extinguisher_crystal/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/iteration in 1 to created_volume)
		var/obj/item/food/drug/extinguisher_crystal/new_crystal = new(location)
		new_crystal.pixel_x = rand(-6, 6)
		new_crystal.pixel_y = rand(-6, 6)

/datum/reagent/drug/crystal_firefighter_foam
	name = "Crystalline FireFighting Foam"
	description = "Extinguisher foam in the form of possibly thousands of tiny crystals, not that great at extinguishing fires anymore.\nWhat it is great at however, is being a powerful hallucinogen when smoked."
	reagent_state = SOLID
	color = "#526679"
	taste_description = "asbestos"
	ph = 10
	overdose_threshold = 30
	metabolization_rate = 0.08 * REM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/hallucinogens = 5)
	/// Possible colors we can pick from to flash the target while processing
	var/static/list/trip_colors = list(
		"#ffae00",
		"#cc00ff",
		"#48ff00",
		"#ffd900",
	)

/datum/reagent/drug/crystal_firefighter_foam/on_mob_metabolize(mob/living/our_guy)
	. = ..()

	our_guy.sound_environment_override = SOUND_ENVIRONMENT_DRUGGED

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	game_plane_master_controller.add_filter("da_foam_waves", 1, list("type" = "wave", "x" = 32, "size" = 6, "offset" = 1))

	for(var/filter in game_plane_master_controller.get_filters("da_foam_waves"))
		animate(filter, loop = -1, time = 4 SECONDS, easing = ELASTIC_EASING|EASE_OUT, flags = ANIMATION_PARALLEL, offset = 2)
		animate(time = 4 SECONDS, easing = ELASTIC_EASING|EASE_IN, offset = 1)

/datum/reagent/drug/crystal_firefighter_foam/on_mob_end_metabolize(mob/living/carbon/our_guy)
	. = ..()

	our_guy.sound_environment_override = NONE

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	game_plane_master_controller.remove_filter("da_foam_waves")

/datum/reagent/drug/crystal_firefighter_foam/on_mob_life(mob/living/carbon/our_guy, delta_time, times_fired)
	. = ..()

	our_guy.set_drugginess(1 MINUTES * REM * delta_time)
	our_guy.adjust_slurring_up_to(30 SECONDS, 2 MINUTES)
	our_guy.set_dizzy_if_lower(5 * REM * delta_time * 2 SECONDS)

	if(DT_PROB(25, delta_time))
		flash_color(our_guy, flash_color = pick(trip_colors), flash_time = 1 SECONDS)

/datum/reagent/drug/crystal_firefighter_foam/overdose_process(mob/living/carbon/our_guy, delta_time, times_fired)
	. = ..()

	our_guy.set_jitter_if_lower(10 SECONDS * REM * delta_time)

	our_guy.adjustOrganLoss(ORGAN_SLOT_LUNGS, 0.5 * REM * delta_time)

	if(DT_PROB(5, delta_time))
		to_chat(our_guy, span_danger("You cough up a painful cloud of crystal shards!"))
		our_guy.adjustStaminaLoss(10)
		our_guy.emote("cough")
