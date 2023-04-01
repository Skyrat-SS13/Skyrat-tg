#define SYNTH_BAD_EFFECT_DURATION 30 SECONDS
#define SYNTH_DEAF_STACKS 30
#define SYNTH_KNOCKDOWN_POWER 40
#define SYNTH_HEAVY_EMP_MULTIPLIER 2

/obj/item/organ/internal/ears/synth
	name = "auditory sensors"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "ears-ipc"
	desc = "A pair of microphones intended to be installed in an IPC head, that grant the ability to hear."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EARS
	gender = PLURAL
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC | ORGAN_SYNTHETIC_FROM_SPECIES

/obj/item/organ/internal/ears/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	switch(severity)
		if(EMP_HEAVY)
			owner.set_jitter_if_lower(SYNTH_BAD_EFFECT_DURATION * SYNTH_HEAVY_EMP_MULTIPLIER)
			owner.set_dizzy_if_lower(SYNTH_BAD_EFFECT_DURATION * SYNTH_HEAVY_EMP_MULTIPLIER)
			owner.Knockdown(SYNTH_KNOCKDOWN_POWER * SYNTH_HEAVY_EMP_MULTIPLIER)
			adjustEarDamage(SYNTH_ORGAN_HEAVY_EMP_DAMAGE, SYNTH_DEAF_STACKS)
			to_chat(owner, span_warning("Your system reports a complete lack of input from your auditory sensors."))

		if(EMP_LIGHT)
			owner.set_jitter_if_lower(SYNTH_BAD_EFFECT_DURATION)
			owner.set_dizzy_if_lower(SYNTH_BAD_EFFECT_DURATION)
			owner.Knockdown(SYNTH_KNOCKDOWN_POWER)
			to_chat(owner, span_warning("Your system reports anomalous feedback from your auditory sensors."))

#undef SYNTH_BAD_EFFECT_DURATION
#undef SYNTH_DEAF_STACKS
#undef SYNTH_KNOCKDOWN_POWER
#undef SYNTH_HEAVY_EMP_MULTIPLIER
