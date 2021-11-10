/datum/component/vore
	var/list/obj/vbelly/bellies = list()
	var/mob/living/owner
	var/tastes_of = "nothing in particular"
	var/vore_toggles = VORE_TOGGLES_DEFAULT
	var/selected_belly = 1
	var/vore_enabled = TRUE

/datum/component/vore/Initialize()
	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	owner = parent
	RegisterSignal(owner, COMSIG_PARENT_PREQDELETED, .proc/handle_delete)
	update_bellies()

/datum/component/vore/Destroy()
	UnregisterSignal(owner, COMSIG_PARENT_PREQDELETED)
	handle_delete()
	. = ..()

/datum/component/vore/proc/handle_delete()
	SIGNAL_HANDLER

	owner.release_belly_contents()

/datum/component/vore/proc/get_belly_contents(bellynum, ref=FALSE, living=FALSE, as_string=FALSE, ignored=null)
	if (bellynum < 1 || bellynum > bellies.len)
		return
	return bellies[bellynum].get_belly_contents(ref, living, as_string, ignored)

/datum/component/vore/proc/update_bellies()
	if (!owner.client?.prefs?.vr_prefs)
		return
	var/datum/vore_prefs/vore = owner.client.prefs.vr_prefs
	vore_toggles = vore.vore_toggles
	tastes_of = vore.tastes_of
	selected_belly = vore.selected_belly
	vore_enabled = vore.vore_enabled
	for (var/bellynum in 1 to vore.bellies.len)
		if (bellynum > bellies.len)
			var/obj/vbelly/belly = new(null, owner, vore.bellies[bellynum])
			bellies += belly
		else
			var/obj/vbelly/belly = bellies[bellynum]
			belly.set_data(vore.bellies[bellynum])

/datum/component/vore/proc/remove_belly(bellynum)
	var/obj/vbelly/belly = bellies[bellynum]
	belly.mass_release_from_contents()
	bellies -= bellies[bellynum]
	qdel(belly)

//this could probably go somewhere else
/mob/living/Login()
	. = ..()
	if (!. || !client)
		return

	if (client.prefs?.vr_prefs?.vore_enabled)
		var/datum/component/vore/vore = LoadComponent(/datum/component/vore)
		vore.update_bellies()
		add_verb(src, /mob/living/proc/Ingest)
	else
		remove_verb(src, /mob/living/proc/Ingest)

/mob/living/proc/Ingest(mob/living/prey in oview(1)) //this will get moved to an interaction or something, rather than a proc, before it gets merged, this is just so I can actually use it for the moment
	/* //turned off for debugging
	if (prey == src)
		return
	if (!client?.prefs?.vr_prefs?.vore_enabled || !prey.client?.prefs?.vr_prefs?.vore_enabled)
		return
	if (!(prey.client.prefs.vr_prefs & DEVOURABLE))
		to_chat(src, span_warning("[prey] can't be eaten!"))
	*/
	var/datum/component/vore/vore = LoadComponent(/datum/component/vore)
	send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|is attempting|begin|begins| to [vore.bellies[vore.selected_belly].swallow_verb] %a|[prey]|[prey]|you| into %a|their|your|their| [vore.bellies[vore.selected_belly].name]!"), SEE_OTHER_MESSAGES, prey)
	if (!do_after(src, VORE_EATING_TIME, prey))
		return
	var/obj/vbelly/belly = vore?.bellies[vore.selected_belly]
	if (belly)
		send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|manages|manage|manages| to [vore.bellies[vore.selected_belly].swallow_verb] %a|[prey]|[prey]|you| into %a|their|your|their| [vore.bellies[vore.selected_belly].name]!"), SEE_OTHER_MESSAGES, prey)
		prey.forceMove(belly)
		if (client?.prefs?.vr_prefs)
			SStgui.update_uis(client.prefs.vr_prefs)

/mob/living/proc/IngestInside(mob/living/prey, mob/living/inside_of)
	/* //turned off for debugging
	if (prey == src)
		return
	if (!client?.prefs?.vr_prefs?.vore_enabled || !prey.client?.prefs?.vr_prefs?.vore_enabled)
		return
	if (!(prey.client.prefs.vr_prefs & DEVOURABLE))
		to_chat(src, span_warning("[prey] can't be eaten!"))
	*/
	var/datum/component/vore/vore = LoadComponent(/datum/component/vore)
	var/datum/component/vore/pred_vore = inside_of.LoadComponent(/datum/component/vore)
	if (pred_vore.vore_toggles & SEE_OTHER_MESSAGES)
		to_chat(inside_of, span_warning("Someone inside of you is eating someone else!"))
	send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|is attempting|begin|begins| to [vore.bellies[vore.selected_belly].swallow_verb] %a|[prey]|[prey]|you| into %a|their|your|their| [vore.bellies[vore.selected_belly].name]!"), SEE_OTHER_MESSAGES, prey, audience=FALSE)
	if (!do_after(src, VORE_EATING_TIME, prey))
		return
	var/obj/vbelly/belly = vore?.bellies[vore.selected_belly]
	if (belly)
		if (pred_vore.vore_toggles & SEE_OTHER_MESSAGES)
			to_chat(inside_of, span_warning("Someone inside of you has eaten someone else!"))
		send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|manages|manage|manages| to [vore.bellies[vore.selected_belly].swallow_verb] %a|[prey]|[prey]|you| into %a|their|your|their| [vore.bellies[vore.selected_belly].name]!"), SEE_OTHER_MESSAGES, prey, audience=FALSE)
		prey.forceMove(belly)
		if (client?.prefs?.vr_prefs)
			SStgui.update_uis(client.prefs.vr_prefs)
