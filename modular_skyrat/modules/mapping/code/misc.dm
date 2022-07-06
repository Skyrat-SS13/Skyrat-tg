/obj/item/melee/sabre/luna
	name = "Luna"
	desc = "Forged by a madwoman, in recognition of a time, a place - she thought almost real. Various etchings of moons are inscribed onto the surface, different phases marking different parts of the blade."
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/items_and_weapons.dmi'
	lefthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "luna"

/datum/mod_theme/prototype/hauler
	name = "Prototype: Hauler"
	desc = "Bulky and quite heavy, This prototype modular suit has seemed to be modified quite a bit with additional supports to distribute its weight. The servos there within have been modified to handle the additional stress, but the loose wiring required an internal lining of rubberized insulation"
	inbuilt_modules = list()
	charge_drain = DEFAULT_CHARGE_DRAIN * 3
	siemens_coefficient = 0
	slowdown_active = 1

/obj/item/mod/control/pre_equipped/prototype/hauler
	theme = /datum/mod_theme/prototype/hauler
	applied_cell = /obj/item/stock_parts/cell/high
	initial_modules = list(/obj/item/mod/module/storage/large_capacity, /obj/item/mod/module/welding, /obj/item/mod/module/clamp, /obj/item/mod/module/flashlight, /obj/item/mod/module/tether)

/obj/machinery/suit_storage_unit/industrial/hauler
	mod_type = /obj/item/mod/control/pre_equipped/prototype/hauler

/obj/item/areaeditor/blueprints/tarkon
	desc = "Blueprints of the Tarkon drill and several base designs for it. Red, stamped text reads \"Confidential\" on the backside of it."
	name = "Tarkon Design Prints"

/obj/item/mod/module/armor_booster/retractplates
	name = "MOD retractive plates module"
	desc = "A complex set of actuators, micro-seals and a simple guide on how to install it, This... \"Modification\" allows the plating around the joints to retract, giving minor protection and a bit better mobility."
	removable = TRUE
	complexity = 1
	speed_added = 0.25
	armor_values = list(MELEE = 20, BULLET = 25, LASER = 15, ENERGY = 20)
