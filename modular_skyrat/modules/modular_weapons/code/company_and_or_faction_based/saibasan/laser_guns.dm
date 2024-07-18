/// File location for the long gun's speech
#define LONG_MOD_LASER_SPEECH "saibasan/long_modular_laser.json"
/// File location for the short gun's speech
#define SHORT_MOD_LASER_SPEECH "saibasan/short_modular_laser.json"
/// How long the gun should wait between speaking to lessen spam
#define MOD_LASER_SPEECH_COOLDOWN 2 SECONDS
/// What color is the default kill mode for these guns, used to make sure the chat colors are right at roundstart
#define DEFAULT_RUNECHAT_GUN_COLOR "#cd4456"

// Modular energy weapons, laser guns that can transform into different variants after a few seconds of waiting and animation
// Long version, takes both hands to use and doesn't fit in any bags out there
/obj/item/gun/energy/modular_laser_rifle
	name = "\improper Hyeseong modular laser rifle"
	desc = "A popular energy weapon system that can be reconfigured into many different variants on the fly. \
		Seen commonly amongst the Marsians who produce the weapon, with many different shapes and sizes to fit \
		the wide variety of modders the planet is home to."
	base_icon_state = "hyeseong"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/saibasan/guns48x.dmi'
	icon_state = "hyeseong_kill"
	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/saibasan/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/saibasan/guns_righthand.dmi'
	inhand_icon_state = "hyeseong_kill"
	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/mob/company_and_or_faction_based/saibasan/guns_worn.dmi'
	worn_icon_state = "hyeseong_kill"
	cell_type = /obj/item/stock_parts/power_store/cell/hyeseong_internal_cell
	modifystate = FALSE
	ammo_type = list(/obj/item/ammo_casing/energy/cybersun_big_kill)
	can_select = FALSE
	ammo_x_offset = 0
	selfcharge = 1
	charge_delay = 15
	shaded_charge = TRUE
	slot_flags = ITEM_SLOT_BACK
	obj_flags = UNIQUE_RENAME
	SET_BASE_PIXEL(-8, 0)
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	actions_types = list(/datum/action/item_action/toggle_personality)
	fire_sound_volume = 50
	recoil = 0.25 // This isn't enough to mean ANYTHING aside from it jolting your screen the tiniest amount
	/// What datums of weapon modes can we use?
	var/list/weapon_mode_options = list(
		/datum/laser_weapon_mode,
		/datum/laser_weapon_mode/marksman,
		/datum/laser_weapon_mode/disabler_machinegun,
		/datum/laser_weapon_mode/launcher,
		/datum/laser_weapon_mode/shotgun,
	)
	/// Populates with a list of weapon mode names and their respective paths on init
	var/list/weapon_mode_name_to_path = list()
	/// Info for the radial menu for switching weapon mode
	var/list/radial_menu_data = list()
	/// Is the gun currently changing types? Prevents the gun from firing if yes
	var/currently_switching_types = FALSE
	/// How long transitioning takes before you're allowed to pick a weapon type
	var/transition_duration = 1 SECONDS
	/// What the currently selected weapon mode is, for quickly referencing for use in procs and whatnot
	var/datum/laser_weapon_mode/currently_selected_mode
	/// Name of the firing mode that is selected by default
	var/default_selected_mode = "Kill"
	/// Allows firing of the gun to be disabled for any reason, for example, if a gun has a melee mode
	var/disabled_for_other_reasons = FALSE
	/// The json file this gun pulls from when speaking
	var/speech_json_file = LONG_MOD_LASER_SPEECH
	/// Keeps track of the last processed charge, prevents message spam
	var/last_charge = 0
	/// If the gun's personality speech thing is on, defaults to on because just listen to her
	var/personality_mode = TRUE
	/// Keeps track of our soulcatcher component
	var/datum/component/carrier/soulcatcher/tracked_soulcatcher
	/// What is this gun's extended examine, we only have to do this because the carbine is a subtype
	var/expanded_examine_text = "The Hyeseong rifle is the first line of man-portable Marsian weapons platforms \
		from Cybersun Industries. Like her younger sister weapon, the Hoshi carbine, CI used funding aid provided \
		by SolFed to develop a portable weapon fueled by a proprietary generator rumored to be fueled by superstable plasma. \
		A rugged and hefty weapon, the Hyeseong stars in applications anywhere from medium to long ranges, though struggling \
		in CQB. Her onboard machine intelligence, at first devised to support the operator and manage the internal reactor, \
		is shipped with a more professional and understated personality-- since influenced by 'negligence' from users in \
		wiping the intelligence's memory before resale or transport."
	/// A cooldown for when the weapon has last spoken, prevents messages from getting turbo spammed
	COOLDOWN_DECLARE(last_speech)

/obj/item/gun/energy/modular_laser_rifle/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CYBERSUN)
	chat_color = DEFAULT_RUNECHAT_GUN_COLOR
	chat_color_darkened = process_chat_color(DEFAULT_RUNECHAT_GUN_COLOR, sat_shift = 0.85, lum_shift = 0.85)
	last_charge = cell.charge
	tracked_soulcatcher = AddComponent(/datum/component/carrier/soulcatcher/modular_laser)
	create_weapon_mode_stuff()
	voice = null

/obj/item/gun/energy/modular_laser_rifle/examine(mob/user)
	. = ..()
	. += span_notice("You can <b>examine closer</b> to learn a little more about this weapon.")
	. += span_notice("You can <b>Alt-Click</b> this gun to access the <b>internal soulcatcher</b>.")

/obj/item/gun/energy/modular_laser_rifle/examine_more(mob/user)
	. = ..()
	. += expanded_examine_text
	return .

/obj/item/gun/energy/modular_laser_rifle/Destroy()
	QDEL_NULL(tracked_soulcatcher)
	return ..()

/obj/item/gun/energy/modular_laser_rifle/click_alt(mob/user)
	. = ..()
	tracked_soulcatcher?.ui_interact(user)

/// Handles filling out all of the lists regarding weapon modes and radials around that
/obj/item/gun/energy/modular_laser_rifle/proc/create_weapon_mode_stuff()
	if(length(weapon_mode_name_to_path) || length(radial_menu_data))
		return // We don't need to worry about it if there's already stuff here
	for(var/datum/laser_weapon_mode/laser_mode as anything in weapon_mode_options)
		weapon_mode_name_to_path["[initial(laser_mode.name)]"] = new laser_mode()
		var/obj/projectile/mode_projectile = initial(laser_mode.casing.projectile_type)
		radial_menu_data["[initial(laser_mode.name)]"] = image(icon = mode_projectile.icon, icon_state = mode_projectile.icon_state)
	currently_selected_mode = weapon_mode_name_to_path["[default_selected_mode]"]
	transform_gun(currently_selected_mode, FALSE, TRUE)

/obj/item/gun/energy/modular_laser_rifle/attack_self(mob/living/user)
	if(!currently_switching_types)
		change_to_switch_mode(user)
	return ..()

/// Makes the gun inoperable, playing an animation and giving a prompt to switch gun modes after the transition_duration passes
/obj/item/gun/energy/modular_laser_rifle/proc/change_to_switch_mode(mob/living/user)
	currently_switching_types = TRUE
	flick("[base_icon_state]_switch_on", src)
	cut_overlays()
	playsound(src, 'sound/items/modsuit/ballin.ogg', 75, TRUE)
	var/new_icon_state = "[base_icon_state]_switch"
	icon_state = new_icon_state
	inhand_icon_state = new_icon_state
	worn_icon_state = new_icon_state
	addtimer(CALLBACK(src, PROC_REF(show_radial_choice_menu), user), transition_duration)

/// Shows the radial choice menu to the user, if the user doesnt exist or isnt holding the gun anymore, it reverts back to its last form
/obj/item/gun/energy/modular_laser_rifle/proc/show_radial_choice_menu(mob/living/user)
	if(!user?.is_holding(src))
		flick("[base_icon_state]_switch_off", src)
		transform_gun(currently_selected_mode, FALSE)
		playsound(src, 'sound/items/modsuit/ballout.ogg', 75, TRUE)
		return

	var/picked_choice = show_radial_menu(
		user,
		src,
		radial_menu_data,
		require_near = TRUE,
		tooltips = TRUE,
		)

	if(isnull(picked_choice) || isnull(weapon_mode_name_to_path["[picked_choice]"]))
		flick("[base_icon_state]_switch_off", src)
		transform_gun(currently_selected_mode, FALSE)
		playsound(src, 'sound/items/modsuit/ballout.ogg', 75, TRUE)
		return

	var/new_weapon_mode = weapon_mode_name_to_path["[picked_choice]"]
	transform_gun(new_weapon_mode, TRUE)

/// Transforms the gun into a different type, if replacing is set to true then it'll make sure to remove any effects the prior gun type had
/obj/item/gun/energy/modular_laser_rifle/proc/transform_gun(datum/laser_weapon_mode/new_weapon_mode, replacing = TRUE, dont_speak = FALSE)
	if(!new_weapon_mode)
		stack_trace("transform_gun was called but didn't get a new weapon mode, meaning it couldn't work.")
		return
	if(replacing)
		currently_selected_mode.remove_from_weapon(src)
	currently_selected_mode = new_weapon_mode
	flick("[base_icon_state]_switch_off", src)
	currently_selected_mode.apply_stats(src)
	currently_selected_mode.apply_to_weapon(src)
	playsound(src, 'sound/items/modsuit/ballout.ogg', 75, TRUE)
	if(!dont_speak)
		speak_up(currently_selected_mode.json_speech_string, TRUE)
	currently_switching_types = FALSE

/obj/item/gun/energy/modular_laser_rifle/can_shoot()
	if(!length(ammo_type))
		return FALSE
	return ..()

/obj/item/gun/energy/modular_laser_rifle/can_trigger_gun(mob/living/user, akimbo_usage)
	. = ..()
	if(currently_switching_types || disabled_for_other_reasons)
		return FALSE

/// Makes the gun speak with a sound effect and colored runetext based on the mode the gun is in, reads the gun's speech json as defined through variables
/obj/item/gun/energy/modular_laser_rifle/proc/speak_up(json_string, ignores_cooldown = FALSE, ignores_personality_toggle = FALSE)
	if(!personality_mode && !ignores_personality_toggle)
		return
	if(!json_string)
		return
	if(!ignores_cooldown && !COOLDOWN_FINISHED(src, last_speech))
		return
	say(pick_list_replacements(speech_json_file, json_string))
	playsound(src, 'sound/creatures/tourist/tourist_talk.ogg', 15, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, frequency = rand(2, 2.2))
	Shake(2, 2, 1 SECONDS)
	COOLDOWN_START(src, last_speech, MOD_LASER_SPEECH_COOLDOWN)

/obj/item/gun/energy/modular_laser_rifle/equipped(mob/user, slot, initial)
	. = ..()
	if(slot & (ITEM_SLOT_BELT|ITEM_SLOT_BACK|ITEM_SLOT_SUITSTORE))
		speak_up("worn")
	else if(slot & ITEM_SLOT_HANDS)
		RegisterSignal(user, COMSIG_MOB_CI_TOGGLED, PROC_REF(user_ci_toggled))
		speak_up("pickup")
		return
	UnregisterSignal(user, COMSIG_MOB_CI_TOGGLED)

/obj/item/gun/energy/modular_laser_rifle/dropped(mob/user, silent)
	. = ..()
	if(src in user.contents)
		return // If they're still holding us or have us on them, dw about it
	UnregisterSignal(user, COMSIG_MOB_CI_TOGGLED)
	speak_up("putdown")

/obj/item/gun/energy/modular_laser_rifle/process(seconds_per_tick)
	. = ..()
	var/cell_charge_quarter = cell.maxcharge / 4
	if((cell_charge_quarter > cell.charge) && !(last_charge < cell_charge_quarter))
		speak_up("lowcharge")
	else if((cell.maxcharge == cell.charge) && !(last_charge == cell.maxcharge))
		speak_up("fullcharge")
	last_charge = cell.charge

/// Triggers when a mob user toggles CI
/obj/item/gun/energy/modular_laser_rifle/proc/user_ci_toggled(mob/living/source)
	if(source.combat_indicator)
		speak_up("combatmode")

/obj/item/gun/energy/modular_laser_rifle/ui_action_click(mob/user, actiontype)
	if(!istype(actiontype, /datum/action/item_action/toggle_personality))
		return ..()
	playsound(src, 'sound/machines/beep.ogg', 30, TRUE)
	personality_mode = !personality_mode
	speak_up("[personality_mode ? "pickup" : "putdown"]", ignores_personality_toggle = TRUE)
	return ..()

// Power cell for the big rifle
/obj/item/stock_parts/power_store/cell/hyeseong_internal_cell
	name = "\improper Hyeseong modular laser rifle internal cell"
	desc = "These are usually supposed to be inside of the gun, you know."
	maxcharge = STANDARD_CELL_CHARGE * 2

/datum/action/item_action/toggle_personality
	name = "Toggle Weapon Personality"
	desc = "Toggles the weapon's personality core. Studies find that turning them off makes them quite sad, however."
	background_icon_state = "bg_mod"

/datum/component/carrier/soulcatcher/modular_laser
	max_mobs = 1
	communicate_as_parent = TRUE

//Short version of the above modular rifle, has less charge and different modes
/obj/item/gun/energy/modular_laser_rifle/carbine
	name = "\improper Hoshi modular laser carbine"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/saibasan/guns32x.dmi'
	icon_state = "hoshi_kill"
	inhand_icon_state = "hoshi_kill"
	worn_icon_state = "hoshi_kill"
	base_icon_state = "hoshi"
	charge_sections = 3
	cell_type = /obj/item/stock_parts/power_store/cell
	ammo_type = list(/obj/item/ammo_casing/energy/cybersun_small_hellfire)
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT
	SET_BASE_PIXEL(0, 0)
	w_class = WEIGHT_CLASS_NORMAL
	weapon_weight = WEAPON_MEDIUM
	weapon_mode_options = list(
		/datum/laser_weapon_mode/hellfire,
		/datum/laser_weapon_mode/sword,
		/datum/laser_weapon_mode/flare,
		/datum/laser_weapon_mode/shotgun_small,
		/datum/laser_weapon_mode/trickshot_disabler,
	)
	default_selected_mode = "Incinerate"
	speech_json_file = SHORT_MOD_LASER_SPEECH
	expanded_examine_text = "The Hoshi carbine is the latest line of man-portable Marsian weapons platforms from \
		Cybersun Industries. Like her older sister weapon, the Hyeseong rifle, CI used funding aid provided by SolFed \
		to develop a portable weapon fueled by a proprietary generator rumored to be fueled by superstable plasma. A \
		lithe and mobile weapon, the Hoshi stars in close-quarters battle, trickshots, and area-of-effect blasts; though \
		ineffective at ranged combat. Her onboard machine intelligence, at first devised to support the operator and \
		manage the internal reactor, was originally shipped with a more energetic personality-- since influenced by 'negligence' \
		from users in wiping the intelligence's memory before resale or transport."

/obj/item/gun/energy/modular_laser_rifle/carbine/emp_act(severity)
	. = ..()
	speak_up("emp", TRUE) // She gets very upset if you emp her

#undef LONG_MOD_LASER_SPEECH
#undef SHORT_MOD_LASER_SPEECH
#undef MOD_LASER_SPEECH_COOLDOWN
#undef DEFAULT_RUNECHAT_GUN_COLOR
