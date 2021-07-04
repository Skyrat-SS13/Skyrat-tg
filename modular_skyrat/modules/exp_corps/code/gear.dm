//Gateway Medkit, no more combat defibs!
/obj/item/storage/firstaid/expeditionary
	name = "combat medical kit"
	desc = "Now with 100% less bullshit."
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
	new /obj/item/defibrillator/compact/loaded(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/clothing/glasses/hud/health/night(src)

//Pointman's riot shield. Fixable with 1 plasteel, crafting recipe for broken shield
/obj/item/shield/riot/pointman
	name = "pointman shield"
	desc = "A shield fit for those that want to sprint headfirst into the unknown! Cumbersome as hell."
	icon_state = "riot"
	icon = 'modular_skyrat/modules/exp_corps/icons/riot.dmi'
	lefthand_file = 'modular_skyrat/modules/exp_corps/icons/riot_left.dmi'
	righthand_file = 'modular_skyrat/modules/exp_corps/icons/riot_right.dmi'
	force = 14
	throwforce = 5
	throw_speed = 1
	throw_range = 1
	block_chance = 60
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("shoves", "bashes")
	attack_verb_simple = list("shove", "bash")
	transparent = TRUE
	max_integrity = 200
	var/repairable_by = /obj/item/stack/sheet/plasteel //what to repair the shield with

/obj/item/shield/riot/pointman/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/glassbr3.ogg', 100)
	new /obj/item/pointman_broken((get_turf(src)))

/obj/item/shield/riot/pointman/attackby(obj/item/W, mob/user, params)
	if(istype(W, repairable_by))
		var/obj/item/stack/sheet/plasteel_repair = W
		plasteel_repair.use(1)
		repair(user, params)
	return ..()

/obj/item/shield/riot/pointman/proc/repair(mob/user, params)
	obj_integrity = max_integrity
	if(user)
		UnregisterSignal(user, COMSIG_MOVABLE_MOVED)
		to_chat(user, span_notice("You fix the damage on [src]."))

/obj/item/pointman_broken
	name = "broken pointman shield"
	desc = "Might be able to be repaired with plasteel and a welder."
	icon_state = "riot_broken"
	icon = 'modular_skyrat/modules/exp_corps/icons/riot.dmi'
	w_class = WEIGHT_CLASS_BULKY

//broken shield fixing
/datum/crafting_recipe/pointman
	name = "Broken Riot Repair"
	result = /obj/item/shield/riot/pointman
	reqs = list(/obj/item/pointman_broken = 1,
				/obj/item/stack/sheet/plasteel = 3,
				/obj/item/stack/sheet/rglass = 3)
	time = 40
	category = CAT_MISC
	tool_behaviors = list(TOOL_WELDER)

//Marksman's throwing knife and a pouch for it
/obj/item/kitchen/knife/combat/marksman
	name = "throwing knife"
	desc = "Very well weighted for throwing, feels awkward to use for anything else."
	icon = 'modular_skyrat/modules/exp_corps/icons/throwing.dmi'
	icon_state = "throwing"
	force = 12
	throwforce = 24

/obj/item/storage/bag/ammo/marksman
	name = "marksman's knife pouch"

/obj/item/storage/bag/ammo/marksman/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 60
	STR.max_items = 8
	STR.display_numerical_stacking = TRUE
	STR.can_hold = typecacheof(list(/obj/item/kitchen/knife/combat))

/obj/item/storage/bag/ammo/marksman/PopulateContents()
	new /obj/item/kitchen/knife/combat/marksman(src)
	new /obj/item/kitchen/knife/combat/marksman(src)
	new /obj/item/kitchen/knife/combat/marksman(src)
	new /obj/item/kitchen/knife/combat/marksman(src)

