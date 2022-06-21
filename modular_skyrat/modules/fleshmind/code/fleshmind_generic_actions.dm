/datum/action/cooldown/fleshmind_create_structure
	name = "Create Structure"
	desc = "Creates a structure of your choice at your location(must be on wireweed)."
	icon_icon = 'icons/obj/items_and_weapons.dmi'
	background_icon_state = "bg_fugu"
	button_icon_state = "toyhammer"
	cooldown_time = 2 MINUTES
	var/static/list/possible_structures = list(
		/obj/structure/fleshmind/structure/babbler,
		/obj/structure/fleshmind/structure/whisperer,
		/obj/structure/fleshmind/structure/modulator,
		/obj/structure/fleshmind/structure/screamer,
		/obj/structure/fleshmind/structure/turret,
		/obj/structure/fleshmind/structure/assembler,
	)

/datum/action/cooldown/fleshmind_create_structure/Activate(atom/target)
	. = ..()
	var/datum/component/human_corruption/our_component = owner.GetComponent(/datum/component/human_corruption)
	if(!our_component?.our_controller)
		return
	var/datum/fleshmind_controller/owner_controller = our_component.our_controller
	var/obj/structure/fleshmind/wireweed/under_wireweed = locate() in get_turf(owner)
	if(!under_wireweed)
		to_chat(owner, span_warning("There needs to be wireweed underneath you!"))
		return
	var/picked_stucture_type = tgui_input_list(owner, "Pick structure type!", "Structure Type", possible_structures)
	if(!picked_stucture_type)
		return
	if(QDELETED(owner_controller)) // Input is not async
		return
	owner_controller.spawn_structure(get_turf(owner), picked_stucture_type)
	StartCooldownSelf()

/datum/action/cooldown/fleshmind_flesh_call
	name = "Call Flesh Reinforcements"
	desc = "Gets all fleshmind mobs to come to your location in a radius."
	icon_icon = 'icons/obj/items_and_weapons.dmi'
	background_icon_state = "bg_fugu"
	button_icon_state = "latexballon_blow"
	cooldown_time = 2 MINUTES

/datum/action/cooldown/fleshmind_flesh_call/Activate(atom/target)
	. = ..()
	for(var/mob/living/simple_animal/hostile/iterating_mob in view(DEFAULT_VIEW_RANGE, owner))
		if(!faction_check(owner.faction, iterating_mob))
			continue
		iterating_mob.Goto(owner, MOB_RALLY_SPEED)
	owner.visible_message(span_warning("[owner] lets out a horrible screech!"), span_notice("You let out a calling screech!"))
	playsound(owner, 'modular_skyrat/modules/horrorform/sound/horror_scream.ogg', 100, TRUE)
	StartCooldownSelf()

/datum/action/innate/fleshmind_flesh_chat
	name = "Flesh Chat"
	desc = "Sends a message to all other sentient fleshmind beings."
	icon_icon = 'icons/mob/actions/actions_changeling.dmi'
	background_icon_state = "bg_fugu"
	button_icon_state = "hivemind_link"

/datum/action/innate/fleshmind_flesh_chat/Activate(atom/target)
	. = ..()
	var/message = tgui_input_text(owner, "Send a message to the fleshmind.", "Flesh Chat")
	if(!message)
		return
	for(var/mob/iterating_mob in GLOB.player_list)
		if(!(FACTION_FLESHMIND in iterating_mob.faction) && !isobserver(iterating_mob))
			continue
		to_chat(iterating_mob, span_purple("<b>FLESHMIND ([owner]):</b> [message]"))

/datum/action/cooldown/fleshmind_plant_weeds
	name = "Create Wireweed"
	desc = "Creates a single patch of wireweed at your location."
	icon_icon = 'icons/obj/items_and_weapons.dmi'
	background_icon_state = "bg_fugu"
	button_icon_state = "toyhammer"
	cooldown_time = 30 SECONDS

/datum/action/cooldown/fleshmind_create_structure/Activate(atom/target)
	. = ..()
	var/datum/component/human_corruption/our_component = owner.GetComponent(/datum/component/human_corruption)
	if(!our_component?.our_controller)
		return
	var/datum/fleshmind_controller/owner_controller = our_component.our_controller
	var/obj/structure/fleshmind/wireweed/under_wireweed = locate() in get_turf(owner)
	if(!under_wireweed)
		to_chat(owner, span_warning("There is already wireweed beneath you!"))
		return
	owner_controller.spawn_wireweed(get_turf(owner), /obj/structure/fleshmind/wireweed)
	to_chat(owner, span_green("Wireweed planted!"))
	StartCooldownSelf()
