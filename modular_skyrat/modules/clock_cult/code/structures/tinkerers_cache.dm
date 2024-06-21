/obj/structure/destructible/clockwork/gear_base/powered/tinkerers_cache
	name = "tinkerer's cache"
	desc = "A bronze store filled with parts and components."
	icon_state = "tinkerers_cache"
	base_icon_state = "tinkerers_cache"
	clockwork_desc = "Can be used to forge powerful Ratvarian items and traps at the cost of power and time."
	anchored = TRUE
	break_message = span_warning("The tinkerer's cache melts into a pile of brass.")
	has_on_icon = FALSE
	has_off_icon = FALSE
	has_power_toggle = FALSE
	COOLDOWN_DECLARE(use_cooldown)
	/// Assoc list of the names of all the craftable items to their path
	var/static/list/craft_possibilities


/obj/structure/destructible/clockwork/gear_base/powered/tinkerers_cache/Initialize(mapload)
	. = ..()
	if(!length(craft_possibilities))
		assemble_datum_list()


/obj/structure/destructible/clockwork/gear_base/powered/tinkerers_cache/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	if(!IS_CLOCK(user))
		to_chat(user, span_warning("You try to put your hand into [src], but almost burn yourself!"))
		return

	if(!anchored)
		to_chat(user, span_brass("[src] needs to be anchored to the floor first."))
		return

	if(depowered)
		to_chat(user, span_brass("[src] isn't connected to power!"))
		return

	if(!COOLDOWN_FINISHED(src, use_cooldown))
		to_chat(user, span_brass("[src] is still warming up, it will be ready in [DisplayTimeText(COOLDOWN_TIMELEFT(src, use_cooldown))]."))
		return

	var/list/real_possibilities = craft_possibilities.Copy()

	for(var/name in real_possibilities)
		var/datum/tinker_cache_item/path = real_possibilities[name]
		if(initial(path.research_locked) && !(path in GLOB.clockwork_research_unlocked_recipes))
			real_possibilities -= name

	var/selection = tgui_input_list(user, "Select an item to create at the forge.", "Forging", real_possibilities)

	if(!selection)
		return

	var/datum/tinker_cache_item/chosen_item = real_possibilities[selection]

	if(!can_interact(user) || !anchored || depowered || !chosen_item || !COOLDOWN_FINISHED(src, use_cooldown))
		return

	if(!LAZYLEN(transmission_sigils))
		to_chat(user, span_brass("This needs to be connected to a transmission sigil!"))
		return

	if(!use_power(initial(chosen_item.power_use)))
		to_chat(user, span_brass("You need more power to forge this item."))
		return

	COOLDOWN_START(src, use_cooldown, 4 MINUTES * initial(chosen_item.time_delay_mult))

	var/crafting_item = initial(chosen_item.item_path)
	new crafting_item(get_turf(src))
	playsound(src, 'modular_skyrat/modules/clock_cult/sound/machinery/steam_whoosh.ogg', 50)

	to_chat(user, span_brass("You craft [initial(chosen_item.name)] to near perfection, [src] cooling down. [initial(chosen_item.time_delay_mult) ? "It will be available in [DisplayTimeText(COOLDOWN_TIMELEFT(src, use_cooldown))]." : "It is ready to use again."]"))


// Assemble a list of subtype tinker cache datums
/obj/structure/destructible/clockwork/gear_base/powered/tinkerers_cache/proc/assemble_datum_list()
	craft_possibilities = list()
	for(var/type in subtypesof(/datum/tinker_cache_item))
		var/datum/tinker_cache_item/initial_item = type
		craft_possibilities["[initial(initial_item.name)] ([initial(initial_item.power_use)] W)"] = type


// This used to be a hardcoded list
/datum/tinker_cache_item
	/// Name of the item
	var/name = "abstract parent"
	/// Path to the object that this will create
	var/atom/item_path
	/// Amount of power this will consume to create
	var/power_use = 0
	/// Multiplier for time delay (default 4m) after producing this item
	var/time_delay_mult = 1
	/// If this is locked behind research
	var/research_locked = FALSE
	/// Override icon file for the item for the technologist's lectern
	var/research_icon
	/// Override icon state for the item for the technologist's lectern
	var/research_icon_state

/datum/tinker_cache_item/speed_robes
	name = "Robes Of Divinity"
	item_path = /obj/item/clothing/suit/clockwork/speed
	power_use = 200

/datum/tinker_cache_item/invis_cloak
	name = "Shrouding Cloak"
	item_path = /obj/item/clothing/suit/clockwork/cloak
	power_use = 200

/datum/tinker_cache_item/sight_goggles
	name = "Wraith Spectacles"
	item_path = /obj/item/clothing/glasses/clockwork/wraith_spectacles
	power_use = 500

/datum/tinker_cache_item/hud_visor
	name = "Judicial Visor"
	item_path = /obj/item/clothing/glasses/clockwork/judicial_visor
	power_use = 400

/datum/tinker_cache_item/replica_fabricator
	name = "Replica Fabricator"
	item_path = /obj/item/clockwork/replica_fabricator
	power_use = 400

/datum/tinker_cache_item/clockwork_rifle
	name = "Clockwork Rifle"
	item_path = /obj/item/gun/ballistic/rifle/lionhunter/clockwork
	power_use = 500
	research_locked = TRUE
	research_icon = 'modular_skyrat/modules/clock_cult/icons/weapons/clockwork_weapons.dmi'
	research_icon_state = "clockwork_rifle_research"

/datum/tinker_cache_item/clockwork_rifle_ammo
	name = "Clockwork Rifle Ammunition"
	item_path = /obj/item/ammo_box/strilka310/lionhunter/clock
	power_use = 200
	time_delay_mult = 0.5
	research_locked = TRUE

/datum/tinker_cache_item/tools
	name = "Equipped Toolbelt"
	item_path = /obj/item/storage/belt/utility/clock
	power_use = 300
	time_delay_mult = 0.75

/datum/tinker_cache_item/trap
	name = "Flipper (Trap)"
	item_path = /obj/item/clockwork/trap_placer/flipper
	power_use = 75
	time_delay_mult = 0

/datum/tinker_cache_item/trap/skewer
	name = "Skewer (Trap)"
	item_path = /obj/item/clockwork/trap_placer/skewer

/datum/tinker_cache_item/trap/delay
	name = "Delayer (Trigger)"
	item_path = /obj/item/wallframe/clocktrap/delay

/datum/tinker_cache_item/trap/lever
	name = "Lever (Trigger)"
	item_path = /obj/item/wallframe/clocktrap/lever

/datum/tinker_cache_item/trap/pressure
	name = "Pressure Sensor (Trigger)"
	item_path = /obj/item/clockwork/trap_placer/pressure_sensor
