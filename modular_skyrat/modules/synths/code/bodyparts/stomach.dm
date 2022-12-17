/obj/item/organ/internal/stomach/synth
	name = "synth power cell"
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "stomach-ipc"
	w_class = WEIGHT_CLASS_NORMAL
	zone = "chest"
	slot = "stomach"
	desc = "A specialised cell, for synthetic use only. Has a low-power mode. Without this, synthetics are unable to stay powered."
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/internal/stomach/synth/emp_act(severity)
	. = ..()
	if(!owner || . & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			owner.nutrition = 50
			to_chat(owner, span_warning("Alert: Detected severe battery discharge!"))
		if(2)
			owner.nutrition = 250
			to_chat(owner, span_warning("Alert: Minor battery discharge!"))
