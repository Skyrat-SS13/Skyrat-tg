GLOBAL_DATUM_INIT(unitologists, /datum/antagonist/unitologist, new)
GLOBAL_LIST_EMPTY(unitologists_list)
/*
/mob/proc/message_unitologists()
	set category = SPECIES_NECROMORPH
	set name = "Commune with the marker"
	set src = usr
	var/message = input("Say what?","Text") as null|text
	message = sanitize(message)
	message_necromorphs("<span class='unitologist'>[usr]: [message]</span>")
*/
/datum/antagonist/unitologist
	name = "Unitologist Zealot"
	//role_text_plural = "Unitologist Zealots"
	//id = MODE_UNITOLOGIST
	//flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	//skill_setter = /datum/antag_skill_setter/station
	//antaghud_indicator = "hudunitologist" // Used by the ghost antagHUD.
	//antag_indicator = "hudunitologist"// icon_state for icons/mob/mob.dm visual indicator.
	preference_candidacy_toggle = TRUE
	antagpanel_category = "Unitologist"
	job_rank = ROLE_UNITOLOGIST
	antag_hud_type = ANTAG_HUD_UNITOLOGIST
	antag_hud_name = "unitologist"
	show_in_antagpanel = FALSE //should only show subtypes
	show_to_ghosts = TRUE
	var/datum/team/unitologist/unitologist_team

	// Spawn values (autotraitor and game mode)
	//Hard cap of 6 will only be reached at really high playercounts
	//hard_cap = 6                        // Autotraitor var. Won't spawn more than this many antags.
	//hard_cap_round = 6                  // As above but 'core' round antags ie. roundstart.
	//initial_spawn_req = 0               // Gamemode using this template won't start without this # candidates.
	//initial_spawn_target = 3            // Gamemode will attempt to spawn this many antags.


/datum/antagonist/unitologist/get_team()
	return unitologist_team

/datum/antagonist/unitologist/create_team(datum/team/unitologist/new_team)
	if(!new_team)
		//todo remove this and allow admin buttons to create more than one unitologist
		for(var/datum/antagonist/unitologist/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.cult_team)
				cult_team = H.cult_team
				return
		cult_team = new /datum/team/unitologist
		cult_team.setup_objectives()
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	cult_team = new_team

/datum/antagonist/unitologist/proc/add_objectives()
	objectives |= cult_team.objectives

/datum/antagonist/unitologist/Destroy()
	QDEL_NULL(communion)
	QDEL_NULL(vote)
	return ..()

/datum/antagonist/unitologist/can_be_owned(datum/mind/new_owner)
	. = ..()
	if(. && !ignore_implant)
		. = is_convertable_to_cult(new_owner.current,cult_team)


/datum/antagonist/unitologist/greet()
	to_chat(owner, "<span class='userdanger'>You are a zealot of Unitology, one of firm belief in convergence and be made whole, willing to do anything in pursuit of your beliefs. It is your assignment to make the Crew see the light, and submit to convergence, one way or the other. You have been blessed with a psychic connection created by the <b>marker</b>, and must serve the marker's will at all costs by bringing it human sacrifices. Remember, its objectives come before your own...</span>")
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/bloodcult.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)//subject to change
	owner.announce_objectives()

/datum/antagonist/unitologist/create_objectives(var/datum/mind/marker_minion)
	.=..()
	if(!.)
		return
//	marker_minion.current?.psychosis_immune = TRUE //PENDING PSYCHOSIS MERGE.
	var/datum/objective/unitologist/unitologist_objective = new
	marker_minion.objectives += unitologist_objective
	GLOB.unitologists_list += marker_minion.current
	to_chat(marker_minion.current, "<span class='warning'>You can feel an alien presence altering your mind...</span>")
	addtimer(CALLBACK(src, .proc/give_collaborators, marker_minion.current), 2 SECONDS) //Let the other unitologists spawn before iterating through them.
	return

/datum/antagonist/unitologist/proc/give_collaborators(mob/living/our_owner)
	//our_owner.verbs |= /mob/proc/message_unitologists
	to_chat(our_owner, "<span class='warning'>The marker has established a psychic link between you and your fellow zealots.</span>")
	to_chat(our_owner, "<span class='warning'><i>Your mind is flooded with several names, these people must also share a connection to the marker...</i></span>")
	for(var/mob/living/minion in GLOB.unitologists_list)
		if(minion && minion != our_owner)
			to_chat(our_owner, "Fellow zealot: [minion.real_name]")
			our_owner.mind.store_memory("<b>Fellow zealot</b>: [minion.real_name]")


/datum/antagonist/unitologist/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current
	if(mob_override)
		current = mob_override
	add_antag_hud(antag_hud_type, antag_hud_name, current)
	handle_clown_mutation(current, mob_override ? null : "Your training has allowed you to overcome your clownish nature, allowing you to wield weapons without harming yourself.")
	current.faction |= "unitologist"
	current.grant_language(/datum/language/unitology, TRUE, TRUE, LANGUAGE_CULTIST)
	if(!cult_team.cult_master)
		vote.Grant(current)
	communion.Grant(current)
	if(ishuman(current))
		magic.Grant(current)
	current.throw_alert("bloodsense", /atom/movable/screen/alert/bloodsense)
	if(cult_team.cult_risen)
		cult_team.rise(current)
		if(cult_team.cult_ascendent)
			cult_team.ascend(current)

/datum/antagonist/unitologist/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current = owner.current
	if(mob_override)
		current = mob_override
	remove_antag_hud(antag_hud_type, current)
	handle_clown_mutation(current, removing = FALSE)
	current.faction -= "unitologist"
	current.remove_language(/datum/language/narsie, TRUE, TRUE, LANGUAGE_CULTIST)
	vote.Remove(current)
	communion.Remove(current)
	magic.Remove(current)
	current.clear_alert("bloodsense")
	if(ishuman(current))
		var/mob/living/carbon/human/H = current
		H.eye_color = initial(H.eye_color)
		H.dna.update_ui_block(DNA_EYE_COLOR_BLOCK)
		REMOVE_TRAIT(H, CULT_EYES, null)
		H.remove_overlay(HALO_LAYER)
		H.update_body()

/datum/antagonist/unitologist/on_removal()
	SSticker.mode.unitologist -= owner
	if(!silent)
		owner.current.visible_message("<span class='deconversion_message'>[owner.current] looks like [owner.current.p_theyve()] just reverted to [owner.current.p_their()] old faith!</span>", null, null, null, owner.current)
		to_chat(owner.current, "<span class='userdanger'>An unfamiliar white light flashes through your mind, cleansing the taint of the Geometer and all your memories as her servant.</span>")
		owner.current.log_message("has renounced the unitologist of Nar'Sie!", LOG_ATTACK, color="#960000")
	if(cult_team.blood_target && cult_team.blood_target_image && owner.current.client)
		owner.current.client.images -= cult_team.blood_target_image
	. = ..()

/datum/antagonist/unitologist/admin_add(datum/mind/new_owner,mob/admin)
	give_equipment = FALSE
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has unitologist-ed [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has unitologist-ed [key_name(new_owner)].")

/datum/antagonist/unitologist/admin_remove(mob/user)
	message_admins("[key_name_admin(user)] has decult-ed [key_name_admin(owner)].")
	log_admin("[key_name(user)] has decult-ed [key_name(owner)].")
	SSticker.mode.remove_cultist(owner,silent=TRUE) //disgusting

/datum/antagonist/unitologist/get_admin_commands()
	. = ..()
	.["Dagger"] = CALLBACK(src,.proc/admin_give_dagger)
	.["Dagger and Metal"] = CALLBACK(src,.proc/admin_give_metal)
	.["Remove Dagger and Metal"] = CALLBACK(src, .proc/admin_take_all)

/datum/antagonist/unitologist/proc/admin_give_dagger(mob/admin)
	if(!equip_cultist(metal=FALSE))
		to_chat(admin, "<span class='danger'>Spawning dagger failed!</span>")

/datum/antagonist/unitologist/proc/admin_give_metal(mob/admin)
	if (!equip_cultist(metal=TRUE))
		to_chat(admin, "<span class='danger'>Spawning runed metal failed!</span>")

/datum/antagonist/unitologist/proc/admin_take_all(mob/admin)
	var/mob/living/current = owner.current
	for(var/o in current.GetAllContents())
		if(istype(o, /obj/item/melee/cultblade/dagger) || istype(o, /obj/item/stack/sheet/runed_metal))
			qdel(o)



GLOBAL_DATUM_INIT(shardbearers, /datum/antagonist/unitologist/shardbearer, new)
/*
	The Shardbearer
*/
/datum/antagonist/unitologist/shardbearer
	name = "Unitologist Zealot Shardbearer"
	//role_text_plural = "Shardbearers"
	preference_candidacy_toggle = TRUE
	id = MODE_UNITOLOGIST_SHARD
	flags = 0
	initial_spawn_req = 1
	to_chat(owner, "<span class='userdanger'>You are a zealot of Unitology, one of firm belief in convergence and be made whole, willing to do anything in pursuit of your beliefs. It is your assignment to make the Crew see the light, and submit to convergence, one way or the other. You have been blessed with a psychic connection created by the <b>marker</b>, and must serve the marker's will at all costs by bringing it human sacrifices. Remember, its objectives come before your own...</span>")

/datum/antagonist/unitologist/shardbearer/equip(var/mob/living/carbon/human/H)
	.=..()
	H.equip_to_storage_or_drop(new /obj/item/marker_shard)




/datum/antagonist/unitologist/shardbearer/create_objectives(var/datum/mind/marker_minion)
	if(!..())
		return
	var/datum/objective/unitologist/shard/unitologist_objective = new
	marker_minion.objectives += unitologist_objective


/datum/objective/unitologist/shard
	to_chat(owner, "Plant the marker shard, and ensure it can safetly grow!</span>")
/*
/datum/codex_entry/concept/unitology
	display_name = "Unitology"
	category = CATEGORY_CONCEPTS
	associated_strings = list("zealot", "unitologist", "unitology")
	lore_text = "Unitology is one of the few remaining widespread religions. Unitology was founded in 2215 by Craig Markoff, who used Michael Altman as a stalking horse. Michael Altman, as a result, became the unwilling prophet and icon of Unitology, sparking the popular phrase: Praise Altman."
	mechanics_text = "Unitology within the confines of this server is separated in two entities: Believers and Fanatics. The differences being:<br>\
	* Believers are not permitted to engage in hostile acts off their own volition. Believers are more susceptible to Marker whispers and voices, though are not allowed to comply with kill or suicide orders.<br>\
	* Fanatics are permitted to engage in hostile acts off their own volition, as they are antagonists in our server. They may also answer the calls of the Marker for offerings, murder, sacrifices and even suicide.<br><br>\
	\
	Players who choose to be a Unitologist, or convert to Unitology mid-round are considered Believers, whereas those chosen to be an antagonist are considered Fanatics. Only by being randomly spawned or chosen as an antag, can you consider yourself a fanatic.<br>\
	For obvious reasons, we hold Unitology in high regard with respect to the rules. The creation of characters that are clinically insane, and use this as cover to murder while <b>choosing</b> to be a Unitologist, won't get away with that."
	antag_text = "As one of the ship's fanatic Unitologists, it is your job to spread the word, light and convergence at the Marker's behest. You are to listen and comply with orders coming from the Marker, and you may <b>opt to listen</b> to the whispers coming from Signals.<br>\
	As an antagonist, you may kill others or yourself in the name of the Marker, and provide offerings to them for good favor. If you play your cards right, you may be the only man or woman walking amongst corpses for a while.<br>\
	As an antagonist, you may NOT use the Supermatter or Atmospherics in a grief-like way to ensure mass-kills. You may not willingly disrupt the flow of air, or blow up the Supermatter. You <b>may sabotage the Supermatter</b> however, by ejecting it and cutting power."
*/
