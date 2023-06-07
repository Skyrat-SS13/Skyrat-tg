/obj/item/organ/external/pod_hair
	name = "podperson hair"
	desc = "Base for many-o-salads."

	mutantpart_key = "pod_hair"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Ivy", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_POD_HAIR

	bodypart_overlay = /datum/bodypart_overlay/mutant/pod_hair

/datum/bodypart_overlay/mutant/pod_hair
	feature_key = "pod_hair"
	layers = EXTERNAL_FRONT_OVER|EXTERNAL_FRONT
	color_swapped_layer = EXTERNAL_FRONT_OVER
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/pod_hair/override_color(rgb_value)
	return draw_color

// TODO: at some point make this use tricolors instead of inverting
/datum/bodypart_overlay/mutant/pod_hair/color_images(list/image/overlays, draw_layer, obj/item/bodypart/limb)
	if(draw_layer != bitflag_to_layer(color_swapped_layer))
		return ..()

	for(var/index_to_color in overlay_indexes_to_color)
		if(index_to_color > length(overlays))
			break

		var/image/overlay = overlays[index_to_color]

		var/list/rgb_list
		if(islist(draw_color))
			rgb_list = rgb2num(draw_color[1])
		else
			rgb_list = rgb2num(draw_color)

		if(rgb_list)
			overlay.color = rgb(color_inverse_base - rgb_list[1], color_inverse_base - rgb_list[2], color_inverse_base - rgb_list[3]) //inversa da color
		else
			overlay.color = null
