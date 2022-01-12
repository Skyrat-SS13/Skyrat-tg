#define ONLY_DEPLOY 1
#define ONLY_RETRACT 2
#define SEAL_DELAY 30

/*
 * Defines the behavior of RIGs
 */

/obj/item/weapon/rig

	name = "RIG control module"
	icon = 'icons/obj/rig_frames.dmi'
	desc = "A back-mounted RIG deployment and control mechanism."
	slot_flags = SLOT_BACK
	var/desired_slot = slot_back
	req_one_access = list()
	req_access = list()
	w_class = ITEM_SIZE_HUGE
	center_of_mass = null

	// These values are passed on to all component pieces.
	armor = list(melee = 40, bullet = 5, laser = 20,energy = 5, bomb = 35, bio = 100, rad = 20)
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	max_heat_protection_temperature = SPACE_SUIT_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.2
	permeability_coefficient = 0.0
	var/permeability_threshold = 0.7
	unacidable = FALSE
	acid_resistance = 2
	acid_melted = -1 //Prevents it from being turned into a melted object

	max_health = 2500	//These are tough since they tank hits for the whole thing

	var/equipment_overlay_icon = 'icons/mob/onmob/rig_modules.dmi'
	var/hides_uniform = 1 	//used to determinate if uniform should be visible whenever the suit is sealed or not

	var/interface_path = "RIGSuit"
	var/ai_interface_path = "RIGSuit"
	var/interface_title = "RIG Controller"
	var/wearer_move_delay //Used for AI moving.
	var/ai_controlled_move_delay = 10

	// Keeps track of what this rig should spawn with.
	var/suit_type = "RIG"
	var/list/initial_modules = list(/obj/item/rig_module/healthbar,
	/obj/item/rig_module/storage)
	var/chest_type = /obj/item/clothing/suit/space/rig
	var/helm_type =  /obj/item/clothing/head/helmet/space/rig
	var/boot_type =  /obj/item/clothing/shoes/magboots/rig
	var/glove_type = /obj/item/clothing/gloves/rig
	var/cell_type =  /obj/item/weapon/cell/high
	var/air_type =   /obj/item/weapon/tank/oxygen
	var/list/toggleable_while_active = list("helmet", "gauntlets")

	//Component/device holders.
	var/obj/item/weapon/tank/air_supply                       // Air tank, if any.
	var/obj/item/clothing/shoes/boots = null                  // Deployable boots, if any.
	var/obj/item/clothing/suit/space/rig/chest                // Deployable chestpiece, if any.
	var/obj/item/clothing/head/helmet/space/rig/helmet = null // Deployable helmet, if any.
	var/obj/item/clothing/gloves/rig/gloves = null            // Deployable gauntlets, if any.
	var/obj/item/weapon/cell/cell                             // Power supply, if any.
	var/obj/item/rig_module/selected_module = null            // Primary system (used with middle-click)
	var/obj/item/rig_module/vision/visor                      // Kinda shitty to have a var for a module, but saves time.
	var/obj/item/rig_module/voice/speech                      // As above.
	var/obj/item/rig_module/storage/storage					  // Internal storage, can only have one
	var/obj/item/rig_module/healthbar/healthbar				  // Healthbar
	var/mob/living/carbon/human/wearer                        // The person currently wearing the rig.
	var/image/mob_icon                                        // Holder for on-mob icon.
	var/list/installed_modules = list()                       // List of all modules, including those initialized at startup
	var/list/processing_modules = list()					  // Power consumption/use bookkeeping.

	// Rig status vars.
	var/open = 0                                              // Access panel status.
	var/locked = 1                                            // Lock status.
	var/subverted = 0
	var/interface_locked = 0
	var/control_overridden = 0
	var/ai_override_enabled = 0
	var/security_check_enabled = 1
	var/malfunctioning = 0
	var/malfunction_delay = 0
	var/electrified = 0
	var/locked_down = 0
	var/aimove_power_usage = 200							  // Power usage per tile traveled when suit is moved by AI in IIS. In joules.
	var/hotswap = FALSE	//If true, modules can be added/removed while the rig is worn
	var/active	=	FALSE	//Set true when sealed and toggled

	var/seal_delay = SEAL_DELAY
	var/sealing                                               // Keeps track of seal status independantly of canremove.
	var/offline = 1                                           // Should we be applying suit maluses?
	var/online_slowdown = RIG_MEDIUM                                  // If the suit is deployed and powered, it sets slowdown to this.
	var/offline_slowdown = 4                                  // If the suit is deployed and unpowered, it sets slowdown to this.
	var/vision_restriction = TINT_NONE
	var/offline_vision_restriction = TINT_HEAVY               // tint value given to helmet
	var/airtight = 1 //If set, will adjust ITEM_FLAG_AIRTIGHT and ITEM_FLAG_STOPPRESSUREDAMAGE flags on components. Otherwise it should leave them untouched.

	var/emp_protection = 0

	// Wiring! How exciting.
	var/datum/wires/rig/wires
	var/datum/effect/effect/system/spark_spread/spark_system

	var/rig_verbs = list(/obj/item/weapon/rig/verb/RIG_interface, /obj/item/weapon/rig/verb/deploy_suit,
						/obj/item/weapon/rig/verb/toggle_vision, /obj/item/weapon/rig/verb/toggle_seals_verb,
						/obj/item/weapon/rig/verb/switch_vision_mode, /obj/item/weapon/rig/verb/alter_voice,
						/obj/item/weapon/rig/verb/select_module, /obj/item/weapon/rig/verb/toggle_module,
						/obj/item/weapon/rig/verb/engage_module)

/obj/item/weapon/rig/examine()
	. = ..()
	if(wearer)
		for(var/obj/item/piece in list(helmet,gloves,chest,boots))
			if(!piece || piece.loc != wearer)
				continue
			to_chat(usr, "[icon2html(piece)] \The [piece] [piece.gender == PLURAL ? "are" : "is"] deployed.")

	if(src.loc == usr)
		to_chat(usr, "The access panel is [locked? "locked" : "unlocked"].")
		to_chat(usr, "The maintenance panel is [open ? "open" : "closed"].")
		to_chat(usr, "RIG systems are [offline ? "<font color='red'>offline</font>" : "<font color='green'>online</font>"].")

		if(open)
			to_chat(usr, "It's equipped with [english_list(installed_modules)].")

/obj/item/weapon/rig/New(var/location, var/dummy)
	src.dummy = dummy
	.=..()

/obj/item/weapon/rig/Initialize()
	. = ..()

	item_state = icon_state
	wires = new(src)

	if((!req_access || !req_access.len) && (!req_one_access || !req_one_access.len))
		locked = 0

	spark_system = new()
	spark_system.set_up(5, 0, src)
	spark_system.attach(src)
	if (!dummy)
		START_PROCESSING(SSobj, src)

	if(initial_modules && initial_modules.len)
		for(var/path in initial_modules)
			var/obj/item/rig_module/module = new path(src)
			install(module)

	// Create and initialize our various segments.
	if(cell_type)
		cell = new cell_type(src)
	if(air_type)
		air_supply = new air_type(src)
	if(glove_type)
		gloves = new glove_type(src)
		gloves.rig = src
		verbs |= /obj/item/weapon/rig/proc/toggle_gauntlets
	if(helm_type)
		helmet = new helm_type(src)
		helmet.rig = src
		verbs |= /obj/item/weapon/rig/proc/toggle_helmet_verb
	if(boot_type)
		boots = new boot_type(src)
		boots.rig = src
		verbs |= /obj/item/weapon/rig/proc/toggle_boots
	if(chest_type)
		chest = new chest_type(src)
		chest.rig = src
		if(allowed)
			chest.allowed |= allowed
		verbs |= /obj/item/weapon/rig/proc/toggle_chest

	for(var/obj/item/clothing/piece in list(gloves,helmet,boots,chest))
		if(!istype(piece))
			continue
		piece.canremove = 0
		piece.SetName("[suit_type] [initial(piece.name)]")
		piece.desc = "It seems to be part of a [src.name]."
		piece.icon_state = "[initial(icon_state)]"
		piece.min_cold_protection_temperature = min_cold_protection_temperature
		piece.max_heat_protection_temperature = max_heat_protection_temperature
		if(piece.siemens_coefficient > siemens_coefficient) //So that insulated gloves keep their insulation.
			piece.siemens_coefficient = siemens_coefficient
		piece.permeability_coefficient = permeability_coefficient
		piece.permeability_threshold = permeability_threshold
		piece.unacidable = unacidable
		piece.acid_resistance = acid_resistance
		piece.acid_melted = acid_melted
		if(islist(armor)) piece.armor = armor.Copy()

	set_slowdown_and_vision(!offline)
	update_icon(1)

/obj/item/weapon/rig/Destroy()
	QDEL_NULL_LIST(installed_modules)
	QDEL_NULL_LIST(processing_modules)
	for(var/obj/item/piece in list(gloves,boots,helmet,chest))
		if (piece && isclothing(piece))
			var/obj/item/clothing/C = piece
			if (C.rig == src)
				C.rig = null
		qdel(piece)
	qdel(wires)
	wires = null
	qdel(spark_system)
	spark_system = null
	return ..()

/obj/item/weapon/rig/proc/get_pieces()
	.=list()
	if (helmet)
		.+=helmet
	if (chest)
		.+=chest
	if (gloves)
		.+=gloves
	if (boots)
		.+=boots

/obj/item/weapon/rig/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	if(icon_override)
		ret.icon = icon_override
	else if(slot == slot_back_str)
		ret.icon = mob_icon
	return ret

/obj/item/weapon/rig/proc/set_slowdown_and_vision(var/active)
	if(chest)
		chest.slowdown_per_slot[slot_wear_suit] = (active? online_slowdown : offline_slowdown)
	if(helmet)
		helmet.tint = (active? vision_restriction : offline_vision_restriction)
		helmet.update_vision()

	if (wearer)
		wearer.update_extension(/datum/extension/updating/encumbrance)

/obj/item/weapon/rig/proc/suit_is_deployed()
	if(!istype(wearer) || src.loc != wearer || wearer.back != src)
		return FALSE
	if(helm_type && !(helmet && wearer.head == helmet))
		return FALSE
	if(glove_type && !(gloves && wearer.gloves == gloves))
		return FALSE
	if(boot_type && !(boots && wearer.shoes == boots))
		return FALSE
	if(chest_type && !(chest && wearer.wear_suit == chest))
		return FALSE
	return TRUE

/obj/item/weapon/rig/proc/reset()
	canremove = 1
	if(istype(chest))
		chest.check_limb_support(wearer)
	for(var/obj/item/piece in list(helmet,boots,gloves,chest))
		if(!piece) continue
		piece.icon_state = "[initial(icon_state)]"
		if(airtight)
			piece.item_flags &= ~(ITEM_FLAG_STOPPRESSUREDAMAGE|ITEM_FLAG_AIRTIGHT)
	update_icon(1)

/obj/item/weapon/rig/proc/toggle_seals(var/mob/initiator,var/instant)

	if(sealing) return

	// Seal toggling can be initiated by the suit AI, too
	if(!wearer)
		to_chat(initiator, "<span class='danger'>Cannot toggle suit: The suit is currently not being worn by anyone.</span>")
		return FALSE


	deploy(wearer,instant)

	var/seal_target = canremove

	if(seal_target && !check_power_cost(wearer, 1))
		return FALSE


	var/failed_to_seal

	canremove = 0 // No removing the suit while unsealing.
	sealing = 1


	var/time_taken = (instant ? 0 : seal_delay)
	if (!seal_target)
		//When unsealing, the time taken is halved
		time_taken *= 0.5

	if(seal_target && !suit_is_deployed())
		wearer.visible_message("<span class='danger'>[wearer]'s suit flashes an error light.</span>","<span class='danger'>Your suit flashes an error light. It can't function properly without being fully deployed.</span>")
		failed_to_seal = 1

	if(!failed_to_seal)
		wearer.visible_message("<font color='blue'>[wearer]'s suit emits a quiet hum as it begins to adjust its seals.</font>","<font color='blue'>With a quiet hum, the suit begins running checks and adjusting components.</font>")
		if(time_taken && !do_after(wearer,time_taken, src, incapacitation_flags = INCAPACITATION_NONE))
			if(wearer) to_chat(wearer, "<span class='warning'>You must remain still while the suit is adjusting the components.</span>")
			failed_to_seal = 1

		if(!wearer)
			failed_to_seal = 1
		else
			for(var/list/piece_data in list(list(wearer.shoes,boots,"boots",boot_type),list(wearer.gloves,gloves,"gloves",glove_type),list(wearer.head,helmet,"helmet",helm_type),list(wearer.wear_suit,chest,"chest",chest_type)))

				var/obj/item/piece = piece_data[1]
				var/obj/item/compare_piece = piece_data[2]
				var/msg_type = piece_data[3]
				var/piece_type = piece_data[4]

				if(!piece || !piece_type)
					continue

				if(!istype(wearer) || !istype(piece) || !istype(compare_piece) || !msg_type)
					if(wearer) to_chat(wearer, "<span class='warning'>You must remain still while the suit is adjusting the components.</span>")
					failed_to_seal = 1
					break

				if(!failed_to_seal && wearer.wearing_rig == src && piece == compare_piece)

					if(time_taken && !do_after(wearer,time_taken, src, incapacitation_flags = INCAPACITATION_NONE))
						failed_to_seal = 1

					piece.icon_state = "[initial(icon_state)][seal_target ? "_sealed" : ""]"
					switch(msg_type)
						if("boots")
							to_chat(wearer, "<font color='blue'>\The [piece] [seal_target ? "seal around your feet" : "relax their grip on your legs"].</font>")
							wearer.update_inv_shoes()
						if("gloves")
							to_chat(wearer, "<font color='blue'>\The [piece] [seal_target ? "tighten around your fingers and wrists" : "become loose around your fingers"].</font>")
							wearer.update_inv_gloves()
						if("chest")
							to_chat(wearer, "<font color='blue'>\The [piece] [seal_target ? "cinches tight again your chest" : "releases your chest"].</font>")
							wearer.update_inv_wear_suit()
						if("helmet")
							to_chat(wearer, "<font color='blue'>\The [piece] hisses [seal_target ? "closed" : "open"].</font>")
							wearer.update_inv_head()
							if(helmet)
								helmet.update_light(wearer)

					//sealed pieces become airtight, protecting against diseases
					if (seal_target)
						piece.armor["bio"] = 100
					else
						piece.armor["bio"] = src.armor["bio"]

				else
					failed_to_seal = 1

		if(!istype(wearer) || wearer.wearing_rig != src || (seal_target && !suit_is_deployed()))
			failed_to_seal = 1

	sealing = FALSE

	if(failed_to_seal)
		for(var/obj/item/piece in list(helmet,boots,gloves,chest))
			if(!piece) continue
			piece.icon_state = "[initial(icon_state)][seal_target ? "" : "_sealed"]"
		canremove = seal_target
		if(airtight)
			update_component_sealed()
		update_icon(1)
		return FALSE

	// Success!
	canremove = !seal_target
	active = seal_target
	to_chat(wearer, "<font color='blue'><b>Your entire suit [canremove ? "loosens as the components relax" : "tightens around you as the components lock into place"].</b></font>")

	if(wearer != initiator)
		to_chat(initiator, "<font color='blue'>Suit adjustment complete. Suit is now [canremove ? "unsealed" : "sealed"].</font>")

	if(!active)
		for(var/obj/item/rig_module/module in installed_modules)
			module.deactivate()
	if(airtight)
		update_component_sealed()
	update_icon(1)

/obj/item/weapon/rig/proc/update_component_sealed()
	for(var/obj/item/piece in list(helmet,boots,gloves,chest))
		if(canremove)
			piece.item_flags &= ~(ITEM_FLAG_STOPPRESSUREDAMAGE|ITEM_FLAG_AIRTIGHT)
		else
			piece.item_flags |=  (ITEM_FLAG_STOPPRESSUREDAMAGE|ITEM_FLAG_AIRTIGHT)
	if (hides_uniform && chest)
		if(canremove)
			chest.flags_inv &= ~(HIDEJUMPSUIT)
		else
			chest.flags_inv |= HIDEJUMPSUIT
	if (helmet)
		if (canremove)
			helmet.flags_inv &= ~(HIDEMASK)
		else
			helmet.flags_inv |= HIDEMASK
	update_icon(1)

/obj/item/weapon/rig/Process()

	// If we've lost any parts, grab them back.
	var/mob/living/M
	for(var/obj/item/piece in list(gloves,boots,helmet,chest))
		if(piece.loc != src && !(wearer && piece.loc == wearer))
			if(istype(piece.loc, /mob/living))
				M = piece.loc
				M.drop_from_inventory(piece)
			piece.forceMove(src)

	var/changed = update_offline()
	if(changed)
		if(offline)
			//notify the wearer
			if(!canremove)
				if (offline_slowdown < 3)
					to_chat(wearer, "<span class='danger'>Your suit beeps stridently, and suddenly goes dead.</span>")
				else
					to_chat(wearer, "<span class='danger'>Your suit beeps stridently, and suddenly you're wearing a leaden mass of metal and plastic composites instead of a powered suit.</span>")

			if (helmet && helmet.loc == wearer)
				if(offline_vision_restriction >= TINT_MODERATE)
					to_chat(wearer, "<span class='danger'>The suit optics flicker and die, leaving you with restricted vision.</span>")
				else if(offline_vision_restriction >= TINT_BLIND)
					to_chat(wearer, "<span class='danger'>The suit optics drop out completely, drowning you in darkness.</span>")

			if(electrified > 0)
				electrified = 0
			for(var/obj/item/rig_module/module in installed_modules)
				module.deactivate()


		set_slowdown_and_vision(!offline)
		if(istype(chest))
			chest.check_limb_support(wearer)

	if(!offline)
		if(cell && cell.charge > 0 && electrified > 0)
			electrified--

		if(malfunction_delay > 0)
			malfunction_delay--
		else if(malfunctioning)
			malfunctioning--
			malfunction()

		for(var/obj/item/rig_module/module in processing_modules)
			var/cost = module.Process()
			if(!cell.use(cost * CELLRATE) && module.active && cost)
				module.deactivate()

//offline should not change outside this proc
/obj/item/weapon/rig/proc/update_offline()
	var/go_offline = (!istype(wearer) || loc != wearer || wearer.back != src || canremove || sealing || !cell || cell.charge <= 0)
	if(offline != go_offline)
		offline = go_offline
		update_wear_icon()
		return TRUE
	return FALSE

/obj/item/weapon/rig/proc/check_power_cost(var/mob/living/user, var/cost, var/active_cost, var/use_unconcious, var/obj/item/rig_module/mod, var/user_is_ai)

	if(!istype(user))
		return FALSE

	var/fail_msg

	if(!user_is_ai)
		var/mob/living/carbon/human/H = user
		if(istype(H) && H.back != src)
			fail_msg = "<span class='warning'>You must be wearing \the [src] to do this.</span>"
	if(sealing)
		fail_msg = "<span class='warning'>The RIG is in the process of adjusting seals and cannot be activated.</span>"
	else if(!fail_msg && ((use_unconcious && user.stat > 1) || (!use_unconcious && user.stat)))
		fail_msg = "<span class='warning'>You are in no fit state to do that.</span>"
	else if(!cell)
		fail_msg = "<span class='warning'>There is no cell installed in the suit.</span>"
	else if(cost && !cell.check_charge(cost * CELLRATE) || active_cost && !cell.check_charge(active_cost * CELLRATE))
		fail_msg = "<span class='warning'>Not enough stored power.</span>"

	if(fail_msg)
		to_chat(user, "[fail_msg]")
		return FALSE

	// This is largely for cancelling stealth and whatever.
	if(mod && mod.disruptive)
		for(var/obj/item/rig_module/module in (installed_modules - mod))
			if(module.active && module.disruptable)
				module.deactivate()

	return TRUE

/obj/item/weapon/rig/update_icon(var/update_mob_icon)

	//TODO: Maybe consider a cache for this (use mob_icon as blank canvas, use suit icon overlay).
	overlays.Cut()
	if(!mob_icon || update_mob_icon)
		var/species_icon = 'icons/mob/onmob/rig_back.dmi'
		// Since setting mob_icon will override the species checks in
		// update_inv_wear_suit(), handle species checks here.
		if(wearer && sprite_sheets && sprite_sheets[wearer.species.get_bodytype(wearer)])
			species_icon =  sprite_sheets[wearer.species.get_bodytype(wearer)]
		mob_icon = image("icon" = species_icon, "icon_state" = "[icon_state]")


	if(wearer)
		if(equipment_overlay_icon && LAZYLEN(installed_modules))
			for(var/obj/item/rig_module/module in installed_modules)
				if(module.suit_overlay)
					var/image/overlay = image("icon" = equipment_overlay_icon, "icon_state" = "[module.suit_overlay]", "dir" = SOUTH, layer = module.suit_overlay_layer)
					overlay.plane = module.suit_overlay_plane
					overlay.appearance_flags = module.suit_overlay_flags
					if (chest)
						//Some rigs dont have a chestpiece
						chest.overlays += overlay
					else
						src.overlays += overlay
		wearer.update_inv_shoes()
		wearer.update_inv_gloves()
		wearer.update_inv_head()
		wearer.update_inv_wear_mask()
		wearer.update_inv_wear_suit()
		wearer.update_inv_w_uniform()
		wearer.update_inv_back()
	return

/obj/item/weapon/rig/get_mob_overlay(mob/user_mob, slot)
	var/image/ret = ..()
	if(is_held() || offline)
		return ret

	if(equipment_overlay_icon && LAZYLEN(installed_modules))
		for(var/obj/item/rig_module/module in installed_modules)
			if(module.suit_overlay)
				var/image/overlay = image("icon" = equipment_overlay_icon, "icon_state" = "[module.suit_overlay]", layer = module.suit_overlay_layer)
				overlay.plane = module.suit_overlay_plane
				overlay.appearance_flags = module.suit_overlay_flags
				ret.overlays += overlay
	return ret

/obj/item/weapon/rig/proc/check_suit_access(mob/living/carbon/human/user, do_message = TRUE)

	if(!security_check_enabled)
		return TRUE

	if(istype(user))
		if(!canremove)
			return TRUE
		if(malfunction_check(user))
			return FALSE
		if(user.back != src)
			return FALSE
		else if(!src.allowed(user))
			if(do_message)
				to_chat(user, "<span class='danger'>Unauthorized user. Access denied.</span>")
			return FALSE

	else if(!ai_override_enabled)
		if(do_message)
			to_chat(user, "<span class='danger'>Synthetic access disabled. Please consult hardware provider.</span>")
		return FALSE

	return TRUE

/obj/item/weapon/rig/proc/notify_ai(var/message)
	for(var/obj/item/rig_module/ai_container/module in installed_modules)
		if(module.integrated_ai && module.integrated_ai.client && !module.integrated_ai.stat)
			to_chat(module.integrated_ai, "[message]")
			. = 1

/obj/item/weapon/rig/equipped(mob/living/carbon/human/M, slot)
	.=..()
	if (!istype(M))
		return FALSE

	if (equip_slot == desired_slot)

		//This code is completely out of place and causes a myriad of problems, it is not worth the effort to solve it
		/*
		if(seal_delay > 0)
			M.visible_message("<font color='blue'>[M] starts putting on \the [src]...</font>", "<font color='blue'>You start putting on \the [src]...</font>")
			if(!do_after(M,seal_delay,src))
				if(M && M.back == src)
					if(!M.unEquip(src))
						return FALSE
				src.forceMove(get_turf(src))
				return FALSE
		*/

		if(istype(M) && equip_slot == desired_slot)
			M.visible_message("<font color='blue'><b>[M] struggles into \the [src].</b></font>", "<font color='blue'><b>You struggle into \the [src].</b></font>")

			wearer = M
			wearer.wearing_rig = src
			add_verb(M, rig_verbs)
			update_icon()

		for(var/obj/item/rig_module/module in installed_modules)
			module.rig_equipped(M, slot)
	else
		if (M.wearing_rig == src)
			M.wearing_rig = null
		wearer = null

		for(var/obj/item/rig_module/module in installed_modules)
			module.rig_unequipped(M, slot)

/obj/item/weapon/rig/proc/toggle_piece(var/piece, var/mob/initiator, var/deploy_mode)

	if(sealing || !cell || !cell.charge)
		return

	if(!istype(wearer) || wearer.wearing_rig != src)
		return

	if(initiator == wearer && wearer.incapacitated(INCAPACITATION_KNOCKOUT)) // If the initiator isn't wearing the suit it's probably an AI.
		return

	if (active && !(piece in toggleable_while_active))
		to_chat(initiator, SPAN_DANGER("The [piece] cannot be toggled while the RIG is active, it must be unsealed and powered down."))
		return

	var/obj/item/check_slot
	var/equip_to
	var/obj/item/use_obj

	if(!wearer)
		return

	switch(piece)
		if("helmet")
			equip_to = slot_head
			use_obj = helmet
			check_slot = wearer.head
		if("gauntlets")
			equip_to = slot_gloves
			use_obj = gloves
			check_slot = wearer.gloves
		if("boots")
			equip_to = slot_shoes
			use_obj = boots
			check_slot = wearer.shoes
		if("chest")
			equip_to = slot_wear_suit
			use_obj = chest
			check_slot = wearer.wear_suit

	if(use_obj)
		if(check_slot == use_obj && deploy_mode != ONLY_DEPLOY)

			var/mob/living/carbon/human/holder

			if(use_obj)
				holder = use_obj.loc
				if(istype(holder))
					if(use_obj && check_slot == use_obj)
						to_chat(wearer, "<font color='blue'><b>Your [use_obj.name] [use_obj.gender == PLURAL ? "retract" : "retracts"] swiftly.</b></font>")
						use_obj.canremove = 1
						holder.drop_from_inventory(use_obj, src)
						use_obj.canremove = 0

		else if (deploy_mode != ONLY_RETRACT)
			if(check_slot && check_slot == use_obj)
				return
			use_obj.forceMove(wearer)
			if(!wearer.equip_to_slot_if_possible(use_obj, equip_to, 0, 1))
				use_obj.forceMove(src)
				if(check_slot)
					to_chat(initiator, "<span class='danger'>You are unable to deploy \the [piece] as \the [check_slot] [check_slot.gender == PLURAL ? "are" : "is"] in the way.</span>")
					return
			else
				to_chat(wearer, "<span class='notice'>Your [use_obj.name] [use_obj.gender == PLURAL ? "deploy" : "deploys"] swiftly.</span>")

	if(piece == "helmet" && helmet)
		helmet.update_light(wearer)

/obj/item/weapon/rig/proc/deploy(mob/M,var/sealed)

	var/mob/living/carbon/human/H = M

	if(!H || !istype(H)) return

	if(H.back != src)
		return

	//Future todo: Make these pieces move inside the rig instead of being deleted

	if(sealed)
		if(helm_type && H.head && istype(H.head, helm_type))
			var/obj/item/garbage = H.head
			H.head = null
			qdel(garbage)

		if(glove_type && H.gloves && istype(H.gloves, glove_type))
			var/obj/item/garbage = H.gloves
			H.gloves = null
			qdel(garbage)

		if(boot_type && H.shoes && istype(H.shoes, boot_type))
			var/obj/item/garbage = H.shoes
			H.shoes = null
			qdel(garbage)

		if(chest_type && H.wear_suit && istype(H.wear_suit, chest_type))
			var/obj/item/garbage = H.wear_suit
			H.wear_suit = null
			qdel(garbage)

	for(var/piece in list("helmet","gauntlets","chest","boots"))
		toggle_piece(piece, H, ONLY_DEPLOY)

/obj/item/weapon/rig/proc/retract()
	var/mob/living/carbon/human/H = loc

	if(!H || !istype(H)) return

	if(H.wearing_rig != src)
		return
	for(var/piece in list("helmet","gauntlets","chest","boots"))
		toggle_piece(piece, null, ONLY_RETRACT)

/obj/item/weapon/rig/dropped(mob/user)
	..()
	for(var/piece in list("helmet","gauntlets","chest","boots"))
		toggle_piece(piece, user, ONLY_RETRACT)
	if(wearer)
		wearer.wearing_rig = null
		wearer = null
		remove_verb(user, rig_verbs)

//Todo
/obj/item/weapon/rig/proc/malfunction()
	return FALSE

/obj/item/weapon/rig/emp_act(severity_class)
	//set malfunctioning
	if(emp_protection < 30) //for ninjas, really.
		malfunctioning += 10
		if(malfunction_delay <= 0)
			malfunction_delay = max(malfunction_delay, round(30/severity_class))

	//drain some charge
	if(cell) cell.emp_act(severity_class + 1)

	//possibly damage some modules
	take_hit((100/severity_class), "electrical pulse", 1)

/obj/item/weapon/rig/proc/shock(mob/user)
	if (electrocute_mob(user, cell, src)) //electrocute_mob() handles removing charge from the cell, no need to do that here.
		spark_system.start()
		if(user.stunned)
			return TRUE
	return FALSE

/obj/item/weapon/rig/proc/take_hit(damage, source, is_emp=0)

	if(!installed_modules.len)
		return

	var/chance
	if(!is_emp)
		var/damage_resistance = 0
		if(istype(chest, /obj/item/clothing/suit/space))
			damage_resistance = chest.breach_threshold
		chance = 2*max(0, damage - damage_resistance)
	else
		//Want this to be roughly independant of the number of modules, meaning that X emp hits will disable Y% of the suit's modules on average.
		//that way people designing RIGs don't have to worry (as much) about how adding that extra module will affect emp resiliance by 'soaking' hits for other modules
		chance = 2*max(0, damage - emp_protection)*min(installed_modules.len/15, 1)

	if(!prob(chance))
		return

	//deal addition damage to already damaged module first.
	//This way the chances of a module being disabled aren't so remote.
	var/list/valid_modules = list()
	var/list/damaged_modules = list()
	for(var/obj/item/rig_module/module in installed_modules)
		if(module.damage < 2)
			valid_modules |= module
			if(module.damage > 0)
				damaged_modules |= module

	var/obj/item/rig_module/dam_module = null
	if(damaged_modules.len)
		dam_module = pick(damaged_modules)
	else if(valid_modules.len)
		dam_module = pick(valid_modules)

	if(!dam_module) return

	dam_module.damage++

	if(!source)
		source = "hit"

	if(wearer)
		if(dam_module.damage >= 2)
			to_chat(wearer, "<span class='danger'>The [source] has disabled your [dam_module.interface_name]!</span>")
		else
			to_chat(wearer, "<span class='warning'>The [source] has damaged your [dam_module.interface_name]!</span>")
	dam_module.deactivate()

/obj/item/weapon/rig/proc/malfunction_check(var/mob/living/carbon/human/user)
	if(malfunction_delay)
		if(offline)
			to_chat(user, "<span class='danger'>The suit is completely unresponsive.</span>")
		else
			to_chat(user, "<span class='danger'>ERROR: Hardware fault. Rebooting interface...</span>")
		return TRUE
	return FALSE

/obj/item/weapon/rig/proc/ai_can_move_suit(var/mob/user, var/check_user_module = 0, var/check_for_ai = 0)

	if(check_for_ai)
		if(!(locate(/obj/item/rig_module/ai_container) in contents))
			return FALSE
		var/found_ai
		for(var/obj/item/rig_module/ai_container/module in contents)
			if(module.damage >= 2)
				continue
			if(module.integrated_ai && module.integrated_ai.client && !module.integrated_ai.stat)
				found_ai = 1
				break
		if(!found_ai)
			return FALSE

	if(check_user_module)
		if(!user || !user.loc || !user.loc.loc)
			return FALSE
		var/obj/item/rig_module/ai_container/module = user.loc.loc
		if(!istype(module) || module.damage >= 2)
			to_chat(user, "<span class='warning'>Your host module is unable to interface with the suit.</span>")
			return FALSE

	if(offline || !cell || !cell.charge || locked_down)
		if(user) to_chat(user, "<span class='warning'>Your host rig is unpowered and unresponsive.</span>")
		return FALSE
	if(!wearer || wearer.back != src)
		if(user) to_chat(user, "<span class='warning'>Your host rig is not being worn.</span>")
		return FALSE
	if(!wearer.stat && !control_overridden && !ai_override_enabled)
		if(user) to_chat(user, "<span class='warning'>You are locked out of the suit servo controller.</span>")
		return FALSE
	return TRUE

/obj/item/weapon/rig/check_access(obj/item/I)
	return TRUE

/obj/item/weapon/rig/proc/force_rest(var/mob/user)
	if(!ai_can_move_suit(user, check_user_module = 1))
		return
	wearer.lay_down()
	to_chat(user, "<span class='notice'>\The [wearer] is now [wearer.resting ? "resting" : "getting up"].</span>")

/obj/item/weapon/rig/proc/forced_move(var/direction, var/mob/user)
	if(malfunctioning)
		direction = pick(GLOB.cardinal)

	if(world.time < wearer_move_delay)
		return

	if(!wearer || !wearer.loc || !ai_can_move_suit(user, check_user_module = 1))
		return

	// AIs are a bit slower than regular and ignore move intent.
	wearer_move_delay = world.time + ai_controlled_move_delay

	cell.use(aimove_power_usage * CELLRATE)
	wearer.DoMove(direction, user)

// This returns the rig if you are contained inside one, but not if you are wearing it
/atom/proc/get_rig()
	if(loc)
		return loc.get_rig()
	return null

/obj/item/weapon/rig/get_rig()
	return src

/mob/living/carbon/human/get_rig()
	return wearing_rig

/obj/item/weapon/rig/store_item(var/obj/item/input, var/mob/user)
	if (storage && storage.container.can_be_inserted(input, user))
		storage.container.handle_item_insertion(input, FALSE)
		return TRUE
	return FALSE

#undef ONLY_DEPLOY
#undef ONLY_RETRACT
#undef SEAL_DELAY
