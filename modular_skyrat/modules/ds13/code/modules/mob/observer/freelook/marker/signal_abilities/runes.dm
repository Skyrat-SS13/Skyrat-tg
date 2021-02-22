/datum/signal_ability/runes
	name = "Bloody Rune"
	id = "rune"
	desc = "Creates a spooky rune. Has no functional effects, just for decoration"
	target_string = "a wall or floor"
	energy_cost = 16
	require_corruption = FALSE
	autotarget_range = 0
	LOS_block = FALSE	//This is for spooking people, we want them to see it happen
	target_types = list(/turf/simulated)

/datum/signal_ability/runes/on_cast(var/mob/user, var/atom/target, var/list/data)
	GLOB.cult.powerless = TRUE //Just in case. This makes sure the runes don't do anything
	new /obj/random/rune(target)



/obj/random/rune /*Better loot for away missions and salvage */
	name = "random rune"
	desc = "This is some random loot."
	icon = 'icons/obj/items.dmi'
	icon_state = "gift3"

/obj/random/rune/item_to_spawn()
	return pickweight(list(/obj/effect/rune/convert,
				/obj/effect/rune/teleport,
				/obj/effect/rune/tome,
				/obj/effect/rune/wall,
				/obj/effect/rune/ajorney,
				/obj/effect/rune/defile,
				/obj/effect/rune/offering,
				/obj/effect/rune/drain,
				/obj/effect/rune/emp,
				/obj/effect/rune/massdefile,
				/obj/effect/rune/weapon,
				/obj/effect/rune/shell,
				/obj/effect/rune/confuse,
				/obj/effect/rune/revive,
				/obj/effect/rune/blood_boil,
				/obj/effect/rune/tearreality))