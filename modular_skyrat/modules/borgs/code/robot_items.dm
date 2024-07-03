/// Use this file to add STANDARD ITEMS to borgs, the upgrade items will go in the modular robot_upgrade.dm

/*
*	CARGO BORGS
*/

#define CYBORG_FONT "Consolas"
#define MAX_PAPER_INTEGRATED_CLIPBOARD 10

/obj/item/pen/cyborg
	name = "integrated pen"
	font = CYBORG_FONT
	desc = "You can almost hear the sound of gears grinding against one another as you write with this pen. Almost."


/obj/item/clipboard/cyborg
	name = "\improper integrated clipboard"
	desc = "A clipboard which seems to come adapted with a paper synthetizer, carefully hidden in its paper clip."
	integrated_pen = TRUE
	/// When was the last time the printer was used?
	COOLDOWN_DECLARE(printer_cooldown)
	/// How long is the integrated printer's cooldown?
	var/printer_cooldown_time = 10 SECONDS
	/// How much charge is required to print a piece of paper?
	var/paper_charge_cost = STANDARD_CELL_CHARGE * 0.05


/obj/item/clipboard/cyborg/Initialize(mapload)
	. = ..()
	pen = new /obj/item/pen/cyborg


/obj/item/clipboard/cyborg/examine()
	. = ..()
	. += "Alt-click to synthesize a piece of paper."
	if(!COOLDOWN_FINISHED(src, printer_cooldown))
		. += "Its integrated paper synthesizer seems to still be on cooldown."


/obj/item/clipboard/cyborg/click_alt(mob/user)
	if(!iscyborg(user))
		to_chat(user, span_warning("You do not seem to understand how to use [src]."))
		return CLICK_ACTION_BLOCKING
	var/mob/living/silicon/robot/cyborg_user = user
	// Not enough charge? Tough luck.
	if(cyborg_user?.cell.charge < paper_charge_cost)
		to_chat(user, span_warning("Your internal cell doesn't have enough charge left to use [src]'s integrated printer."))
		return CLICK_ACTION_BLOCKING
	// Check for cooldown to avoid paper spamming
	if(COOLDOWN_FINISHED(src, printer_cooldown))
		// If there's not too much paper already, let's go
		if(!toppaper_ref || length(contents) < MAX_PAPER_INTEGRATED_CLIPBOARD)
			cyborg_user.cell.use(paper_charge_cost)
			COOLDOWN_START(src, printer_cooldown, printer_cooldown_time)
			var/obj/item/paper/new_paper = new /obj/item/paper
			new_paper.forceMove(src)
			if(toppaper_ref)
				var/obj/item/paper/toppaper = toppaper_ref?.resolve()
				UnregisterSignal(toppaper, COMSIG_ATOM_UPDATED_ICON)
			RegisterSignal(new_paper, COMSIG_ATOM_UPDATED_ICON, PROC_REF(on_top_paper_change))
			toppaper_ref = WEAKREF(new_paper)
			update_appearance()
			to_chat(user, span_notice("[src]'s integrated printer whirs to life, spitting out a fresh piece of paper and clipping it into place."))
			return CLICK_ACTION_SUCCESS
		else
			to_chat(user, span_warning("[src]'s integrated printer refuses to print more paper, as [src] already contains enough paper."))
	else
		to_chat(user, span_warning("[src]'s integrated printer refuses to print more paper, its bluespace paper synthesizer not having finished recovering from its last synthesis."))
	return CLICK_ACTION_BLOCKING


/obj/item/hand_labeler/cyborg
	name = "integrated hand labeler"
	labels_left = 9000 // I don't want to bother forcing them to recharge, honestly, that's a lot of code for a very niche functionality


/// THE CLAMPS!!
/obj/item/borg/hydraulic_clamp
	name = "integrated hydraulic clamp"
	desc = "A neat way to lift and move around few small packages for quick and painless deliveries!"
	icon = 'icons/obj/devices/mecha_equipment.dmi' // Just some temporary sprites because I don't have any unique one yet
	icon_state = "mecha_clamp"
	/// How much power does it draw per operation?
	var/charge_cost = STANDARD_CELL_CHARGE * 0.02
	/// How many items can it hold at once in its internal storage?
	var/storage_capacity = 5
	/// Does it require the items it takes in to be wrapped in paper wrap? Can have unforeseen consequences, change to FALSE at your own risks.
	var/whitelisted_contents = TRUE
	/// What kind of wrapped item can it hold, if `whitelisted_contents` is set to true?
	var/list/whitelisted_item_types = list(/obj/item/delivery/small, /obj/item/bounty_cube)
	/// A short description used when the check to pick up something has failed.
	var/whitelisted_item_description = "small wrapped packages"
	/// Weight limit on the items it can hold. Leave as NONE if there isn't.
	var/item_weight_limit = WEIGHT_CLASS_SMALL
	/// Can it hold mobs? (Dangerous, it is recommended to leave this to FALSE)
	var/can_hold_mobs = FALSE
	/// Audio for using the hydraulic clamp.
	var/clamp_sound = 'sound/mecha/hydraulic.ogg'
	/// Volume of the clamp's loading and unloading noise.
	var/clamp_sound_volume = 25
	/// Cooldown for the clamp.
	COOLDOWN_DECLARE(clamp_cooldown)
	/// How long is the clamp on cooldown for after every usage?
	var/cooldown_duration = 0.5 SECONDS
	/// How long does it take to load in an item?
	var/loading_time = 2 SECONDS
	/// How long does it take to unload an item?
	var/unloading_time = 1 SECONDS
	/// Is it currently in use?
	var/in_use = FALSE
	/// Index of the item we want to take out of the clamp, 0 if nothing selected.
	var/selected_item_index = 0
	/// Weakref to the cyborg we're currently connected to.
	var/datum/weakref/cyborg_holding_me


/obj/item/borg/hydraulic_clamp/Initialize(mapload)
	. = ..()
	if(!istype(loc, /obj/item/robot_model))
		return

	var/obj/item/robot_model/holder_model = loc
	cyborg_holding_me = WEAKREF(holder_model.robot)

	RegisterSignal(holder_model.robot, COMSIG_LIVING_DEATH, PROC_REF(empty_contents))


/obj/item/borg/hydraulic_clamp/Destroy()
	var/mob/living/silicon/robot/robot_holder = cyborg_holding_me?.resolve()
	if(robot_holder)
		UnregisterSignal(robot_holder, COMSIG_LIVING_DEATH)
	return ..()


/obj/item/borg/hydraulic_clamp/examine(mob/user)
	. = ..()
	. += span_notice("It's cargo hold has a capacity of [storage_capacity] and is currently holding <b>[contents.len ? contents.len : 0]</b> items in it!")
	if(storage_capacity > 1)
		. += span_notice("Use in hand to select an item you want to prioritize taking out of the storage.")


/// A simple proc to empty the contents of the hydraulic clamp, forcing them on the turf it's on. Also forces `selected_item_index` to 0, to avoid any possible issues resulting from it.
/obj/item/borg/hydraulic_clamp/proc/empty_contents()
	SIGNAL_HANDLER

	selected_item_index = 0
	var/spilled_amount = 0
	var/turf/turf_of_clamp = get_turf(src)
	for(var/atom/movable/item in contents)
		item.forceMove(turf_of_clamp)
		spilled_amount++

	if(spilled_amount)
		var/holder = cyborg_holding_me?.resolve()
		if(holder)
			visible_message(span_warning("[cyborg_holding_me?.resolve()] spills the content of [src]'s cargo hold all over the floor!"))


/obj/item/borg/hydraulic_clamp/attack_self(mob/user, modifiers)
	if(storage_capacity <= 1) // No need for selection if there's one or less item at maximum in the clamp.
		return

	selected_item_index = 0

	if(contents.len <= 1)
		to_chat(user, span_warning("There's currently [contents.len ? "only one item" : "nothing"] to take out of [src]'s cargo hold, no need to pick!"))
		return

	. = ..()

	var/list/choices = list()
	var/index = 1
	for(var/item in contents)
		choices[item] = index
		index++

	var/selection = tgui_input_list(user, "Which item would you like to prioritize?", "Choose an item to prioritize", choices)
	if(!selection)
		return

	var/new_index = choices[selection]
	if(!new_index)
		return

	selected_item_index = new_index
	to_chat(user, span_notice("[src] will now prioritize unloading [selection]."))


/obj/item/borg/hydraulic_clamp/emp_act(severity)
	. = ..()
	empty_contents()


/obj/item/borg/hydraulic_clamp/pre_attack(atom/attacked_atom, mob/living/silicon/robot/user, params)
	if(!istype(user) || !user.Adjacent(attacked_atom) || !COOLDOWN_FINISHED(src, clamp_cooldown) || in_use)
		return

	// Not enough charge? Tough luck.
	if(user?.cell.charge < charge_cost)
		to_chat(user, span_warning("Your internal cell doesn't have enough charge left to use [src]."))
		return

	user.cell.use(charge_cost)
	in_use = TRUE
	COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

	// We're trying to unload something from the clamp, only possible on the floor, tables and conveyors.
	if(isturf(attacked_atom) || istype(attacked_atom, /obj/structure/table) || istype(attacked_atom, /obj/machinery/conveyor))
		if(!contents.len)
			in_use = FALSE
			return

		var/extraction_index = selected_item_index ? selected_item_index : contents.len
		var/atom/movable/extracted_item = contents[extraction_index]
		selected_item_index = 0

		if(unloading_time > 0.5 SECONDS) // We don't want too much chat spam if the clamp works fast.
			to_chat(user, span_notice("You start unloading something from [src]..."))
		playsound(src, clamp_sound, clamp_sound_volume, FALSE, -5)
		COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

		if(!do_after(user, unloading_time, attacked_atom))
			in_use = FALSE
			return

		var/turf/extraction_turf = get_turf(attacked_atom)
		extracted_item.forceMove(extraction_turf)
		visible_message(span_notice("[src.loc] unloads [extracted_item] from [src]."))
		log_silicon("[user] unloaded [extracted_item] onto [extraction_turf] ([AREACOORD(extraction_turf)]).")
		in_use = FALSE
		return

	// We're trying to load something in the clamp
	else
		if(whitelisted_contents && !is_type_in_list(attacked_atom, whitelisted_item_types))
			to_chat(user, span_warning("[src] can only pick up [whitelisted_item_description]!"))
			in_use = FALSE
			return

		if(contents.len >= storage_capacity)
			to_chat(user, span_warning("[src] is already at full capacity!"))
			in_use = FALSE
			return

		if(item_weight_limit)
			var/obj/item/to_lift = attacked_atom
			if(!to_lift || to_lift.w_class > item_weight_limit)
				to_chat(user, span_warning("[to_lift] is too big for [src]!"))
				in_use = FALSE
				return

		var/atom/movable/lifting_up = attacked_atom

		if(lifting_up.anchored)
			to_chat(user, span_warning("[lifting_up] is firmly secured, it's not currently possible to move it into [src]!"))
			in_use = FALSE
			return

		var/contains_mobs = FALSE

		if(istype(lifting_up, /obj/item/delivery/big))
			var/obj/item/delivery/big/parcel = lifting_up
			if(parcel.contains_mobs)
				if(!can_hold_mobs)
					to_chat(user, span_warning("[src]'s warning light blinks red: There's something with the potential to be alive inside of [parcel]!"))
					in_use = FALSE
					return
				contains_mobs = TRUE
			parcel.set_anchored(TRUE)

		lifting_up.add_fingerprint(user)

		if(loading_time > 0.5 SECONDS) // We don't want too much chat spam if the clamp works fast.
			to_chat(user, span_notice("You start loading [lifting_up] into [src]'s cargo hold..."))
		playsound(src, clamp_sound, clamp_sound_volume, FALSE, -5)

		if(!do_after(user, loading_time, lifting_up)) // It takes two seconds to put stuff into the clamp's cargo hold
			lifting_up.set_anchored(initial(lifting_up.anchored))
			in_use = FALSE
			return

		lifting_up.set_anchored(FALSE)
		lifting_up.forceMove(src)
		var/turf/lifting_up_from = get_turf(lifting_up.loc)
		log_silicon("[user] loaded [lifting_up] (Contains mobs: [contains_mobs]) into [src] at ([AREACOORD(lifting_up_from)]).")
		visible_message(span_notice("[src.loc] loads [lifting_up] into [src]'s cargo hold."))
		in_use = FALSE

/// The fabled paper plane crossbow and its hardlight paper planes.
/obj/item/paperplane/syndicate/hardlight
	name = "hardlight paper plane"
	desc = "Hard enough to hurt, fickle enough to be impossible to pick up."
	impact_eye_damage_lower = 10
	impact_eye_damage_higher = 10
	delete_on_impact = TRUE
	/// Which color is the paper plane?
	var/list/paper_colors = list(COLOR_CYAN, COLOR_BLUE_LIGHT, COLOR_BLUE)
	alpha = 150 // It's hardlight, it's gotta be see-through.


/obj/item/paperplane/syndicate/hardlight/Initialize(mapload)
	. = ..()
	color = color_hex2color_matrix(pick(paper_colors))
	alpha = initial(alpha) // It's hardlight, it's gotta be see-through.


/obj/item/borg/paperplane_crossbow
	name = "paper plane crossbow"
	desc = "Be careful, don't aim for the eyes- Who am I kidding, <i>definitely</i> aim for the eyes!"
	icon = 'icons/obj/weapons/guns/energy.dmi'
	icon_state = "crossbow"
	/// How many planes does the crossbow currently have in its internal magazine?
	var/planes = 4
	/// Maximum of planes the crossbow can hold.
	var/max_planes = 4
	/// Time it takes to regenerate one plane
	var/charge_delay = 1 SECONDS
	/// Is the crossbow currently charging a new paper plane?
	var/charging = FALSE
	/// How long is the cooldown between shots?
	var/shooting_delay = 0.5 SECONDS
	/// Are we ready to fire again?
	COOLDOWN_DECLARE(shooting_cooldown)


/obj/item/borg/paperplane_crossbow/examine(mob/user)
	. = ..()
	. += span_notice("There is <b>[planes]</b> left inside of its internal magazine, out of [max_planes].")
	var/charging_speed = 10 / charge_delay
	. += span_notice("It recharges at a rate of <b>[charging_speed]</b> plane[charging_speed >= 2 ? "s" : ""] per second.")


/obj/item/borg/paperplane_crossbow/equipped()
	. = ..()
	check_amount()


/obj/item/borg/paperplane_crossbow/dropped()
	. = ..()
	check_amount()


/// A simple proc to check if we're at the max amount of planes, if not, we keep on charging. Called by [/obj/item/borg/paperplane_crossbow/proc/charge_paper_planes()].
/obj/item/borg/paperplane_crossbow/proc/check_amount()
	if(!charging && planes < max_planes)
		addtimer(CALLBACK(src, PROC_REF(charge_paper_planes)), charge_delay)
		charging = TRUE


/// A simple proc to charge paper planes, that then calls [/obj/item/borg/paperplane_crossbow/proc/check_amount()] to see if it should charge another one, over and over.
/obj/item/borg/paperplane_crossbow/proc/charge_paper_planes()
	planes++
	charging = FALSE
	check_amount()


/// A proc for shooting a projectile at the target, it's just that simple, really.
/obj/item/borg/paperplane_crossbow/proc/shoot(atom/target, mob/living/user, params)
	if(!COOLDOWN_FINISHED(src, shooting_cooldown))
		return
	if(planes <= 0)
		to_chat(user, span_warning("Not enough paper planes left!"))
		return FALSE
	planes--

	var/obj/item/paperplane/syndicate/hardlight/plane_to_fire = new /obj/item/paperplane/syndicate/hardlight(get_turf(src.loc))

	playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
	plane_to_fire.throw_at(target, plane_to_fire.throw_range, plane_to_fire.throw_speed, user)
	COOLDOWN_START(src, shooting_cooldown, shooting_delay)
	user.visible_message(span_warning("[user] shoots a paper plane at [target]!"))
	check_amount()


/obj/item/borg/paperplane_crossbow/afterattack(atom/target, mob/living/user, proximity, click_params)
	. = ..()
	check_amount()
	if(iscyborg(user))
		var/mob/living/silicon/robot/robot_user = user
		if(!robot_user.cell.use(STANDARD_CELL_CHARGE * 0.1))
			to_chat(user, span_warning("Not enough power."))
			return FALSE
		shoot(target, user, click_params)


/// Holders for the package wrap and the wrapping paper synthetizers.

/datum/robot_energy_storage/package_wrap
	name ="package wrapper synthetizer"
	max_energy = 25
	recharge_rate = 2


/datum/robot_energy_storage/wrapping_paper
	name ="wrapping paper synthetizer"
	max_energy = 25
	recharge_rate = 2


/obj/item/stack/package_wrap/cyborg
	name = "integrated package wrapper"
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/package_wrap


/obj/item/stack/wrapping_paper/xmas/cyborg
	name = "integrated wrapping paper"
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/wrapping_paper


/obj/item/stack/wrapping_paper/xmas/cyborg/use(used, transfer, check = FALSE) // Check is set to FALSE here, so the stack istn't deleted.
	. = ..()


/// Some override that didn't belong anywhere else.

/obj/item/delivery/big
	/// Does this wrapped package contain at least one mob?
	var/contains_mobs = FALSE

// I did this out of sanity, I didn't want to make the clamp code more complex than necessary, and honestly I'm considering taking this upstream, it just feels awkward to PR just that.
/obj/item/bounty_cube
	w_class = WEIGHT_CLASS_SMALL

#define BASE_NINJA_REAGENTS list(\
		/datum/reagent/medicine/inacusiate,\
		/datum/reagent/medicine/morphine,\
		/datum/reagent/medicine/potass_iodide,\
		/datum/reagent/medicine/syndicate_nanites,\
		/datum/reagent/consumable/nutriment\
	)


/obj/item/katana/ninja_blade
	name = "energy katana"
	desc = "A katana infused with strong energy."
	force = 30
	icon_state = "energy_katana"
	inhand_icon_state = "energy_katana"
	worn_icon_state = "energy_katana"

/obj/item/shockpaddles/syndicate/cyborg/ninja
	name = "modified defibrillator paddles"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "ninjapaddles0"
	base_icon_state = "ninjapaddles"

/obj/item/reagent_containers/borghypo/syndicate/ninja
	name = "modified cyborg hypospray"
	desc = "An experimental piece of technology used to produce powerful restorative nanites used to very quickly restore injuries of all types. metabolizes potassium iodide for radiation poisoning, inacusiate for ear damage and morphine for offense and nutriment for the operative in the field."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "borghypo_n"
	charge_cost = 20
	recharge_time = 2
	default_reagent_types = BASE_NINJA_REAGENTS //That is for Ninja
	bypass_protection = TRUE //They still wearing suits, don't they?

/// Engineering Modules ///
/obj/item/crowbar/cyborg/power
	name = "modular crowbar"
	desc = "A cyborg fitted module resembling the jaws of life."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "jaws_pry_cyborg"
	usesound = 'sound/items/jaws_pry.ogg'
	force = 10
	toolspeed = 0.5

/obj/item/crowbar/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_CROWBAR ? "prying" : "cutting"] head."

/obj/item/crowbar/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_CROWBAR)
		tool_behaviour = TOOL_WIRECUTTER
		to_chat(user, span_notice("You attach the cutting jaws to [src]."))
		icon_state = "jaws_cutter_cyborg"
		usesound = 'sound/items/jaws_cut.ogg'
	else
		tool_behaviour = TOOL_CROWBAR
		to_chat(user, span_notice("You attach the prying jaws to [src]."))
		icon_state = "jaws_pry_cyborg"
		usesound = 'sound/items/jaws_pry.ogg'

/obj/item/screwdriver/cyborg/power
	name =	"automated drill"
	desc = "A cyborg fitted module resembling the hand drill"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "drill_screw_cyborg"
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.5
	random_color = FALSE

/obj/item/screwdriver/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_SCREWDRIVER ? "screw" : "bolt"] head."

/obj/item/screwdriver/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_WRENCH
		to_chat(user, span_notice("You attach the bolt bit to [src]."))
		icon_state = "drill_bolt_cyborg"
	else
		tool_behaviour = TOOL_SCREWDRIVER
		to_chat(user, span_notice("You attach the screw bit to [src]."))
		icon_state = "drill_screw_cyborg"

/// Shapeshifter
/obj/item/borg_shapeshifter
	name = "cyborg chameleon projector"
	icon = 'icons/obj/devices/syndie_gadget.dmi'
	icon_state = "shield0"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/saved_icon
	var/saved_bubble_icon
	var/saved_icon_override
	var/saved_name
	var/saved_model_features
	var/saved_special_light_key
	var/saved_hat_offset
	var/active = FALSE
	var/activationCost = STANDARD_CELL_CHARGE * 0.1
	var/activationUpkeep = STANDARD_CELL_CHARGE * 0.005
	var/disguise_model_name
	var/disguise
	var/disguise_icon_override
	var/disguise_pixel_offset = 0
	var/disguise_hat_offset = 0
	/// Traits unique to this model (deadsprite, wide/dogborginess, etc.). Mirrors the definition in modular_skyrat\modules\borgs\code\modules\mob\living\silicon\robot\robot_model.dm
	var/list/disguise_model_features = list()
	var/disguise_special_light_key
	var/mob/listeningTo
	var/list/signalCache = list( // list here all signals that should break the camouflage
			COMSIG_ATOM_ATTACKBY,
			COMSIG_ATOM_ATTACK_HAND,
			COMSIG_MOVABLE_IMPACT_ZONE,
			COMSIG_ATOM_BULLET_ACT,
			COMSIG_ATOM_EX_ACT,
			COMSIG_ATOM_FIRE_ACT,
			COMSIG_ATOM_EMP_ACT,
			)
	var/mob/living/silicon/robot/user // needed for process()
	var/animation_playing = FALSE

/obj/item/borg_shapeshifter/Initialize(mapload)
	. = ..()

/obj/item/borg_shapeshifter/Destroy()
	listeningTo = null
	return ..()

/obj/item/borg_shapeshifter/dropped(mob/user)
	. = ..()
	disrupt(user)

/obj/item/borg_shapeshifter/equipped(mob/user)
	. = ..()
	disrupt(user)

/**
 * check_menu: Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The mob interacting with a menu
 */
/obj/item/borg_shapeshifter/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/borg_shapeshifter/attack_self(mob/living/silicon/robot/user)
	if (user && user.cell && user.cell.charge >  activationCost)
		if (isturf(user.loc))
			toggle(user)
		else
			to_chat(user, span_warning("You can't use [src] while inside something!"))
	else
		to_chat(user, span_warning("You need at least [activationCost] charge in your cell to use [src]!"))

/obj/item/borg_shapeshifter/proc/toggle(mob/living/silicon/robot/user)
	if(active)
		playsound(src, 'sound/effects/pop.ogg', 100, TRUE, -6)
		to_chat(user, span_notice("You deactivate \the [src]."))
		deactivate(user)
	else
		if(animation_playing)
			to_chat(user, span_notice("\the [src] is recharging."))
			return
		var/static/list/model_icons = sort_list(list(
			"Standard" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "robot"),
			"Medical" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "medical"),
			"Cargo" = image(icon = CYBORG_ICON_CARGO, icon_state = "cargoborg"),
			"Engineer" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "engineer"),
			"Security" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "sec"),
			"Service" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "service_f"),
			"Janitor" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "janitor"),
			"Miner" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "miner"),
			"Peacekeeper" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "peace"),
			"Clown" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "clown"),
			"Syndicate" = image(icon = 'icons/mob/silicon/robots.dmi', icon_state = "synd_sec"),
			"Spider Clan" = image(icon = CYBORG_ICON_NINJA, icon_state = "ninja_engi")
		))
		var/model_selection = show_radial_menu(user, user, model_icons, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 42, require_near = TRUE)
		if(!model_selection)
			return FALSE

		var/obj/item/robot_model/model
		switch(model_selection)
			if("Standard")
				model = new /obj/item/robot_model/standard
			if("Medical")
				model = new /obj/item/robot_model/medical
			if("Cargo")
				model = new /obj/item/robot_model/cargo
			if("Engineer")
				model = new /obj/item/robot_model/engineering
			if("Security")
				model = new /obj/item/robot_model/security
			if("Service")
				model = new /obj/item/robot_model/service
			if("Janitor")
				model = new /obj/item/robot_model/janitor
			if("Miner")
				model = new /obj/item/robot_model/miner
			if("Peacekeeper")
				model = new /obj/item/robot_model/peacekeeper
			if("Clown")
				model = new /obj/item/robot_model/clown
			if("Syndicate")
				model = new /obj/item/robot_model/syndicatejack
			if("Spider Clan")
				model = new /obj/item/robot_model/ninja
			else
				return FALSE
		if (!set_disguise_vars(model, user))
			qdel(model)
			return FALSE
		qdel(model)
		animation_playing = TRUE
		to_chat(user, span_notice("You activate \the [src]."))
		playsound(src, 'sound/effects/seedling_chargeup.ogg', 100, TRUE, -6)
		var/start = user.filters.len
		var/X,Y,rsq,i,f
		for(i=1, i<=7, ++i)
			do
				X = 60*rand() - 30
				Y = 60*rand() - 30
				rsq = X*X + Y*Y
			while(rsq<100 || rsq>900)
			user.filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
		for(i=1, i<=7, ++i)
			f = user.filters[start+i]
			animate(f, offset=f:offset, time=0, loop=3, flags=ANIMATION_PARALLEL)
			animate(offset=f:offset-1, time=rand()*20+10)
		if (do_after(user, 5 SECONDS, target=user) && user.cell.use(activationCost))
			playsound(src, 'sound/effects/bamf.ogg', 100, TRUE, -6)
			to_chat(user, span_notice("You are now disguised."))
			activate(user)
		else
			to_chat(user, span_warning("The chameleon field fizzles."))
			do_sparks(3, FALSE, user)
			for(i=1, i<=min(7, user.filters.len), ++i) // removing filters that are animating does nothing, we gotta stop the animations first
				f = user.filters[start+i]
				animate(f)
		user.filters = null
		animation_playing = FALSE

/obj/item/borg_shapeshifter/proc/set_disguise_vars(obj/item/robot_model/disguise_model, mob/living/silicon/robot/cyborg)
	if (!disguise_model || !cyborg)
		return FALSE
	var/list/reskin_icons = list()
	for(var/skin in disguise_model.borg_skins)
		var/list/details = disguise_model.borg_skins[skin]
		var/image/reskin = image(icon = details[SKIN_ICON] || 'icons/mob/silicon/robots.dmi', icon_state = details[SKIN_ICON_STATE])
		if (!isnull(details[SKIN_FEATURES]))
			if (TRAIT_R_WIDE in details[SKIN_FEATURES])
				reskin.pixel_x -= 16
		reskin_icons[skin] = reskin
	var/borg_skin = show_radial_menu(cyborg, cyborg, reskin_icons, custom_check = CALLBACK(src, PROC_REF(check_menu), cyborg), radius = 38, require_near = TRUE)
	if(!borg_skin)
		return FALSE
	disguise_model_name = disguise_model.name
	var/list/details = disguise_model.borg_skins[borg_skin]
	disguise = details[SKIN_ICON_STATE]
	disguise_icon_override = details[SKIN_ICON]
	disguise_special_light_key = details[SKIN_LIGHT_KEY]
	disguise_hat_offset = 0 || details[SKIN_HAT_OFFSET]
	disguise_model_features = details[SKIN_FEATURES]
	return TRUE

/obj/item/borg_shapeshifter/process()
	if (user && !user.cell?.use(activationUpkeep))
		disrupt(user)
	else
		return PROCESS_KILL

/obj/item/borg_shapeshifter/proc/activate(mob/living/silicon/robot/user)
	src.user = user
	START_PROCESSING(SSobj, src)
	saved_icon = user.model.cyborg_base_icon
	saved_bubble_icon = user.bubble_icon
	saved_icon_override = user.model.cyborg_icon_override
	saved_name = user.model.name
	saved_model_features = user.model.model_features
	saved_special_light_key = user.model.special_light_key
	saved_hat_offset = user.model.hat_offset
	user.model.name = disguise_model_name
	user.model.cyborg_base_icon = disguise
	user.model.cyborg_icon_override = disguise_icon_override
	user.model.model_features = disguise_model_features
	user.model.special_light_key = disguise_special_light_key
	user.bubble_icon = "robot"
	active = TRUE
	user.update_icons()
	user.model.update_dogborg()
	user.model.update_tallborg()

	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
	RegisterSignal(user, signalCache, PROC_REF(disrupt))
	listeningTo = user

/obj/item/borg_shapeshifter/proc/deactivate(mob/living/silicon/robot/user)
	STOP_PROCESSING(SSobj, src)
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
		listeningTo = null
	do_sparks(5, FALSE, user)
	user.model.name = saved_name
	user.model.cyborg_base_icon = saved_icon
	user.model.cyborg_icon_override = saved_icon_override
	user.icon = saved_icon_override
	user.model.model_features = saved_model_features
	user.model.special_light_key = saved_special_light_key
	user.bubble_icon = saved_bubble_icon
	active = FALSE
	user.update_icons()
	user.model.update_dogborg()
	user.model.update_tallborg()

/obj/item/borg_shapeshifter/proc/disrupt(mob/living/silicon/robot/user)
	SIGNAL_HANDLER
	if(active)
		to_chat(user, span_danger("Your chameleon field deactivates."))
		deactivate(user)

// Quadruped tongue - lick lick
/obj/item/quadborg_tongue
	name = "synthetic tongue"
	desc = "Useful for slurping mess off the floor before affectionally licking the crew members in the face."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "synthtongue"
	hitsound = 'sound/effects/attackblob.ogg'
	desc = "For giving affectionate kisses."
	item_flags = NOBLUDGEON

/obj/item/quadborg_tongue/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !isliving(target))
		return
	var/mob/living/silicon/robot/borg = user
	var/mob/living/mob = target

	if(!HAS_TRAIT(target, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		if(check_zone(borg.zone_selected) == "head")
			borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]'s face!"), span_notice("You affectionally lick \the [mob]'s face!"))
			playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)
		else
			borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]!"), span_notice("You affectionally lick \the [mob]!"))
			playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)
	else
		to_chat(user, span_warning("ERROR: [target] is on the Do Not Lick registry!"))

// Quadruped nose - Boop
/obj/item/quadborg_nose
	name = "boop module"
	desc = "The BOOP module"
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "nose"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	force = 0

/obj/item/quadborg_nose/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return

	if(!HAS_TRAIT(target, TRAIT_AFFECTION_AVERSION)) // Checks for Affection Aversion trait
		do_attack_animation(target, null, src)
		user.visible_message(span_notice("[user] [pick("nuzzles", "pushes", "boops")] \the [target.name] with their nose!"))
	else
		to_chat(user, span_warning("ERROR: [target] is on the No Nosing registry!"))

/// Better Clamp
/obj/item/borg/hydraulic_clamp/better
	name = "improved integrated hydraulic clamp"
	desc = "A neat way to lift and move around crates for quick and painless deliveries!"
	storage_capacity = 4
	whitelisted_item_types = list(/obj/structure/closet/crate, /obj/item/delivery/big, /obj/item/delivery, /obj/item/bounty_cube) // If they want to carry a small package or a bounty cube instead, so be it, honestly.
	whitelisted_item_description = "wrapped packages"
	item_weight_limit = NONE
	clamp_sound_volume = 50

/obj/item/borg/hydraulic_clamp/better/examine(mob/user)
	. = ..()
	var/crate_count = contents.len
	. += "There is currently <b>[crate_count > 0 ? crate_count : "no"]</b> crate[crate_count > 1 ? "s" : ""] stored in the clamp's internal storage."

/obj/item/borg/hydraulic_clamp/mail
	name = "integrated rapid mail delivery device"
	desc = "Allows you to carry around a lot of mail, to distribute it around the station like the good little mailbot you are!"
	icon = 'icons/obj/service/library.dmi'
	icon_state = "bookbag"
	storage_capacity = 100
	loading_time = 0.25 SECONDS
	unloading_time = 0.25 SECONDS
	cooldown_duration = 0.25 SECONDS
	whitelisted_item_types = list(/obj/item/mail)
	whitelisted_item_description = "envelopes"
	item_weight_limit = WEIGHT_CLASS_NORMAL
	clamp_sound_volume = 25
	clamp_sound = 'sound/items/pshoom.ogg'

/obj/item/borg/forging_setup
	name = "integrated forging dispenser"
	desc = "Allows cyborgs to dispense the necessary structures for forging in return for power."
	icon = 'modular_skyrat/modules/borgs/icons/robot_items.dmi'
	icon_state = "forge_dispense"
	/// how much charge the item will use per use
	var/charge_cost = 1000

/obj/item/borg/forging_setup/attack_self(mob/user, modifiers)
	var/mob/living/silicon/robot/robot_user = user
	if(!istype(robot_user)) //you have to be a borg to use this item
		to_chat(user, span_warning("Must be a cyborg to use [src]!"))
		return

	if(robot_user.cell.charge < charge_cost)
		to_chat(user, span_warning("Not enough charge!"))
		return

	var/turf/src_turf = get_turf(src)
	if(!isopenturf(src_turf) || isspaceturf(src_turf))
		to_chat(user, span_warning("Must be built on a solid surface!"))
		return

	for(var/obj/structure/locate_structure in src_turf)
		if(locate_structure.density)
			to_chat(user, span_warning("Must be built on an empty surface!"))
			return

	robot_user.cell.use(charge_cost)

	var/choice = tgui_input_list(user, "Which structure would you like to produce?", "Structure Choice", list("Forge", "Anvil", "Water Basin", "Crafting Bench"))
	if(isnull(choice))
		return
	switch(choice)
		if("Forge")
			new /obj/structure/reagent_forge(src_turf)
		if("Anvil")
			new /obj/structure/reagent_anvil(src_turf)
		if("Water Basin")
			new /obj/structure/reagent_water_basin(src_turf)
		if("Crafting Bench")
			new /obj/structure/reagent_crafting_bench(src_turf)
