/obj/item/reagent_containers/hypospray/medipen/twitch_injector
	name = "TWitch injector"
	desc = "A tiny injector filled with a slowly shifting, angry-red liquid.\nYou suspect it contains TWtich; a drug that users claim lets them 'see faster', whatever that means."
	icon = 'modular_skyrat/modules/morenarcotics/icons/drug_items.dmi'
	icon_state = "twitch"
	base_icon_state = "twitch"
	amount_per_transfer_from_this = 10
	volume = 10
	ignore_flags = 0
	reagent_flags = NONE
	list_reagents = list(/datum/reagent/drug/twitch = 10)
	label_examine = FALSE

/obj/item/reagent_containers/hypospray/medipen/inject(mob/living/affected_mob, mob/user)
	. = ..()
	if(.)
		playsound(src, 'modular_skyrat/modules/hyposprays/sound/hypospray_long.ogg', 50, 1, -1) // pshhhs

/datum/reagent/drug/twitch
	name = "TWitch"
	description = "A drug originally developed by an as of now undisclosed military body for enhancing soldiers.\nDoes not see wide use due to the whole terrible psychosis and reality-disassociation thing afterwards."
	reagent_state = LIQUID
	color = "#c22a44"
	taste_description = "television static"
	ph = 3
	overdose_threshold = 15
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/hallucinogens = 15)

/datum/reagent/drug/twitch/on_mob_metabolize(mob/living/consoomer)
	. = ..()

	RegisterSignal(consoomer, COMSIG_MOVABLE_MOVED, PROC_REF(on_movement), TRUE)

	if(!consoomer.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = consoomer.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	var/list/col_filter_darker_green = list(0.2,0,0,0, 0,1,0,0, 0,0,0.2,0, 0,0,0,1)

	game_plane_master_controller.add_filter("twitch_filter", 10, color_matrix_filter(col_filter_darker_green, FILTER_COLOR_RGB))
	game_plane_master_controller.add_filter("twitch_blur", 1, list("type" = "radial_blur", "size" = 0.1))

	for(var/filter in game_plane_master_controller.get_filters("twitch_blur"))
		animate(filter, loop = -1, size = 0.05, time = 4 SECONDS, easing = ELASTIC_EASING|EASE_OUT, flags = ANIMATION_PARALLEL)
		animate(size = 0.15, time = 4 SECONDS, easing = CIRCULAR_EASING|EASE_IN)

	consoomer.sound_environment_override = SOUND_ENVIRONMENT_UNDERWATER

/datum/reagent/drug/twitch/on_mob_end_metabolize(mob/living/consoomer)
	. = ..()

	if(!consoomer.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = consoomer.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	game_plane_master_controller.remove_filter("twitch_filter")
	game_plane_master_controller.remove_filter("twitch_blur")
	consoomer.sound_environment_override = NONE

/datum/reagent/drug/twitch/proc/on_movement(mob/living/our_guy)
	SIGNAL_HANDLER
	new /obj/effect/temp_visual/decoy/fading/color_changing(our_guy.loc, our_guy)

/*
/datum/reagent/drug/blastoff/on_mob_life(mob/living/carbon/dancer, delta_time, times_fired)
	. = ..()

	dancer.adjustOrganLoss(ORGAN_SLOT_LUNGS, 0.3 * REM * delta_time)
	dancer.AdjustKnockdown(-20)

	if(DT_PROB(BLASTOFF_DANCE_MOVE_CHANCE_PER_UNIT * volume, delta_time))
		dancer.emote("flip")

/datum/reagent/drug/blastoff/overdose_process(mob/living/dancer, delta_time, times_fired)
	. = ..()
	dancer.adjustOrganLoss(ORGAN_SLOT_LUNGS, 0.3 * REM * delta_time)

	if(DT_PROB(BLASTOFF_DANCE_MOVE_CHANCE_PER_UNIT * volume, delta_time))
		dancer.emote("spin")
*/

/obj/effect/temp_visual/decoy/fading/color_changing
	/// The color matrix it should be at spawn
	var/list/matrix_start = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0.5,0,0)
	/// The color matrix it should be by the time it despawns
	var/list/matrix_end = list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0.1,0.4,0)

/obj/effect/temp_visual/decoy/fading/color_changing/Initialize(mapload)
	. = ..()
	color = matrix_start
	animate(color = matrix_end, time = duration)
