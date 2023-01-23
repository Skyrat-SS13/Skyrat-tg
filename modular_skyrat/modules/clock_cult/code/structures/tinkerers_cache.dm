/obj/structure/destructible/clockwork/gear_base/tinkerers_cache
	name = "tinkerer's cache"
	desc = "A bronze store filled with parts and components."
	icon_state = "tinkerers_cache"
	clockwork_desc = "Can be used to forge powerful Ratvarian items at the cost of power and time."
	anchored = TRUE
	break_message = span_warning("The tinkerer's cache melts into a pile of brass.")
	COOLDOWN_DECLARE(use_cooldown)
	/// Assoc list of the names of all the craftable items to their path
	var/static/list/craft_possibilities


/obj/structure/destructible/clockwork/gear_base/tinkerers_cache/Initialize(mapload)
	. = ..()
	if(!length(craft_possibilities))
		assemble_datum_list()


/obj/structure/destructible/clockwork/gear_base/tinkerers_cache/attack_hand(mob/living/user)
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

	var/selection = tgui_input_list(user, "Select an item to create at the forge.", "Forging", craft_possibilities)
	
	if(!selection)
		return
		
	var/datum/tinker_cache_item/chosen_item = craft_possibilities[selection]

	if(!can_interact(user) || !anchored || depowered || !chosen_item)
		return

	if(!LAZYLEN(transmission_sigils))
		to_chat(user, span_brass("This needs to be connected to a transmission sigil!"))
		return

	if(!check_power(initial(chosen_item.power_use)))
		to_chat(user, span_brass("You need more power to forge this item."))
		return

	COOLDOWN_START(src, use_cooldown, 4 MINUTES)

	var/crafting_item = initial(chosen_item.item_path)
	new crafting_item(get_turf(src))
	playsound(src, 'sound/machines/clockcult/steam_whoosh.ogg', 50)

	to_chat(user, span_brass("You craft a [crafting_item] to near perfection, [src] cooling down."))


// Assemble a list of subtype tinker cache datums
/obj/structure/destructible/clockwork/gear_base/tinkerers_cache/proc/assemble_datum_list()
	craft_possibilities = list()
	for(var/type in subtypesof(/datum/tinker_cache_item))
		var/datum/tinker_cache_item/initial_item = type
		craft_possibilities["[initial(initial_item.name)] ([initial(initial_item.power_use)] W)"] = type


// This used to be a hardcoded list
/datum/tinker_cache_item
	/// Name of the item
	var/name = "abstract parent"
	/// Path to the object that this will create
	var/item_path
	/// Amount of power this will consume to create
	var/power_use = 0

/datum/tinker_cache_item/speed_robes
	name = "Robes Of Divinity"
	item_path = /obj/item/clothing/suit/clockwork/speed
	power_use = 100

/datum/tinker_cache_item/invis_cloak
	name = "Shrouding Cloak"
	item_path = /obj/item/clothing/suit/clockwork/cloak
	power_use = 100

/datum/tinker_cache_item/sight_goggles
	name = "Wraith Spectacles"
	item_path = /obj/item/clothing/glasses/clockwork/wraith_spectacles
	power_use = 250

/datum/tinker_cache_item/hud_visor
	name = "Judicial Visor"
	item_path = /obj/item/clothing/glasses/clockwork/judicial_visor
	power_use = 200
