/obj/item/melee/sabre/luna
	name = "Luna"
	desc = "Forged by a madwoman, in recognition of a time, a place - she thought almost real. Various etchings of moons are inscribed onto the surface, different phases marking different parts of the blade."
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/items_and_weapons.dmi'
	lefthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "luna"

/datum/mod_theme/prototype/hauler
	name = "Prototype: Hauler"
	desc = "Bulky and quite heavy, This prototype modular suit has seemed to be modified quite a bit with additional supports to distribute its weight."
	inbuilt_modules = null
	slowdown_active = 1

/obj/item/mod/control/pre_equipped/prototype/hauler
	theme = /datum/mod_theme/prototype/hauler
	cell = /obj/item/stock_parts/cell/high/plus
	initial_modules = list(/obj/item/mod/module/storage/large_capacity, /obj/item/mod/module/welding, /obj/item/mod/module/clamp, /obj/item/mod/module/flashlight, /obj/item/mod/module/tether)
