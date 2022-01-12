/obj/item/rig_module/power_sink

	name = "power siphon"
	desc = "A convenient way to recharge the rig's internal battery"
	icon_state = "powersink"
	selectable = 1
	//activates_on_touch = 1
	disruptive = 0

	activate_string = "Enable Power siphon"
	deactivate_string = "Disable Power siphon"

	origin_tech = list(TECH_POWER = 6, TECH_ENGINEERING = 6)
	var/atom/interfaced_with // Currently draining power from this device.
	var/total_power_drained = 0
	var/drain_loc
	var/max_draining_rate = 30 KILOWATTS // The same as unupgraded cyborg recharger.

	loadout_tags = list(LOADOUT_TAG_RIG_POWERSIPHON)

/obj/item/rig_module/power_sink/deactivate()

	if(interfaced_with)
		if(holder && holder.wearer)
			to_chat(holder.wearer, "<span class = 'warning'>Your power siphon retracts as the module deactivates.</span>")
		drain_complete()
	interfaced_with = null
	total_power_drained = 0
	return ..()

/obj/item/rig_module/power_sink/activate()
	interfaced_with = null
	total_power_drained = 0
	return ..()

/obj/item/rig_module/power_sink/engage(atom/target)
	if(!..())
		return 0


	//Target wasn't supplied or we're already draining.
	if(interfaced_with)
		return 0

	if(!target)
		return 1

	// Are we close enough?
	var/mob/living/carbon/human/H = holder.wearer
	if(!target.Adjacent(H))
		return 0

	// Is it a valid power source?
	if(target.drain_power(1) <= 0)
		return 0

	to_chat(H, "<span class = 'danger'>You begin draining power from [target]!</span>")
	interfaced_with = target
	if (holder)
		holder.processing_modules |= src
	drain_loc = interfaced_with.loc

	H.face_atom(target)

	holder.spark_system.start()
	playsound(H.loc, 'sound/effects/sparks2.ogg', 50, 1)

	return 1

/obj/item/rig_module/power_sink/accepts_item(var/obj/item/input_device, var/mob/living/user)
	var/can_drain = input_device.drain_power(1)
	if(can_drain > 0)
		engage(input_device)
		return 1
	return 0

/obj/item/rig_module/power_sink/Process()
	if(!interfaced_with)
		return ..()

	var/mob/living/carbon/human/H
	if(holder && holder.wearer)
		H = holder.wearer

	if(!H || !istype(H))
		return 0

	if (prob(10))
		holder.spark_system.start()
		playsound(H.loc, 'sound/effects/sparks2.ogg', 50, 1)

	if(!holder.cell)
		to_chat(H, "<span class = 'danger'>Your power siphon flashes an error; there is no cell in your rig.</span>")
		drain_complete(H)
		return

	if(!interfaced_with || !interfaced_with.Adjacent(H) || !(interfaced_with.loc == drain_loc))
		to_chat(H, "<span class = 'warning'>Your power siphon retracts into its casing.</span>")
		drain_complete(H)
		return

	if(holder.cell.fully_charged())
		to_chat(H, "<span class = 'warning'>Your power siphon flashes an amber light; your rig cell is full.</span>")
		drain_complete(H)
		return

	var/target_drained = interfaced_with.drain_power(0,0,max_draining_rate)
	if(target_drained <= 0)
		to_chat(H, "<span class = 'danger'>Your power siphon flashes a red light; there is no power left in [interfaced_with].</span>")
		drain_complete(H)
		return

	holder.cell.give(target_drained * CELLRATE)
	total_power_drained += target_drained

	return

/obj/item/rig_module/power_sink/proc/drain_complete(var/mob/living/M)
	holder.spark_system.start()
	playsound(M.loc, 'sound/effects/sparks2.ogg', 50, 1)

	if(!interfaced_with)
		if(M) to_chat(M, "<font color='blue'><b>Total power drained:</b> [round(total_power_drained*CELLRATE)] Wh.</font>")
	else
		if(M) to_chat(M, "<font color='blue'><b>Total power drained from [interfaced_with]:</b> [round(total_power_drained*CELLRATE)] Wh.</font>")
		interfaced_with.drain_power(0,1,0) // Damage the victim.

	drain_loc = null
	interfaced_with = null
	total_power_drained = 0
	if (holder)
		holder.processing_modules -= src