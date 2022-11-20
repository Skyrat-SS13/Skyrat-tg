/obj/item/reagent_containers/hypospray/medipen/demoneye_applicator
	name = "DemonEye applicator"
	desc = "A small black box with a glass vial on one end, and an aerosolizer on the other.\nYou suspect it contains DemonEye, a performance enhancing drug popular with gangs on mars."
	icon = 'modular_skyrat/modules/morenarcotics/icons/drug_items.dmi'
	icon_state = "demoneye"
	base_icon_state = "demoneye"
	amount_per_transfer_from_this = 10
	volume = 10
	ignore_flags = FALSE
	reagent_flags = NONE
	list_reagents = list(/datum/reagent/drug/demoneye = 10)
	label_examine = FALSE

/obj/item/reagent_containers/hypospray/medipen/twitch_injector/inject(mob/living/affected_mob, mob/user) // Mostly the same as default just with some changed logic for if it succeeds
	. = ..()

	if(!reagents.total_volume)
		to_chat(user, span_warning("[src] is empty!"))
		return FALSE

	if(!iscarbon(affected_mob))
		return FALSE

	//Always log attemped injects for admins
	var/list/injected = list()
	for(var/datum/reagent/injected_reagent in reagents.reagent_list)
		injected += injected_reagent.name
	var/contained = english_list(injected)
	log_combat(user, affected_mob, "attempted to inject", src, "([contained])")

	if(affected_mob.is_eyes_covered())
		to_chat(user, span_notice("[affected_mob]'s eyes can't be covered!"))
		return FALSE

	if(reagents.total_volume && (ignore_flags || affected_mob.try_inject(user, injection_flags = INJECT_TRY_SHOW_ERROR_MESSAGE)) && do_after(user, 2 SECONDS, affected_mob))
		to_chat(affected_mob, span_warning("[user] sprays [src] into your eye!"))
		to_chat(user, span_notice("You spray [src] into [affected_mob]'s eye."))
		playsound(src, 'sound/effects/spray.ogg', 50, 1, -1)
		var/fraction = min(amount_per_transfer_from_this/reagents.total_volume, 1)

		if(affected_mob.reagents)
			var/trans = 0
			if(!infinite)
				trans = reagents.trans_to(affected_mob, amount_per_transfer_from_this, transfered_by = user, methods = TOUCH)
			else
				reagents.expose(affected_mob, TOUCH, fraction)
				trans = reagents.copy_to(affected_mob, amount_per_transfer_from_this)
			to_chat(user, span_notice("[trans] unit\s injected. [reagents.total_volume] unit\s remaining in [src]."))
			log_combat(user, affected_mob, "injected", src, "([contained])")
		return TRUE
	return FALSE

/datum/chemical_reaction/demoneye
	required_reagents = list(/datum/reagent/medicine/ephedrine = 5, /datum/reagent/blood = 15, /datum/reagent/toxin/plasma = 5)
	mob_react = FALSE
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_DRUG | REACTION_TAG_ORGAN | REACTION_TAG_DAMAGING

/datum/chemical_reaction/demoneye/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/iteration in 1 to created_volume)
		var/obj/item/reagent_containers/hypospray/medipen/demoneye_applicator/new_applicator = new(location)
		new_applicator.pixel_x = rand(-6, 6)
		new_applicator.pixel_y = rand(-6, 6)

/datum/reagent/drug/demoneye
	name = "DemonEye"
	description = "A performance enhancing drug originally developed on mars.\nA favorite among gangs other outlaws on the planet, though overuse can cause terrible addiction and bodily damage."
	reagent_state = LIQUID
	color = "#af00be"
	taste_description = "industrial shuttle fuel"
	ph = 7
	overdose_threshold = 15
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
	addiction_types = list(/datum/addiction/exotic_stimulants = 15)
	/// How much time has the drug been in them?
	var/constant_dose_time = 0

/datum/reagent/drug/demoneye/on_mob_metabolize(mob/living/our_guy)
	. = ..()

	var/obj/item/bodypart/arm/left/left_arm = our_guy.get_bodypart(BODY_ZONE_L_ARM)
	if(left_arm)
		left_arm.unarmed_damage_low += 5
		left_arm.unarmed_damage_high += 5

	var/obj/item/bodypart/arm/right/right_arm = our_guy.get_bodypart(BODY_ZONE_R_ARM)
	if(right_arm)
		right_arm.unarmed_damage_low += 5
		right_arm.unarmed_damage_high += 5

	our_guy.sound_environment_override = SOUND_ENVIROMENT_PHASED

	if(!our_guy.hud_used)
		return

	var/atom/movable/plane_master_controller/game_plane_master_controller = our_guy.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]

	var/list/col_filter_green = list(1,0,0,0, 0,0,0,0, 0,0,0,0, 0.5,0,0,1)

	game_plane_master_controller.add_filter("demoneye_filter", 10, color_matrix_filter(col_filter_green, FILTER_COLOR_RGB))

	game_plane_master_controller.add_filter("demoneye_blur", 1, list("type" = "ripple", "size" = 10, "repeat" = 10, "radius" = 32, "falloff" = 10))
