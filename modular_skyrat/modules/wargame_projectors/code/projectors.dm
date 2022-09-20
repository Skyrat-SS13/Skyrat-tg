/obj/item/wargame_projector
	name = "holographic projector"
	desc = "A handy-dandy holographic projector developed by Nanotrasen Naval Command for playing wargames with, this one creates markers for 'units'."
	icon = 'modular_skyrat/modules/wargame_projectors/icons/projectors_and_holograms.dmi'
	icon_state = "unit_projector"
	inhand_icon_state = "electronic"
	worn_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	force = 0
	w_class = WEIGHT_CLASS_SMALL
	throwforce = 0
	throw_speed = 3
	throw_range = 7
	item_flags = NOBLUDGEON
	/// All of the signs this projector is maintaining
	var/list/projections
	/// The maximum number of projections this can support
	var/max_signs = 30 //These aren't solid and you may need a few of these
	/// The color to give holograms when created with left click
	var/holosign_color = COLOR_BLUE_LIGHT
	/// The color to give holograms when created with right click
	var/holosign_type = /obj/structure/wargame_hologram
	/// A list containing all of the possible holosigns this can choose from
	var/list/holosign_options = list(
		/obj/structure/wargame_hologram,
	)

/obj/item/wargame_projector/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/openspace_item_click_handler)

/obj/item/wargame_projector/handle_openspace_click(turf/target, mob/user, proximity_flag, click_parameters)
	afterattack(target, user, proximity_flag, click_parameters)

/obj/item/wargame_projector/examine(mob/user)
	. = ..()
	if(!projections)
		return
	. += span_notice("It is currently maintaining <b>[projections.len]/[max_signs]</b> projections.")

/// Changes the selected hologram to one of the options from the hologram list
/obj/item/wargame_projector/proc/select_hologram(mob/user)
	var/list/choices = list()
	var/list/names_to_path = list()
	if(!choices.len || !names_to_path.len)
		for(var/obj/structure/wargame_hologram/hologram as anything in holosign_options)
			names_to_path[initial(hologram.name)] = hologram
			choices[initial(hologram.name)] = image(icon = initial(hologram.icon), icon_state = initial(hologram.icon_state))

	var/picked_choice = show_radial_menu(
		user,
		src,
		choices,
		require_near = TRUE,
		tooltips = TRUE,
		)

	if(isnull(picked_choice))
		return

	holosign_type = names_to_path[picked_choice]

/obj/item/wargame_projector/AltClick(mob/user)
	select_hologram(user)

/// Can we place a hologram at the target location?
/obj/item/wargame_projector/proc/check_can_place_hologram(atom/target, mob/user, proximity_flag, team)
	if(!proximity_flag)
		return FALSE
	if(!check_allowed_items(target, not_inside = TRUE))
		return FALSE
	var/turf/target_turf = get_turf(target)
	if(target_turf.is_blocked_turf(TRUE))
		return FALSE
	if(LAZYLEN(projections) >= max_signs)
		balloon_alert(user, "max capacity!")
		return FALSE
	return TRUE

/// Spawn a hologram with pixel offset based on where the user clicked
/obj/item/wargame_projector/proc/create_hologram(atom/target, mob/user, click_parameters, sign_color)
	var/obj/target_holosign = new holosign_type(get_turf(target), src)

	var/list/modifiers = params2list(click_parameters)
	var/click_x
	var/click_y

	if(LAZYACCESS(modifiers, ICON_X) && LAZYACCESS(modifiers, ICON_Y))
		click_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -(world.icon_size/2), world.icon_size/2)
		click_y = clamp(text2num(LAZYACCESS(modifiers, ICON_Y)) - 16, -(world.icon_size/2), world.icon_size/2)

	target_holosign.pixel_x = click_x
	target_holosign.pixel_y = click_y

	target_holosign.color = sign_color

	playsound(loc, 'sound/machines/click.ogg', 20, TRUE)

/obj/item/wargame_projector/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	check_can_place_hologram(target, user, proximity_flag, 1)
	create_hologram(target, user, click_parameters, holosign_color)

/obj/item/wargame_projector/attack(mob/living/carbon/human/M, mob/user) //Jesse what the fuck is happening with that var, I'm scared to change it from M
	return

/obj/item/wargame_projector/attack_self(mob/user)
// Make sure to do team clearing here

/obj/item/wargame_projector/Destroy()
	. = ..()
	if(LAZYLEN(projections))
		for(var/hologram as anything in projections)
			qdel(hologram)
