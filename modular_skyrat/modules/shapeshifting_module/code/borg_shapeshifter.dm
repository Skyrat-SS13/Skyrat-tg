/obj/item/borg_shapeshifter
	name = "cyborg chameleon projector"
	icon = 'icons/obj/device.dmi'
	icon_state = "shield0"
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/saved_icon
	var/saved_bubble_icon
	var/saved_icon_override
	var/saved_model_name
	var/saved_model_features
	var/saved_special_light_key
	var/saved_hat_offset
	var/active = FALSE
	var/activationCost = 100
	var/activationUpkeep = 5
	var/disguise_model_name
	var/disguise
	var/disguise_icon_override
	var/disguise_pixel_offset = 0
	var/disguise_hat_offset = 0
	/// Traits unique to this model (deadsprite, wide/dogborginess, etc.). Mirrors the definition in modular_skyrat\modules\altborgs\code\modules\mob\living\silicon\robot\robot_model.dm
	var/list/disguise_model_features = list()
	var/disguise_special_light_key
	var/mob/listeningTo
	var/list/signalCache = list( // list here all signals that should break the camouflage
			COMSIG_PARENT_ATTACKBY,
			COMSIG_ATOM_ATTACK_HAND,
			COMSIG_MOVABLE_IMPACT_ZONE,
			COMSIG_ATOM_BULLET_ACT,
			COMSIG_ATOM_EX_ACT,
			COMSIG_ATOM_FIRE_ACT,
			COMSIG_ATOM_EMP_ACT,
			)
	var/mob/living/silicon/robot/user // needed for process()
	var/animation_playing = FALSE

/obj/item/borg_shapeshifter/Initialize()
	. = ..()

/obj/item/borg_shapeshifter/Destroy()
	listeningTo = null
	return ..()

/obj/item/borg_shapeshifter/dropped(mob/user)
	. = ..()
	disrupt(user)

/obj/item/borg_shapeshifter/equipped(mob/user)
	. = ..()
	disrupt(user)

/**
  * check_menu: Checks if we are allowed to interact with a radial menu
  *
  * Arguments:
  * * user The mob interacting with a menu
  */
/obj/item/borg_shapeshifter/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/borg_shapeshifter/attack_self(mob/living/silicon/robot/user)
	if (user && user.cell && user.cell.charge >  activationCost)
		if (isturf(user.loc))
			toggle(user)
		else
			to_chat(user, span_warning("You can't use [src] while inside something!"))
	else
		to_chat(user, span_warning("You need at least [activationCost] charge in your cell to use [src]!"))

/obj/item/borg_shapeshifter/proc/toggle(mob/living/silicon/robot/user)
	if(active)
		playsound(src, 'sound/effects/pop.ogg', 100, TRUE, -6)
		to_chat(user, span_notice("You deactivate \the [src]."))
		deactivate(user)
	else
		if(animation_playing)
			to_chat(user, span_notice("\the [src] is recharging."))
			return
		var/static/list/model_icons = sort_list(list(
			"Standard" = image(icon = 'icons/mob/robots.dmi', icon_state = "robot"),
			"Medical" = image(icon = 'icons/mob/robots.dmi', icon_state = "medical"),
			"Cargo" = image(icon = CYBORG_ICON_CARGO, icon_state = "cargoborg"),
			"Engineer" = image(icon = 'icons/mob/robots.dmi', icon_state = "engineer"),
			"Security" = image(icon = 'icons/mob/robots.dmi', icon_state = "sec"),
			"Service" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_f"),
			"Janitor" = image(icon = 'icons/mob/robots.dmi', icon_state = "janitor"),
			"Miner" = image(icon = 'icons/mob/robots.dmi', icon_state = "miner"),
			"Peacekeeper" = image(icon = 'icons/mob/robots.dmi', icon_state = "peace"),
			"Clown" = image(icon = 'icons/mob/robots.dmi', icon_state = "clown"),
			"Syndicate" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_sec"),
			"Spider Clan" = image(icon = CYBORG_ICON_NINJA, icon_state = "ninja_engi")
		))
		var/model_selection = show_radial_menu(user, user, model_icons, custom_check = CALLBACK(src, .proc/check_menu, user), radius = 42, require_near = TRUE)
		if(!model_selection)
			return FALSE

		var/obj/item/robot_model/model
		switch(model_selection)
			if("Standard")
				model = new /obj/item/robot_model/standard
			if("Medical")
				model = new /obj/item/robot_model/medical
			if("Cargo")
				model = new /obj/item/robot_model/cargo
			if("Engineer")
				model = new /obj/item/robot_model/engineering
			if("Security")
				model = new /obj/item/robot_model/security
			if("Service")
				model = new /obj/item/robot_model/service
			if("Janitor")
				model = new /obj/item/robot_model/janitor
			if("Miner")
				model = new /obj/item/robot_model/miner
			if("Peacekeeper")
				model = new /obj/item/robot_model/peacekeeper
			if("Clown")
				model = new /obj/item/robot_model/clown
			if("Syndicate")
				model = new /obj/item/robot_model/syndicatejack
			if("Spider Clan")
				model = new /obj/item/robot_model/ninja
			else
				return FALSE
		if (!set_disguise_vars(model, user))
			qdel(model)
			return FALSE
		qdel(model)
		animation_playing = TRUE
		to_chat(user, span_notice("You activate \the [src]."))
		playsound(src, 'sound/effects/seedling_chargeup.ogg', 100, TRUE, -6)
		var/start = user.filters.len
		var/X,Y,rsq,i,f
		for(i=1, i<=7, ++i)
			do
				X = 60*rand() - 30
				Y = 60*rand() - 30
				rsq = X*X + Y*Y
			while(rsq<100 || rsq>900)
			user.filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
		for(i=1, i<=7, ++i)
			f = user.filters[start+i]
			animate(f, offset=f:offset, time=0, loop=3, flags=ANIMATION_PARALLEL)
			animate(offset=f:offset-1, time=rand()*20+10)
		if (do_after(user, 50, target=user) && user.cell.use(activationCost))
			playsound(src, 'sound/effects/bamf.ogg', 100, TRUE, -6)
			to_chat(user, span_notice("You are now disguised."))
			activate(user)
		else
			to_chat(user, span_warning("The chameleon field fizzles."))
			do_sparks(3, FALSE, user)
			for(i=1, i<=min(7, user.filters.len), ++i) // removing filters that are animating does nothing, we gotta stop the animations first
				f = user.filters[start+i]
				animate(f)
		user.filters = null
		animation_playing = FALSE

/obj/item/borg_shapeshifter/proc/set_disguise_vars(obj/item/robot_model/disguise_model, mob/living/silicon/robot/cyborg)
	if (!disguise_model || !cyborg)
		return FALSE
	var/list/reskin_icons = list()
	for(var/skin in disguise_model.borg_skins)
		var/list/details = disguise_model.borg_skins[skin]
		var/image/reskin = image(icon = details[SKIN_ICON] || 'icons/mob/robots.dmi', icon_state = details[SKIN_ICON_STATE])
		if (!isnull(details[SKIN_FEATURES]))
			if (R_TRAIT_WIDE in details[SKIN_FEATURES])
				reskin.pixel_x -= 16
		reskin_icons[skin] = reskin
	var/borg_skin = show_radial_menu(cyborg, cyborg, reskin_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg), radius = 38, require_near = TRUE)
	if(!borg_skin)
		return FALSE
	disguise_model_name = borg_skin
	var/list/details = disguise_model.borg_skins[borg_skin]
	disguise = details[SKIN_ICON_STATE]
	disguise_icon_override = details[SKIN_ICON]
	disguise_special_light_key = details[SKIN_LIGHT_KEY]
	disguise_hat_offset = 0 || details[SKIN_HAT_OFFSET]
	disguise_model_features = details[SKIN_FEATURES]
	return TRUE

/obj/item/borg_shapeshifter/process()
	if (user && !user.cell?.use(activationUpkeep))
		disrupt(user)
	else
		return PROCESS_KILL

/obj/item/borg_shapeshifter/proc/activate(mob/living/silicon/robot/user)
	src.user = user
	START_PROCESSING(SSobj, src)
	saved_icon = user.model.cyborg_base_icon
	saved_bubble_icon = user.bubble_icon
	saved_icon_override = user.model.cyborg_icon_override
	saved_model_name = user.model.name
	saved_model_features = user.model.model_features
	saved_special_light_key = user.model.special_light_key
	saved_hat_offset = user.model.hat_offset
	user.model.name = disguise_model_name
	user.model.cyborg_base_icon = disguise
	user.model.cyborg_icon_override = disguise_icon_override
	user.model.model_features = disguise_model_features
	user.model.special_light_key = disguise_special_light_key
	user.bubble_icon = "robot"
	active = TRUE
	user.update_icons()
	user.model.update_dogborg()
	user.model.update_tallborg()

	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
	RegisterSignal(user, signalCache, .proc/disrupt)
	listeningTo = user

/obj/item/borg_shapeshifter/proc/deactivate(mob/living/silicon/robot/user)
	STOP_PROCESSING(SSobj, src)
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
		listeningTo = null
	do_sparks(5, FALSE, user)
	user.model.name = saved_model_name
	user.model.cyborg_base_icon = saved_icon
	user.model.cyborg_icon_override = saved_icon_override
	user.icon = saved_icon_override
	user.model.model_features = saved_model_features
	user.model.special_light_key = saved_special_light_key
	user.bubble_icon = saved_bubble_icon
	active = FALSE
	user.update_icons()
	user.model.update_dogborg()
	user.model.update_tallborg()

/obj/item/borg_shapeshifter/proc/disrupt(mob/living/silicon/robot/user)
	SIGNAL_HANDLER
	if(active)
		to_chat(user, span_danger("Your chameleon field deactivates."))
		deactivate(user)
