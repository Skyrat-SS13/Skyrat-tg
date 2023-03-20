/// Allows us to offset the spines' layer by a very small amount, to make it appear above the tails.
/// Not the best solution, but the simplest I found in the amount of time I had.
#define SPINES_LAYER_OFFSET 0.01

/datum/bodypart_overlay/mutant/spines
	color_source = ORGAN_COLOR_OVERRIDE
	layers = ALL_EXTERNAL_OVERLAYS

/datum/bodypart_overlay/mutant/spines/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/spines/can_draw_on_bodypart(mob/living/carbon/human/human)
	return !sprite_datum.is_hidden(human)

/// We overwrite this just because we need to change the layer to be ever so slightly above the tails.
/// It sucks, but it's the best I could do without refactoring a lot more.
/datum/bodypart_overlay/mutant/spines/get_images(image_layer, obj/item/bodypart/limb)
	var/list/mutable_appearance/returned_overlays = ..()

	for(var/mutable_appearance/overlay in returned_overlays)
		overlay.layer += SPINES_LAYER_OFFSET

	return returned_overlays
