/**
 * Simple proc to insert the pAI into the MODsuit.
 *
 * user - The person trying to put the pAI into the MODsuit.
 * card - The pAI card we're slotting in the MODsuit.
 */

/obj/item/mod/control/proc/insert_pai(mob/user, obj/item/paicard/card)
	if(mod_pai)
		balloon_alert(user, "pAI already installed!")
		return
	if(!card.pai || !card.pai.mind)
		balloon_alert(user, "pAI unresponsive!")
		return
	balloon_alert(user, "transferring to suit...")
	if(!do_after(user, 5 SECONDS, target = src))
		balloon_alert(user, "interrupted!")
		return FALSE
	if(!user.transferItemToLoc(card, src))
		return

	mod_pai = card.pai
	balloon_alert(user, "pAI transferred to suit")
	balloon_alert(mod_pai, "transferred to a suit")
	mod_pai.can_transmit = TRUE
	mod_pai.can_receive = TRUE
	mod_pai.canholo = FALSE
	mod_pai.remote_control = src
	for(var/datum/action/action as anything in actions)
		action.Grant(mod_pai)
	return TRUE

/**
 * Simple proc to extract the pAI from the MODsuit. It's the proc to call if you want to take it out,
 * remove_pai() is there so atom_destruction() doesn't have any risk of sleeping.
 *
 * user - The person trying to take out the pAI from the MODsuit.
 * forced - Whether or not we skip the checks and just eject the pAI. Defaults to FALSE.
 * feedback - Whether to give feedback via balloon alerts or not. Defaults to TRUE.
 */
/obj/item/mod/control/proc/extract_pai(mob/user, forced = FALSE, feedback = TRUE)
	if(!mod_pai)
		if(user && feedback)
			balloon_alert(user, "no pAI to remove!")
		return
	if(!forced)
		if(!open)
			if(user && feedback)
				balloon_alert(user, "open the suit panel!")
			return FALSE
		if(!do_after(user, 5 SECONDS, target = src))
			if(user && feedback)
				balloon_alert(user, "interrupted!")
			return FALSE

	remove_pai(feedback)

	if(feedback && user)
		balloon_alert(user, "pAI removed from the suit")

/**
 * Simple proc that handles the safe removal of the pAI from a MOD control unit.
 *
 * Arguments:
 * * feedback - Whether or not we want to give balloon alert feedback to the mod_pai. Defaults to FALSE.
 */
/obj/item/mod/control/proc/remove_pai(feedback = FALSE)
	var/turf/drop_off = get_turf(src)
	if(drop_off) // In case there's no drop_off, the pAI will simply get deleted.
		mod_pai.card.forceMove(drop_off)

	for(var/datum/action/action as anything in actions)
		if(action.owner == mod_pai)
			action.Remove(mod_pai)

	if(feedback)
		balloon_alert(mod_pai, "removed from a suit")
	mod_pai.remote_control = null
	mod_pai.canholo = TRUE
	mod_pai = null


#define MOVE_DELAY 2
#define WEARER_DELAY 1
#define LONE_DELAY 5
#define CELL_PER_STEP DEFAULT_CHARGE_DRAIN * 2.5
#define PAI_FALL_TIME 1 SECONDS

/obj/item/mod/control/relaymove(mob/user, direction)
	if((!active && wearer) || (active && !can_pai_move_suit) || !core.charge_source() || core.charge_amount() < CELL_PER_STEP  || user != mod_pai || !COOLDOWN_FINISHED(src, cooldown_mod_move))
		return FALSE
	if(wearer && (wearer.pulledby?.grab_state || wearer.incapacitated() || wearer.stat))
		return FALSE
	var/timemodifier = MOVE_DELAY * (ISDIAGONALDIR(direction) ? SQRT_2 : 1) * (wearer ? WEARER_DELAY : LONE_DELAY)
	COOLDOWN_START(src, cooldown_mod_move, movedelay * timemodifier + slowdown)
	playsound(src, 'sound/mecha/mechmove01.ogg', 25, TRUE)
	core.subtract_charge(CELL_PER_STEP)
	if(wearer)
		ADD_TRAIT(wearer, TRAIT_FORCED_STANDING, MOD_TRAIT)
		addtimer(CALLBACK(src, .proc/pai_fall), PAI_FALL_TIME, TIMER_UNIQUE | TIMER_OVERRIDE)
	if(ismovable(wearer?.loc))
		return wearer.loc.relaymove(wearer, direction)
	if(wearer && !wearer.Process_Spacemove(direction))
		return FALSE
	var/atom/movable/mover = wearer || src
	return step(mover, direction)

#undef MOVE_DELAY
#undef WEARER_DELAY
#undef LONE_DELAY
#undef CELL_PER_STEP
#undef PAI_FALL_TIME

/// Simple proc adding the falling of the MODsuit when it's no longer moving, for corpses and unconscious wearers.
/obj/item/mod/control/proc/pai_fall()
	if(!wearer)
		return
	REMOVE_TRAIT(wearer, TRAIT_FORCED_STANDING, MOD_TRAIT)

/**
 * Misc stuff to avoid having files with three lines in them.
 */
/obj/item/mod/control
	/// pAI mob inhabiting the MOD.
	var/mob/living/silicon/pai/mod_pai
	/// Whether or not an on-board pAI can move the suit. FALSE by default, intended to be modified either via VV or via a possible future pAI program.
	var/can_pai_move_suit = FALSE


/datum/action/item_action/mod
	/// Whether this action is intended for the inserted pAI. Stuff breaks a lot if this is done differently.
	var/pai_action = FALSE


/datum/action/item_action/mod/deploy/pai
	pai_action = TRUE


/datum/action/item_action/mod/panel/pai
	pai_action = TRUE


/datum/action/item_action/mod/module/pai
	pai_action = TRUE


/datum/action/item_action/mod/activate/pai
	pai_action = TRUE


/obj/item/mod/control/ui_state(mob/user)
	if(user == mod_pai)
		return GLOB.contained_state
	return ..()
