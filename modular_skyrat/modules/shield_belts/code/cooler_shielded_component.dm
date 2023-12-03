/datum/component/shielded/shield_belt
	/// The alpha of the shield overlay that'll be flicked when damage is taken
	var/shield_overlay_alpha
	/// The shield overlay color
	var/shield_overlay_color

/datum/component/shielded/shield_belt/Initialize(
		max_charges,
		recharge_start_delay,
		charge_increment_delay,
		charge_recovery,
		lose_multiple_charges,
		show_charge_as_alpha,
		recharge_path,
		starting_charges,
		shield_icon_file,
		shield_icon,
		shield_inhand,
		run_hit_callback,
		shield_overlay_alpha = 200,
		shield_overlay_color = "#77bd5d",
	)

	. = ..()

	src.shield_overlay_alpha = shield_overlay_alpha
	src.shield_overlay_color = shield_overlay_color

/datum/component/shielded/shield_belt/set_wearer(mob/user)
	if(wearer == user)
		return
	if(!isnull(wearer))
		CRASH("[type] called set_wearer with [user] but [wearer] was already the wearer!")

	wearer = user
	RegisterSignal(wearer, COMSIG_QDELETING, PROC_REF(lost_wearer))
	if(current_charges)
		wearer.update_appearance(UPDATE_ICON)

/datum/component/shielded/shield_belt/default_run_hit_callback(mob/living/wearer, attack_text, new_current_charges)
	do_sparks(2, TRUE, wearer)
	wearer.visible_message(span_danger("[wearer]'s shield stops [attack_text] in a burst of blinding light!"))
	/// The icon state for the shield overlay when we flick it later
	var/shield_overlay_icon_state = "shield"
	if(new_current_charges <= 0)
		wearer.visible_message(span_danger("The shield around [wearer] shatters!"))
		shield_overlay_icon_state = "break"
		playsound(wearer, SFX_SHATTER, BLOCK_SOUND_VOLUME, TRUE)
	else
		playsound(wearer, 'sound/weapons/parry.ogg', BLOCK_SOUND_VOLUME, TRUE)

	var/mutable_appearance/overlay = mutable_appearance(shield_icon_file, shield_overlay_icon_state, ABOVE_MOB_LAYER)
	/// How long the shield effect will last
	var/effect_duration = 0.5 SECONDS

	wearer.flick_overlay_static(overlay, effect_duration)
