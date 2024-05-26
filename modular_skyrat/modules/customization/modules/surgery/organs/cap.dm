/obj/item/organ/external/mushroom_cap
	icon_state = "random_fly_1"

	mutantpart_key = "caps"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Round", MUTANT_INDEX_COLOR_LIST = list("#FF4B19"))
	slot = ORGAN_SLOT_EXTERNAL_CAP
	preference = "feature_caps"

/obj/item/organ/external/mushroom_cap/Initialize(mapload)
	if(!ispath(bodypart_overlay))
		mutantpart_info[MUTANT_INDEX_COLOR_LIST] = bodypart_overlay.draw_color
	return ..()

/datum/bodypart_overlay/mutant/mushroom_cap
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/mushroom_cap/randomize_appearance()
	. = ..()
	randomize_cap_color()

/datum/bodypart_overlay/mutant/mushroom_cap/proc/randomize_cap_color()
	draw_color = pick("#FF4B19", "#925858","#e6dfdf", "#E7AB33", "#704923", "#5db847", "#b359ab", "#9039a1", "#533ea0", "#3192af") // mushroom colors I guess

/datum/bodypart_overlay/mutant/mushroom_cap/override_color(rgb_value)
	if(isnull(draw_color))
		randomize_cap_color()
	return draw_color

/datum/bodypart_overlay/mutant/mushroom_cap/can_draw_on_bodypart(mob/living/carbon/human/human)
	return !sprite_datum.is_hidden(human)
