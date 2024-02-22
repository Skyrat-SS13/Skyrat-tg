/datum/quirk/better_aim
	name = "Marksman"
	desc = "Training is not the same thing as LARPing. Prove it by action. Heavy recoil is still a problem though."
	icon = FA_ICON_CROSSHAIRS
	value = 7 //It is not something crazy just because screen shake will still make your aim fly. It still can offset some negative effects present in the code
	medical_record_text = "Patient's 'aim' is very 'tight'. It is unhealthy and leads to lead poisoning, severe burns, unprovoked agression and inflated ego. Ask them to relax it."
	hardcore_value = -7
	mail_goodies = list(/obj/item/cardboard_cutout) // for target practice

/datum/quirk/better_aim/add(client/client_source)
	RegisterSignal(quirk_holder, COMSIG_MOB_FIRED_GUN, PROC_REF(on_mob_fired_gun))

/datum/quirk/better_aim/remove(client/client_source)
	UnregisterSignal(quirk_holder, COMSIG_MOB_FIRED_GUN)

/datum/quirk/better_aim/proc/on_mob_fired_gun(mob/user, obj/item/gun/gun_fired, target, params, zone_override, list/bonus_spread_values)
	SIGNAL_HANDLER
	bonus_spread_values[MIN_BONUS_SPREAD_INDEX] -= 15
	bonus_spread_values[MAX_BONUS_SPREAD_INDEX] -= 30

