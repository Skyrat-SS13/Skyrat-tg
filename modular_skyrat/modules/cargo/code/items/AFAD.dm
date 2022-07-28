#define PHYSICAL_DAMAGE_HEALING -0.2
#define EXOTIC_DAMAGE_HEALING -0.1

/obj/item/gun/medbeam/afad
	name = "Automated First Aid Device"
	desc = "Usually supplied in medkits, the AFAD is a revolutionary device meant for fixing scrapes and bruises, and totally not a knockoff of the legendary medibeam. A label on the underside reminds you not to cross the beams."
	icon = 'icons/obj/chronos.dmi'
	icon_state = "chronogun"
	inhand_icon_state = "chronogun"
	w_class = WEIGHT_CLASS_NORMAL

	

/obj/item/gun/medbeam/afad/on_beam_tick(mob/living/target)
	if(target.health != target.maxHealth)
		new /obj/effect/temp_visual/heal(get_turf(target), "#80F5FF")
	target.adjustBruteLoss(PHYSICAL_DAMAGE_HEALING)
	target.adjustFireLoss(PHYSICAL_DAMAGE_HEALING)
	target.adjustToxLoss(EXOTIC_DAMAGE_HEALING)
	target.adjustOxyLoss(EXOTIC_DAMAGE_HEALING)
	return
