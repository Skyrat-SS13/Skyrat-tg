/// CARGO BORGS ///
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
	var/paper_charge_cost = 50

/obj/item/clipboard/cyborg/Initialize()
	. = ..()
	pen = new /obj/item/pen/cyborg

/obj/item/clipboard/cyborg/examine()
	. = ..()
	. += "Alt-click to synthetize a piece of paper."
	if(!COOLDOWN_FINISHED(src, printer_cooldown))
		. += "Its integrated paper synthetizer seems to still be on cooldown."

/obj/item/clipboard/cyborg/AltClick(mob/user)
	if(!iscyborg(user))
		to_chat(user, span_warning("You do not seem to understand how to use [src]."))
		return
	var/mob/living/silicon/robot/cyborg_user = user
	// Not enough charge? Tough luck.
	if(cyborg_user?.cell.charge < paper_charge_cost)
		to_chat(user, span_warning("Your internal cell doesn't have enough charge left to use [src]'s integrated printer."))
		return
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
			RegisterSignal(new_paper, COMSIG_ATOM_UPDATED_ICON, .proc/on_top_paper_change)
			toppaper_ref = WEAKREF(new_paper)
			update_appearance()
			to_chat(user, span_notice("[src]'s integrated printer whirs to life, spitting out a fresh piece of paper and clipping it into place."))
		else
			to_chat(user, span_warning("[src]'s integrated printer refuses to print more paper, as [src] already contains enough paper."))
	else
		to_chat(user, span_warning("[src]'s integrated printer refuses to print more paper, its bluespace paper synthetizer not having finished recovering from its last synthesis."))

/obj/item/hand_labeler/cyborg
	name = "integrated hand labeler"

/// The clamps
/obj/item/borg/hydraulic_clamp
	name = "integrated hydraulic clamp"
	desc = "A neat way to lift and move around a wrapped crate for quick and painless deliveries!"
	icon = 'icons/mecha/mecha_equipment.dmi' // Just some temporary sprites because I don't have any unique one yet
	icon_state = "mecha_clamp"
	/// How much power does it draw per operation?
	var/charge_cost = 20
	/// How many items can it hold at once in its internal storage?
	var/storage_capacity = 1
	/// Does it require the items it takes in to be wrapped in paper wrap? Can have unforeseen consequences, change to FALSE at your own risks.
	var/whitelisted_contents = TRUE
	/// What kind of wrapped item can it hold, if `whitelisted_contents` is set to true?
	var/list/whitelisted_item_types = list(/obj/item/small_delivery, /obj/structure/big_delivery) // If they want to carry a small package instead, so be it, honestly.
	/// Weight limit on the items it can hold. Leave as NONE if there isn't.
	var/item_weight_limit = NONE
	/// Can it hold mobs? (Dangerous, it is recommended to leave this to FALSE)
	var/can_hold_mobs = FALSE
	/// Audio for using the hydraulic clamp.
	var/clamp_sound = 'sound/mecha/hydraulic.ogg'
	/// Volume of the clamp's loading and unloading noise.
	var/clamp_sound_volume = 50
	/// Cooldown for the clamp.
	COOLDOWN_DECLARE(clamp_cooldown)
	/// How long is the clamp on cooldown for after every usage?
	var/cooldown_duration = 0.5 SECONDS
	/// How long does it take to load in an item?
	var/loading_time = 2 SECONDS
	/// How long does it take to unload an item?
	var/unloading_time = 1 SECONDS
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

	RegisterSignal(holder_model.robot, COMSIG_LIVING_DEATH, .proc/empty_contents)


/obj/item/borg/hydraulic_clamp/Destroy()
	var/mob/living/silicon/robot/robot_holder = cyborg_holding_me.resolve()
	UnregisterSignal(robot_holder, COMSIG_LIVING_DEATH)
	..()


/obj/item/borg/hydraulic_clamp/examine(mob/user)
	. = ..()
	. += span_notice("It's cargo hold has a capacity of [storage_capacity] and is currently holding <b>[contents.len ? contents.len : 0]</b> items in it!")


/// A simple proc to empty the contents of the hydraulic clamp, forcing them on the turf it's on. Also forces `selected_item_index` to 0, to avoid any possible issues resulting from it.
/obj/item/borg/hydraulic_clamp/proc/empty_contents()
	SIGNAL_HANDLER

	selected_item_index = 0
	var/turf/turf_of_clamp = get_turf(src)
	for(var/atom/movable/item in contents)
		item.forceMove(turf_of_clamp)


/obj/item/borg/hydraulic_clamp/attack_self(mob/user, modifiers)
	if(storage_capacity <= 1) // No need for selection if there's one or less item at maximum in the clamp.
		return

	selected_item_index = 0

	if(!contents.len)
		to_chat(user, span_warning("There's currently nothing to take out of [src]'s cargo hold!"))
		return

	. = ..()

	var/list/choices = list()
	var/index = 1
	for(var/item in contents)
		choices[item] = index
		index++

	var/selection = tgui_input_list(user, "Which item would you like to take out of the cargo hold first?", "Choose an item to prioritize", choices)
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


/obj/item/borg/hydraulic_clamp/attack_atom(atom/attacked_atom, mob/living/user, params)
	if(!user.Adjacent(attacked_atom) || !COOLDOWN_FINISHED(src, clamp_cooldown))
		return

	COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

	// We're trying to unload something from the clamp
	if(isturf(attacked_atom))
		if(!contents.len)
			return

		var/extraction_index = selected_item_index ? selected_item_index : contents.len
		var/atom/movable/extracted_item = contents[extraction_index]
		selected_item_index = 0
		visible_message(span_notice("[src.loc] starts unloading something from [src]..."))
		playsound(src, clamp_sound, clamp_sound_volume, FALSE, -5)
		COOLDOWN_START(src, clamp_cooldown, cooldown_duration)

		if(!do_after(user, unloading_time, attacked_atom))
			return

		var/turf/extraction_turf = get_turf(attacked_atom)
		extracted_item.forceMove(extraction_turf)
		visible_message(span_notice("[src.loc] unloads [extracted_item] from [src]."))
		log_silicon("[user] unloaded [extracted_item] onto [extraction_turf] ([AREACOORD(extraction_turf)]).")
		return

	// We're trying to load something in the clamp
	else
		if(whitelisted_contents && !is_type_in_list(attacked_atom, whitelisted_item_types))
			to_chat(user, span_warning("[attacked_atom] needs to be wrapped for [src] to pick it up!"))
			return

		if(contents.len >= storage_capacity)
			to_chat(user, span_warning("[src] is already at full capacity!"))
			return

		if(item_weight_limit)
			var/obj/item/to_lift = attacked_atom
			if(!to_lift || to_lift.w_class > item_weight_limit)
				to_chat(user, span_warning("[to_lift] is too big for [src]!"))
				return

		var/atom/movable/lifting_up = attacked_atom

		if(lifting_up.anchored)
			to_chat(user, span_warning("[lifting_up] is firmly secured, it's not currently possible to move it into [src]!"))
			return

		var/contains_mobs = FALSE

		if(istype(lifting_up, /obj/structure/big_delivery))
			var/obj/structure/big_delivery/parcel = lifting_up
			if(parcel.contains_mobs)
				if(!can_hold_mobs)
					to_chat(user, span_warning("[src]'s warning light blinks red: There's something with the potential to be alive inside of [parcel]!"))
					return
				contains_mobs = TRUE
			parcel.set_anchored(TRUE)

		lifting_up.add_fingerprint(user)
		visible_message(span_notice("[src.loc] starts loading [lifting_up] into [src]'s cargo hold..."))
		playsound(src, clamp_sound, clamp_sound_volume, FALSE, -5)

		if(!do_after(user, loading_time, lifting_up)) // It takes two seconds to put stuff into the clamp's cargo hold
			lifting_up.set_anchored(initial(lifting_up.anchored))
			return

		lifting_up.set_anchored(FALSE)
		lifting_up.forceMove(src)
		var/turf/lifting_up_from = get_turf(lifting_up.loc)
		log_silicon("[user] loaded [lifting_up] (Contains mobs: [contains_mobs]) into [src] at ([AREACOORD(lifting_up_from)]).")
		visible_message(span_notice("[src.loc] loads [lifting_up] into [src]'s cargo hold."))
		return


/obj/item/borg/hydraulic_clamp/small
	name = "small integrated hydraulic clamp"
	desc = "A neat way to lift and move around a few small packages."
	storage_capacity = 4
	whitelisted_item_types = list(/obj/item/small_delivery)
	item_weight_limit = WEIGHT_CLASS_SMALL
	clamp_sound_volume = 25


/obj/item/borg/hydraulic_clamp/mail
	name = "integrated rapid mail delivery device"
	desc = "Allows you to carry around a lot of mail, to distribute it around the station like the good little mailbot you are!"
	storage_capacity = 100
	loading_time = 0.25 SECONDS
	unloading_time = 0.25 SECONDS
	cooldown_duration = 0.25 SECONDS
	whitelisted_item_types = list(/obj/item/mail)
	item_weight_limit = WEIGHT_CLASS_NORMAL
	clamp_sound_volume = 25
	clamp_sound = 'sound/items/pshoom.ogg'
	icon = 'icons/obj/library.dmi'
	icon_state = "bookbag"



/// The fabled paper plane crossbow and its hardlight paper planes.
/obj/item/paperplane/syndicate/hardlight
	name = "hardlight paper plane"
	desc = "Hard enough to hurt, fickle enough to be impossible to pick up."
	impact_eye_damage_lower = 10
	impact_eye_damage_higher = 10
	delete_on_impact = TRUE
	/// Which color is the paper plane?
	var/list/paper_colors = list(COLOR_CYAN, COLOR_BLUE_LIGHT, COLOR_BLUE)

/obj/item/paperplane/syndicate/hardlight/Initialize()
	. = ..()
	color = color_hex2color_matrix(pick(paper_colors))

/obj/item/borg/paperplane_crossbow
	name = "paper plane crossbow"
	desc = "Be careful, don't aim for the eyes- Who am I kidding, <i>definitely</i> aim for the eyes!"
	icon_state = "lollipop"
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
	. += "There is [planes] left inside of its internal magazine."

/obj/item/borg/paperplane_crossbow/equipped()
	. = ..()
	check_amount()

/obj/item/borg/paperplane_crossbow/dropped()
	. = ..()
	check_amount()

/obj/item/borg/paperplane_crossbow/proc/check_amount() //Doesn't even use processing ticks.
	if(!charging && planes < max_planes)
		addtimer(CALLBACK(src, .proc/charge_paper_planes), charge_delay)
		charging = TRUE

/obj/item/borg/paperplane_crossbow/proc/charge_paper_planes()
	planes++
	charging = FALSE
	check_amount()

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
		if(!robot_user.cell.use(10))
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


/// Some overrides that didn't belong anywhere else.

/obj/structure/big_delivery
	/// Does this wrapped package contain at least one mob?
	var/contains_mobs = FALSE
