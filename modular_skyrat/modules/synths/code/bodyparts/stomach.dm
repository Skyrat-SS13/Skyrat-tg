#define SYNTH_STOMACH_LIGHT_EMP_CHARGE_LOSS 50
#define SYNTH_STOMACH_HEAVY_EMP_CHARGE_LOSS 150

/obj/item/organ/internal/stomach/synth
	name = "synth power cell"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "stomach-ipc"
	w_class = WEIGHT_CLASS_NORMAL
	zone = "chest"
	slot = "stomach"
	desc = "A specialised cell, for synthetic use only. Has a low-power mode. Without this, synthetics are unable to stay powered."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC | ORGAN_SYNTHETIC_FROM_SPECIES

/obj/item/organ/internal/stomach/synth/emp_act(severity)
	. = ..()

	if(!owner || . & EMP_PROTECT_SELF)
		return

	switch(severity)
		if(EMP_HEAVY)
			owner.nutrition = max(0, owner.nutrition - SYNTH_STOMACH_HEAVY_EMP_CHARGE_LOSS)
			to_chat(owner, span_warning("Alert: Severe battery discharge!"))

		if(EMP_LIGHT)
			owner.nutrition = max(0, owner.nutrition - SYNTH_STOMACH_LIGHT_EMP_CHARGE_LOSS)
			to_chat(owner, span_warning("Alert: Minor battery discharge!"))

#undef SYNTH_STOMACH_LIGHT_EMP_CHARGE_LOSS
#undef SYNTH_STOMACH_HEAVY_EMP_CHARGE_LOSS
