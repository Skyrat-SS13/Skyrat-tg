/obj/item/autosurgeon/bodypart
	name = "bodypart upgrade autosurgeon"
	desc = "A device that will expertly replace your bodypart."

	var/bodypart_type = /obj/item/bodypart

	var/starting_bodypart //The bodypart we come with

	var/obj/item/bodypart/storedbodypart

/obj/item/autosurgeon/bodypart/Initialize(mapload)
	. = ..()
	if(starting_bodypart)
		insert_bodypart(new starting_bodypart(src))

/obj/item/autosurgeon/bodypart/proc/insert_bodypart(obj/item/I)
	storedbodypart = I
	I.forceMove(src)
	name = "[initial(name)] ([storedbodypart.name])"

/obj/item/autosurgeon/bodypart/attack_self(mob/user)//when the object it used...
	if(!uses)
		to_chat(user, span_alert("[src] has already been used. The tools are dull and won't reactivate."))
		return
	if(!storedbodypart)
		to_chat(user, span_alert("[src] currently has no implant stored."))
		return
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user

	var/obj/item/bodypart/oldBP = H.get_bodypart(storedbodypart.body_zone)

	if(oldBP)
		to_chat(H, span_warning("The [src] removes your [oldBP.name]!"))
		oldBP.dismember()

	user.visible_message(span_notice("[H] presses a button on [src], and you hear a short mechanical noise."), span_notice("You feel a sharp sting as [src] plunges into your body."))

	if(!storedbodypart.try_attach_limb(H))
		to_chat(H, span_warning("The [src] fails to attach [storedbodypart]!"))
		return

	playsound(get_turf(H), 'sound/weapons/circsawhit.ogg', 50, TRUE)
	storedbodypart = null
	name = initial(name)
	if(uses != INFINITE)
		uses--
	if(!uses)
		desc = "[initial(desc)] Looks like it's been used up."

/obj/item/autosurgeon/bodypart/attackby(obj/item/I, mob/user, params)
	if(istype(I, bodypart_type))
		if(storedbodypart)
			to_chat(user, span_alert("[src] already has an implant stored."))
			return
		else if(!uses)
			to_chat(user, span_alert("[src] has already been used up."))
			return
		if(!user.transferItemToLoc(I, src))
			return
		storedbodypart = I
		to_chat(user, span_notice("You insert the [I] into [src]."))
	else
		return ..()

/obj/item/autosurgeon/bodypart/screwdriver_act(mob/living/user, obj/item/I)
	if(..())
		return TRUE
	if(!storedbodypart)
		to_chat(user, span_warning("There's no implant in [src] for you to remove!"))
	else
		var/atom/drop_loc = user.drop_location()
		for(var/J in src)
			var/atom/movable/AM = J
			AM.forceMove(drop_loc)

		to_chat(user, span_notice("You remove the [storedbodypart] from [src]."))
		I.play_tool_sound(src)
		storedbodypart = null
		if(uses != INFINITE)
			uses--
		if(!uses)
			desc = "[initial(desc)] Looks like it's been used up."
	return TRUE

/obj/item/autosurgeon/bodypart/l_arm_robotic
	starting_bodypart = /obj/item/bodypart/l_arm/robot

/obj/item/autosurgeon/bodypart/l_arm_robotic/Initialize(mapload)
	. = ..()
	storedbodypart.icon = 'modular_skyrat/master_files/icons/mob/augmentation/hi2ipc.dmi'
	storedbodypart.organic_render = FALSE
