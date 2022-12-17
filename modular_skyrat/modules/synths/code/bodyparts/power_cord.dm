#define SYNTH_CHARGE_MAX 150
#define SYNTH_CHARGE_MIN 50
#define SYNTH_CHARGE_PER_NUTRITION 10
#define SYNTH_CHARGE_DELAY_PER_100 10
#define SYNTH_DRAW_NUTRITION_BUFFER 30

/obj/item/organ/internal/cyberimp/arm/power_cord
	name = "power cord implant"
	desc = "An internal power cord. Useful if you run on elecricity. Not so much otherwise."
	contents = newlist(/obj/item/apc_powercord)
	zone = "l_arm"

/obj/item/apc_powercord
	name = "power cord"
	desc = "An internal power cord. Useful if you run on electricity. Not so much otherwise."
	icon = 'icons/obj/power.dmi'
	icon_state = "wire1"

/obj/item/apc_powercord/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!istype(target, /obj/machinery/power/apc) || !ishuman(user) || !proximity_flag)
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)
	var/obj/machinery/power/apc/target_apc = target
	var/mob/living/carbon/human/ipc = user
	var/obj/item/organ/internal/stomach/synth/cell = ipc.internal_organs_slot[ORGAN_SLOT_STOMACH]
	if(!cell)
		to_chat(ipc, span_warning("You try to siphon energy from the [target_apc], but you have no stomach! How are you still standing?"))
		return
	if(!istype(cell))
		to_chat(ipc, span_warning("You plug into the APC, but nothing happens! It seems you don't have a cell to charge!"))
		return

	if(target_apc.cell && target_apc.cell.charge > 0)
		if(ipc.nutrition >= NUTRITION_LEVEL_WELL_FED)
			to_chat(user, span_warning("You are already fully charged!"))
			return
		else
			powerdraw_loop(target_apc, ipc)
			return

	to_chat(user, span_warning("There is no charge to draw from that APC."))

/obj/item/apc_powercord/proc/powerdraw_loop(obj/machinery/power/apc/target_apc, mob/living/carbon/human/user)
	user.visible_message(span_notice("[user] inserts a power connector into the [target_apc]."), span_notice("You begin to draw power from the [target_apc]."))

	while(TRUE)
		var/power_needed = NUTRITION_LEVEL_WELL_FED - user.nutrition // How much charge do we need in total?
		// Do we even need anything?
		if(power_needed <= SYNTH_CHARGE_MIN * 2) // Times two to make sure minimum draw is always lower than this margin to prevent potential needless loops.
			to_chat(user, span_notice("You are fully charged."))
			break

		// Is the APC not charging equipment? And yes, synths are gonna be treated as equipment. Deal with it.
		if(target_apc.equipment == APC_CHANNEL_AUTO_OFF || target_apc.equipment == APC_CHANNEL_OFF) // Better than just 10%, as that's enough margin for synths to overstep and trip doors offline.
			to_chat(user, span_warning("[target_apc]'s equipment power is disabled."))
			break

		// Calculate how much to draw this cycle
		var/power_use = clamp(power_needed, SYNTH_CHARGE_MIN, SYNTH_CHARGE_MAX)
		power_use = clamp(power_use, 0, target_apc.cell.charge)
		// Are we able to draw anything?
		if(power_use == 0)
			to_chat(user, span_warning("[target_apc] lacks the power to charge you."))
			break

		// Calculate the delay.
		var/power_delay = (power_use / 100) * SYNTH_CHARGE_DELAY_PER_100
		// Attempt to run a charging cycle.
		if(!do_after(user, power_delay, target = target_apc))
			break

		// Use the power and increase nutrition.
		target_apc.cell.use(power_use)
		// I will gut you if you remove this following code, as it fixes synths powersinking department doors and lights so easily.
		target_apc.update() // IMPORTANT TO MAKE SURE APCS ARE AWARE OF SYNTH POWERDRAW AS IT HAPPENS.

		user.nutrition += power_use / SYNTH_CHARGE_PER_NUTRITION
		do_sparks(1, FALSE, target_apc)

	user.visible_message(span_notice("[user] unplugs from the [target_apc]."), span_notice("You unplug from the [target_apc]."))

#undef SYNTH_CHARGE_MAX
#undef SYNTH_CHARGE_MIN
#undef SYNTH_CHARGE_PER_NUTRITION
#undef SYNTH_CHARGE_DELAY_PER_100
