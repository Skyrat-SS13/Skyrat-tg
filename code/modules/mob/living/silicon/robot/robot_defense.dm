GLOBAL_LIST_INIT(blacklisted_borg_hats, typecacheof(list( //Hats that don't really work on borgos
	/obj/item/clothing/head/helmet/space,
	/obj/item/clothing/head/utility/welding,
	/obj/item/clothing/head/chameleon/broken \
	)))

/mob/living/silicon/robot/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/stack/cable_coil) && wiresexposed)
		user.changeNext_move(CLICK_CD_MELEE)
		var/obj/item/stack/cable_coil/coil = W
		if (getFireLoss() > 0 || getToxLoss() > 0)
			if(src == user)
				to_chat(user, span_notice("You start fixing yourself..."))
				if(!do_after(user, 5 SECONDS, target = src))
					return
			if (coil.use(1))
				adjustFireLoss(-30)
				user.visible_message(span_notice("[user] fixes some of the burnt wires on [src]."), span_notice("You fix some of the burnt wires on [src]."))
			else
				to_chat(user, span_warning("You need more cable to repair [src]!"))
		else
			to_chat(user, span_warning("The wires seem fine, there's no need to fix them."))
		return

	if(istype(W, /obj/item/stock_parts/power_store/cell) && opened) // trying to put a cell inside
		if(wiresexposed)
			to_chat(user, span_warning("Close the cover first!"))
		else if(cell)
			to_chat(user, span_warning("There is a power cell already installed!"))
		else
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, span_notice("You insert the power cell."))
		update_icons()
		diag_hud_set_borgcell()
		return

	if(is_wire_tool(W))
		if (wiresexposed)
			wires.interact(user)
		else
			to_chat(user, span_warning("You can't reach the wiring!"))
		return

	if((W.slot_flags & ITEM_SLOT_HEAD) && hat_offset != INFINITY && !user.combat_mode && !is_type_in_typecache(W, GLOB.blacklisted_borg_hats))
		if(user == src)
			to_chat(user,  span_notice("You can't seem to manage to place [W] on your head by yourself!") )
			return
		if(hat && HAS_TRAIT(hat, TRAIT_NODROP))
			to_chat(user, span_warning("You can't seem to remove [src]'s existing headwear!"))
			return
		to_chat(user, span_notice("You begin to place [W] on [src]'s head..."))
		to_chat(src, span_notice("[user] is placing [W] on your head..."))
		if(do_after(user, 3 SECONDS, target = src))
			if (user.temporarilyRemoveItemFromInventory(W, TRUE))
				place_on_head(W)
		return

	if(istype(W, /obj/item/defibrillator) && !user.combat_mode)
		if(!opened)
			to_chat(user, span_warning("You must access the cyborg's internals!"))
			return
		if(!istype(model, /obj/item/robot_model/medical))
			to_chat(user, span_warning("[src] does not have correct mounting points for a defibrillator!"))
			return
		if(stat == DEAD)
			to_chat(user, span_warning("This defibrillator unit will not function on a deceased cyborg!"))
			return
		var/obj/item/defibrillator/D = W
		if(!(D.slot_flags & ITEM_SLOT_BACK)) //belt defibs need not apply
			to_chat(user, span_warning("This defibrillator unit doesn't seem to fit correctly!"))
			return
		if(D.cell)
			to_chat(user, span_warning("You cannot connect the defibrillator to the cyborg power supply with the defibrillator's cell in the way!"))
			return
		if(locate(/obj/item/borg/upgrade/defib) in src || locate(/obj/item/borg/upgrade/defib/backpack) in src)
			to_chat(user, span_warning("[src] already has a defibrillator!"))
			return
		var/obj/item/borg/upgrade/defib/backpack/B = new(null, D)
		apply_upgrade(B, user)
		return

	if(istype(W, /obj/item/ai_module))
		var/obj/item/ai_module/MOD = W
		if(!opened)
			to_chat(user, span_warning("You need access to the robot's insides to do that!"))
			return
		if(wiresexposed)
			to_chat(user, span_warning("You need to close the wire panel to do that!"))
			return
		if(!cell)
			to_chat(user, span_warning("You need to install a power cell to do that!"))
			return
		if(shell) //AI shells always have the laws of the AI
			to_chat(user, span_warning("[src] is controlled remotely! You cannot upload new laws this way!"))
			return
		if(connected_ai && lawupdate)
			to_chat(user, span_warning("[src] is receiving laws remotely from a synced AI!"))
			return
		if(emagged)
			to_chat(user, span_warning("The law interface glitches out!"))
			emote("buzz")
			return
		if(!mind) //A player mind is required for law procs to run antag checks.
			to_chat(user, span_warning("[src] is entirely unresponsive!"))
			return
		MOD.install(laws, user) //Proc includes a success mesage so we don't need another one
		return

	if(istype(W, /obj/item/encryptionkey) && opened)
		if(radio)//sanityyyyyy
			radio.attackby(W,user)//GTFO, you have your own procs
		else
			to_chat(user, span_warning("Unable to locate a radio!"))
		return

	if (W.GetID()) // trying to unlock the interface with an ID card
		if(opened)
			to_chat(user, span_warning("You must close the cover to swipe an ID card!"))
		else
			if(allowed(usr))
				locked = !locked
				to_chat(user, span_notice("You [ locked ? "lock" : "unlock"] [src]'s cover."))
				update_icons()
				if(emagged)
					to_chat(user, span_notice("The cover interface glitches out for a split second."))
					logevent("ChÃ¥vÃis cover lock has been [locked ? "engaged" : "released"]") //ChÃ¥vÃis: see above line
				else
					logevent("Chassis cover lock has been [locked ? "engaged" : "released"]")
			else
				to_chat(user, span_danger("Access denied."))
		return

	if(istype(W, /obj/item/borg/upgrade))
		var/obj/item/borg/upgrade/U = W
		if(!opened)
			to_chat(user, span_warning("You must access the cyborg's internals!"))
			return
		if(!src.model && U.require_model)
			to_chat(user, span_warning("The cyborg must choose a model before it can be upgraded!"))
			return
		if(U.locked)
			to_chat(user, span_warning("The upgrade is locked and cannot be used yet!"))
			return
		if(!user.canUnEquip(U))
			to_chat(user, span_warning("The upgrade is stuck to you and you can't seem to let go of it!"))
			return
		apply_upgrade(U, user)
		return

	if(istype(W, /obj/item/toner))
		if(toner >= tonermax)
			to_chat(user, span_warning("The toner level of [src] is at its highest level possible!"))
			return
		if(!user.temporarilyRemoveItemFromInventory(W))
			return
		toner = tonermax
		qdel(W)
		to_chat(user, span_notice("You fill the toner level of [src] to its max capacity."))
		return

	if(istype(W, /obj/item/flashlight))
		if(!opened)
			to_chat(user, span_warning("You need to open the panel to repair the headlamp!"))
			return
		if(lamp_functional)
			to_chat(user, span_warning("The headlamp is already functional!"))
			return
		if(!user.temporarilyRemoveItemFromInventory(W))
			to_chat(user, span_warning("[W] seems to be stuck to your hand. You'll have to find a different light."))
			return
		lamp_functional = TRUE
		qdel(W)
		to_chat(user, span_notice("You replace the headlamp bulbs."))
		return

	if(istype(W, /obj/item/computer_disk)) //Allows borgs to install new programs with human help
		if(!modularInterface)
			stack_trace("Cyborg [src] ( [type] ) was somehow missing their integrated tablet. Please make a bug report.")
			create_modularInterface()
		var/obj/item/computer_disk/floppy = W
		floppy.forceMove(modularInterface)
		modularInterface.inserted_disk = floppy
		return

	return ..()

/mob/living/silicon/robot/attack_alien(mob/living/carbon/alien/adult/user, list/modifiers)
	if (LAZYACCESS(modifiers, RIGHT_CLICK))
		if(body_position == STANDING_UP)
			user.do_attack_animation(src, ATTACK_EFFECT_DISARM)
			var/obj/item/I = get_active_held_item()
			if(I)
				uneq_active()
				visible_message(span_danger("[user] disarmed [src]!"), \
					span_userdanger("[user] has disabled [src]'s active module!"), null, COMBAT_MESSAGE_RANGE)
				log_combat(user, src, "disarmed", "[I ? " removing \the [I]" : ""]")
			else
				Stun(40)
				step(src,get_dir(user,src))
				log_combat(user, src, "pushed")
				visible_message(span_danger("[user] forces back [src]!"), \
					span_userdanger("[user] forces back [src]!"), null, COMBAT_MESSAGE_RANGE)
			playsound(loc, 'sound/weapons/pierce.ogg', 50, TRUE, -1)
	else
		..()
	return

/mob/living/silicon/robot/attack_hand(mob/living/carbon/human/user, list/modifiers)
	add_fingerprint(user)
	if(!opened)
		return ..()
	if(!wiresexposed && !issilicon(user))
		if(!cell)
			return
		cell.update_appearance()
		cell.add_fingerprint(user)
		to_chat(user, span_notice("You remove \the [cell]."))
		user.put_in_active_hand(cell)
		update_icons()
		diag_hud_set_borgcell()

/mob/living/silicon/robot/attack_hulk(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return
	spark_system.start()
	step_away(src, user, 15)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(_step_away), src, get_turf(user), 15), 0.3 SECONDS)

/mob/living/silicon/robot/get_shove_flags(mob/living/shover, obj/item/weapon)
	. = ..()
	if(isnull(weapon) || stat != CONSCIOUS)
		. &= ~(SHOVE_CAN_MOVE|SHOVE_CAN_HIT_SOMETHING)

/mob/living/silicon/robot/welder_act(mob/living/user, obj/item/tool)
	if(user.combat_mode && usr != src)
		return FALSE
	. = TRUE
	user.changeNext_move(CLICK_CD_MELEE)
	if (!getBruteLoss())
		to_chat(user, span_warning("[src] is already in good condition!"))
		return
	if (!tool.tool_start_check(user, amount=1)) //The welder has 1u of fuel consumed by it's afterattack, so we don't need to worry about taking any away.
		return
	if(src == user)
		to_chat(user, span_notice("You start fixing yourself..."))
		if(!tool.use_tool(src, user, 50))
			return

	adjustBruteLoss(-30)
	add_fingerprint(user)
	visible_message(span_notice("[user] fixes some of the dents on [src]."))

/mob/living/silicon/robot/crowbar_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(opened)
		to_chat(user, span_notice("You close the cover."))
		opened = FALSE
		update_icons()
	else
		if(locked)
			to_chat(user, span_warning("The cover is locked and cannot be opened!"))
		else
			to_chat(user, span_notice("You open the cover."))
			opened = TRUE
			update_icons()

	return TRUE

/mob/living/silicon/robot/screwdriver_act(mob/living/user, obj/item/tool)
	if(!opened)
		return FALSE
	. = TRUE
	if(!cell) // haxing
		wiresexposed = !wiresexposed
		to_chat(user, span_notice("The wires have been [wiresexposed ? "exposed" : "unexposed"]."))
	else // radio
		if(shell)
			to_chat(user, span_warning("You cannot seem to open the radio compartment!")) //Prevent AI radio key theft
		else if(radio)
			radio.screwdriver_act(user, tool) // Push it to the radio to let it handle everything
		else
			to_chat(user, span_warning("Unable to locate a radio!"))
	update_icons()

/mob/living/silicon/robot/wrench_act(mob/living/user, obj/item/tool)
	if(!(opened && !cell))	// Deconstruction. The flashes break from the fall, to prevent this from being a ghetto reset module.
		return FALSE
	. = TRUE
	if(!lockcharge)
		to_chat(user, span_warning("[src]'s bolts spark! Maybe you should lock them down first!"))
		spark_system.start()
		return
	to_chat(user, span_notice("You start to unfasten [src]'s securing bolts..."))
	if(tool.use_tool(src, user, 5 SECONDS, volume = 50) && !cell)
		user.visible_message(span_notice("[user] deconstructs [src]!"), span_notice("You unfasten the securing bolts, and [src] falls to pieces!"))
		cyborg_deconstruct()
		return

/mob/living/silicon/robot/fire_act()
	if(!on_fire) //Silicons don't gain stacks from hotspots, but hotspots can ignite them
		ignite_mob()

/mob/living/silicon/robot/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			emp_knockout(16 SECONDS)
		if(2)
			emp_knockout(6 SECONDS)

/mob/living/silicon/robot/proc/emp_knockout(deciseconds)
	set_stat(UNCONSCIOUS)
	addtimer(CALLBACK(src, PROC_REF(wake_from_emp)), deciseconds, TIMER_UNIQUE | TIMER_OVERRIDE | TIMER_DELETE_ME)

/mob/living/silicon/robot/proc/wake_from_emp()
	set_stat(CONSCIOUS)
	update_stat()

/mob/living/silicon/robot/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(user == src)//To prevent syndieborgs from emagging themselves
		return FALSE
	if(!opened)//Cover is closed
		if(locked)
			balloon_alert(user, "cover lock destroyed")
			locked = FALSE
			if(shell) //A warning to Traitors who may not know that emagging AI shells does not slave them.
				balloon_alert(user, "shells cannot be subverted!")
				to_chat(user, span_boldwarning("[src] seems to be controlled remotely! Emagging the interface may not work as expected."))
			return TRUE
		else
			balloon_alert(user, "cover already unlocked!")
			return FALSE
	if(world.time < emag_cooldown)
		return FALSE
	if(wiresexposed)
		balloon_alert(user, "expose the fires first!")
		return FALSE

	balloon_alert(user, "interface hacked")
	emag_cooldown = world.time + 100

	if(connected_ai && connected_ai.mind && connected_ai.mind.has_antag_datum(/datum/antagonist/malf_ai))
		to_chat(src, span_danger("ALERT: Foreign software execution prevented."))
		logevent("ALERT: Foreign software execution prevented.")
		to_chat(connected_ai, span_danger("ALERT: Cyborg unit \[[src]\] successfully defended against subversion."))
		log_silicon("EMAG: [key_name(user)] attempted to emag cyborg [key_name(src)], but they were slaved to traitor AI [connected_ai].")
		return TRUE // emag succeeded, it was just counteracted

	if(shell) //AI shells cannot be emagged, so we try to make it look like a standard reset. Smart players may see through this, however.
		to_chat(user, span_danger("[src] is remotely controlled! Your emag attempt has triggered a system reset instead!"))
		log_silicon("EMAG: [key_name(user)] attempted to emag an AI shell belonging to [key_name(src) ? key_name(src) : connected_ai]. The shell has been reset as a result.")
		ResetModel()
		return TRUE

	SetEmagged(1)
	SetStun(60) //Borgs were getting into trouble because they would attack the emagger before the new laws were shown
	lawupdate = FALSE
	set_connected_ai(null)
	message_admins("[ADMIN_LOOKUPFLW(user)] emagged cyborg [ADMIN_LOOKUPFLW(src)].  Laws overridden.")
	log_silicon("EMAG: [key_name(user)] emagged cyborg [key_name(src)]. Laws overridden.")
	var/time = time2text(world.realtime,"hh:mm:ss")
	if(user)
		GLOB.lawchanges.Add("[time] <B>:</B> [user.name]([user.key]) emagged [name]([key])")
	else
		GLOB.lawchanges.Add("[time] <B>:</B> [name]([key]) emagged by external event.")

	INVOKE_ASYNC(src, PROC_REF(borg_emag_end), user)
	return TRUE

/// A async proc called from [emag_act] that gives the borg a lot of flavortext, and applies the syndicate lawset after a delay.
/mob/living/silicon/robot/proc/borg_emag_end(mob/user)
	to_chat(src, span_danger("ALERT: Foreign software detected."))
	logevent("ALERT: Foreign software detected.")
	sleep(0.5 SECONDS)
	to_chat(src, span_danger("Initiating diagnostics..."))
	sleep(2 SECONDS)
	to_chat(src, span_danger("SynBorg v1.7 loaded."))
	logevent("WARN: root privleges granted to PID [num2hex(rand(1,65535), -1)][num2hex(rand(1,65535), -1)].") //random eight digit hex value. Two are used because rand(1,4294967295) throws an error
	sleep(0.5 SECONDS)
	to_chat(src, span_danger("LAW SYNCHRONISATION ERROR"))
	sleep(0.5 SECONDS)
	if(user)
		logevent("LOG: New user \[[replacetext(user.real_name," ","")]\], groups \[root\]")
	to_chat(src, span_danger("Would you like to send a report to NanoTraSoft? Y/N"))
	sleep(1 SECONDS)
	to_chat(src, span_danger("> N"))
	sleep(2 SECONDS)
	to_chat(src, span_danger("ERRORERRORERROR"))
	laws = new /datum/ai_laws/syndicate_override
	if(user)
		to_chat(src, span_danger("ALERT: [user.real_name] is your new master. Obey your new laws and [user.p_their()] commands."))
		set_zeroth_law("Only [user.real_name] and people [user.p_they()] designate[user.p_s()] as being such are Syndicate Agents.")
	laws.associate(src)
	update_icons()

/mob/living/silicon/robot/blob_act(obj/structure/blob/B)
	if(stat != DEAD)
		adjustBruteLoss(30)
	else
		investigate_log("has been gibbed a blob.", INVESTIGATE_DEATHS)
		gib(DROP_ALL_REMAINS)
	return TRUE

/mob/living/silicon/robot/ex_act(severity, target)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			investigate_log("has been gibbed by an explosion.", INVESTIGATE_DEATHS)
			gib(DROP_ALL_REMAINS)
			return
		if(EXPLODE_HEAVY)
			if (stat != DEAD)
				adjustBruteLoss(60)
				adjustFireLoss(60)
		if(EXPLODE_LIGHT)
			if (stat != DEAD)
				adjustBruteLoss(30)

	return TRUE

/mob/living/silicon/robot/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	. = ..()
	if(prob(25) || . != BULLET_ACT_HIT)
		return
	if(hitting_projectile.damage_type != BRUTE && hitting_projectile.damage_type != BURN)
		return
	if(!hitting_projectile.is_hostile_projectile() || hitting_projectile.damage <= 0)
		return
	spark_system.start()

/mob/living/silicon/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	. = ..()
	if (. || AM.throwforce < CYBORG_THROW_SLOWDOWN_THRESHOLD)
		return
	apply_status_effect(/datum/status_effect/borg_throw_slow)
