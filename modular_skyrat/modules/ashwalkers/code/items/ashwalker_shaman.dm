//ASH STAFF
/obj/item/ash_staff
	name = "staff of the ashlands"
	desc = "A gnarly and twisted branch that is imbued with some ancient power."

	icon = 'icons/obj/weapons/guns/magic.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	icon_state = "staffofanimation"
	inhand_icon_state = "staffofanimation"

	///If the world.time is above this, it wont work. Charging requires whacking the necropolis nest
	var/staff_time = 0

/obj/item/ash_staff/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!user.mind.has_antag_datum(/datum/antagonist/ashwalker))
		return NONE
	if(istype(interacting_with, /obj/structure/lavaland/ash_walker))
		return NONE
	if(!isopenturf(interacting_with))
		return NONE
	var/turf/target_turf = interacting_with
	if(istype(interacting_with, /turf/open/misc/asteroid/basalt/lava_land_surface))
		to_chat(user, span_warning("You begin to corrupt the land even further..."))
		if(!do_after(user, 4 SECONDS, target = target_turf))
			to_chat(user, span_warning("[src] had their casting cut short!"))
			return ITEM_INTERACT_BLOCKING
		target_turf.ChangeTurf(/turf/open/lava/smooth/lava_land_surface)
		to_chat(user, span_notice("[src] sparks, corrupting the area too far!"))
		return
	if(world.time > staff_time)
		to_chat(user, span_warning("[src] has had its permission expire from the necropolis!"))
		return ITEM_INTERACT_BLOCKING
	if(!do_after(user, 2 SECONDS, target = target_turf))
		to_chat(user, span_warning("[src] had their casting cut short!"))
		return ITEM_INTERACT_BLOCKING
	target_turf.ChangeTurf(/turf/open/misc/asteroid/basalt/lava_land_surface)
	return ITEM_INTERACT_SUCCESS

/obj/structure/lavaland/ash_walker/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/ash_staff) && user.mind.has_antag_datum(/datum/antagonist/ashwalker))
		var/obj/item/ash_staff/target_staff = I
		target_staff.staff_time = world.time + 5 MINUTES
		playsound(src, 'sound/magic/demon_consume.ogg', 50, TRUE)
		to_chat(user, span_notice("The tendril permits you to have more time to corrupt the world with ashes."))
		return
	return ..()

//generic ash item recipe
/datum/crafting_recipe/ash_recipe
	reqs = list(
		/obj/item/stack/sheet/bone = 1,
		/obj/item/stack/sheet/sinew = 1,
	)
	time = 4 SECONDS
	category = CAT_TOOLS
