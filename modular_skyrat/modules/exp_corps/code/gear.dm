//Gateway Medkit, no more combat defibs!
/obj/item/storage/medkit/expeditionary
	name = "combat medical kit"
	desc = "Now with 100% less bullshit."
	icon_state = "medkit_tactical"
	damagetype_healed = "all"

/obj/item/storage/medkit/expeditionary/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/medkit/expeditionary/PopulateContents()
	if(empty)
		return
	new /obj/item/stack/medical/gauze(src)
	new /obj/item/stack/medical/splint(src)
	new /obj/item/defibrillator/compact/loaded(src)
	new /obj/item/reagent_containers/hypospray/combat(src)
	new /obj/item/stack/medical/mesh/advanced(src)
	new /obj/item/stack/medical/suture/medicated(src)
	new /obj/item/clothing/glasses/hud/health(src)

//Field Medic's weapon, no more tomahawk!
/obj/item/circular_saw/field_medic
	name = "bone saw"
	desc = "Did that sting? SAW-ry!"
	force = 20
	icon_state = "bonesaw"
	icon = 'modular_skyrat/modules/exp_corps/icons/bonesaw.dmi'
	lefthand_file = 'modular_skyrat/modules/exp_corps/icons/bonesaw_l.dmi'
	righthand_file = 'modular_skyrat/modules/exp_corps/icons/bonesaw_r.dmi'
	hitsound = 'sound/weapons/bladeslice.ogg'
	toolspeed = 0.2
	throw_range = 3
	w_class = WEIGHT_CLASS_SMALL

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
	atom_integrity = max_integrity
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
/obj/item/knife/combat/marksman
	name = "throwing knife"
	desc = "Very well weighted for throwing, feels awkward to use for anything else."
	icon = 'modular_skyrat/modules/exp_corps/icons/throwing.dmi'
	icon_state = "throwing"
	force = 12
	throwforce = 30

/obj/item/storage/bag/ammo/marksman
	name = "marksman's knife pouch"
	component_type = /datum/component/storage/concrete/marksman

/obj/item/storage/bag/ammo/marksman/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.max_combined_w_class = 60
	STR.max_items = 10
	STR.display_numerical_stacking = TRUE
	STR.can_hold = typecacheof(list(/obj/item/knife/combat))

/datum/component/storage/concrete/marksman/open_storage(mob/user)
	if(!isliving(user) || !user.CanReach(parent) || user.incapacitated())
		return FALSE
	if(locked)
		to_chat(user, span_warning("[parent] seems to be locked!"))
		return

	var/obj/item/knife/combat/knife_to_draw = locate() in real_location()
	if(!knife_to_draw)
		return ..()
	remove_from_storage(knife_to_draw, get_turf(user))
	playsound(parent, 'modular_skyrat/modules/sec_haul/sound/holsterout.ogg', 50, TRUE, -5)
	INVOKE_ASYNC(user, /mob/.proc/put_in_hands, knife_to_draw)
	user.visible_message(span_warning("[user] draws [knife_to_draw] from [parent]!"), span_notice("You draw [knife_to_draw] from [parent]."))

/obj/item/storage/bag/ammo/marksman/PopulateContents() //can kill most basic enemies with 5 knives, though marksmen shouldn't be soloing enemies anyways
	new /obj/item/knife/combat/marksman(src)
	new /obj/item/knife/combat/marksman(src)
	new /obj/item/knife/combat/marksman(src)
	new /obj/item/knife/combat/marksman(src)
	new /obj/item/knife/combat/marksman(src)
