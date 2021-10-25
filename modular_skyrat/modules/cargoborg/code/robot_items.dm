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




/// The fabled paper plane crossbow and its hardlight paper planes.
/obj/item/paperplane/syndicate/hardlight
	name = "hardlight paper plane"
	desc = "Hard enough to hurt, fickle enough to be impossible to pick up."
	impact_eye_damage_lower = 10
	impact_eye_damage_higher = 10
	delete_on_impact = TRUE

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

/obj/item/stack/wrapping_paper/use(used, transfer, check = FALSE)
	. = ..()
