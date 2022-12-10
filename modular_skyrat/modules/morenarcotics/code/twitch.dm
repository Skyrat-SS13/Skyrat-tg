/obj/item/reagent_containers/hypospray/medipen/twitch_injector
	name = "TWitch injector"
	desc = "A tiny injector filled with a slowly shifting, angry-red liquid.\nYou suspect it contains TWitch; a drug that users claim lets them 'see faster', whatever that means."
	icon = 'modular_skyrat/modules/morenarcotics/icons/drug_items.dmi'
	icon_state = "twitch"
	base_icon_state = "twitch"
	amount_per_transfer_from_this = 10
	volume = 10
	ignore_flags = FALSE
	reagent_flags = NONE
	list_reagents = list(/datum/reagent/drug/twitch = 10)
	label_examine = FALSE

/obj/item/reagent_containers/hypospray/medipen/twitch_injector/inject(mob/living/affected_mob, mob/user)
	. = ..()
	if(.)
		playsound(src, 'modular_skyrat/modules/hyposprays/sound/hypospray_long.ogg', 50, 1, -1) // pshhhs

/datum/chemical_reaction/twitch_injectors
	required_reagents = list(/datum/reagent/impedrezene = 5, /datum/reagent/bluespace = 10, /datum/reagent/consumable/liquidelectricity/enriched = 2)
	mob_react = FALSE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING

/datum/chemical_reaction/twitch_injectors/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/iteration in 1 to created_volume)
		var/obj/item/reagent_containers/hypospray/medipen/twitch_injector/new_injector = new(location)
		new_injector.pixel_x = rand(-6, 6)
		new_injector.pixel_y = rand(-6, 6)

/datum/reagent/drug/twitch
	name = "TWitch"
	description = "A drug originally developed by an as of now undisclosed military body for enhancing soldiers.\nDoes not see wide use due to the whole reality-disassociation and heart disease thing afterwards."
	reagent_state = LIQUID
	color = "#c22a44"
	taste_description = "television static"
	ph = 3
	overdose_threshold = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/exotic_stimulants = 15)
	/// How much time has the drug been in them?
	var/constant_dose_time = 0
	/// What type of span class do we change heard speech to?
	var/speech_effect_span

/datum/reagent/drug/twitch/on_mob_metabolize(mob/living/our_guy)
	. = ..()

	our_guy.add_movespeed_modifier(/datum/movespeed_modifier/reagent/twitch)
	our_guy.next_move_modifier -= 0.3 // For the duration of this you move and attack faster

	our_guy.sound_environment_override = SOUND_ENVIRONMENT_DIZZY

	speech_effect_span = "green"

	RegisterSignal(our_guy, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement))
	RegisterSignal(our_guy, COMSIG_MOVABLE_HEAR, PROC_REF(fuck_up_hearing))

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	var/list/col_filter_green = list(0.5,0,0,0, 0,1,0,0, 0,0,0.5,0, 0,0,0,1)

	game_plane_master_controller.add_filter("twitch_filter", 10, color_matrix_filter(col_filter_green, FILTER_COLOR_RGB))

	game_plane_master_controller.add_filter("twitch_blur", 1, list("type" = "radial_blur", "size" = 0.1))

	for(var/filter in game_plane_master_controller.get_filters("twitch_blur"))
		animate(filter, loop = -1, size = 0.2, time = 2 SECONDS, easing = ELASTIC_EASING|EASE_OUT, flags = ANIMATION_PARALLEL)
		animate(size = 0.1, time = 6 SECONDS, easing = CIRCULAR_EASING|EASE_IN)

/datum/reagent/drug/twitch/on_mob_end_metabolize(mob/living/carbon/our_guy)
	. = ..()

	our_guy.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/twitch)
	our_guy.next_move_modifier += (overdosed ? 0.5 : 0.3)

	our_guy.sound_environment_override = NONE

	speech_effect_span = "hierophant"

	UnregisterSignal(our_guy, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(our_guy, COMSIG_MOVABLE_HEAR)

	if(constant_dose_time < 100) // Anything less than this and you'll come out fiiiine, aside from a big hit of stamina damage
		our_guy.visible_message(
			span_danger("[our_guy] suddenly slows from their inhuman speeds, coming back with a wicked nosebleed!"),
			span_danger("You suddenly slow back to normal, a stream of blood gushing from your nose!")
		)
		our_guy.adjustStaminaLoss(constant_dose_time)
	else // Much longer than that however, and you're not gonna have a good day
		our_guy.visible_message(
			span_danger("[our_guy] suddenly snaps back from their inhumans speeds, coughing up a spray of blood!"),
			span_danger("As you snap back to normal speed you cough up a worrying amount of blood. You feel like you've just been run over by a power loader.")
		)
		our_guy.spray_blood(our_guy.dir, 2) // The before mentioned coughing up blood
		our_guy.emote("cough")
		our_guy.adjustStaminaLoss(constant_dose_time)
		our_guy.adjustOrganLoss(ORGAN_SLOT_HEART, 0.3 * constant_dose_time) // Basically you might die

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	game_plane_master_controller.remove_filter("twitch_filter")
	game_plane_master_controller.remove_filter("twitch_blur")

/// Leaves an afterimage behind the mob when they move
/datum/reagent/drug/twitch/proc/on_movement(mob/living/carbon/our_guy)
	SIGNAL_HANDLER
	new /obj/effect/temp_visual/decoy/twitch_afterimage(our_guy.loc, our_guy)

/datum/reagent/drug/twitch/on_mob_life(mob/living/carbon/our_guy, delta_time, times_fired)
	. = ..()

	constant_dose_time += delta_time

	if(locate(/datum/reagent/drug/kronkaine) in our_guy.reagents.reagent_list) // Kronkaine, another heart-straining drug, could cause problems if mixed with this
		our_guy.ForceContractDisease(new /datum/disease/adrenal_crisis(), FALSE, TRUE)

/datum/reagent/drug/twitch/overdose_start(mob/living/our_guy)
	. = ..()

	our_guy.next_move_modifier -= 0.2 // Overdosing makes you a liiitle faster but you know has some really bad consequences

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	var/list/col_filter_ourple = list(1,0,0,0, 0,0.5,0,0, 0,0,1,0, 0,0,0,1)

	for(var/filter in game_plane_master_controller.get_filters("twitch_filter"))
		animate(filter, color = col_filter_ourple, time = 4 SECONDS, easing = EASE_OUT)

/datum/reagent/drug/twitch/overdose_process(mob/living/carbon/our_guy, delta_time, times_fired)
	. = ..()

	our_guy.set_jitter_if_lower(10 SECONDS * REM * delta_time)

	our_guy.adjustOrganLoss(ORGAN_SLOT_HEART, 1 * REM * delta_time)

	if(DT_PROB(5, delta_time))
		to_chat(our_guy, span_danger("You cough up a splatter of blood!"))
		our_guy.spray_blood(our_guy.dir, 1)
		our_guy.emote("cough")

	if(DT_PROB(10, delta_time))
		our_guy.add_filter("overdose_phase", 2, phase_filter(8))
		addtimer(CALLBACK(our_guy, TYPE_PROC_REF(/atom, remove_filter), "overdose_phase"), 0.5 SECONDS)

/datum/reagent/drug/twitch/proc/fuck_up_hearing(datum/source, list/hearing_args)
	SIGNAL_HANDLER
	hearing_args[HEARING_RAW_MESSAGE] = "<span class='[speech_effect_span]'>[hearing_args[HEARING_RAW_MESSAGE]]</span>"

/// Cool filter that I'm using for some of this :)))
/proc/phase_filter(size)
	. = list("type" = "wave")
	.["x"] = 1
	if(!isnull(size))
		.["size"] = size

/obj/effect/temp_visual/decoy/twitch_afterimage
	/// The color matrix it should be at spawn
	var/list/matrix_start = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0.1,0.4,0)
	/// The color matrix it should be by the time it despawns
	var/list/matrix_end = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0.5,0,0)

/obj/effect/temp_visual/decoy/twitch_afterimage/Initialize(mapload)
	. = ..()
	color = matrix_start
	animate(src, color = matrix_end, time = duration, easing = EASE_OUT)
	animate(src, alpha = 0, time = duration, easing = EASE_OUT)

/datum/movespeed_modifier/reagent/twitch
	multiplicative_slowdown = -0.4
