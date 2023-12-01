#define HACKERMAN_DECK_TEMPERATURE_INCREASE 200

// An implant that injects you with twitch on demand, acting like a bootleg sandevistan

/obj/item/organ/internal/cyberimp/sensory_enhancer
	name = "Qani-Laaca sensory computer"
	desc = "An experimental implant replacing the spine of organics. When activated, it can give a temporary boost to mental processing speed, \
		Which many users percieve as a slowing of time and quickening of their ability to act. Due to its nature, it is incompatible with \
		system that heavily influence the user's nervous system, like the central nervous system rebooter. \
		As a bonus effect, you are immune to the burst of heart damage that comes at the end of twitch usage, as the computer is able to regulate \
		your heart's rythm back to normal after its use."
	icon = 'modular_skyrat/modules/implants/icons/implants.dmi'
	icon_state = "sandy"
	slot = ORGAN_SLOT_BRAIN_ANTISTUN
	zone = BODY_ZONE_HEAD
	implant_overlay = null
	implant_color = null
	actions_types = list(/datum/action/cooldown/sensory_enhancer)
	w_class = WEIGHT_CLASS_SMALL
	/// The bodypart overlay datum we should apply to whatever mob we are put into
	var/bodypart_overlay = /datum/bodypart_overlay/simple/sensory_enhancer
	/// What limb we are inside of, used for tracking when and how to remove our overlays and all that
	var/obj/item/bodypart/ownerlimb

/obj/item/organ/internal/cyberimp/sensory_enhancer/Insert(mob/living/carbon/receiver, special, drop_if_replaced)
	var/obj/item/bodypart/limb = receiver.get_bodypart(deprecise_zone(zone))

	. = ..()

	if(!.)
		return

	if(!limb)
		return FALSE

	ownerlimb = limb
	add_to_limb(ownerlimb)

	ADD_TRAIT(receiver, TRAIT_TWITCH_ADAPTED, TRAIT_NARCOTICS)

/obj/item/organ/internal/cyberimp/sensory_enhancer/Remove(mob/living/carbon/organ_owner, special, moving)
	. = ..()

	if(ownerlimb)
		remove_from_limb()
		if(!moving && use_mob_sprite_as_obj_sprite)
			update_appearance(UPDATE_OVERLAYS)

	if(organ_owner)
		organ_owner.update_body_parts()

	REMOVE_TRAIT(organ_owner, TRAIT_TWITCH_ADAPTED, TRAIT_NARCOTICS)

/obj/item/organ/internal/cyberimp/sensory_enhancer/add_to_limb(obj/item/bodypart/bodypart)
	ownerlimb = bodypart
	ownerlimb.add_bodypart_overlay(bodypart_overlay)
	return ..()

/obj/item/organ/internal/cyberimp/sensory_enhancer/remove_from_limb()
	ownerlimb.remove_bodypart_overlay(bodypart_overlay)
	ownerlimb = null
	return ..()

/obj/item/organ/internal/cyberimp/sensory_enhancer/Destroy()
	else if(ownerlimb)
		remove_from_limb()
	return ..()

/datum/bodypart_overlay/simple/sensory_enhancer
	icon = 'modular_skyrat/modules/implants/icons/implants_onmob.dmi'
	icon_state = "sandy"
	layers = EXTERNAL_ADJACENT

/datum/action/cooldown/sensory_enhancer
	name = "Activate Qani-Laaca System"
	desc = "Activates your Qani-Laaca computer and grants you its powers. LMB: Short, safer activation. RMB: Longer, more powerful, more dangerous activation."
	button_icon = 'modular_skyrat/modules/implants/icons/implants.dmi'
	button_icon_state = "sandy"
	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = 5 MINUTES
	text_cooldown = TRUE
	click_to_activate = TRUE

/datum/action/cooldown/sensory_enhancer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/our_implant = target
	if(our_implant.organ_flags & ORGAN_FAILING)
		to_chat(owner, span_warning("Your Qani-Laaca does nothing except spit back errors at you!"))
		return

	var/injection_amount = 10

	if(trigger_flags & TRIGGER_SECONDARY_ACTION)
		injection_amount = 20

	var/mob/living/carbon/human/human_owner = owner

	human_owner.reagents.add_reagent(/datum/reagent/drug/twitch, injection_amount)
	playsound(human_owner, 'sound/items/hypospray.ogg', 50, TRUE)

// Hackerman deck, lets you emag or doorjack things (NO CYBORGS) within a short range of yourself

/obj/item/organ/internal/cyberimp/hackerman_deck
	name = "Binyat wireless hacking system"
	desc = "A rare-to-find neural chip that allows its user to interface with nearby machinery \
		and effect it in (usually) beneficial ways. Due to the rudimentary connection, fine manipulation \
		isn't possible, however the deck will drop a payload into the target's systems that will attempt \
		hacking for you. Due to their complexity, the system does not appear to work on cyborgs."
	icon = 'modular_skyrat/modules/implants/icons/implants.dmi'
	icon_state = "hackerman"
	slot = ORGAN_SLOT_BRAIN_ANTISTUN
	zone = BODY_ZONE_HEAD
	implant_overlay = null
	implant_color = null
	actions_types = list(/datum/action/cooldown/spell/pointed/hackerman_deck)
	w_class = WEIGHT_CLASS_SMALL

/datum/action/cooldown/spell/pointed/hackerman_deck
	active_msg = "You warm up your Binyat deck, there's an idle buzzing at the back of your mind as it awaits a target."
	deactive_msg = "Your hacking deck makes an almost disappointed sounding buzz at the back of your mind as it powers down."
	cast_range = 2
	aim_assist = FALSE
	spell_max_level = 1 // God I hate actions
	cooldown_time = 5 MINUTES
	sparks_amt = 2
	/// What we change the icon of the mouse pointer to when we activate
	var/ranged_mousepointer = 'icons/effects/mouse_pointers/override_machine_target.dmi'

/datum/action/cooldown/spell/pointed/hackerman_deck/on_activation(mob/on_who)
	if(ranged_mousepointer)
		on_who.client?.mouse_override_icon = ranged_mousepointer
		on_who.update_mouse_pointer()

	. = ..()

/datum/action/cooldown/spell/pointed/hackerman_deck/on_deactivation(mob/on_who, refund_cooldown = TRUE)
	if(ranged_mousepointer)
		on_who.client?.mouse_override_icon = initial(owner.client?.mouse_pointer_icon)
		on_who.update_mouse_pointer()

	. = ..()

/datum/action/cooldown/spell/pointed/hackerman_deck/is_valid_target(atom/cast_on)
	. = ..()

	if(ismob(cast_on))
		return FALSE

	if(!cast_on.emag_act(owner))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/pointed/hackerman_deck/cast(atom/cast_on)
	. = ..()

	playsound(cast_on, 'sound/machines/terminal_processing.ogg', 15, TRUE)

	var/mob/living/carbon/human/human_owner = owner

	human_owner.adjust_bodytemperature(HACKERMAN_DECK_TEMPERATURE_INCREASE)

#undef HACKERMAN_DECK_TEMPERATURE_INCREASE
