/datum/component/vore
	var/list/obj/vbelly/bellies = list()
	var/mob/living/owner
	var/char_vars
	var/vore_toggles = list()
	var/selected_belly = 1
	var/vore_enabled = TRUE
	var/current_slot

/datum/component/vore/Initialize()
	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	owner = parent
	if (ishuman(owner))
		var/mob/living/carbon/human/character = owner
		current_slot = character.character_slot
	RegisterSignal(owner, COMSIG_PARENT_PREQDELETED, .proc/handle_delete)
	update_bellies(TRUE)

/datum/component/vore/Destroy()
	UnregisterSignal(owner, COMSIG_PARENT_PREQDELETED)
	handle_delete()
	. = ..()

/datum/component/vore/proc/update_current_slot()
	if (!isnull(current_slot))
		return
	if (ishuman(owner))
		var/mob/living/carbon/human/character = owner
		current_slot = character.character_slot
		return
	current_slot = owner.client?.prefs.default_slot
	return current_slot

/datum/component/vore/proc/handle_delete()
	SIGNAL_HANDLER

	owner.release_belly_contents()

/datum/component/vore/proc/get_belly_contents(bellynum, ref=FALSE, living=FALSE, as_string=FALSE, ignored=null, full=FALSE)
	if (bellynum < 1 || bellynum > bellies.len)
		return
	return bellies[bellynum].get_belly_contents(ref, living, as_string, ignored, full)

/datum/component/vore/proc/update_bellies(set_ref=FALSE) //update everything
	if (!owner.client?.prefs?.vr_prefs)
		return
	var/datum/vore_prefs/vore = owner.client.prefs.vr_prefs
	vore_toggles = vore.vore_toggles
	char_vars = vore.char_vars
	selected_belly = vore.selected_belly
	vore_enabled = vore.vore_enabled
	for (var/bellynum in 1 to vore.bellies.len)
		var/belly_ref = (set_ref ? bellynum : null)
		if (bellynum > bellies.len)
			var/obj/vbelly/belly = new(null, owner, vore.bellies[bellynum], belly_ref)
			bellies += belly
		else
			var/obj/vbelly/belly = bellies[bellynum]
			belly.set_data(vore.bellies[bellynum], belly_ref)

/datum/component/vore/proc/update_belly(bellynum, data)
	bellies[bellynum].set_data(data)

/datum/component/vore/proc/remove_belly(bellynum)
	var/obj/vbelly/belly = bellies[bellynum]
	belly.mass_release_from_contents()
	bellies.Cut(bellynum, bellynum+1)
	qdel(belly)

//change this to mob/living once/if you make simplemob vore a thing
/mob/living/carbon/human/Login()
	. = ..()
	if (!. || !client)
		return
	update_vore_verbs()

/mob/living/Login()
	. = ..()
	if (!. || !client)
		return
	add_verb(src, /mob/living/proc/OOC_Escape)

/mob/living/proc/update_vore_verbs()
	if (client.prefs?.vr_prefs?.vore_enabled)
		var/datum/component/vore/vore = LoadComponent(/datum/component/vore)
		vore.update_bellies()
		add_verb(src, /mob/living/verb/Ingest)
	else
		remove_verb(src, /mob/living/verb/Ingest)

/mob/living/proc/OOC_Escape()
	set name = "OOC Escape"
	set category = "OOC"

	while(istype(loc, /obj/vbelly))
		var/obj/vbelly/belly = loc
		forceMove(belly.drop_location())

/mob/living/verb/Ingest(mob/living/prey in oview(1)) //this should be moved to some other way of doing things rather than a verb
	set name = "Vore Person"
	set category = "Vore"

	//I wonder if I should put a fun little animation here... probably not
	if (prey == src)
		return
	if (!prey.check_vore_toggle(DEVOURABLE, VORE_MECHANICS_TOGGLES))
		to_chat(src, span_warning("[prey] can't be eaten!"))
		return
	var/datum/component/vore/vore = LoadComponent(/datum/component/vore)
	send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|is attempting|begin|begins| to [vore.bellies[vore.selected_belly].swallow_verb] %a|[prey]|[prey]|you| into %a|[p_their()]|your|[p_their()]| [vore.bellies[vore.selected_belly].name]!"), SEE_OTHER_MESSAGES, prey=prey)
	if (!do_after(src, VORE_EATING_TIME, prey))
		return
	var/obj/vbelly/belly = vore?.bellies[vore.selected_belly]
	if (belly)
		send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|manages|manage|manages| to [vore.bellies[vore.selected_belly].swallow_verb] %a|[prey]|[prey]|you| into %a|[p_their()]|your|[p_their()]| [vore.bellies[vore.selected_belly].name]!"), SEE_OTHER_MESSAGES, prey=prey)
		prey.forceMove(belly)
		if (client?.prefs?.vr_prefs)
			SStgui.update_uis(client.prefs.vr_prefs)

/mob/living/proc/IngestInside(mob/living/prey, mob/living/inside_of, obj/vbelly/belly_inside)
	if (prey == src)
		return
	if (!prey.check_vore_toggle(DEVOURABLE, VORE_MECHANICS_TOGGLES))
		to_chat(src, span_warning("[prey] can't be eaten!"))
		return
	var/datum/component/vore/vore = LoadComponent(/datum/component/vore)
	vore_message(inside_of, "Someone inside of you is eating someone else!", SEE_OTHER_MESSAGES, VORE_CHAT_TOGGLES, warning=TRUE)
	send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|is attempting|begin|begins| to [vore.bellies[vore.selected_belly].swallow_verb] %a|[prey]|[prey]|you| into %a|[p_their()]|your|[p_their()]| [vore.bellies[vore.selected_belly].name]!"), SEE_OTHER_MESSAGES, prey=prey, only=belly_inside.get_belly_contents(living=TRUE))
	if (!do_after(src, VORE_EATING_TIME, prey))
		return
	var/obj/vbelly/belly = vore?.bellies[vore.selected_belly]
	if (belly)
		vore_message(inside_of, "Someone inside of you is eating someone else!", SEE_OTHER_MESSAGES, VORE_CHAT_TOGGLES, warning=TRUE)
		send_vore_message(src, span_warning("%a|[src]|You|[src]| %a|manages|manage|manages| to [vore.bellies[vore.selected_belly].swallow_verb] %a|[prey]|[prey]|you| into %a|[p_their()]|your|[p_their()]| [vore.bellies[vore.selected_belly].name]!"), SEE_OTHER_MESSAGES, prey=prey, only=belly_inside.get_belly_contents(living=TRUE))
		prey.forceMove(belly)
		if (client?.prefs?.vr_prefs)
			SStgui.update_uis(client.prefs.vr_prefs)
