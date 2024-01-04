/datum/action/cooldown/fleshmind_create_structure
	name = "Create Tech Structure"
	desc = "Creates a tech structure of your choice at your location(must be on wireweed)."
	background_icon_state = "bg_fugu"
	button_icon = 'icons/obj/scrolls.dmi'
	button_icon_state = "blueprints"
	cooldown_time = 2 MINUTES
	var/list/possible_structures = list(
		/obj/structure/fleshmind/structure/babbler,
		/obj/structure/fleshmind/structure/whisperer,
		/obj/structure/fleshmind/structure/modulator,
		/obj/structure/fleshmind/structure/screamer,
		/obj/structure/fleshmind/structure/turret,
	)

/datum/action/cooldown/fleshmind_create_structure/Activate(atom/target)
	var/datum/component/human_corruption/our_component = owner.GetComponent(/datum/component/human_corruption)
	if(!our_component?.our_controller)
		to_chat(owner, span_warning("There is no hive link to tunnel this power through!"))
		return
	var/datum/fleshmind_controller/owner_controller = our_component.our_controller

	var/list/built_radial_menu = list()
	for(var/obj/iterating_type as anything in possible_structures)
		built_radial_menu[iterating_type] = image(icon = initial(iterating_type.icon), icon_state = initial(iterating_type.icon_state))
	var/obj/structure/fleshmind/structure/picked_stucture_type = show_radial_menu(owner, owner, built_radial_menu, radius = 40)
	if(!picked_stucture_type)
		return
	var/obj/structure/fleshmind/wireweed/under_wireweed = locate() in get_turf(owner)
	if(!under_wireweed)
		to_chat(owner, span_warning("There needs to be wireweed underneath you!"))
		return
	if(QDELETED(owner_controller)) // Input is not async
		return
	if(initial(picked_stucture_type.required_controller_level) > owner_controller.level)
		to_chat(owner, span_warning("Our processor core is not strong enough yet!"))
		return
	owner_controller.spawn_structure(get_turf(owner), picked_stucture_type)
	StartCooldownSelf()

/datum/action/cooldown/fleshmind_create_structure/basic
	name = "Create Basic Structure"
	desc = "Creates a basic structure of your choice at your location(must be on wireweed)."
	button_icon_state = "mjollnir1"
	button_icon = 'icons/obj/weapons/hammer.dmi'
	possible_structures = list(
		/obj/structure/fleshmind/structure/wireweed_door,
		/obj/structure/fleshmind/structure/wireweed_wall,
	)
	cooldown_time = 5 SECONDS

/datum/action/cooldown/fleshmind_flesh_call
	name = "Call Flesh Reinforcements"
	desc = "Gets all fleshmind mobs to come to your location in a radius."
	background_icon_state = "bg_fugu"
	button_icon = 'icons/obj/signs.dmi'
	button_icon_state = "bio"
	cooldown_time = 2 MINUTES

/datum/action/cooldown/fleshmind_flesh_call/Activate(atom/target)
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
	background_icon_state = "bg_fugu"
	button_icon = 'icons/mob/actions/actions_changeling.dmi'
	button_icon_state = "hivemind_link"

/datum/action/innate/fleshmind_flesh_chat/Activate(atom/target)
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
	button_icon = 'modular_skyrat/modules/fleshmind/icons/fleshmind_structures.dmi'
	background_icon_state = "bg_fugu"
	button_icon_state = "wires-0"
	cooldown_time = 10 SECONDS

/datum/action/cooldown/fleshmind_plant_weeds/Activate(atom/target)
	var/datum/component/human_corruption/our_component = owner.GetComponent(/datum/component/human_corruption)
	if(!our_component?.our_controller)
		to_chat(owner, span_warning("There is no hive link to tunnel this power through!"))
		return
	var/datum/fleshmind_controller/owner_controller = our_component.our_controller
	var/obj/structure/fleshmind/wireweed/under_wireweed = locate() in get_turf(owner)
	if(under_wireweed)
		to_chat(owner, span_warning("There is already wireweed beneath you!"))
		return
	owner_controller.spawn_wireweed(get_turf(owner), /obj/structure/fleshmind/wireweed)
	to_chat(owner, span_green("Wireweed planted!"))
	StartCooldownSelf()


/datum/action/fleshmind/weapon
	name = "Deploy Weapon"
	desc = "Deploy a powerful weapon from your body, a mechanical armblade."
	/// The weapon we deploy upon clicking.
	var/weapon_type = /obj/item/melee/arm_blade/fleshmind


/datum/action/fleshmind/weapon/Grant(mob/granted_to)
	. = ..()
	if (!owner)
		return
	if(!iscarbon(granted_to))
		return
	RegisterSignal(granted_to, COMSIG_HUMAN_MONKEYIZE, PROC_REF(became_monkey))

/datum/action/fleshmind/weapon/Remove(mob/remove_from)
	UnregisterSignal(remove_from, COMSIG_HUMAN_MONKEYIZE)
	unequip_held(remove_from)
	return ..()

/// Remove weapons if we become a monkey
/datum/action/fleshmind/weapon/proc/became_monkey(mob/source)
	SIGNAL_HANDLER
	unequip_held(source)

/// Removes weapon if it exists, returns true if we removed something
/datum/action/fleshmind/weapon/proc/unequip_held(mob/user)
	var/found_weapon = FALSE
	for(var/obj/item/held in user.held_items)
		found_weapon = check_weapon(user, held) || found_weapon
	return found_weapon

/datum/action/fleshmind/weapon/proc/check_weapon(mob/user, obj/item/hand_item)
	if(istype(hand_item, weapon_type))
		user.temporarilyRemoveItemFromInventory(hand_item, TRUE) //DROPDEL will delete the item
		playsound(user, 'sound/effects/blobattack.ogg', 30, TRUE)
		user.visible_message(span_warning("With a sickening crunch, [user] reforms [user.p_their()] [hand_item.name] into an arm!"), span_notice("We assimilate the [hand_item.name] back into our body."), "<span class='italics>You hear organic matter ripping and tearing!</span>")
		user.update_held_items()
		return TRUE

/datum/action/fleshmind/weapon/Trigger(trigger_flags)
	. = ..()
	var/mob/living/carbon/user = owner
	var/obj/item/held = user.get_active_held_item()
	if(held && !user.dropItemToGround(held))
		user.balloon_alert(user, "hand occupied!")
		return FALSE
	var/limb_regen = 0
	if(user.active_hand_index % 2 == 0) //we regen the arm before changing it into the weapon
		limb_regen = user.regenerate_limb(BODY_ZONE_R_ARM, 1)
	else
		limb_regen = user.regenerate_limb(BODY_ZONE_L_ARM, 1)
	if(limb_regen)
		user.visible_message(span_warning("[user]'s missing arm reforms, making a loud, grotesque sound!"), span_userdanger("Your arm regrows, making a loud, crunchy sound and giving you great pain!"), span_hear("You hear organic matter ripping and tearing!"))
		user.emote("scream")
	var/obj/item/new_weapon_type = new weapon_type(user)
	user.put_in_hands(new_weapon_type)
	playsound(user, 'sound/effects/blobattack.ogg', 30, TRUE)
	return new_weapon_type

/obj/item/melee/arm_blade/fleshmind
	name = "mchanical armblade"
	desc = "A sharp and deadly blade, made of metal and flesh. Slash them dead."
