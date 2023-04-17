/obj/structure/destructible/clockwork/gear_base/technologists_lectern
	name = "lectern"
	desc = "A small pedestal with a glowing book floating over it.."
	clockwork_desc = "A small pedestal, glowing with a divine energy. Used to research new abilities and objects."
	base_icon_state = "lectern"
	icon_state = "lectern"
	anchored = TRUE
	break_message = "<span class='warning'>The stargazer collapses.</span>"
	/// If the last process() found a clock cultist in range
	var/mobs_in_range = FALSE
	/// Ref to the mutable appearance of the lectern's book
	var/mutable_appearance/lectern_light

// Base procs
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/Initialize(mapload)
	. = ..()
	lectern_light = mutable_appearance('modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi', "lectern_closed", FLY_LAYER, alpha = 160)
	lectern_light.pixel_y = 24 // check me later
	add_overlay(lectern_light)
	START_PROCESSING(SSobj, src)


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/process()
	var/mob_nearby = FALSE
	for(var/mob/living/person in viewers(2, get_turf(src)))
		if(IS_CLOCK(person))
			mob_nearby = TRUE
			break

	if(mob_nearby && !mobs_in_range)
		open_book()
		mobs_in_range = TRUE

	else if(!mob_nearby && mobs_in_range)
		close_book()
		mobs_in_range = FALSE


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/attack_hand(mob/living/user, list/modifiers)
	if(!IS_CLOCK(user))
		return ..()

	if(!anchored)
		balloon_alert(user, "not fastened!")
		return

	ui_interact(user)


// UI code
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ClockworkResearch")
		ui.open()


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/ui_data(mob/user)
	var/list/data = list()

	return data

/obj/structure/destructible/clockwork/gear_base/technologists_lectern/ui_static_data(mob/user)
	var/list/data = list()
	data["research"] = list()
	for(var/datum/clockwork_research/research as anything in GLOB.clockwork_research)
		var/list/research_data = list(
			"name" = research.name,
			"desc" = research.desc,
			"researched" = research.researched,
			"starting" = research.starting,
		)
		data["research"] += list(research_data)
	return data

// Custom procs

/// Open the book overlay
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/open_book()
	lectern_light.icon_state = "lectern_open"
	flick("lectern_opening", lectern_light)


/// Close the book overlay
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/close_book()
	lectern_light.icon_state = "lectern_closed"
	flick("lectern_closing", lectern_light)


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/populate_research()
	for(var/type in subtypesof(/datum/clockwork_research))
		GLOB.clockwork_research += new type
