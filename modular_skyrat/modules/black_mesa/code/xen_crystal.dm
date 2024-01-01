/obj/structure/xen_crystal
	name = "resonating crystal"
	desc = "A strange resinating crystal."
	icon = 'modular_skyrat/modules/black_mesa/icons/plants.dmi'
	icon_state = "crystal"
	light_power = 2
	light_range = 4
	density = TRUE
	anchored = TRUE
	/// Have we been harvested?
	var/harvested = FALSE

/obj/structure/xen_crystal/Initialize(mapload)
	. = ..()
	var/color_to_set = pick(COLOR_VIBRANT_LIME, COLOR_VIVID_YELLOW, COLOR_LIGHT_PINK, LIGHT_COLOR_ELECTRIC_GREEN)
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
	update_appearance()

/obj/structure/xen_crystal/update_icon_state()
	. = ..()
	if(harvested)
		icon_state = "crystal_harvested"
	else
		icon_state = "crystal"

/obj/item/grenade/xen_crystal
	name = "xen crystal"
	desc = "A crystal with anomalous properties."
	icon = 'modular_skyrat/modules/black_mesa/icons/plants.dmi'
	icon_state = "crystal_grenade"
	/// What range do we effect mobs?
	var/effect_range = 6
	/// The faction we convert the mobs to
	var/factions = list(FACTION_STATION, "neutral")
	/// Mobs in this list will not be affected by this grenade.
	var/list/blacklisted_mobs = list(
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab_zombie/gordon_freeman,
		/mob/living/simple_animal/hostile/blackmesa/xen/nihilanth,
	)

/obj/item/grenade/xen_crystal/detonate(mob/living/lanced_by)
	for(var/mob/living/mob_to_neutralize in view(src, effect_range))
		if(is_type_in_list(mob_to_neutralize, blacklisted_mobs))
			return
		mob_to_neutralize.faction |= factions
		mob_to_neutralize.visible_message(span_green("[mob_to_neutralize] is overcome by a wave of peace and tranquility!"))
		new /obj/effect/particle_effect/sparks/quantum(get_turf(mob_to_neutralize))
	qdel(src)

/datum/export/xen_crystal
	cost = CARGO_CRATE_VALUE * 6 //1200
	unit_name = "anomalous crystal sample"
	export_types = list(/obj/item/grenade/xen_crystal)
	include_subtypes = FALSE
