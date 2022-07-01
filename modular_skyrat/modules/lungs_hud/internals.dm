/mob/living/carbon/update_internals_hud_icon(internal_state)
	. = ..()
	internals_text_update()

/mob/living/carbon/proc/internals_text_update()
	var/mob/living/carbon/carbon = src
	var/atom/movable/screen/internals/internal_hud = hud_used?.internals
	var/obj/item/organ/internal/lungs/mylungs = carbon.getorganslot(ORGAN_SLOT_LUNGS)
	var/datum/gas_mixture/mix_turf = return_air()
	var/safe_min = mylungs.safe_oxygen_min ? mylungs.safe_oxygen_min : (mylungs.safe_nitro_min ? mylungs.safe_nitro_min : (mylungs.safe_co2_min ? mylungs.safe_co2_min : (mylungs.safe_plasma_min ? mylungs.safe_plasma_min : 0)))
	var/pressure = internal ? internal.distribute_pressure : mix_turf.return_pressure()
	internal_hud?.maptext_y = 32
	if(internal)
		internal_hud?.maptext = MAPTEXT("<span style=\"font-size:5px\">LUNG:\n[safe_min]KPA\nCUR:\n[pressure]KPA\n</span>")
	else
		internal_hud?.maptext = MAPTEXT("<span style=\"font-size:5px\">LAST KPA:\n[pressure]\n</span>")

/obj/item/organ/internal/lungs/check_breath(datum/gas_mixture/breath, mob/living/carbon/human/breather)
	breather?.internals_text_update()
	. = ..()
