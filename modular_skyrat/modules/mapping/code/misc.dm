/obj/item/melee/sabre/luna
	name = "Luna"
	desc = "Forged by a madwoman, in recognition of a time, a place - she thought almost real. Various etchings of moons are inscribed onto the surface, different phases marking different parts of the blade."
	icon = 'modular_skyrat/modules/mapping/icons/obj/items/items_and_weapons.dmi'
	lefthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/mapping/icons/mob/inhands/weapons/swords_righthand.dmi'
	icon_state = "luna"
	inhand_icon_state = "luna"


/obj/item/mod/module/armor_booster/retractplates
	name = "MOD retractive plates module"
	desc = "A complex set of actuators, micro-seals and a simple guide on how to install it, This... \"Modification\" allows the plating around the joints to retract, giving minor protection and a bit better mobility."
	removable = TRUE
	complexity = 1
	speed_added = 0.25
	armor_mod = /datum/armor/retractive_plates

/datum/armor/retractive_plates
	melee = 20
	bullet = 25
	laser = 15
	energy = 20

/obj/machinery/vending/security/noaccess
	req_access = null

/obj/structure/closet/secure_closet/medical2/unlocked/Initialize(mapload)
	. = ..()
	locked = FALSE
	update_appearance()
