//ASH TOOL
/obj/item/screwdriver/ashwalker
	name = "primitive screwdriver"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "screwdriver"

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_screwdriver
	name = "Ash Screwdriver"
	result = /obj/item/screwdriver/ashwalker

/obj/item/wirecutters/ashwalker
	name = "primitive wirecutters"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "cutters"

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_cutters
	name = "Ash Wirecutters"
	result = /obj/item/wirecutters/ashwalker

/obj/item/wrench/ashwalker
	name = "primitive wrench"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "wrench"

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_wrench
	name = "Ash Wrench"
	result = /obj/item/wrench/ashwalker

/obj/item/crowbar/ashwalker
	name = "primitive crowbar"
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "crowbar"

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_crowbar
	name = "Ash Crowbar"
	result = /obj/item/crowbar/ashwalker

/obj/item/cursed_dagger
	name = "cursed ash dagger"
	desc = "A blunted dagger that seems to cause the shadows near it to tremble."
	icon = 'icons/obj/weapons/sword.dmi'
	icon_state = "crysknife"
	inhand_icon_state = "crysknife"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'

/obj/item/cursed_dagger/examine(mob/user)
	. = ..()
	. += span_notice("To be used on tendrils. It will visually change the tendril to indicate whether it has been cursed or not.")

/obj/item/tendril_seed
	name = "tendril seed"
	desc = "A horrible fleshy mass that pulse with a dark energy."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
	icon_state = "tendril_seed"

/obj/item/tendril_seed/examine(mob/user)
	. = ..()
	. += span_notice("In order to be planted, it is required to be on the mining level as well as on basalt.")

/obj/item/tendril_seed/attack_self(mob/user, modifiers)
	. = ..()
	var/turf/src_turf = get_turf(src)
	if(!is_mining_level(src_turf.z) || !istype(src_turf, /turf/open/misc/asteroid/basalt))
		return
	if(!isliving(user))
		return
	var/mob/living/living_user = user
	to_chat(living_user, span_warning("You begin to squeeze [src]..."))
	if(!do_after(living_user, 4 SECONDS, target = src))
		return
	to_chat(living_user, span_warning("[src] begins to crawl between your hand's appendages, crawling up your arm..."))
	living_user.adjustBruteLoss(35)
	if(!do_after(living_user, 4 SECONDS, target = src))
		return
	to_chat(living_user, span_warning("[src] wraps around your chest and begins to tighten, causing an odd needling sensation..."))
	living_user.adjustBruteLoss(35)
	if(!do_after(living_user, 4 SECONDS, target = src))
		return
	to_chat(living_user, span_warning("[src] leaps from you satisfied and begins to grossly assemble itself!"))
	var/type = pick(/obj/structure/spawner/lavaland, /obj/structure/spawner/lavaland/goliath, /obj/structure/spawner/lavaland/legion)
	new type(user.loc)
	playsound(get_turf(src), 'sound/magic/demon_attack1.ogg', 50, TRUE)
	qdel(src)
