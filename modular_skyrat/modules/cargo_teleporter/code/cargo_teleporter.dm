GLOBAL_LIST_EMPTY(cargo_marks)

/obj/item/cargo_teleporter
	name = "cargo teleporter"
	desc = "An item that can set down a set number of markers, allowing them to teleport items within a tile to the set markers."
	icon = 'modular_skyrat/modules/cargo_teleporter/icons/cargo_teleporter.dmi'
	icon_state = "cargo_tele"

	var/allow_persons = FALSE
	var/faster_cooldown = FALSE

	COOLDOWN_DECLARE(use_cooldown)

/obj/item/cargo_teleporter/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return ..()
	if(!COOLDOWN_FINISHED(src, use_cooldown))
		to_chat(user, span_warning("[src] is still on cooldown!"))
		return
	var/choice = tgui_input_list(user, "Select which cargo mark to teleport the items to?", "Cargo Mark Selection", GLOB.cargo_marks)
	if(!choice)
		return ..()
	var/turf/moving_turf = get_turf(choice)
	var/turf/target_turf = get_turf(target)
	for(var/check_content in target_turf.contents)
		if(!ismovable(check_content))
			continue
		var/atom/movable/movable_content = check_content
		if(isliving(movable_content) && !allow_persons)
			continue
		if(movable_content.anchored)
			continue
		if(!do_after(user, 5, target = target))
			break
		movable_content.forceMove(moving_turf)
	var/set_cooldown = faster_cooldown ? 10 SECONDS : 20 SECONDS
	COOLDOWN_START(src, use_cooldown, set_cooldown)

/obj/item/cargo_tele_upgrade
	name = "cargo teleporter upgrade"
	desc = "An item that can upgrade the cargo teleporter."
