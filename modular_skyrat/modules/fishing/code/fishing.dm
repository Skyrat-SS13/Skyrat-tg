GLOBAL_LIST_INIT(fishing_weights, list(
	/obj/item/stack/ore/diamond = 1,
	/obj/item/stack/ore/bluespace_crystal = 1,
	/obj/item/stack/ore/gold = 2,
	/obj/item/stack/ore/uranium = 2,
	/obj/item/stack/ore/titanium = 3,
	/obj/item/stack/ore/silver = 3,
	/obj/item/stack/ore/iron = 5,
	/obj/item/stack/ore/glass = 5,
	/obj/item/xenoarch/strange_rock = 2,
))

#define FOCUS_NONE	0
#define FOCUS_TRASH	1
#define FOCUS_FISH	2
#define FOCUS_ORE	3

/datum/component/fishing
	///the list of possible loot you can get from successfully fishing from this
	var/list/possible_loot = list()
	///whether this should generate fish when successfully fishing from this
	var/generate_fish = FALSE
	//the starting window for when to reel back in (too early before this)
	COOLDOWN_DECLARE(start_fishing_window)
	//the closing window for when to reel back in (too late past this)
	COOLDOWN_DECLARE(stop_fishing_window)
	///the timer for playing the sound for when to reel back in
	var/reel_sound_timer
	///to modify the parent with a bobber icon
	var/mutable_appearance/mutate_parent
	///the atom that has recieved this component
	var/atom/atom_parent

/datum/component/fishing/Initialize(list/set_loot, allow_fishes = FALSE)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	atom_parent = parent
	if(set_loot)
		possible_loot = set_loot
	if(allow_fishes)
		generate_fish = TRUE
	RegisterSignal(parent, COMSIG_START_FISHING, .proc/start_fishing)
	RegisterSignal(parent, COMSIG_FINISH_FISHING, .proc/finish_fishing)

/datum/component/fishing/Destroy(force, silent)
	UnregisterSignal(parent, COMSIG_START_FISHING)
	UnregisterSignal(parent, COMSIG_FINISH_FISHING)
	if(reel_sound_timer)
		deltimer(reel_sound_timer)
	return ..()

/datum/component/fishing/proc/start_fishing(mob/living/user)
	SIGNAL_HANDLER
	var/random_fish_time = rand(3 SECONDS, 6 SECONDS) * user.mind.get_skill_modifier(/datum/skill/fishing, SKILL_SPEED_MODIFIER)
	var/fishing_buffer = random_fish_time + (2 SECONDS / user.mind.get_skill_modifier(/datum/skill/fishing, SKILL_SPEED_MODIFIER))
	COOLDOWN_START(src, start_fishing_window, random_fish_time)
	COOLDOWN_START(src, stop_fishing_window, fishing_buffer)
	if(reel_sound_timer)
		deltimer(reel_sound_timer)
	if(mutate_parent)
		atom_parent.cut_overlay(mutate_parent)
		QDEL_NULL(mutate_parent)
	reel_sound_timer = addtimer(CALLBACK(src, .proc/reel_sound), random_fish_time, TIMER_STOPPABLE)
	mutate_parent = mutable_appearance(icon = 'modular_skyrat/modules/fishing/icons/fishing.dmi', icon_state = "bobber")
	atom_parent.add_overlay(mutate_parent)

//rather than making a visual change, create a sound to reel back in
/datum/component/fishing/proc/reel_sound()
	playsound(atom_parent, 'sound/machines/ping.ogg', 35, FALSE)
	atom_parent.do_alert_animation()

/datum/component/fishing/proc/finish_fishing(obj/item/fishing_rod/fisher = null, mob/living/user)
	SIGNAL_HANDLER
	if(reel_sound_timer)
		deltimer(reel_sound_timer)
	if(mutate_parent)
		atom_parent.cut_overlay(mutate_parent)
		QDEL_NULL(mutate_parent)
	if(!fisher || !istype(fisher))
		return
	if(COOLDOWN_FINISHED(src, start_fishing_window) && !COOLDOWN_FINISHED(src, stop_fishing_window))
		var/turf/fisher_turf = get_turf(fisher)
		create_reward(fisher_turf, fisher.fishing_focus, user)
		var/skill_prob = user.mind.get_skill_modifier(/datum/skill/fishing, SKILL_PROBS_MODIFIER)
		if(prob(skill_prob))
			create_reward(fisher_turf, fisher.fishing_focus, user)

/datum/component/fishing/proc/create_reward(turf/spawning_turf, focus, mob/living/user)
	var/atom/spawning_reward
	var/enhanced_reward = user.mind.get_skill_modifier(/datum/skill/fishing, SKILL_RANDS_MODIFIER)
	user.mind.adjust_experience(/datum/skill/fishing, 10)
	switch(focus)
		if(FOCUS_NONE)
			switch(rand(1, 100))
				if(1 to 33)
					spawning_reward = enhanced_reward ? pick_weight(GLOB.maintenance_loot) : pick_weight(GLOB.trash_loot)
					while(islist(spawning_reward))
						spawning_reward = pick_weight(spawning_reward)
				if(34 to 66)
					if(generate_fish)
						var/fish_type = random_fish_type()
						new fish_type(spawning_turf)
				if(67 to 100)
					spawning_reward = pick_weight(possible_loot)
		if(FOCUS_TRASH)
			spawning_reward = enhanced_reward ? pick_weight(GLOB.maintenance_loot) : pick_weight(GLOB.trash_loot)
			while(islist(spawning_reward))
				spawning_reward = pick_weight(spawning_reward)
		if(FOCUS_FISH)
			if(generate_fish)
				var/fish_type = random_fish_type()
				new fish_type(spawning_turf)
		if(FOCUS_ORE)
			spawning_reward = pick_weight(possible_loot)
	if(spawning_reward)
		new spawning_reward(spawning_turf)
	atom_parent.balloon_alert_to_viewers("something has been caught!")

/turf/open/water/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/fishing, set_loot = GLOB.fishing_weights, allow_fishes = TRUE)

/turf/open/lava/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/fishing, set_loot = GLOB.fishing_weights, allow_fishes = FALSE)

/obj/item/fishing_rod
	name = "fishing rod"
	desc = "A wonderful item that can be used to fish from bodies of liquids."
	icon = 'modular_skyrat/modules/fishing/icons/fishing.dmi'
	icon_state = "normal_rod"
	inhand_icon_state = "normal_rod"
	lefthand_file = 'modular_skyrat/modules/fishing/icons/fishing_left.dmi'
	righthand_file = 'modular_skyrat/modules/fishing/icons/fishing_right.dmi'
	///the target that is currently being fished from
	var/atom/target_atom
	///the mob that picked up/equiped the rod and will be listened to
	var/mob/listening_to
	///what the fishing rod will focus on when fishing
	var/fishing_focus = FOCUS_NONE
	///whether the fishing rod is being dual-wielded
	var/is_wielded = FALSE

/obj/item/fishing_rod/primitive
	icon_state = "lava_rod"
	inhand_icon_state = "lava_rod"

/obj/item/fishing_rod/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed)
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/fishing_rod/proc/on_wield()
	is_wielded = TRUE

/obj/item/fishing_rod/proc/on_unwield()
	is_wielded = FALSE

/obj/item/fishing_rod/examine(mob/user)
	. = ..()
	switch(fishing_focus)
		if(FOCUS_NONE)
			. += span_notice("There is no fishing attachment, this rod will fish normally!")
		if(FOCUS_TRASH)
			. += span_notice("There is a trash attachment, this rod will attempt to fish for trash solely!")
		if(FOCUS_ORE)
			. += span_notice("There is an ore attachment, this rod will attempt to fish for ore solely!")
		if(FOCUS_FISH)
			. += span_notice("There is a fish attachment, this rod will attempt to fish for fish solely!")

/obj/item/fishing_rod/Destroy()
	if(listening_to)
		UnregisterSignal(listening_to, COMSIG_MOVABLE_MOVED)
		listening_to = null
	if(target_atom)
		SEND_SIGNAL(target_atom, COMSIG_FINISH_FISHING, fisher = src)
		target_atom = null
	return ..()

/obj/item/fishing_rod/equipped(mob/user, slot, initial)
	. = ..()
	if(listening_to == user)
		return
	if(listening_to)
		UnregisterSignal(listening_to, COMSIG_MOVABLE_MOVED)
	if(target_atom)
		SEND_SIGNAL(target_atom, COMSIG_FINISH_FISHING, fisher = src)
		target_atom = null
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/check_movement)
	listening_to = user

/obj/item/fishing_rod/dropped(mob/user, silent)
	. = ..()
	if(listening_to)
		UnregisterSignal(listening_to, COMSIG_MOVABLE_MOVED)
		listening_to = null
	if(target_atom)
		SEND_SIGNAL(target_atom, COMSIG_FINISH_FISHING, fisher = src)
		target_atom = null

/obj/item/fishing_rod/proc/check_movement()
	SIGNAL_HANDLER
	if(!listening_to)
		return
	if(!target_atom)
		return
	if(get_dist(target_atom, listening_to) >= 4)
		SEND_SIGNAL(target_atom, COMSIG_FINISH_FISHING, fisher = src)

/obj/item/fishing_rod/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	var/skill_level = user.mind.get_skill_level(/datum/skill/fishing)
	if((!is_wielded && skill_level < SKILL_LEVEL_MASTER) || get_dist(target, user) >= 4)
		return
	if(target_atom)
		SEND_SIGNAL(target_atom, COMSIG_FINISH_FISHING, fisher = src, user = user)
		target_atom = null
		return
	var/check_fishable = target.GetComponent(/datum/component/fishing)
	if(!check_fishable)
		return ..()
	target_atom = target
	if(ismovable(target_atom))
		RegisterSignal(target_atom, COMSIG_MOVABLE_MOVED, .proc/check_movement, override = TRUE)
	SEND_SIGNAL(target_atom, COMSIG_START_FISHING, user = user)

/obj/item/fishing_rod/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/fishing_focus))
		if(fishing_focus != FOCUS_NONE)
			to_chat(user, span_warning("You need to remove the current attachment first, use a crowbar!"))
			return
		var/obj/item/fishing_focus/get_focus = attacking_item
		get_focus.forceMove(src)
		fishing_focus = get_focus.given_focus
		add_overlay(image(icon='modular_skyrat/modules/fishing/icons/fishing.dmi', icon_state="[get_focus.icon_state]_attach"))
		return
	return ..()

/obj/item/fishing_rod/crowbar_act(mob/living/user, obj/item/tool)
	var/obj/item/fishing_focus/find_focus = locate() in contents
	if(find_focus)
		find_focus.forceMove(get_turf(src))
	fishing_focus = FOCUS_NONE
	tool.play_tool_sound(src, 50)
	cut_overlays()
	return

/obj/item/fishing_focus
	icon = 'modular_skyrat/modules/fishing/icons/fishing.dmi'
	var/given_focus = FOCUS_NONE

/obj/item/fishing_focus/trash
	name = "magnetic bobber attachment"
	desc = "Perhaps you wanted to fish more trash, like a weirdo."
	icon_state = "magnet"
	given_focus = FOCUS_TRASH

/obj/item/fishing_focus/fish
	name = "bait bobber attachment"
	desc = "Perhaps you wanted to fish more fish, like an actual fisher."
	icon_state = "food"
	given_focus = FOCUS_FISH

/obj/item/fishing_focus/ore
	name = "pickaxe bobber attachment"
	desc = "Perhaps you wanted to fish more ore, like a weirdo."
	icon_state = "pick"
	given_focus = FOCUS_ORE

/datum/crafting_recipe/fishing_rod_primitive
	name = "Primitive Fishing Rod"
	result = /obj/item/fishing_rod
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide = 2,
				/obj/item/stack/sheet/sinew = 2)
	category = CAT_MISC

/datum/crafting_recipe/fishing_rod
	name = "Fishing Rod"
	result = /obj/item/fishing_rod
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/cable_coil = 2)
	category = CAT_MISC

/datum/crafting_recipe/trash_attachment
	name = "Magnetic Fishing Attachment"
	result = /obj/item/fishing_focus/trash
	reqs = list(/obj/item/forging/complete/plate = 1,
				/obj/item/forging/complete/chain = 1)
	category = CAT_MISC

/datum/crafting_recipe/fish_attachment
	name = "Bait Fishing Attachment"
	result = /obj/item/fishing_focus/fish
	reqs = list(/obj/item/food/grown = 1)
	category = CAT_MISC

/datum/crafting_recipe/ore_attachment
	name = "Pickaxe Fishing Attachment"
	result = /obj/item/fishing_focus/ore
	reqs = list(/obj/item/pickaxe = 1)
	category = CAT_MISC

#undef FOCUS_NONE
#undef FOCUS_TRASH
#undef FOCUS_FISH
#undef FOCUS_ORE
