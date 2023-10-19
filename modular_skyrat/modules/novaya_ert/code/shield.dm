/obj/item/shield/riot/pointman/nri
	name = "heavy corpsman shield"
	desc = "A shield designed for people that have to sprint to the rescue. Cumbersome as hell. Repair with plasteel."
	icon_state = "riot"
	icon = 'modular_skyrat/modules/novaya_ert/icons/riot.dmi'
	lefthand_file = 'modular_skyrat/modules/novaya_ert/icons/riot_left.dmi'
	righthand_file = 'modular_skyrat/modules/novaya_ert/icons/riot_right.dmi'
	transparent = FALSE

/obj/item/shield/riot/pointman/nri/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/glassbr3.ogg', 100)
	new /obj/item/corpsman_broken((get_turf(src)))


/obj/item/corpsman_broken
	name = "broken corpsman shield"
	desc = "Might be able to be repaired with a welder."
	icon_state = "riot_broken"
	icon = 'modular_skyrat/modules/novaya_ert/icons/riot.dmi'
	w_class = WEIGHT_CLASS_BULKY

/obj/item/corpsman_broken/welder_act(mob/living/user, obj/item/I)
	..()
	new /obj/item/shield/riot/pointman/nri((get_turf(src)))
	qdel(src)
