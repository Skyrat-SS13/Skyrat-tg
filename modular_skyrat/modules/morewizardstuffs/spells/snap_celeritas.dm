/datum/action/cooldown/spell/pointed/celeritas
	name = "Celeritas"
	desc = "Swap places with a target within range."
	school = "transmutation"
	cooldown_time = 20 SECONDS
	cooldown_reduction_per_rank = 4 SECONDS
	spell_requirements = NONE
	invocation_type = INVOCATION_NONE
	base_icon_state = "spellcard"
	button_icon_state = "spellcard0"
	cast_range = 12
	active_msg = "You prepare to swap spots with a target..."
	deactive_msg = "You dispel swap spots."

/datum/action/cooldown/spell/pointed/celeritas/cast(mob/living/cast_on)
	. = ..()
	swap_spot(owner, cast_on)

/datum/action/cooldown/spell/pointed/celeritas/proc/swap_spot(mob/living/caster, mob/living/cast_on)
	caster.emote("snap")
	playsound(caster, 'sound/weapons/punchmiss.ogg', 75, TRUE)
	var/turf/targeted_turf = get_turf(cast_on)
	var/turf/caster_turf = get_turf(caster)

	new /obj/effect/temp_visual/small_smoke/halfsecond(caster.drop_location())
	new /obj/effect/temp_visual/small_smoke/halfsecond(targeted_turf)
	do_teleport(caster, targeted_turf, 0, no_effects = TRUE, channel = TELEPORT_CHANNEL_MAGIC)
	do_teleport(cast_on, caster_turf, 0, no_effects = TRUE, channel= TELEPORT_CHANNEL_MAGIC)
