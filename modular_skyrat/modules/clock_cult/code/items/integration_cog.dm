/obj/item/clockwork/integration_cog
	name = "integration cog"
	desc = "A small cog that seems to spin by its own acord when left alone."
	icon_state = "integration_cog"
	clockwork_hint = "A sharp cog that can cut through and be inserted into APCs to extract power for your machinery."

/obj/item/clockwork/integration_cog/attack_atom(atom/attacked_atom, mob/living/user, params)
	if(!(FACTION_CLOCK in user.faction))
		return ..()
	if(!istype(attacked_atom, /obj/machinery/power/apc))
		return ..()
	var/obj/machinery/power/apc/A = attacked_atom
	if(A.integration_cog)
		to_chat(user, span_brass("There is already \an [src] in [A]."))
		return
	if(!A.panel_open)
		//Cut open the panel
		to_chat(user, span_notice("You begin cutting open [A]."))
		if(!do_after(user, 5 SECONDS, target = A))
			return
		to_chat(user, span_brass("You cut open [A] with [src]."))
		A.panel_open = TRUE
		A.update_appearance()
		return
	//Insert the cog
	to_chat(user, span_notice("You begin inserting [src] into [A]."))
	if(!do_after(user, 4 SECONDS, target = A))
		return
	A.integration_cog = src
	forceMove(A)
	A.panel_open = FALSE
	A.update_appearance()
	to_chat(user, span_notice("You insert [src] into [A]."))
	playsound(get_turf(user), 'sound/machines/clockcult/integration_cog_install.ogg', 20)
	if(!A.clock_cog_rewarded)
		GLOB.clock_installed_cogs++
		A.clock_cog_rewarded = TRUE
		send_clock_message(user, span_brass(span_bold("[user] has installed an integration cog into \an [A].")))
		//Update the cog counts
		for(var/obj/item/clockwork/clockwork_slab/S as anything in GLOB.clockwork_slabs)
			S.update_integration_cogs()

/obj/machinery/power/apc
	/// If this APC has given a reward for being coggered before
	var/clock_cog_rewarded = FALSE
	/// Reference to the cog inside
	var/integration_cog = null

/obj/machinery/power/apc/Destroy()
	integration_cog = null //It's deleted when `contents` are handled
	return ..()

/obj/machinery/power/apc/examine(mob/user)
	. = ..()
	if(isliving(user))
		var/mob/living/living_user = user
		if(integration_cog || (living_user.has_status_effect(/datum/status_effect/hallucination) && prob(20)))
			. += span_brass("A small cogwheel is inside of it.")

/obj/machinery/power/apc/crowbar_act(mob/user, obj/item/crowbar)
	if(!opened)
		return ..()
	if(!integration_cog)
		return ..()
	to_chat(user, span_notice("You begin prying something out of [src]."))
	crowbar.play_tool_sound(src)
	if(!crowbar.use_tool(src, user, 5 SECONDS))
		return
	to_chat(user, span_warning("You screw up, breaking whatever was inside!"))
	QDEL_NULL(integration_cog)
