/datum/preference/color/chat_color
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	priority = PREFERENCE_PRIORITY_NAME_MODIFICATIONS
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ic_chat_color"

/datum/preference/color/chat_color/apply_to_human(mob/living/carbon/human/target, value)
	target.apply_preference_chat_color(value)
	return

/datum/preference/color/chat_color/deserialize(input, datum/preferences/preferences)
	return process_chat_color(sanitize_hexcolor(input))

/datum/preference/color/chat_color/create_default_value()
	return process_chat_color("#[random_color()]")

/datum/preference/color/chat_color/serialize(input)
	return process_chat_color(sanitize_hexcolor(input))

/mob/living/carbon/human/proc/apply_preference_chat_color(value)
	if(isnull(value))
		return FALSE

	chat_color = process_chat_color(value, sat_shift = 1, lum_shift = 1)
	chat_color_darkened = process_chat_color(value, sat_shift = 0.85, lum_shift = 0.85)
	chat_color_name = name
	return TRUE

#define CHAT_COLOR_NORMAL 1
#define CHAT_COLOR_DARKENED 2

/// Get the mob's chat color by looking up their name in the cached list, if no match is found default to colorize_string().
/datum/chatmessage/proc/get_chat_color_string(name, darkened)
	var/chat_color_strings = GLOB.chat_colors_by_mob_name[name]
	if(chat_color_strings)
		return darkened ? chat_color_strings[CHAT_COLOR_DARKENED] : chat_color_strings[CHAT_COLOR_NORMAL]
	if(darkened)
		return colorize_string(name, 0.85, 0.85)

	return colorize_string(name)

#undef CHAT_COLOR_NORMAL
#undef CHAT_COLOR_DARKENED

#define CM_COLOR_HUE 1
#define CM_COLOR_SATURATION 2
#define CM_COLOR_LUMINANCE 3

#define CM_COLOR_SAT_MAX 90 // 90% saturation is the default ceiling
#define CM_COLOR_LUM_MIN 40 // 40% luminosity is the default floor
#define CM_COLOR_LUM_MIN_GREY 35 // 35% luminosity for greys
#define CM_COLOR_LUM_MAX_DARK_RANGE 45 // 45% luminosity for dark blues/reds/violets

#define CM_COLOR_HUE_RANGE_LOWER 180
#define CM_COLOR_HUE_RANGE_UPPER 350
#define CM_COLOR_HUE_GREY 0

/**
 * Converts a given color to comply within a smaller subset of colors to be used in runechat.
 * If a color is outside the min/max saturation or lum, it will be set at the nearest
 * value that passes validation.
 *
 * Arguments:
 * * color - The color to process
 * * sat_shift - A value between 0 and 1 that will be multiplied against the saturation
 * * lum_shift - A value between 0 and 1 that will be multiplied against the luminescence
 */
/proc/process_chat_color(color, sat_shift = 1, lum_shift = 1)
	if(isnull(color))
		return "#FFFFFF"

	// Convert color hex to HSL
	var/hsl_color = rgb2num(color, COLORSPACE_HSL)

	// Hue / saturation / luminance
	var/hue = hsl_color[CM_COLOR_HUE]
	var/saturation = hsl_color[CM_COLOR_SATURATION]
	var/luminance = hsl_color[CM_COLOR_LUMINANCE]

	// Cap the saturation at 90%
	saturation = min(saturation, CM_COLOR_SAT_MAX)

	// Now clamp the luminance according to the hue
	var/processed_luminance

	// There are special cases for greyscale and the red/blue/violet range
	if(hue == CM_COLOR_HUE_GREY)
		processed_luminance = max(luminance, CM_COLOR_LUM_MIN_GREY) // greys have a lower floor on the allowed luminance value than the default
	else if(CM_COLOR_HUE_RANGE_UPPER > hue > CM_COLOR_HUE_RANGE_LOWER)
		processed_luminance = min(luminance, CM_COLOR_LUM_MAX_DARK_RANGE) // colors in the deep reds/blues/violets range will have a slightly higher luminance floor than the default
	else
		processed_luminance = max(luminance, CM_COLOR_LUM_MIN) // everything else gets the default floor

	// Convert it back to a hex
	return rgb(hue, saturation*sat_shift, processed_luminance*lum_shift, space = COLORSPACE_HSL)

#undef CM_COLOR_HUE
#undef CM_COLOR_SATURATION
#undef CM_COLOR_LUMINANCE

#undef CM_COLOR_SAT_MAX
#undef CM_COLOR_LUM_MIN
#undef CM_COLOR_LUM_MIN_GREY
#undef CM_COLOR_LUM_MAX_DARK_RANGE

#undef CM_COLOR_HUE_RANGE_LOWER
#undef CM_COLOR_HUE_RANGE_UPPER
#undef CM_COLOR_HUE_GREY
