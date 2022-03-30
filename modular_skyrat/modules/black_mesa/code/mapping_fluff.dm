/obj/structure/alien/weeds/xen
	name = "xen weeds"
	desc = "A thick vine-like surface covers the floor."
	color = "#ac3b06"

/obj/structure/spacevine/xen
	name = "xen vines"
	color = "#ac3b06"

/obj/structure/spacevine/xen/Initialize(mapload)
	. = ..()
	add_atom_colour("#ac3b06", FIXED_COLOUR_PRIORITY)

/obj/structure/spacevine/xen/thick
	name = "thick xen vines"
	color = "#ac3b06"
	opacity = TRUE

/obj/structure/mineral_door/xen
	name = "organic door"
	color = "#ff8d58"
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_door.dmi'
	icon_state = "resin"
	openSound = 'modular_skyrat/modules/black_mesa/sound/xen_door.ogg'
	closeSound = 'modular_skyrat/modules/black_mesa/sound/xen_door.ogg'

/obj/machinery/door/keycard/xen_boss
	name = "locktight organic door"
	desc = "Complete the puzzle to open this door."
	icon = 'modular_skyrat/modules/black_mesa/icons/xen_door.dmi'
	icon_state = "resin"
	puzzle_id = "xen"

/obj/item/keycard/xen
	name = "xen keycard"
	desc = "A xen keycard."
	color = "#ac3b06"
	puzzle_id = "xen"

/obj/effect/sliding_puzzle/xen
	reward_type = /obj/item/keycard/xen

/obj/structure/xen_crystal
	name = "resonating crystal"
	desc = "A strange resinating crystal."
	icon = 'modular_skyrat/modules/black_mesa/icons/plants.dmi'
	icon_state = "crystal"
	light_power = 2
	light_range = 4
	density = TRUE
	/// Have we been harvested?
	var/harvested = FALSE

/obj/structure/xen_crystal/Initialize(mapload)
	. = ..()
	var/color_to_set = pick(COLOR_VIBRANT_LIME, COLOR_RED, COLOR_PURPLE)
	color = color_to_set
	light_color = color_to_set

/obj/structure/xen_crystal/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(harvested)
		to_chat(user, span_warning("[src] has already been harvested!"))
		return
	to_chat(user, span_notice("You start harvesting [src]!"))
	if(do_after(user, 5 SECONDS, src))
		harvest(user)

/obj/structure/xen_crystal/proc/harvest(mob/living/user)
	if(harvested)
		return
	to_chat(user, span_notice("You harvest [src]!"))
	var/obj/item/grenade/xen_crystal/nade = new (get_turf(src))
	nade.color = color
	harvested = TRUE

/obj/item/grenade/xen_crystal
	name = "xen crystal"
	desc = "A crystal with anomalous properties."
	icon = 'modular_skyrat/modules/black_mesa/icons/plants.dmi'
	icon_state = "crystal"
	/// What range do we effect mobs?
	var/effect_range = 5
	/// The faction we convert the mobs to
	var/factions = list(FACTION_STATION)
	/// Mobs in this list will not be affected by this grenade.
	var/list/blacklisted_mobs = list(
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman,
		/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth,
	)

/obj/item/grenade/xen_crystal/detonate(mob/living/lanced_by)
	for(var/mob/living/mob_to_neutralize in view(src, effect_range))
		if(is_type_in_list(mob_to_neutralize, blacklisted_mobs))
			return
		mob_to_neutralize.faction = factions
		mob_to_neutralize.visible_message(span_green("[mob_to_neutralize] is overcome by a wave of peace and tranquility!"))
		new /obj/effect/temp_visual/heal(get_turf(mob_to_neutralize))
