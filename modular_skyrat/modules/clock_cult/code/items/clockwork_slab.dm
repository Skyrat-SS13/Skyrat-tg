#define MAXIMUM_QUICKBIND_SLOTS 5

GLOBAL_LIST_INIT(clockwork_slabs, list())


/obj/item/clockwork
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	/// Extra info to give clock cultists, added via the /datum/element/clockwork_description element
	var/clockwork_desc = ""


/obj/item/clockwork/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/clockwork_description, clockwork_desc)
	AddElement(/datum/element/clockwork_pickup)


/obj/item/clockwork/clockwork_slab
	name = "Clockwork Slab"
	desc = "A mechanical-looking device filled with intricate cogs that swirl to their own accord."
	clockwork_desc = "A beautiful work of art, harnessing mechanical energy for a variety of useful powers."
	item_flags = NOBLUDGEON
	icon_state = "clockwork_slab"
	lefthand_file = 'modular_skyrat/modules/clock_cult/icons/weapons/clockwork_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/clock_cult/icons/weapons/clockwork_righthand.dmi'

	/// The scripture currently being invoked
	var/datum/scripture/invoking_scripture
	/// For scriptures that power the slab
	var/datum/scripture/slab/active_scripture
	/// What overlay the slab should use, should the active scripture have one
	var/charge_overlay

	/// How many cogs this slab has currently
	var/cogs = 0
	/// A list of what scriptures that this slab has purchased
	var/list/purchased_scriptures = list()

	//Initialise an empty list for quickbinding
	var/list/quick_bound_scriptures = list(
		1 = null,
		2 = null,
		3 = null,
		4 = null,
		5 = null,
	)

	//The default scriptures that get auto-assigned.
	var/list/default_scriptures = list()

	//For trap linkage
	var/datum/component/clockwork_trap/buffer


/obj/item/clockwork/clockwork_slab/Initialize(mapload)
	. = ..()
	if(!length(GLOB.clock_scriptures) || !length(GLOB.clock_scriptures_by_type))
		generate_clockcult_scriptures()

	var/pos = 1
	cogs = GLOB.clock_installed_cogs
	GLOB.clockwork_slabs += src
	for(var/script in default_scriptures)
		if(!script)
			continue

		purchased_scriptures += script
		var/datum/scripture/default_script = GLOB.clock_scriptures_by_type[script]
		bind_spell(null, default_script, pos++)


/obj/item/clockwork/clockwork_slab/Destroy()
	GLOB.clockwork_slabs -= src
	invoking_scripture = null
	active_scripture = null
	buffer = null
	return ..()


/obj/item/clockwork/clockwork_slab/dropped(mob/user)
	. = ..()
	//Clear quickbinds
	for(var/datum/action/innate/clockcult/quick_bind/script as anything in quick_bound_scriptures)
		script?.Remove(user)

	if(active_scripture)
		active_scripture?.end_invocation()

	if(buffer)
		buffer = null


/obj/item/clockwork/clockwork_slab/pickup(mob/user)
	. = ..()
	if(!IS_CLOCK(user))
		return

	//Grant quickbound spells
	for(var/datum/action/innate/clockcult/quick_bind/script as anything in quick_bound_scriptures)
		script?.Grant(user)

	user.update_action_buttons()


/obj/item/clockwork/clockwork_slab/update_overlays()
	. = ..()
	cut_overlays()
	if(charge_overlay)
		add_overlay(charge_overlay)


/// Handle binding a spell to a quickbind slot
/obj/item/clockwork/clockwork_slab/proc/bind_spell(mob/living/binder, datum/scripture/spell, position = 1)
	if((position > length(quick_bound_scriptures)) || (position <= 0))
		return

	if(quick_bound_scriptures[position])
		//Unbind the scripture that is quickbound
		qdel(quick_bound_scriptures[position])

	//Put the quickbound action onto the slab, the slab should grant when picked up
	var/datum/action/innate/clockcult/quick_bind/quickbound = new(src)
	quickbound.scripture = spell
	quickbound.slab_weakref = WEAKREF(src)
	quick_bound_scriptures[position] = quickbound
	if(binder)
		quickbound.Grant(binder)

// UI things below

/obj/item/clockwork/clockwork_slab/attack_self(mob/living/user)
	if(!IS_CLOCK(user))
		to_chat(user, span_warning("You cannot figure out what the device is used for!"))
		return

	if(active_scripture)
		active_scripture.end_invocation()
		return

	if(buffer)
		buffer = null
		to_chat(user, span_brass("You clear the [src]'s buffer."))
		return

	SEND_SIGNAL(user, COMSIG_CLOCKWORK_SLAB_USED, src)

	ui_interact(user)

/obj/item/clockwork/clockwork_slab/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ClockworkSlab")
		ui.open()

/obj/item/clockwork/clockwork_slab/ui_data(mob/user)
	var/list/data = list()

	data["cogs"] = cogs
	data["vitality"] = GLOB.clock_vitality
	data["max_vitality"] = GLOB.max_clock_vitality
	data["power"] = GLOB.clock_power
	data["max_power"] = GLOB.max_clock_power
	data["scriptures"] = list()

	//2 scriptures accessible at the same time will cause issues
	for(var/datum/scripture/scripture as anything in GLOB.clock_scriptures)
		var/list/scripture_data = list(
			"name" = scripture.name,
			"desc" = scripture.desc,
			"type" = scripture.category,
			"tip" = scripture.tip,
			"cost" = scripture.power_cost,
			"purchased" = (scripture.type in purchased_scriptures),
			"cog_cost" = scripture.cogs_required,
			"typepath" = scripture.type,
			"research_required" = !!(scripture.research_required ? !(scripture.type in GLOB.clockwork_research_unlocked_scriptures) : FALSE),
		)
		//Add it to the correct list
		data["scriptures"] += list(scripture_data)

	return data


/obj/item/clockwork/clockwork_slab/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/mob/living/living_user = usr
	if(!istype(living_user))
		return FALSE

	switch(action)
		if("invoke")
			var/datum/scripture/scripture = GLOB.clock_scriptures_by_type[text2path(params["scriptureType"])]
			if(!scripture)
				return FALSE

			if(scripture.type in purchased_scriptures)
				if(invoking_scripture)
					living_user.balloon_alert(living_user, "failed to invoke!")
					return FALSE

				if(scripture.power_cost > GLOB.clock_power)
					living_user.balloon_alert(living_user, "[display_energy(scripture.power_cost)] required!")
					return FALSE

				if(scripture.vitality_cost > GLOB.clock_vitality)
					living_user.balloon_alert(living_user, "[display_energy(scripture.vitality_cost)] vitality required!")
					return FALSE

				scripture.begin_invoke(living_user, src)

			else
				if(scripture.research_required && !(scripture.type in GLOB.clockwork_research_unlocked_scriptures))
					living_user.balloon_alert(living_user, "research required!")
					return FALSE

				if(cogs >= scripture.cogs_required)
					cogs -= scripture.cogs_required
					living_user.balloon_alert(living_user, "[scripture.name] purchased")
					log_game("[scripture.name] purchased by [living_user.ckey]/[living_user.name] the [living_user.job] for [scripture.cogs_required] cogs, [cogs] cogs remaining.")
					purchased_scriptures += scripture.type

				else
					living_user.balloon_alert(living_user, "need at least [scripture.cogs_required]!")

			return TRUE


		if("quickbind")
			var/datum/scripture/scripture = GLOB.clock_scriptures_by_type[text2path(params["scriptureType"])]
			if(!scripture)
				return FALSE

			var/list/positions = list()
			for(var/i in 1 to MAXIMUM_QUICKBIND_SLOTS)
				var/datum/scripture/quick_bound = quick_bound_scriptures[i]
				if(!quick_bound)
					positions += "([i])"

				else
					positions += "([i]) - [quick_bound.name]"

			var/position = tgui_input_list(living_user, "Where to quickbind to?", "Quickbind Slot", positions)
			if(!position)
				return FALSE

			// Assign the quickbind
			bind_spell(living_user, scripture, positions.Find(position))

#undef MAXIMUM_QUICKBIND_SLOTS
