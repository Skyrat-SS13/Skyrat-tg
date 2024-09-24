/// Possible states of player consent for using the machine.
#define NO_CONSENT 0
#define CONSENT_GRANTED 1
#define WAITING_PLAYER 2
/// How long does it take to break out of the machine?
#define BREAKOUT_TIME 5 SECONDS
/// The interval that advertisements are said by the machine's speaker.
#define ADVERT_TIME 18 SECONDS

/datum/design/board/self_actualization_device
	name = "Machine Design (Self-Actualization Device)"
	desc = "The circuit board for a Self-Actualization Device by Veymed: A Family Company."
	id = "self_actualization_device"
	build_path = /obj/item/circuitboard/machine/self_actualization_device
	category = list(RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_MEDICAL)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/obj/item/circuitboard/machine/self_actualization_device
	name = "Self-Actualization Device (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/self_actualization_device
	req_components = list(/datum/stock_part/micro_laser = 1)

/obj/machinery/self_actualization_device
	name = "Self-Actualization Device"
	desc = "A state of the art medical device that can restore someone's physical appearance to the last known DNA database backup."
	icon = 'modular_skyrat/modules/self_actualization_device/icons/self_actualization_device.dmi'
	icon_state = "sad_open"
	circuit = /obj/item/circuitboard/machine/self_actualization_device
	state_open = FALSE
	density = TRUE
	/// Is someone being processed inside of the machine?
	var/processing = FALSE
	/// How long does the machine take to work?
	var/processing_time = 1 MINUTES
	/// wzhzhzh
	var/datum/looping_sound/microwave/sound_loop
	/// Has the player consented to the DNA change
	var/player_consent = NO_CONSENT
	/// A list containing advertisements that the machine says while working.
	var/static/list/advertisements = list(\
	"Thank you for using the Self-Actualization Device, brought to you by Veymed, because you asked for it.", \
	"The Self-Actualization device is not to be used by the elderly without direct adult supervision. Veymed is not liable for any and all injuries sustained under unsupervised usage of the Self-Actualization Device.", \
	"The Self-Actualization Device is not to be used un-cleaned. Thanks to its non-stick coating, cleaning up after a failed rejuvenation is easy as cleaning a microwave. Blood just doesn't stick!", \
	"Before using the Self-Actualization Device, remove any and all metal devices, or you might make the term 'ironman' a bit too literal!" , \
	"Remember, this is not cloning! Self-Actualization is a legally distinct, Veymed patent pending procedure. Still have questions? Call your nearest Veymed Representative to requisition more information about the Self-Actualization Device!" , \
	"Coming soon... Self-Actualization Device: Colony Fabricator Edition! Flat-packed and better in every way, with no medical expertise required! It's so easy, it's like cheating! Contact your nearest Veymed Representative to find out more!" \
	)
	COOLDOWN_DECLARE(advert_time)
	COOLDOWN_DECLARE(sad_processing_time)

/obj/machinery/self_actualization_device/examine_more(mob/user)
	. = ..()

	. += "With the power of modern neurological scanning and synthflesh cosmetic surgery, the Veymed Corporation \
		has teamed up with Nanotrasen Human Resources (and elsewise)  to bring you the Self-Actualization Device! \
		Ever revived a patient and had them file a malpractice lawsuit because their head got attached to the wrong body? \
		Just slap 'em in the SAD and turn it on! Their frown will turn upside down as they're reconstituted as their ideal self \
		via the magic technology of brain scanning! Within a few short moments, they'll be popped out as their ideal self, \
		ready to continue on with their day lawsuit-free!"

	return .

/obj/machinery/self_actualization_device/Initialize(mapload)
	. = ..()
	sound_loop = new(src, FALSE)
	register_context()
	update_appearance()

/obj/machinery/self_actualization_device/Destroy()
	QDEL_NULL(sound_loop)
	return ..()

/obj/machinery/self_actualization_device/update_appearance(updates)
	. = ..()
	if(isnull(occupant))
		icon_state = state_open ? "sad_open" : "sad_empty"
	else
		switch(player_consent)
			if(WAITING_PLAYER)
				icon_state = "sad_validating"
			if(CONSENT_GRANTED)
				icon_state = "sad_on"
			if(NO_CONSENT)
				icon_state = "sad_occupied"

/obj/machinery/self_actualization_device/close_machine(atom/movable/target, density_to_set = TRUE)
	..()
	playsound(src, 'sound/machines/click.ogg', 50)
	if(!occupant)
		return FALSE
	if(!ishuman(occupant))
		occupant.forceMove(drop_location())
		set_occupant(null)
		return FALSE
	to_chat(occupant, span_notice("You enter [src]."))
	addtimer(CALLBACK(src, PROC_REF(get_consent)), 4 SECONDS, TIMER_OVERRIDE|TIMER_UNIQUE)
	update_appearance()

/obj/machinery/self_actualization_device/examine(mob/user)
	. = ..()
	. += span_info("Laser power <b>[display_power(active_power_usage)]</b> at average cycle time of <b>[DisplayTimeText(processing_time)]</b>.")

	if(processing)
		. += span_notice("The status display indicates <b>[DisplayTimeText(COOLDOWN_TIMELEFT(src, sad_processing_time), 2)]</b> remaining on the current cycle.")
	else
		. += span_notice("Left-click to <b>[state_open ? "close" : "open"]</b>.")
		if(!isnull(occupant) && !state_open)
			. += span_notice("<b>Alt-click</b> to turn on.")

/obj/machinery/self_actualization_device/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	if(!processing)
		context[SCREENTIP_CONTEXT_LMB] = "[state_open ? "Close" : "Open"] machine"
	if(!isnull(occupant) && !state_open && !processing)
		context[SCREENTIP_CONTEXT_ALT_LMB] = "Start machine"

	return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/self_actualization_device/interact(mob/user)
	if(state_open)
		close_machine()
		return

	if(!processing)
		open_machine()
		return

/obj/machinery/self_actualization_device/click_alt(mob/user)
	if(!powered() || !occupant || state_open || processing)
		return CLICK_ACTION_BLOCKING

	user.visible_message(span_notice("[user] presses the start button of the [src]."), span_notice("You press the start button of the [src]."))
	get_consent()
	return CLICK_ACTION_SUCCESS

/obj/machinery/self_actualization_device/process(seconds_per_tick)
	if(!processing)
		return

	if(!powered() && occupant && processing)
		eject_old_you(damaged_goods = TRUE)
		return

	if(!powered() || !occupant || !iscarbon(occupant))
		open_machine()
		return

	if(player_consent != CONSENT_GRANTED) // breakout
		processing = FALSE
		return

	if(COOLDOWN_FINISHED(src, sad_processing_time))
		eject_new_you()
		return

	if(COOLDOWN_FINISHED(src, advert_time))
		COOLDOWN_START(src, advert_time, rand(ADVERT_TIME, ADVERT_TIME * 2))
		say(pick(advertisements))
		playsound(loc, 'sound/machines/chime.ogg', 30, FALSE)

	use_energy(active_power_usage)

/// Asks the player if they want to consent to the rejuvenation procedure (replacing their DNA with what they currently have selected in character preferences.)
/obj/machinery/self_actualization_device/proc/get_consent()
	if(state_open || !occupant || !powered())
		return

	if(!ishuman(occupant))
		return

	if(player_consent != NO_CONSENT)
		return

	playsound(loc, 'sound/machines/chime.ogg', 30, FALSE)
	say("Procedure validation in progress...")
	var/mob/living/carbon/human/human_occupant = occupant
	if(!isnull(human_occupant.ckey) && isnull(human_occupant.client)) // player mob, currently disconnected
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		say("ERROR: Validation failed: No elicited response from occupant genes. Subject may be suffering from Sudden Sleep Disorder.")
		return

	player_consent = WAITING_PLAYER
	update_appearance()

	// defaults to rejecting it unless specified otherwise
	if(tgui_alert(occupant, "The SAD you are within is about to rejuvenate you, resetting your body to its default state (in character preferences). Do you consent?", "Rejuvenate", list("Yes", "No"), timeout = 10 SECONDS) == "Yes")
		player_consent = CONSENT_GRANTED
		say("Starting procedure! Baking for a cycle time of [DisplayTimeText(processing_time)] at laser power [display_power(active_power_usage)].")
		to_chat(occupant, span_warning("This will take [DisplayTimeText(processing_time)] to complete. To cancel the procedure, hit the RESIST button or hotkey."))
		set_light(l_range = 1.5, l_power = 1.2, l_on = TRUE)
		sound_loop.start()
		COOLDOWN_START(src, sad_processing_time, processing_time)
		COOLDOWN_START(src, advert_time, rand(ADVERT_TIME * 0.75, ADVERT_TIME * 1.25))
		processing = TRUE
		update_appearance()
	else
		player_consent = NO_CONSENT
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		say("ERROR: Validation failed: Occupant genes have willfully rejected the procedure. You may try again if you think this was an error.")
		update_appearance()

/// Ejects the occupant after asking them if they want to accept the rejuvenation. If yes, they exit as their preferences character.
/obj/machinery/self_actualization_device/proc/eject_new_you()
	player_consent = NO_CONSENT
	set_light(l_on = FALSE)
	sound_loop.stop()
	processing = FALSE
	if(state_open || !occupant || !powered())
		return

	var/mob/living/carbon/human/patient = occupant
	var/original_name = patient.dna.real_name

	patient.client?.prefs?.safe_transfer_prefs_to_with_damage(patient)
	patient.dna.update_dna_identity()
	SSquirks.AssignQuirks(patient, patient.client)
	log_game("[key_name(patient)] used a Self-Actualization Device at [loc_name(src)].")

	if(patient.dna.real_name != original_name)
		message_admins("[key_name_admin(patient)] has used the Self-Actualization Device, and changed the name of their character. \
		Original Name: [original_name], New Name: [patient.dna.real_name]. \
		This may be a false positive from changing from a humanized monkey into a character, so be careful.")
	else
		message_admins("[key_name_admin(patient)] has used the Self-Actualization Device, and potentially changed their quirks. \
		This may be a false positive from restoring an altered body of the same name, so be careful.")

	playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, FALSE)
	say("Procedure complete! Enjoy your life being a new you!")

	open_machine()

/// Ejection and shut down of the machine, used before the preferences have been applied to the player. Damage optional.
/obj/machinery/self_actualization_device/proc/eject_old_you(damaged_goods = FALSE)
	player_consent = NO_CONSENT
	set_light(l_on = FALSE)
	sound_loop.stop()
	processing = FALSE

	if(damaged_goods)
		var/mob/living/carbon/human/victim_living = occupant
		var/damage = (rand(75, 150))
		victim_living.emote("scream")
		victim_living.apply_damage(0.2 * damage, BURN, BODY_ZONE_HEAD, wound_bonus = 7)
		victim_living.apply_damage(0.4 * damage, BURN, BODY_ZONE_CHEST, wound_bonus = 21)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_L_LEG, wound_bonus = 14)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_R_LEG, wound_bonus = 14)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_L_ARM, wound_bonus = 14)
		victim_living.apply_damage(0.10 * damage, BURN, BODY_ZONE_R_ARM, wound_bonus = 14)
		victim_living.visible_message(span_warning("[src] shuts down, forcefully ejecting [victim_living]!"), span_danger("The [src] shuts down mid-procedure! That can't be good..."))

	open_machine()

/// The player can break out of the SAD if they've changed their mind about using it.
/obj/machinery/self_actualization_device/container_resist_act(mob/living/user)
	if(state_open)
		return

	if(COOLDOWN_TIMELEFT(src, sad_processing_time) < BREAKOUT_TIME)
		to_chat(user, span_warning("The emergency release is not responding! You start pushing against the door, but you feel your body changing... It's too late!"))
		return

	to_chat(user, span_notice("The emergency release is not responding! You start pushing against the door!"))
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("You see [user] kicking against the door of [src]!"), \
		span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(BREAKOUT_TIME)].)"), \
		span_hear("You hear a metallic creaking from [src]."))
	user.emote("scream")

	if(do_after(user, BREAKOUT_TIME, target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src || state_open)
			return
		user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
			span_notice("You successfully break out of [src]!"))
		eject_old_you(damaged_goods = TRUE)

/obj/machinery/self_actualization_device/screwdriver_act(mob/living/user, obj/item/used_item)
	. = TRUE
	if(..())
		return

	if(occupant)
		to_chat(user, span_warning("[src] is currently occupied!"))
		return

	if(default_deconstruction_screwdriver(user, icon_state, icon_state, used_item))
		update_appearance()
		return

	return FALSE

/obj/machinery/self_actualization_device/crowbar_act(mob/living/user, obj/item/used_item)
	if(occupant)
		to_chat(user, span_warning("[src] is currently occupied!"))
		return

	if(default_deconstruction_crowbar(used_item))
		return TRUE

/obj/machinery/self_actualization_device/RefreshParts()
	. = ..()
	processing_time = 70 SECONDS
	for(var/datum/stock_part/micro_laser/laser in component_parts) // Laser tier increases speed, at the expense of power.
		processing_time -= laser.tier * 10 SECONDS
		active_power_usage = 7200000 / processing_time WATTS
		idle_power_usage = active_power_usage / 4

#undef NO_CONSENT
#undef CONSENT_GRANTED
#undef WAITING_PLAYER
#undef BREAKOUT_TIME
#undef ADVERT_TIME
