/datum/design/board/self_actualization_device
	name = "Machine Design (Self-Actualization Device)"
	desc = "The circuit board for a Self-Actualization Device by Cinco: A Family Company."
	id = "self_actualization_device"
	build_path = /obj/item/circuitboard/machine/self_actualization_device
	category = list("Medical Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/obj/item/circuitboard/machine/self_actualization_device
	name = "Self-Actualization Device (Machine Board)"
	greyscale_colors = CIRCUIT_COLOR_MEDICAL
	build_path = /obj/machinery/self_actualization_device
	req_components = list(/obj/item/stock_parts/micro_laser = 1)

/obj/machinery/self_actualization_device
	name = "Self-Actualization Device"
	desc = "With the power of modern neurological scanning and synthflesh cosmetic surgery, the Morningstar corporation \
	has teamed up with the Cinco Chemical & Toy Division to bring you the Self-Actualization Device! \
	Ever revived a patient and had them file a malpractice lawsuit because their head got attached to the wrong body? \
	Just slap 'em in the SAD and turn it on! Their frown will turn upside down as they're reconstituted as their ideal self \
	via the magic technology of brain scanning! Within a few short moments, they'll be popped out as their ideal self, \
	ready to continue on with their day lawsuit-free! WARNING: KEEP AWAY FROM POTENTIAL SOURCES OF ELECTRO-MAGNETIC INTERFERENCE."
	icon = 'modular_skyrat/modules/self_actualization_device/icons/self_actualization_device.dmi'
	icon_state = "sad_open"
	circuit = /obj/item/circuitboard/machine/self_actualization_device
	state_open = FALSE
	density = TRUE
	var/processing = FALSE
	var/breakout_time = 10 SECONDS
	var/processing_time = 1 MINUTES
	var/next_fact = 10
	var/static/list/advertisements = list(\
	"Thank you for using the Self-Actualization Device, brought to you by Cinco: A Family Company!", \
	"The Self-Actualization device is not to be used by the elderly without direct adult supervision. Cinco is not liable for any and all injuries sustained under unsupervised usage of the Self-Actualization Device.", \
	"Please make sure to clean the Self-Actualization Device every fifteen minutes! The Self-Actualization Device is not to be used un-cleaned.", \
	"Before using the Self-Actualization Device, remove your teeth. You don't want your pearly whites getting in the way of the Self-Actualization Device!" , \
	"Please make sure to have your pre-Self Actualization Device brain-stimulating full-body gel lube session performed by a licensed lube man.", \
	"Have more questions about the Self-Actualization Device? Call your Cinco Mancierge to requisition more information about the Self-Actualization Device!" \
	)
	var/times_processed = 0

/obj/machinery/self_actualization_device/update_appearance(updates)
	. = ..()
	if(occupant)
		icon_state = processing ? "sad_on" : "sad_off"
	else
		icon_state = state_open ? "sad_open" : "sad_closed"



/obj/machinery/self_actualization_device/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/machinery/self_actualization_device/close_machine(mob/user)
	..()
	playsound(src, 'sound/machines/click.ogg', 50)
	if(occupant)
		if(!ishuman(occupant))
			occupant.forceMove(drop_location())
			set_occupant(null)
			return
		to_chat(occupant, span_notice("You enter [src]."))
		update_appearance()

/obj/machinery/self_actualization_device/examine(mob/user)
	. = ..()
	. += span_notice("ALT-Click to turn ON when closed.")

/obj/machinery/self_actualization_device/open_machine(mob/user)
	playsound(src, 'sound/machines/click.ogg', 50)
	..()

/obj/machinery/self_actualization_device/AltClick(mob/user)
	. = ..()
	if(powered() && occupant && !state_open)
		to_chat(user, "You power on [src].")
		addtimer(CALLBACK(src, .proc/eject_new_you), processing_time, TIMER_OVERRIDE|TIMER_UNIQUE)
		processing = TRUE
		update_appearance()

/obj/machinery/self_actualization_device/container_resist_act(mob/living/user)
	if(!state_open)
		to_chat(user, span_notice("The emergency release is not responding! You start pushing against the hull!"))
		user.changeNext_move(CLICK_CD_BREAKOUT)
		user.last_special = world.time + CLICK_CD_BREAKOUT
		user.visible_message(span_notice("You see [user] kicking against the door of [src]!"), \
			span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(breakout_time)].)"), \
			span_hear("You hear a metallic creaking from [src]."))
		if(do_after(user, breakout_time, target = src))
			if(!user || user.stat != CONSCIOUS || user.loc != src || state_open)
				return
			user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
				span_notice("You successfully break out of [src]!"))
			open_machine()
		return
	open_machine()

/obj/machinery/self_actualization_device/interact(mob/user)
	if(state_open)
		close_machine()
		return
	if(!processing)
		open_machine()
		return

/obj/machinery/self_actualization_device/process(delta_time)
	if(!processing)
		return
	if(!powered() || !occupant || !iscarbon(occupant))
		open_machine()
		return

	if(--next_fact <= 0)
		next_fact = rand(initial(next_fact), 2 * initial(next_fact))
		say(pick(advertisements))
		playsound(loc, 'sound/machines/chime.ogg', 30, FALSE)
	use_power(500)
/// Ejects the occupant as either their preference character, or as a monke based on emag status.
/obj/machinery/self_actualization_device/proc/eject_new_you()
	if(state_open || !occupant || !powered())
		return
	processing = FALSE
	if(ishuman(occupant))
		var/mob/living/carbon/human/patient = occupant
		var/original_name = patient.dna.real_name
		if(obj_flags & EMAGGED)
			patient.monkeyize()
		else
			patient?.client?.prefs?.safe_transfer_prefs_to(patient)
			patient.dna.update_dna_identity()
			log_game("[key_name(patient)] used a Self-Actualization Device at [loc_name(src)].")
			if(patient.dna.real_name != original_name)
				message_admins("[key_name_admin(patient)] has used the Self-Actualization Device, and changed the name of their character. \
				Original Name: [original_name], New Name: [patient.dna.real_name]. \
				This may be a false positive from changing from a humanized monkey into a character, so be careful.")
		open_machine()
		playsound(src, 'sound/machines/microwave/microwave-end.ogg', 100, FALSE)

/obj/machinery/self_actualization_device/screwdriver_act(mob/living/user, obj/item/I)
	. = TRUE
	if(..())
		return
	if(occupant)
		to_chat(user, span_warning("[src] is currently occupied!"))
		return
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		update_appearance()
		return
	return FALSE

/obj/machinery/self_actualization_device/crowbar_act(mob/living/user, obj/item/I)
	if(occupant)
		to_chat(user, span_warning("[src] is currently occupied!"))
		return
	if(default_deconstruction_crowbar(I))
		return TRUE

/obj/machinery/self_actualization_device/emag_act(mob/living/user)
	if(obj_flags & EMAGGED)
		return
	to_chat(user, span_notice("You scramble the brain reading circuits!"))
	obj_flags |= EMAGGED
