/atom/movable/screen/fullscreen/color_vision/rage_color
	color = "#550000"

/datum/reagent/drug/pcp //to an extent this is pretty much just super bath salts
	name = "PCP"
	description = "Pure rage put into chemical form."
	reagent_state = LIQUID
	color = "#ffea2e"
	overdose_threshold = 10 //really low overdose to keep people from abusing it too much
	ph = 8
	addiction_types = list(/datum/addiction/stimulants = 40)  //you're fucking doomed
	taste_description = "rage"
	var/datum/brain_trauma/special/psychotic_brawling/bath_salts/pcp_rage
	var/datum/brain_trauma/special/tenacity/pcp_tenacity
	var/pcp_lifetime = 0

/datum/reagent/drug/pcp/on_mob_metabolize(mob/living/L)
	..()
	if(iscarbon(L))
		var/mob/living/carbon/C = L
		pcp_rage = new()
		pcp_tenacity = new()
		C.gain_trauma(pcp_rage, TRAUMA_RESILIENCE_ABSOLUTE)
		C.gain_trauma(pcp_tenacity, TRAUMA_RESILIENCE_ABSOLUTE)
		C.sound_environment_override = SOUND_ENVIRONMENT_HANGAR

/datum/reagent/drug/pcp/on_mob_life(mob/living/carbon/M, seconds_per_tick, times_fired)
	var/high_message = pick("You feel like KILLING!", "Someone's about to fucking die!", "Rip and tear!")
	if(M.hud_used!=null)
		var/atom/movable/plane_master_controller/game_plane_master_controller = M.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
		game_plane_master_controller.add_filter("pcp_blur", 10, angular_blur_filter(0, 0, 0.7))
	if(SPT_PROB(2.5, seconds_per_tick))
		to_chat(M, span_warning("[high_message]"))
	M.AdjustKnockdown(-20 * REM * seconds_per_tick)
	M.AdjustImmobilized(-20 * REM * seconds_per_tick)
	M.adjustStaminaLoss(-10 * REM * seconds_per_tick, 0)
	M.AdjustStun(-10 * REM * seconds_per_tick) //this is absolutely rediculous
	M.overlay_fullscreen("pcp_rage", /atom/movable/screen/fullscreen/color_vision/rage_color)
	M.adjust_hallucinations(10 SECONDS * REM * seconds_per_tick)
	M.sound_environment_override = SOUND_ENVIRONMENT_DRUGGED
	if(SPT_PROB(3.5, seconds_per_tick))
		M.emote(pick("scream","twitch"))
	pcp_lifetime+= 3 * REM * seconds_per_tick
	for(var/stackies in M.reagents.reagent_list)
		if(istype(stackies, /datum/reagent/medicine/))
			M.ForceContractDisease(new /datum/disease/adrenal_crisis(), FALSE, TRUE) //Trying to chemstack? Go directly to hell. Do not pass go.
			break

	..()

/datum/reagent/drug/pcp/on_mob_end_metabolize(mob/living/L)
	if(iscarbon(L))
		var/mob/living/carbon/M = L
		if(M.hud_used!=null)
			var/atom/movable/plane_master_controller/game_plane_master_controller = M.hud_used.plane_master_controllers[PLANE_MASTERS_GAME]
			game_plane_master_controller.remove_filter("pcp_blur")
		M.clear_fullscreen("pcp_rage")
		M.sound_environment_override = SOUND_ENVIRONMENT_NONE
	if(pcp_rage)
		QDEL_NULL(pcp_rage)
	if(pcp_tenacity)
		QDEL_NULL(pcp_tenacity)
	L.visible_message(span_danger("[L] collapses onto the floor!")) //you pretty much pass out
	L.Paralyze(pcp_lifetime,TRUE)
	L.drop_all_held_items()
	L.sound_environment_override = NONE
	..()

/datum/reagent/drug/pcp/overdose_process(mob/living/M, seconds_per_tick, times_fired)
	M.adjustToxLoss(2 * REM * seconds_per_tick, 0)
	M.adjustOrganLoss(ORGAN_SLOT_HEART, (2 * REM * seconds_per_tick))
	M.adjustOrganLoss(ORGAN_SLOT_BRAIN, (2 * REM * seconds_per_tick))
	M.adjustStaminaLoss(15 * REM * seconds_per_tick, 0) //reverses stamina loss
	M.set_jitter_if_lower(5 SECONDS)
	if(SPT_PROB(2.5, seconds_per_tick))
		M.emote(pick("twitch","drool"))
	if(SPT_PROB(1.5, seconds_per_tick))
		M.visible_message(span_danger("[M] flails their arms around everywhere!"))
		M.drop_all_held_items()
	..()
	. = TRUE

//precursor chemical
/datum/reagent/pcc
	name = "PCC"
	description = "A chemical precursor to PCP."
	reagent_state = SOLID
	color = "#ffea2e" // rgb: 128, 128, 128
	taste_description = "satiated rage"
	ph = 7.3
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED
