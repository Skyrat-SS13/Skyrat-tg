/obj/item/storage/firstaid/expeditionary
	name = "combat medical kit"
	desc = "I hope you've got insurance."
	icon_state = "bezerk"
	damagetype_healed = "all"

/obj/item/storage/firstaid/expeditionary/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/firstaid/expeditionary/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/defibrillator/compact/combat/loaded/nanotrasen(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/clothing/glasses/hud/health/night(src)

/obj/item/shield/pointman
	name = "pointman shield"
	desc = "A shield fit for those that want to sprint headfirst into the unknown! Cumbersome as hell"
	icon_state = "riot"
	icon = 'modular_skyrat/modules/exp_corps/icons/riot.dmi'
	lefthand_file = 'modular_skyrat/modules/exp_corps/icons/riot_left.dmi'
	righthand_file = 'modular_skyrat/modules/exp_corps/icons/riot_right.dmi'
	force = 10
	throwforce = 5
	throw_speed = 1
	throw_range = 1
	block_chance = 45
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("shoves", "bashes")
	attack_verb_simple = list("shove", "bash")
	transparent = TRUE
	max_integrity = 120

/obj/item/shield/pointman/proc/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/glassbr3.ogg', 100)
	new /obj/item/pointman_broken((get_turf(src)))

/obj/item/pointman_broken
	name = "broken pointman shield"
	desc = "Might be able to be repaired with plasteel."
	icon_state = "riot_broken"
	icon = 'modular_skyrat/modules/exp_corps/icons/riot.dmi'
	w_class = WEIGHT_CLASS_BULKY
