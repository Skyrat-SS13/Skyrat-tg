#define MAX_POWER_PER_COG 250
#define HALLUCINATION_COG_CHANCE 20
#define SET_UP_TIME (5 MINUTES)

/obj/item/clockwork/integration_cog
	name = "integration cog"
	desc = "A small cog that seems to spin by its own acord when left alone."
	icon_state = "integration_cog"
	clockwork_desc = "A sharp cog that can cut through and be inserted into APCs to extract power for your machinery."
	/// If this cog has been set up, meaning that it is fully initialized (after APC insertion), granting a cog to the clock cultists
	var/set_up = FALSE


/obj/item/clockwork/integration_cog/attack_atom(atom/attacked_atom, mob/living/user, params)
	if(!(IS_CLOCK(user)) || !istype(attacked_atom, /obj/machinery/power/apc))
		return ..()

	var/obj/machinery/power/apc/cogger_apc = attacked_atom
	if(cogger_apc.integration_cog)
		balloon_alert(user, "already has a cog inside!")
		return

	if(!cogger_apc.panel_open)
		//Cut open the panel
		balloon_alert(user, "cutting open APC...")
		if(!do_after(user, 5 SECONDS, target = cogger_apc))
			return

		balloon_alert(user, "APC cut open")
		cogger_apc.panel_open = TRUE
		cogger_apc.update_appearance()
		return

	//Insert the cog
	balloon_alert(user, "inserting [src]...")
	if(!do_after(user, 4 SECONDS, target = cogger_apc))
		balloon_alert(user, "failed to insert [src]!")
		return

	cogger_apc.integration_cog = src
	forceMove(cogger_apc)
	cogger_apc.panel_open = FALSE
	cogger_apc.update_appearance()
	balloon_alert(user, "[src] inserted")
	playsound(get_turf(user), 'modular_skyrat/modules/clock_cult/sound/machinery/integration_cog_install.ogg', 20)
	if(!cogger_apc.clock_cog_rewarded)
		addtimer(CALLBACK(src, PROC_REF(finish_setup), cogger_apc), SET_UP_TIME)

		send_clock_message(null, span_brass(span_bold("[user] has installed an integration cog into [cogger_apc].")), msg_ghosts = FALSE)
		notify_ghosts("[user] has installed an integration cog into [cogger_apc]",
			source = user,
			action = NOTIFY_ORBIT,
			notify_flags = NOTIFY_CATEGORY_NOFLASH,
			header = "Integration cog",
		)


/// Finish setting up the cog 5 minutes after insertion
/obj/item/clockwork/integration_cog/proc/finish_setup(obj/machinery/power/apc/cogger_apc)
	if(!cogger_apc?.integration_cog)
		return

	set_up = TRUE
	GLOB.clock_installed_cogs++
	GLOB.max_clock_power += MAX_POWER_PER_COG
	cogger_apc.clock_cog_rewarded = TRUE
	//Update the cog counts
	for(var/obj/item/clockwork/clockwork_slab/slab as anything in GLOB.clockwork_slabs)
		slab.cogs++

	send_clock_message(null, span_brass(span_bold("[cogger_apc]'s integration cog has finished initialization.")), msg_ghosts = FALSE)


/obj/machinery/power/apc
	/// If this APC has given a reward for being coggered before
	var/clock_cog_rewarded = FALSE
	/// Reference to the cog inside
	var/obj/item/clockwork/integration_cog/integration_cog = null


/obj/machinery/power/apc/Destroy()
	if(integration_cog)
		QDEL_NULL(integration_cog)
	return ..()


/obj/machinery/power/apc/examine(mob/user)
	. = ..()
	if(isliving(user))
		var/mob/living/living_user = user
		if(integration_cog || (living_user.has_status_effect(/datum/status_effect/hallucination) && prob(HALLUCINATION_COG_CHANCE)))
			. += span_brass("A small cogwheel is inside of it.")

		if(integration_cog && IS_CLOCK(user))
			. += span_brass("The integration cog is [integration_cog.set_up ? "fully initialized" : "still initializing"].")


/obj/machinery/power/apc/crowbar_act(mob/user, obj/item/crowbar)
	if(!opened || !integration_cog)
		return ..()

	balloon_alert(user, "prying something out of [src]...")
	crowbar.play_tool_sound(src)
	if(!crowbar.use_tool(src, user, 5 SECONDS))
		return

	balloon_alert(user, "pried out something, destroying it!")
	QDEL_NULL(integration_cog)

#undef MAX_POWER_PER_COG
#undef HALLUCINATION_COG_CHANCE
#undef SET_UP_TIME
