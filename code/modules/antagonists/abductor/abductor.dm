/datum/antagonist/abductor
	name = "\improper Abductor"
	roundend_category = "abductors"
	antagpanel_category = ANTAG_GROUP_ABDUCTORS
	job_rank = ROLE_ABDUCTOR
	antag_hud_name = "abductor"
	show_in_antagpanel = FALSE //should only show subtypes
	show_to_ghosts = TRUE
	suicide_cry = "FOR THE MOTHERSHIP!!" // They can't even talk but y'know
	var/datum/team/abductor_team/team
	var/sub_role
	var/outfit
	var/landmark_type
	var/greet_text
	/// Type path for the associated job datum.
	var/role_job = /datum/job/abductor_agent

/datum/antagonist/abductor/New()
	// lets get the loading started now, but don't block waiting for it
	INVOKE_ASYNC(SSmapping, TYPE_PROC_REF(/datum/controller/subsystem/mapping, lazy_load_template), LAZY_TEMPLATE_KEY_ABDUCTOR_SHIPS)
	return ..()

/datum/antagonist/abductor/get_preview_icon()
	var/mob/living/carbon/human/dummy/consistent/scientist = new
	var/mob/living/carbon/human/dummy/consistent/agent = new

	scientist.set_species(/datum/species/abductor)
	agent.set_species(/datum/species/abductor)

	var/icon/scientist_icon = render_preview_outfit(/datum/outfit/abductor/scientist, scientist)
	scientist_icon.Shift(WEST, 8)

	var/icon/agent_icon = render_preview_outfit(/datum/outfit/abductor/agent, agent)
	agent_icon.Shift(EAST, 8)

	var/icon/final_icon = scientist_icon
	final_icon.Blend(agent_icon, ICON_OVERLAY)

	qdel(scientist)
	qdel(agent)

	return finish_preview_icon(final_icon)

/datum/antagonist/abductor/agent
	name = "\improper Abductor Agent"
	sub_role = "Agent"
	outfit = /datum/outfit/abductor/agent
	landmark_type = /obj/effect/landmark/abductor/agent
	greet_text = "Use your stealth technology and equipment to incapacitate humans for your scientist to retrieve."
	show_in_antagpanel = TRUE

/datum/antagonist/abductor/scientist
	name = "\improper Abductor Scientist"
	sub_role = "Scientist"
	outfit = /datum/outfit/abductor/scientist
	landmark_type = /obj/effect/landmark/abductor/scientist
	greet_text = "Use your experimental console and surgical equipment to monitor your agent and experiment upon abducted humans."
	show_in_antagpanel = TRUE
	role_job = /datum/job/abductor_scientist

/datum/antagonist/abductor/scientist/onemanteam
	name = "\improper Abductor Solo"
	outfit = /datum/outfit/abductor/scientist/onemanteam
	role_job = /datum/job/abductor_solo

/datum/antagonist/abductor/create_team(datum/team/abductor_team/new_team)
	if(!new_team)
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	team = new_team

/datum/antagonist/abductor/get_team()
	return team

/datum/antagonist/abductor/on_gain()
	owner.set_assigned_role(SSjob.GetJobType(role_job))
	owner.special_role = ROLE_ABDUCTOR
	objectives += team.objectives
	finalize_abductor()
	ADD_TRAIT(owner, TRAIT_ABDUCTOR_TRAINING, ABDUCTOR_ANTAGONIST)
	return ..()

/datum/antagonist/abductor/on_removal()
	owner.special_role = null
	REMOVE_TRAIT(owner, TRAIT_ABDUCTOR_TRAINING, ABDUCTOR_ANTAGONIST)
	return ..()

/datum/antagonist/abductor/greet()
	. = ..()
	to_chat(owner.current, span_notice("With the help of your teammate, kidnap and experiment on station crew members!"))
	to_chat(owner.current, span_notice("[greet_text]"))
	owner.announce_objectives()

/datum/antagonist/abductor/proc/finalize_abductor()
	//Equip
	var/mob/living/carbon/human/H = owner.current
	H.set_species(/datum/species/abductor)
	var/obj/item/organ/internal/tongue/abductor/T = H.get_organ_slot(ORGAN_SLOT_TONGUE)
	T.mothership = "[team.name]"

	H.real_name = "[team.name] [sub_role]"
	H.equipOutfit(outfit)

	// We require that the template be loaded here, so call it in a blocking manner, if its already done loading, this won't block
	SSmapping.lazy_load_template(LAZY_TEMPLATE_KEY_ABDUCTOR_SHIPS)
	//Teleport to ship
	for(var/obj/effect/landmark/abductor/LM in GLOB.landmarks_list)
		if(istype(LM, landmark_type) && LM.team_number == team.team_number)
			H.forceMove(LM.loc)
			break

/datum/antagonist/abductor/scientist/on_gain()
	owner.add_traits(list(TRAIT_ABDUCTOR_SCIENTIST_TRAINING, TRAIT_SURGEON), ABDUCTOR_ANTAGONIST)
	return ..()

/datum/antagonist/abductor/scientist/on_removal()
	owner.remove_traits(list(TRAIT_ABDUCTOR_SCIENTIST_TRAINING, TRAIT_SURGEON), ABDUCTOR_ANTAGONIST)
	return ..()

/datum/antagonist/abductor/admin_add(datum/mind/new_owner,mob/admin)
	var/list/current_teams = list()
	for(var/datum/team/abductor_team/T in GLOB.antagonist_teams)
		current_teams[T.name] = T
	var/choice = input(admin,"Add to which team ?") as null|anything in (current_teams + "new team")
	if (choice == "new team")
		team = new
	else if(choice in current_teams)
		team = current_teams[choice]
	else
		return
	new_owner.add_antag_datum(src)
	log_admin("[key_name(usr)] made [key_name(new_owner)] [name] on [choice]!")
	message_admins("[key_name_admin(usr)] made [key_name_admin(new_owner)] [name] on [choice] !")

/datum/antagonist/abductor/get_admin_commands()
	. = ..()
	.["Equip"] = CALLBACK(src, PROC_REF(admin_equip))

/datum/antagonist/abductor/proc/admin_equip(mob/admin)
	if(!ishuman(owner.current))
		to_chat(admin, span_warning("This only works on humans!"))
		return
	var/mob/living/carbon/human/H = owner.current
	var/gear = tgui_alert(admin,"Agent or Scientist Gear", "Gear", list("Agent", "Scientist"))
	if(gear)
		if(gear == "Agent")
			H.equipOutfit(/datum/outfit/abductor/agent)
		else
			H.equipOutfit(/datum/outfit/abductor/scientist)

/datum/team/abductor_team
	member_name = "\improper Abductor"
	var/team_number
	var/static/team_count = 1
	///List of all brainwashed victims' minds
	var/list/datum/mind/abductees = list()

/datum/team/abductor_team/New()
	..()
	team_number = team_count++
	name = "Mothership [pick(GLOB.greek_letters)]" //TODO Ensure unique and actual alieny names
	//add_objective(new /datum/objective/experiment) //SKYRAT EDIT REMOVAL

/datum/team/abductor_team/roundend_report()
	var/list/result = list()

	var/won = TRUE
	for(var/datum/objective/O in objectives)
		if(!O.check_completion())
			won = FALSE
	if(won)
		result += "<span class='greentext big'>[name] team fulfilled its mission!</span>"
	else
		result += "<span class='redtext big'>[name] team failed its mission.</span>"

	result += "<span class='header'>The abductors of [name] were:</span>"
	for(var/datum/mind/abductor_mind in members)
		result += printplayer(abductor_mind)
	result += printobjectives(objectives)

	return "<div class='panel redborder'>[result.Join("<br>")]</div>"

// LANDMARKS
/obj/effect/landmark/abductor
	var/team_number = 1

/obj/effect/landmark/abductor/agent
	icon_state = "abductor_agent"
/obj/effect/landmark/abductor/scientist
	icon_state = "abductor"

// OBJECTIVES
/datum/objective/experiment
	target_amount = 6

/datum/objective/experiment/New()
	explanation_text = "Experiment on [target_amount] humans."

/datum/objective/experiment/check_completion()
	for(var/obj/machinery/abductor/experiment/E as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/abductor/experiment))
		if(!istype(team, /datum/team/abductor_team))
			return FALSE
		var/datum/team/abductor_team/T = team
		if(E.team_number == T.team_number)
			return E.points >= target_amount
	return FALSE
