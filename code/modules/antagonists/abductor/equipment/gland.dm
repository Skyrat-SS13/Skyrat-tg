/obj/item/organ/internal/heart/gland
	name = "fleshy mass"
	desc = "A nausea-inducing hunk of twisting flesh and metal."
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "gland"
	organ_flags = ORGAN_ROBOTIC | ORGAN_PROMINENT // weird?
	/// Shows name of the gland as well as a description of what it does upon examination by abductor scientists and observers.
	var/abductor_hint = "baseline placebo referencer"

	/// The minimum time between activations
	var/cooldown_low = 30 SECONDS
	/// The maximum time between activations
	var/cooldown_high = 30 SECONDS
	/// The cooldown for activations
	COOLDOWN_DECLARE(activation_cooldown)
	/// The number of remaining uses this gland has.
	var/uses = 0 // -1 For infinite
	var/human_only = FALSE
	var/active = FALSE

	var/mind_control_uses = 1
	var/mind_control_duration = 1800
	var/active_mind_control = FALSE

/obj/item/organ/internal/heart/gland/Initialize(mapload)
	. = ..()
	icon_state = pick(list("health", "spider", "slime", "emp", "species", "egg", "vent", "mindshock", "viral"))
	AddElement(/datum/element/update_icon_blocker)

/obj/item/organ/internal/heart/gland/examine(mob/user)
	. = ..()
	if(HAS_MIND_TRAIT(user, TRAIT_ABDUCTOR_SCIENTIST_TRAINING) || isobserver(user))
		. += span_notice("It is \a [abductor_hint]")

/obj/item/organ/internal/heart/gland/Stop()
	return FALSE

/obj/item/organ/internal/heart/gland/proc/ownerCheck()
	if(ishuman(owner))
		return TRUE
	if(!human_only && iscarbon(owner))
		return TRUE
	return FALSE

/obj/item/organ/internal/heart/gland/proc/Start()
	active = 1
	COOLDOWN_START(src, activation_cooldown, rand(cooldown_low, cooldown_high))

/obj/item/organ/internal/heart/gland/proc/update_gland_hud()
	if(!owner)
		return
	var/image/holder = owner.hud_list[GLAND_HUD]
	var/icon/I = icon(owner.icon, owner.icon_state, owner.dir)
	holder.pixel_y = I.Height() - world.icon_size
	if(active_mind_control)
		holder.icon_state = "hudgland_active"
	else if(mind_control_uses)
		holder.icon_state = "hudgland_ready"
	else
		holder.icon_state = "hudgland_spent"

/obj/item/organ/internal/heart/gland/proc/mind_control(command, mob/living/user)
	if(!ownerCheck() || !mind_control_uses || active_mind_control)
		return FALSE
	mind_control_uses--
	owner.balloon_alert(owner, "new compulsion")
	to_chat(owner, span_userdanger("You suddenly feel an irresistible compulsion to follow an order..."))
	to_chat(owner, span_mind_control("[command]"))
	active_mind_control = TRUE
	message_admins("[key_name(user)] sent an abductor mind control message to [key_name(owner)]: [command]")
	user.log_message("sent an abductor mind control message to [key_name(owner)]: [command]", LOG_GAME)
	update_gland_hud()
	var/atom/movable/screen/alert/mind_control/mind_alert = owner.throw_alert(ALERT_MIND_CONTROL, /atom/movable/screen/alert/mind_control)
	mind_alert.command = command
	addtimer(CALLBACK(src, PROC_REF(clear_mind_control)), mind_control_duration)
	return TRUE

/obj/item/organ/internal/heart/gland/proc/clear_mind_control()
	if(!ownerCheck() || !active_mind_control)
		return FALSE
	owner.balloon_alert(owner, "compulsion forgotten")
	to_chat(owner, span_userdanger("You feel the compulsion fade, and you <i>completely forget</i> about your previous orders."))
	owner.clear_alert(ALERT_MIND_CONTROL)
	active_mind_control = FALSE
	return TRUE

/obj/item/organ/internal/heart/gland/Remove(mob/living/carbon/gland_owner, special, movement_flags)
	. = ..()
	active = FALSE
	if(initial(uses) == 1)
		uses = initial(uses)
	var/datum/atom_hud/abductor/hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	hud.remove_atom_from_hud(gland_owner)
	clear_mind_control()

/obj/item/organ/internal/heart/gland/Insert(mob/living/carbon/gland_owner, special = FALSE, movement_flags = DELETE_IF_REPLACED)
	. = ..()
	if(!.)
		return

	if(special != 2 && uses) // Special 2 means abductor surgery
		Start()
	var/datum/atom_hud/abductor/hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	hud.add_atom_to_hud(gland_owner)
	update_gland_hud()

/obj/item/organ/internal/heart/gland/on_life(seconds_per_tick, times_fired)
	if(!active)
		return
	if(!ownerCheck())
		active = FALSE
		return
	if(COOLDOWN_FINISHED(src, activation_cooldown))
		activate()
		uses--
		COOLDOWN_START(src, activation_cooldown, rand(cooldown_low, cooldown_high))
	if(!uses)
		active = FALSE

/obj/item/organ/internal/heart/gland/proc/activate()
	return
