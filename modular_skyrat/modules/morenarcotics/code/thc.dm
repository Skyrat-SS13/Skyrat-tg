/obj/item/food/grown/cannabis/on_grind()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_DRIED))
		grind_results = list(/datum/reagent/drug/thc/hash = 0.15*src.seed.potency)
		reagents.clear_reagents() //prevents anything else from coming out

/datum/chemical_reaction/hash
	required_reagents = list(/datum/reagent/drug/thc/hash = 10)
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/hash/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/hash(location)

/datum/chemical_reaction/dabs
	required_reagents = list(/datum/reagent/drug/thc = 20)
	required_temp = 420 //haha very funny
	reaction_flags = REACTION_INSTANT
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/dabs/on_reaction(datum/reagents/holder, datum/equilibrium/reaction, created_volume)
	var/location = get_turf(holder.my_atom)
	for(var/i in 1 to created_volume)
		new /obj/item/reagent_containers/hash/dabs(location)

//shit for effects
/datum/mood_event/stoned
	description = span_nicegreen("You're totally baked right now...\n")
	mood_change = 6
	timeout = 3 MINUTES

/atom/movable/screen/alert/stoned
	name = "Stoned"
	desc = "You're stoned out of your mind! Woaaahh..."
	icon_state = "high"

//the reagent itself
/datum/reagent/drug/thc
	name = "THC"
	description = "A chemical found in cannabis that serves as its main psychoactive component."
	taste_description = "skunk"
	color = "#cfa40c"
	overdose_threshold = 30 //just gives funny effects, but doesnt hurt you; thc has no actual known overdose
	ph = 6

	/// The name of the mood event
	var/event_name = "stoned"
	/// The mood event given
	var/mood_event = /datum/mood_event/stoned
	/// The alert thrown
	var/thrown_alert = /atom/movable/screen/alert/stoned

	/// How much nutrition you lose on life
	var/nutrition_loss = 1
	/// How drowsy you become on overdose process
	var/drowsyness = 0.1

	/// Does the drug make you dizzy?
	var/makes_dizzy = TRUE
	/// Does the drug make you hungry?
	var/makes_hungry = TRUE
	/// The duration of the dizziness
	var/dizzy_duration = 10 SECONDS

	/// Probability of getting a chat message on life
	var/chat_message_chance = 2.5
	/// Possible chat messages while high
	var/static/list/high_message = list(
		"You feel relaxed.",
		"You feel fucked up.",
		"You feel totally wrecked...",
		)

	/// Probability of having an emote forced on life
	var/emote_chance = 3.5
	/// Possible emotes to force while high
	var/static/list/emotes = list(
		"laugh",
		"giggle",
		)

	/// Probability of having speech forced on overdose process
	var/speak_chance = 1.5
	/// Possible phrases to be forced
	var/static/list/forced_phrase = list(
		"It's major...",
		"Oh my goodness...",
		)

	/// Probability of coughing on overdose process
	var/cough_chance = 3.5
	/// Possible cough SFX
	var/static/list/cough_noise = list(
		'modular_skyrat/master_files/sound/effects/lungbust_cough1.ogg',
		'modular_skyrat/master_files/sound/effects/lungbust_cough2.ogg',
		)

/datum/reagent/drug/thc/on_mob_life(mob/living/carbon/consumer, delta_time, times_fired)
	var/atom/movable/plane_master_controller/game_plane_master_controller = consumer.hud_used?.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller?.add_filter("drug_blur", 10, angular_blur_filter(0, 0, 0.45))

	consumer.add_mood_event(event_name, mood_event, name)
	consumer.throw_alert(event_name, thrown_alert)

	if(makes_dizzy)
		consumer.set_timed_status_effect(dizzy_duration * REM * delta_time, /datum/status_effect/dizziness, only_if_higher = TRUE)
	if(makes_hungry)
		consumer.adjust_nutrition(-nutrition_loss * REM * delta_time) //munchies
	consumer.sound_environment_override = SOUND_ENVIRONMENT_DRUGGED

	if(DT_PROB(chat_message_chance, delta_time))
		to_chat(consumer, span_notice("[pick(high_message)]"))
	if(DT_PROB(emote_chance, delta_time))
		consumer.emote(pick(emotes))
	..()

/datum/reagent/drug/thc/on_mob_end_metabolize(mob/living/carbon/consumer)
	. = ..()
	var/atom/movable/plane_master_controller/game_plane_master_controller = consumer.hud_used?.plane_master_controllers[PLANE_MASTERS_GAME]
	game_plane_master_controller?.remove_filter("drug_blur")
	consumer.clear_alert(event_name)
	consumer.sound_environment_override = SOUND_ENVIRONMENT_NONE

/datum/reagent/drug/thc/overdose_process(mob/living/consumer, delta_time, times_fired)
	if(DT_PROB(speak_chance, delta_time))
		consumer.say("[pick(forced_phrase)]")
	consumer.adjust_drowsyness(drowsyness * REM * delta_time * normalise_creation_purity())
	if(DT_PROB(cough_chance, delta_time))
		playsound(consumer, pick(cough_noise), 50, TRUE)
		consumer.emote("cough")
	..()
	. = TRUE

/datum/reagent/drug/thc/hash //only exists to generate hash object
	name = "hashish"
	description = "Concentrated cannabis extract. Delivers a much better high when used in a bong."
