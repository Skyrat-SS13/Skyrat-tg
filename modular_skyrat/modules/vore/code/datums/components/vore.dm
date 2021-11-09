/datum/component/vore
	var/list/bellies = list()
	var/mob/living/owner

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

/datum/component/vore/proc/get_belly_contents(selected_belly, ref=FALSE, living=FALSE)
	var/obj/vbelly/belly = bellies[selected_belly]
	var/list/belly_contents = list()
	for (var/atom/movable/AM as anything in belly)
		if (living)
			if (!isliving(AM))
				continue
		if (ref)
			belly_contents[AM.name] = ref(AM) //ref(AM) returns a string that can be used in locate() to get that atom back
		else
			belly_contents += AM
	return belly_contents

/datum/component/vore/proc/update_bellies()
	if (!owner.client?.prefs?.vr_prefs)
		return
	var/datum/vore_prefs/vore = owner.client.prefs.vr_prefs
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
		AddComponent(/datum/component/vore)
		add_verb(src, /mob/living/proc/Ingest)
	else
		remove_verb(src, /mob/living/proc/Ingest)

/mob/living/proc/Ingest(mob/living/M in oview(1)) //this will get moved to an interaction or something, rather than a proc, before it gets merged, this is just so I can actually use it for the moment
	/* //turned off for debugging
	if (!client?.prefs?.vr_prefs?.vore_enabled || !M.client?.prefs?.vr_prefs?.vore_enabled)
		return
	if (!(M.client.prefs.vr_prefs & DEVOURABLE))
		to_chat(src, span_warning("[M] can't be eaten!"))
	*/
	var/datum/vore_prefs/vr = client.prefs.vr_prefs
	send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|is attempting|begin|begins| to [vr.get_belly_var("swallow_verb")] %a|[M]|[M]|you| into %a|their|your|their| [vr.get_belly_var("name")]!"), SEE_OTHER_MESSAGES, M)
	if (!do_after(src, 3 SECONDS, M))
		return
	var/datum/component/vore/vore = LoadComponent(/datum/component/vore)
	var/obj/vbelly/belly = vore?.bellies[client.prefs.vr_prefs.selected_belly]
	if (belly)
		send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|manages|manage|manages| to [vr.get_belly_var("swallow_verb")] %a|[M]|[M]|you| into %a|their|your|their| [vr.get_belly_var("name")]!"), SEE_OTHER_MESSAGES, M)
		M.forceMove(belly)
		SStgui.update_uis(vr)

