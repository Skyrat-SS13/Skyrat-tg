/obj/item/organ/internal/lungs/synth
	name = "heat sink"
	desc = "A device that transfers generated heat to a fluid medium to cool it down. Required to keep your synthetics cool-headed. It's shape resembles lungs." //Purposefully left the 'fluid medium' ambigious for interpretation of the character, whether it be air or fluid cooling
	icon = 'modular_skyrat/master_files/icons/obj/surgery.dmi'
	icon_state = "lungs-ipc"
	safe_nitro_min = 0
	safe_nitro_max = 0
	safe_co2_min = 0
	safe_co2_max = 0
	safe_plasma_min = 0
	safe_plasma_max = 0
	safe_oxygen_min = 0	//What are you doing man, dont breathe with those!
	safe_oxygen_max = 0
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

/obj/item/organ/internal/lungs/synth/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	switch(severity)
		if(1)
			to_chat(owner, span_warning("Alert: Critical cooling system failure!"))
			owner.adjust_bodytemperature(100 * TEMPERATURE_DAMAGE_COEFFICIENT)
		if(2)
			owner.adjust_bodytemperature(30 * TEMPERATURE_DAMAGE_COEFFICIENT)
