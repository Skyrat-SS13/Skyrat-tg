/datum/action/cooldown/spell/stimpack
	name = "Magic Stimpack"
	desc = "This spell magically injects stimulants straight into your blood. Won't work on species with no reagent reactions!"
	school = "transmutation"
	cooldown_time = 10 SECONDS
	cooldown_reduction_per_rank = 1.25 SECONDS
	spell_requirements = NONE
	invocation = "STIMULUS CHEQ'US"
	invocation_type = INVOCATION_SHOUT

/datum/action/cooldown/spell/stimpack/cast(mob/living/cast_on)
	. = ..()
	cast_on.balloon_alert(cast_on, "speeding up")
	cast_on.SetKnockdown(0)
	cast_on.setStaminaLoss(0)
	cast_on.set_resting(FALSE)
	cast_on.reagents.add_reagent(/datum/reagent/medicine/stimulants, 3) // Ideally this comes out to a bit less than 30 seconds with tidi taken into account.
	return TRUE
