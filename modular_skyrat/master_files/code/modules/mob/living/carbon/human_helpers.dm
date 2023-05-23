//Overrides TG's version of the proc - only changes are the examine texts, and the extra DNR check
/mob/living/carbon/human/generate_death_examine_text()
	var/mob/dead/observer/ghost = get_ghost(TRUE, TRUE)
	var/t_He = p_they(TRUE)
	var/t_is = p_are()
	//This checks to see if the body is revivable
	if(key || !get_organ_by_type(/obj/item/organ/internal/brain) || ghost?.can_reenter_corpse)
		return span_deadsay("[t_He] [t_is] limp and unresponsive; they're still twitching on occasion, perhaps [p_they(FALSE)] can still be saved..!")
	else
		return span_deadsay("[t_He] [t_is] limp and unresponsive; there are no signs of life and they've degraded beyond revival...")
