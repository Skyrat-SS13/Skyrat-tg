#define TOOL_RUSTSCRAPER "RUST_SCRAPER"

/datum/component/rust
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/atom/parent_atom
	var/mutable_appearance/rust_overlay
	var/static/list/typecache_of_valid_types = list(
		/turf/closed/wall,
		/obj/machinery/door,
	)

/client/verb/MakeRusty(atom/A as turf in view(2))
	set name = "Rustify"
	set category = "OOC"
	stack_trace("I work!")
	A.AddComponent(/datum/component/rust)

/turf/closed/wall/rust/Initialize()
	var/atom/nwall = new /turf/closed/wall(loc)
	nwall._AddComponent(list(/datum/component/rust))
	return INITIALIZE_HINT_QDEL_FORCE

/turf/closed/wall/r_wall/rust/Initialize()
	var/atom/nwall = new /turf/closed/wall/r_wall(loc)
	nwall._AddComponent(list(/datum/component/rust))
	return INITIALIZE_HINT_QDEL_FORCE

/datum/component/rust/Initialize(...)
	. = ..()
	if(!(parent.type in typecache_of_valid_types) || !isatom(parent))
		return COMPONENT_INCOMPATIBLE
	parent_atom = parent
	if(!("rust" in icon_states(parent_atom.icon)) || parent_atom.GetExactComponent(/datum/component/rust))
		return COMPONENT_INCOMPATIBLE

	rust_overlay = mutable_appearance(parent_atom.icon, "rust")
	RegisterSignal(parent_atom, COMSIG_ATOM_UPDATE_OVERLAYS, .proc/apply_rust_overlay)
	RegisterSignal(parent_atom, COMSIG_ATOM_SECONDARY_TOOL_ACT(TOOL_WELDER), .proc/secondary_tool_act)
	RegisterSignal(parent_atom, COMSIG_ATOM_SECONDARY_TOOL_ACT(TOOL_RUSTSCRAPER), .proc/secondary_tool_act)
	RegisterSignal(parent_atom, COMSIG_PARENT_PREQDELETED, .proc/qdel, src)
	parent_atom.update_appearance()

/datum/component/rust/proc/apply_rust_overlay()
	SIGNAL_HANDLER
	parent_atom.add_overlay(rust_overlay)

/datum/component/rust/Destroy()
	parent_atom.cut_overlay(rust_overlay)
	UnregisterSignal(parent_atom, COMSIG_ATOM_UPDATE_OVERLAYS)
	UnregisterSignal(parent_atom, COMSIG_ATOM_SECONDARY_TOOL_ACT(TOOL_WELDER))
	UnregisterSignal(parent_atom, COMSIG_ATOM_SECONDARY_TOOL_ACT(TOOL_RUSTSCRAPER))
	UnregisterSignal(parent_atom, COMSIG_PARENT_PREQDELETED)
	parent_atom.update_appearance()
	rust_overlay = null
	parent_atom = null
	return ..()

/datum/component/rust/proc/handle_tool_use(atom/source, mob/user, obj/item/item)
	if(item.tool_behaviour == TOOL_WELDER)
		var/obj/item/weldingtool/WT = item
		if(WT.isOn() && WT.use(5))
			to_chat(user, span_notice("You begin to burn off the rust of [parent_atom]."))
			if(!do_after(user, 5 SECONDS, parent_atom))
				to_chat(user, span_notice("You change your mind."))
				return
			to_chat(user, span_notice("You burn off the rust of [parent_atom]."))
			qdel(src)
			return
	if(item.tool_behaviour == TOOL_RUSTSCRAPER)
		to_chat(user, span_notice("You begin to scrape the rust off of [parent_atom]."))
		if(!do_after(user, 2 SECONDS, parent_atom))
			to_chat(user, span_notice("You change your mind."))
			return
		to_chat(user, span_notice("You scrape the rust off of [parent_atom]."))
		qdel(src)
		return

/datum/component/rust/proc/secondary_tool_act(atom/source, mob/user, obj/item/item)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/handle_tool_use, source, user, item)
	return COMPONENT_BLOCK_TOOL_ATTACK
